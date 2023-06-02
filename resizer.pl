use strict;
use warnings;
use File::Basename;
use Image::Resize;
use Image::Size;

my $directory = "path/to/directory";
my $target_width = 800;
my $target_height = 600;

opendir(my $dh, $directory) or die "Cannot open directory: $!";
my @files = readdir($dh);
closedir($dh);

foreach my $file (@files) {
    next if ($file =~ /^\./); # Skip hidden files or directories

    my $filepath = "$directory/$file";
    my ($filename, $directory) = fileparse($filepath);

    my ($image_width, $image_height) = imgsize($filepath);
    next unless defined $image_width && defined $image_height;

    my $image = Image::Resize->new($filepath);
    my $resized_image = $image->resize($target_width, $target_height);

    my $resized_filepath = "$directory/resized_$filename";
    $resized_image->save($resized_filepath);

    print "Resized $file to $target_width x $target_height and saved as $resized_filepath\n";
}
