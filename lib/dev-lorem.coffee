{CompositeDisposable} = require 'atom'
request = require 'request'
cheerio = require 'cheerio'

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
      request('https://devlorem.kovah.de/p', (err, res, body) ->
          $ = cheerio.load(body);
          text = "";
          $('.content').find('p').each((i, v) ->
              text += $(v).text() + "\n";
            );
          editor.insertText(text);
        );
