class PostController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), "..")

  set :view, Proc.new { File.join(root, "views") }

  configure:development do
    register Sinatra::Reloader
  end

    $music = [{
      id: 0,
      title: "Havana",
      body: "Camila Cabello ft. Young Thug",
      embed_id: "HCjNJDNzw8Y",
      lyrics: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
    {
      id: 1,
      title: "Rise Up",
      body: "Andra Day",
      embed_id: "kNKu1uNBVkU",
      lyrics: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
    {
      id: 2,
      title: "Bad",
      body: "Tiwa Savage",
      embed_id: "Q9lpzKvTzSY",
      lyrics: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
    {
      id: 3,
      title: "Romantic",
      body: "Korede Bello ft. Tiwa Savage",
      embed_id: "UXyUMMMETsA",
      lyrics: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
    {
      id: 4,
      title: "Meant to be",
      body: "Bebe Rexha ft. Florida Georgia Line",
      embed_id: "4iNC0NXKyNE",
      lyrics: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
  ]

  get "/" do
    @title_of_index = "Homepage"
    @my_music = $music  #this will display the hash created above
    erb :'posts/index'
  end

  get '/new' do
        @my_music = {
          id: "",
          title: "",
          body: "",
          embed_id: "",
          lyrics: ""
        }
        erb :'posts/new'
      end


  #for each songs when clicked-->show.erb
  #show title, body and the youtube page
  get "/:songs_id" do
    id = params[:songs_id].to_i
    @my_music = $music[id]
    erb :'posts/show'
  end

  get "/:id/edit" do
    id = params[:id].to_i
    @my_music = $music[id]
    erb :'posts/edit'
  end

  put "/:id" do
    id = params[:id].to_i
    my_music = $music[id]
    my_music[:title] = params[:title]
    my_music[:body] = params[:body]
    my_music[:embed_id] = params[:embed_id]
    my_music[:lyrics] = params[:lyrics]
    redirect '/'
  end

  # When you press save post
  post "/" do
      new_music = {
        id:$music.length,  # for the new post is id will be the length of the post, so its id number will now be 3
        title: params[:title],
        body: params[:body],
        embed_id: params[:embed_id],
        lyrics: params[:lyrics]
      }
      $music.push new_music
      redirect "/"
    end

  delete "/:id" do
    id = params[:id].to_i
    $music.delete_at(id)
    redirect '/'
  end
end
