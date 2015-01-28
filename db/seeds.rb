require 'open-uri'
require 'nokogiri'
require 'net/http'

blogroll = [
  # "http://www.residentadvisor.net/",
  # "http://www.electrobuzz.me/",
  # "http://www.indieshuffle.com/",
  # "http://sideonetrackone.com/",
  # "http://unrecorded.mu/",
  # "http://survivingthegoldenage.com/",
  # "http://kickkicksnare.com/",
  # "http://rosvot.fi/slowshow/", #QUICKSCAN
  # "http://www.iheartmoosiq.com/",
  # "http://www.myoldkentuckyblog.com/", #QUICKSCAN
  # "http://recommendedlisten.com/", #QUICKSCAN
  # "http://pickuptheheadphones.com/", #QUICKSCAN
  # "http://popdose.com/",
  # "http://breakingmorewaves.blogspot.com/", #QUICKSCAN
  # "http://factmag.com/",
  # "http://www.wonderingsound.com/",
  # "http://poponandon.com/",
  # "http://www.hillydilly.com/",
  # "http://thefourohfive.com/",
  # "http://www.muumuse.com/",
  # "http://www.consequenceofsound.net/",
  # "http://www.stereogum.com/",
  # "http://diymag.com/",
  # "http://jayelaudio.com/",
  # "http://www.joftheday.com/", #QUICKSCAN
  # "http://moarrr.com/", #QUICKSCAN
  # "http://www.earbuddy.net",
  # "http://www.themusicninja.com/",
  # "http://www.chubbybeavers.com/", #QUICKSCAN
  # "http://www.cavemansound.com/", #QUICKSCAN
  # "http://yaqui.co/",
  # "http://www.musicforants.com/", #QUICKSCAN
  # "http://matchmusik.com/", #QUICKSCAN
  # "http://anotherwhiskyformisterbukowski.com/category/musique/",
  # "http://www.guiltyfeet.com/",
  # "http://soulmotionmusic.blogspot.com/", #QUICKSCAN
  # "http://austintownhall.com/", #QUICKSCAN
  # "http://blahblahblahscience.com/",
  # "http://heartandsoulmusic.tumblr.com/",
  # "http://avant-avant.net/",
  # "http://different-kitchen.com/", #QUICKSCAN
  # "http://www.ladywoodmusic.com/", #QUICKSCAN
  # "http://www.orangepeel.ch/", #QUICKSCAN
  # "http://www.phonographecorp.fr/",
  # "http://swanfungus.com/",
  # "http://ravensingstheblues.blogspot.com/", #QUICKSCAN
  # "http://www.thebalticscene.eu/",
  # "http://bootlegumachine.blogspot.com/", #QUICKSCAN
  # "http://www.goldflakepaint.co.uk/",
  # "http://raidersofthelosttrack.tumblr.com/",
  # "http://fluid-radio.co.uk/",
  # "http://www.nialler9.com/",
  # "http://verbreverb.com/",
  # "http://acloserlisten.com/",
  # "http://felinnomusic.blogspot.com/", #QUICKSCAN
  # "http://avoltabr.com/",
  # "http://www.discosalt.com/",
  # "http://www.reviler.org/",
  # "http://swedeandsour.tumblr.com/", #QUICKSCAN
  # "http://www.houseofplates.com/",
  # "http://www.musicminute.org/",
  # "http://welistenforyou.blogspot.com/", #QUICKSCAN
  # "http://www.rookiemag.com/category/music/",
  # "http://artfelicis.com/",
  # "http://thefindmag.com/",
  # "http://music.for-robots.com/", #QUICKSCAN
  # "http://www.nitestylez.de/", #QUICKSCAN
  # "http://grooveonfire.com/", #QUICKSCAN
  # "http://wheniheardyou.com/",
  # "http://break-the-vault.com/", #QUICKSCAN
  # "http://www.indierockcafe.com/",
  # "http://bloopsbleeps.com/", #QUICKSCAN
  # "http://schitzpopinov.com/blog",
  # "http://www.musiclikedirt.com/",
  # "http://www.3hive.com/",
  # "http://www.ifoundmusic.com/", #QUICKSCAN
  # "http://reqeffect.com/",
  # "http://blogtotheoldskool.com/", #QUICKSCAN
  # "http://beatspill.com/", #QUICKSCAN
  # "http://www.78s.ch/",
  # "http://allscandinavian.com/",
  # "http://thetrashjuice.com/", #QUICKSCAN
  # "http://twoinarow.com/category/musik",
  # "http://www.room516.com/", #QUICKSCAN
  # "http://hmwl.org/", #QUICKSCAN
  # "http://www.frontstagemusic.net/",
  # "http://frequenzeindipendenti.blogspot.com/", #QUICKSCAN
  # "http://punch.pt/",
  # "http://onegreattrack.tumblr.com/", #QUICKSCAN
  # "http://www.yestefindeque.com/", #QUICKSCAN
  # "http://www.thetechnokittens.com/", #QUICKSCAN
  # "http://www.electroitalia.it/", #QUICKSCAN
  # "http://www.tunemine.com/", #QUICKSCAN
  # "http://www.xlr8r.com/news",
  # "http://nesthq.com/",
  # "http://wishyouwerehearblog.tumblr.com/",
  # "http://www.gorillavsbear.net/",
  # "http://www.thefader.com/"
]

@track_urls = []
@quick_scans = [
  "http://rosvot.fi/slowshow/",
  "http://www.myoldkentuckyblog.com/",
  "http://recommendedlisten.com/",
  "http://pickuptheheadphones.com/",
  "http://breakingmorewaves.blogspot.com/",
  "http://www.joftheday.com/",
  "http://moarrr.com/",
  "http://www.chubbybeavers.com/",
  "http://www.cavemansound.com/",
  "http://www.musicforants.com/",
  "http://matchmusik.com/",
  "http://soulmotionmusic.blogspot.com/",
  "http://austintownhall.com/",
  "http://different-kitchen.com/",
  "http://www.ladywoodmusic.com/",
  "http://www.orangepeel.ch/",
  "http://ravensingstheblues.blogspot.com/",
  "http://bootlegumachine.blogspot.com/",
  "http://felinnomusic.blogspot.com/",
  "http://swedeandsour.tumblr.com/",
  "http://welistenforyou.blogspot.com/",
  "http://music.for-robots.com/",
  "http://www.nitestylez.de/",
  "http://grooveonfire.com/",
  "http://break-the-vault.com/",
  "http://bloopsbleeps.com/",
  "http://www.ifoundmusic.com/",
  "http://blogtotheoldskool.com/",
  "http://beatspill.com/",
  "http://thetrashjuice.com/",
  "http://www.room516.com/",
  "http://hmwl.org/",
  "http://frequenzeindipendenti.blogspot.com/",
  "http://onegreattrack.tumblr.com/",
  "http://www.yestefindeque.com/",
  "http://www.thetechnokittens.com/",
  "http://www.electroitalia.it/",
  "http://www.tunemine.com/"
]
@deeper_scans = [
  "http://www.residentadvisor.net/",
  "http://www.electrobuzz.me/",
  "http://www.indieshuffle.com/",
  "http://sideonetrackone.com/",
  "http://unrecorded.mu/",
  "http://survivingthegoldenage.com/",
  "http://kickkicksnare.com/",
  "http://www.iheartmoosiq.com/",
  "http://www.myoldkentuckyblog.com/",
  "http://recommendedlisten.com/",
  "http://pickuptheheadphones.com/",
  "http://popdose.com/",
  "http://breakingmorewaves.blogspot.com/",
  "http://factmag.com/",
  "http://www.wonderingsound.com/",
  "http://poponandon.com/",
  "http://www.hillydilly.com/",
  "http://thefourohfive.com/",
  "http://www.consequenceofsound.net/",
  "http://www.stereogum.com/",
  "http://diymag.com/",
  "http://jayelaudio.com/",
  "http://www.joftheday.com/",
  "http://moarrr.com/",
  "http://www.earbuddy.net",
  "http://www.themusicninja.com/",
  "http://www.chubbybeavers.com/",
  "http://www.cavemansound.com/",
  "http://yaqui.co/",
  "http://www.musicforants.com/",
  "http://matchmusik.com/",
  "http://anotherwhiskyformisterbukowski.com/category/musique/",
  "http://www.guiltyfeet.com/",
  "http://austintownhall.com/",
  "http://blahblahblahscience.com/",
  "http://heartandsoulmusic.tumblr.com/",
  "http://avant-avant.net/",
  "http://different-kitchen.com/",
  "http://www.ladywoodmusic.com/",
  "http://www.orangepeel.ch/",
  "http://www.phonographecorp.fr/",
  "http://swanfungus.com/",
  "http://ravensingstheblues.blogspot.com/",
  "http://www.thebalticscene.eu/",
  "http://bootlegumachine.blogspot.com/",
  "http://www.goldflakepaint.co.uk/",
  "http://raidersofthelosttrack.tumblr.com/",
  "http://fluid-radio.co.uk/",
  "http://www.nialler9.com/",
  "http://verbreverb.com/",
  "http://acloserlisten.com/",
  "http://felinnomusic.blogspot.com/",
  "http://avoltabr.com/",
  "http://www.discosalt.com/",
  "http://www.reviler.org/",
  "http://swedeandsour.tumblr.com/",
  "http://www.houseofplates.com/",
  "http://www.musicminute.org/",
  "http://welistenforyou.blogspot.com/",
  "http://www.rookiemag.com/category/music/",
  "http://artfelicis.com/",
  "http://thefindmag.com/",
  "http://music.for-robots.com/",
  "http://www.nitestylez.de/",
  "http://grooveonfire.com/",
  "http://wheniheardyou.com/",
  "http://www.indierockcafe.com/",
  "http://schitzpopinov.com/blog",
  "http://www.musiclikedirt.com/",
  "http://www.3hive.com/",
  "http://www.ifoundmusic.com/",
  "http://reqeffect.com/",
  "http://blogtotheoldskool.com/",
  "http://beatspill.com/",
  "http://www.78s.ch/",
  "http://allscandinavian.com/",
  "http://thetrashjuice.com/",
  "http://twoinarow.com/category/musik",
  "http://hmwl.org/",
  "http://www.frontstagemusic.net/",
  "http://frequenzeindipendenti.blogspot.com/",
  "http://punch.pt/",
  "http://onegreattrack.tumblr.com/",
  "http://www.yestefindeque.com/",
  "http://www.thetechnokittens.com/",
  "http://www.tunemine.com/"
]

@spotify = []

def quick_source_scan(page, url)
  i = 0
  sources = page.xpath("//iframe/@src")
  if sources.empty?
    @deeper_scans << url
    puts ("No quick scan sources found for #{url}").red
  else
    sources.each do |source|
      if source.to_s.include?("soundcloud")
        if !@quick_scans.include?(url)
          @quick_scans << url
        end
        @track_urls << source.to_s
        i += 1
        puts ("#{url} - #{i} links processed")
      elsif source.to_s.include?("spotify")
        @spotify << source.to_s
        i += 1
        puts ("Spotify link found: #{url}").yellow
      else
        @deeper_scans << url
      end
    end
  end
end

def get_sc_info(id)
  client = Soundcloud.new(:client_id => '71e3bc36982b1ca95e6cf30c1ba20028')
  track = client.get("/tracks/#{id.to_i}")
  binding.pry
end

#URL VALIDATION & IFRAME SOURCE SCANNER
#RUN THIS FOR NEW BLOGROLL
# blogroll.each do |url|
#   begin
#     page = Nokogiri::HTML(open(url))
#   rescue RuntimeError
#     puts "#{url} - RuntimeError".yellow
#   rescue StandardError
#     puts "#{url} - StandardError".red
#   rescue
#     puts "#{url} - 403 Forbidden".red
#     next
#   end
#   puts "#{url} - URL is good".green
#   quick_source_scan(page, url)
# end

@quick_scans.each do |url|
  page = Nokogiri::HTML(open(url))
  quick_source_scan(page, url)
end

@quick_scans.uniq!
@deeper_scans.uniq!
@deeper_scans = @deeper_scans - @quick_scans

@track_ids = {}
@track_urls.each do |track|
  track_id_num = track.match(/(?>tracks\D)\w+/).to_s
  track_id_num = track_id_num.match(/\W\w+/).to_s
  @track_ids[track] = track_id_num.match(/\w+/).to_s
end

@track_ids.delete_if{|x| x.length == 0}
@track_ids.each do |track, id|
  get_sc_info(id)
end

#HYPEM
# url = 'http://hypem.com/playlist/popular/3day/json/1/data'
# buffer = open(url).read
# results = JSON.parse(buffer).to_a
# results[1..-1].each do |track|
#   song = Song.where(name: track[1]["title"])
#   artist = Artist.where(name: track[1]["artist"])
#   if artist.empty?
#     artist = Artist.create(name: track[1]["artist"])
#   else
#     song.artist_id = artist[1].id
#   end
#   song.name = track[1]["title"]
#   index = track[1]["loved_count"].to_f * 0.01
#   posted_index = track[1]["posted_count"] * 0.1
#   index += posted_index
#   song.index += index
# end

#EARMILK
# earmilk = [
#   "http://www.earmilk.com/genre/hiphop",
#   "http://www.earmilk.com/genre/dance",
#   "http://www.earmilk.com/genre/indie",
#   "http://www.earmilk.com/genre/electronic",
#   "http://www.earmilk.com/genre/pop"
# ]

# track_pages = []
# urls = []
# genre_pages = []
# track_urls = []
# earmilk.each do |genre|
#   page = Nokogiri::HTML(open(genre))
#   track_pages = page.xpath('//article/a/@href').to_a
#   genres = page.xpath('//div/div/div/ul/li/div/ul/li/a/@href').to_a
#   genres.each do |href|
#     genre_pages << href.to_s
# end
# end
# genre_pages.each do |genre|
#   page = Nokogiri::HTML(open("http://www.earmilk.com#{genre}"))
#   track_array = page.xpath('//article/a/@href').to_a
#   track_array.each do |link|
#     track_pages << link
#   end
# end
# clean = []
# track_pages.each do |page|
#   clean << page.to_s
# end
# clean.uniq!
# clean.each do |link|
#   page = Nokogiri::HTML(open("http://www.earmilk.com#{link}"))
#   sources = page.xpath("//iframe/@src")
#   sources.each do |source|
#     track_urls << source.to_s
#     i += 1
#     puts "#{i} links processed"
#   end
# end





