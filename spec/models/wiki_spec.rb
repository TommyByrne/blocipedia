describe Wiki do
   describe "scopes" do

     before do
       @standard_wiki = Wiki.create # default is public
       @private_wiki = Wiki.create(private: true)
     end

     describe "publicly_viewable" do
       it "returns a relation of all standard wiki" do
         expect(Wiki.standard_viewable).to eq( [@standard_wiki] )
       end
     end

     describe "privately_viewable" do
       it "returns a relation of all private wikis" do
         # Your code here
       end
     end

     describe "visible_to(user)" do
       it "returns all wikis if the user is present" do
         user = true # sneaky solution; we don't need a real user, just something truthy
         # Your code here
       end

       it "returns only public wikis if user is nil" do
         # Your code here
       end
     end
   end
 end