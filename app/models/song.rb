class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents=(contents)
    contents.reject!(&:empty?)
    if contents
      contents.each do |content|
        note = Note.new(:content => content)
        self.notes << note
      end
    end
  end

  def note_contents
    content_array = []
    self.notes.each do |note|
      content_array << note.content
    end
    content_array
  end


end
