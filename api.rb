require 'sinatra'
require 'sinatra/reloader' if development?
require 'redcarpet'
require 'coderay'

class CodeRayify < Redcarpet::Render::HTML
  def block_code(code, language)
    CodeRay.scan(code, language).div
  end
end

post '/' do
  raw = request.env['rack.input'].read
  markdown = Redcarpet::Markdown.new(CodeRayify,
    :tables => true, :fenced_code_blocks => true,
    :autolink => true, :space_after_headers => true)
  return markdown.render(raw)
end
