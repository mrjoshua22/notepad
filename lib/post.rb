require 'sqlite3'

class Post
  SQLITE_DB_FILE = 'notepad.sqlite'.freeze

    def self.create(type)
    post_types[type].new
  end

  def self.find(type, limit)
    db = SQLite3::Database.open(SQLITE_DB_FILE)

    db.results_as_hash = false

    query = "SELECT rowid, * FROM posts "
    query += "WHERE type = :type " unless type.nil?
    query += "ORDER BY rowid DESC "
    query += "LIMIT :limit " unless limit.nil?

    begin
      statement = db.prepare(query)
    rescue SQLite3::SQLException => e
      puts "Не удалось выполнить запрос в базе #{SQLITE_DB_FILE}"
      abort e.message
    end

    statement.bind_param('type', type) unless type.nil?
    statement.bind_param('limit', limit) unless limit.nil?

    begin
      result = statement.execute!
    rescue SQLite3::SQLException => e
      puts "Не удалось выполнить запрос в базе #{SQLITE_DB_FILE}"
      abort e.message
    end

    statement.close
    db.close

    result
  end

  def self.find_by_id(id)
    db = SQLite3::Database.open(SQLITE_DB_FILE)

    db.results_as_hash = true

    begin
      result = db.execute("SELECT * FROM posts WHERE rowid=?", id)
    rescue SQLite3::SQLException => e
      puts "Не удалось выполнить запрос в базе #{SQLITE_DB_FILE}"
      abort e.message
    end

    db.close

    return [] if result.empty?

    result = result.first
    
    post = create(result['type'])
    post.load_data(result)
    post
  end

  def self.post_types
    {'Memo' => Memo, 'Link' => Link, 'Task' => Task}
  end

  def initialize
    @created_at = Time.now
    @text = []
  end

  def file_path
   "#{__dir__}/#{@created_at.strftime("#{self.class}_%d-%m-%Y_%H-%M-%S.txt")}"
  end

  def load_data(data_hash)
    @created_at = Time.parse(data_hash['created_at'])
  end

  def read_from_console
    # todo
  end

  def save
    File.open(file_path, 'w:UTF-8') do |file|
      to_strings.each { |string| file.puts(string) }
    end
  end

  def save_to_db
    db = SQLite3::Database.open(SQLITE_DB_FILE)
    db.results_as_hash = true
  
    begin
      db.execute(
        "INSERT INTO posts (#{to_db_hash.keys.join(',')}) VALUES " \
          "(#{('?,'*to_db_hash.size).chop})",
        to_db_hash.values
      )
    rescue SQLite3::SQLException => e
      puts "Не удалось выполнить запрос в базе #{SQLITE_DB_FILE}"
      abort e.message
    end

    insert_row_id = db.last_insert_row_id

    db.close

    insert_row_id
  end

  def to_db_hash
    {
      'type' => self.class.name,
      'created_at' => @created_at.to_s
    }
  end

  def to_strings
    # todo
  end
end
