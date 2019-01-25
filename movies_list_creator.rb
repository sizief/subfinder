files = %w(
  Mechanism.The.S01E01.1080p.5.1Ch.BluRay.ReEnc-DeeJayAhmed.mkv
  The.Mechanism.S01E02.HDTV.x264-SVA[eztv].mkv
  The.Mechanism.S01E03.1080p.HDTV.x264.hastidl.mp4
  The.Mechanism.S01E04.720p.WEB-DL.DibaMoviez.mkv
  Agatha.Christies.Poirot.S13E02.1080p.BluRay.x264.mkv
  The.Mechanism.S01E01.WEB-DL.srt
  The.Mechanism.S01E02.HDTV.x264-SVA.srt
  The.Mechanism.S01E03.720p.HDTV.x264-IMMERSE.srt
  The.Mechanism.S01E04.HDTV.x264.KILLERS.HI.srx.srt
  The.Mechanism.S01E05.720p.WEB.H264-MEMENTO.srt
)
files += ['The Mechanism S01E06 - The Silkworm pt1 x264 RB58.mp4',
          'The Mechanism S01E06.pilot.720p BluRay BRRip 480p BoB-edited version.srt']

# single file without subtutles
files += %w[
  The.Mechanism.S02E03.1080p.HDTV.x264.hastidl.mp4
]

files.each do |name|
  File.open(Dir.pwd + '/' + name, 'w') { |f| f.write('this is sample file') }
end
