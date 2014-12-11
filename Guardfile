guard 'bundler' do
  watch('Gemfile')
end

guard 'shell' do
  watch(%r{app.rb|lib/.*.rb}) do
    Notifier.notify "Reloading application code", title: "VATS.io"
    `touch tmp/restart.txt`
  end
end
