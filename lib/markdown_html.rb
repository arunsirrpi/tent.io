require 'pygments.rb'

RubyPython.start python_exe: 'python2.6' if ENV['RACK_ENV'] == 'production'

class MarkdownHTML < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants

  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  end

  def table(header, body)
    el('table', el('thead', header) + el('tbody', body), class: 'table table-striped table-bordered')
  end

  private

  def el(el, content, attributes = {})
    if content
      attrs = attributes ? ' ' + attributes.map { |k,v| "#{k}=\"#{v}\"" }.join(' ') : ''
      "<#{el}#{attrs}>\n#{content}</#{el}>\n"
    else
      ''
    end
  end
end
