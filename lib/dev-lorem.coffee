{CompositeDisposable} = require 'atom'
request = require 'request'

module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'dev-lorem:generate': => @generate()

  deactivate: ->
    @subscriptions.dispose()

  generate: ->
    if editor = atom.workspace.getActiveTextEditor()
      request('https://devlorem.kovah.de/api/5/p/json', (err, res, body) ->
          text = ("#{line}" for line in JSON.parse(body));
          editor.insertText(text.join('\n'));
        );
