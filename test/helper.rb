class Comment < ActiveRecord::Base
  acts_as_xlsx
  belongs_to :post
end

class Post < ActiveRecord::Base
  acts_as_xlsx
  has_many :comments
  def ranking
    a = Post.all.order(:votes)      
    a.index(self)
  end  
  def last_comment
    self.comments.last.content
  end
end

def load_schema
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
  ActiveRecord::Base.establish_connection(config['sqlite3'])
  ActiveRecord::Schema.define(:version => 0) do
    begin
    drop_table :comments, :force => true
    drop_table :posts, :force => true
    rescue
      #dont really care if the tables are not dropped
    end
    
    create_table(:comments, :force => true) do |t|
      t.text :content

      t.integer :post_id
      t.timestamps
    end

     create_table(:posts, :force => true) do |t|
      t.string :name
      t.string :title
      t.text :content
      t.integer :votes
      t.timestamps
    end

  end
  posts = []
  posts << Post.new(:name => "first post", :title => "This is the first post", :content=> "I am a very good first post!", :votes => 1)
  posts << Post.new(:name => "second post", :title => "This is the second post", :content=> "I am the best post!", :votes => 7)
  posts.each { |p| p.save! }

  comments = []
  comments << Comment.new(:post => posts[0], :content => "wow, that was a nice post!")
  comments << Comment.new(:content => "Are you really the best post?", :post => posts[1])
  comments << Comment.new(:content => "Only until someone posts better!", :post => posts[1])
  comments.each { |c| c.save! }

end


