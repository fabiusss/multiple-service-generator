MultipleServiceGeneratorView = require './multiple-service-generator-view'
{CompositeDisposable} = require 'atom'

module.exports = MultipleServiceGenerator =
  multipleServiceGeneratorView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @multipleServiceGeneratorView = new MultipleServiceGeneratorView(state.multipleServiceGeneratorViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @multipleServiceGeneratorView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'multiple-service-generator:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @multipleServiceGeneratorView.destroy()

  serialize: ->
    multipleServiceGeneratorViewState: @multipleServiceGeneratorView.serialize()

  toggle: ->
    console.log 'MultipleServiceGenerator was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
