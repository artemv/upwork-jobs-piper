def load_json_fixture(dir, fn)
  JSON.parse(File.open(Rails.root.join('spec', 'support', 'fixtures', dir, fn)).read)
end
