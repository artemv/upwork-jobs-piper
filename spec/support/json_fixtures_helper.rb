def load_json_fixture_text(dir, fn)
  File.open(Rails.root.join('spec', 'support', 'fixtures', dir, fn)) {|f| f.read }
end

def load_json_fixture(dir, fn)
  JSON.parse(load_json_fixture_text(dir, fn))
end

def load_json_fixtures_map(dir, fn)
  load_json_fixture(dir, fn).map { |data| [data['id'], data] }.to_h
end
