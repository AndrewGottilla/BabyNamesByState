#Andrew Gottilla
use warnings;
use strict;
use Text::CSV; #included module for csv operations
use Data::Dumper qw(Dumper); #included module for command-line args

# csv is an object with functions to properly handle data from the .csv file
# States will store a reference value (like a position in an array) for each state from 0 to 50 (Including District of Columbia).
# State abbreviations are the key and the position is the value. This will be used later in the program for array operations
# state_array will be a counter for each state
my $csv = Text::CSV->new({binary => 1});
my %states = ( AK=>0, AL=>1, AR=>2, AZ=>3, CA=>4, CO=>5, CT=>6, DE=>7, FL=>8, GA=>9, HI=>10, IA=>11, ID=>12, IL=>13, IN=>14, KS=>15, KY=>16, LA=>17, MA=>18, MD=>19, ME=>20, MI=>21, MN=>22, MO=>23, MS=>24, MT=>25, NC=>26, ND=>27, NE=>28, NH=>29, NJ=>30, NM=>31, NV=>32, NY=>33, OH=>34, OK=>35, OR=>36, PA=>37, RI=>38, SC=>39, SD=>40, TN=>41, TX=>42, UT=>43, VA=>44, VT=>45, WA=>46, WI=>47, WV=>48, WY=>49, DC=>50 );
my @state_array = ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 );

my ($narg, $yarg) = @ARGV;

my $input;
if (defined $narg && !($narg =~ m/[\d]/))
{
	$input = $narg;
}
else
{

print "Enter Name or Sex (M/F): ";
$input = <STDIN>; chomp $input;
while ($input =~ m/[\d]/)
{
	print "No numbers or symbols this time. You got it.\nTry again: ";
	$input = <STDIN>; chomp $input;
}

}

#$i will be changed to 3 or 1 depending on input. These correspond to the position of the attribute for sex and name.
#If entered sex, then $i will be 3 to correspond with the condition further down in the program
my $i;
if (uc($input) eq 'M' || uc($input) eq 'F') { $i = 3; $input = uc($input); }
else { $i = 1; }

my $year; my $yflag = 0;
if (defined $yarg)
{
	if ($yarg eq "all" || $yarg !~ m/[a-zA-Z]/ && $yarg >= 1910 && $yarg <= 2014)
	{
		$year = $yarg;
		$yflag = 1;
	}
}

if (!$yflag)
{

print "Enter year (1910-2014 or all): "; #prompt User input for year
$year = <STDIN>; chomp $year; #get year
my $flag=0;
while (!$flag) #loop will end when $flag = 1
{ #if year doesn't have any characters, then it must be a number. Now, test if it's within the correct range. If correct, then flag = 1.
	if ($year !~ m/[a-zA-Z]/ && $year >= 1910 && $year <= 2014)	{ $flag = 1; }
	elsif ($year eq "all") { $flag = 1; } #if characters, test for proper "all" input
	else #error handler
	{
		print "I told you before. Number has to be between 1910 and 2014 or 'all'\nTry again: ";
		$year = <STDIN>; chomp $year;
	}
}

}

my $file = "StateNames.csv";	#typical file opening
open(FILE, '<', $file) or die "Couldn't open .csv file! I need a drink...\nProgram stopped";

my $count; #counter for total records to be used in loop
if ($year !~ m/[a-zA-Z]/) #year is number
{
	while (my $line = <FILE>) #keep grabbing data from file
	{
		chomp $line; #chomp line to remove \n

		if($csv->parse($line)) #parsing a line will split each line of the csv file based on ','
		{
			my @fields = $csv->fields(); #split, then take those split pieces of data and throw them into an array

			if ($fields[$i] eq $input && $fields[2] == $year) #match split data to input (requested data)
			{
				print "$line\n"; #display lines that matched
				$state_array[$states{$fields[4]}] += $fields[5]; #counter for state_array (nicely complicated)
				$count += $fields[5]; #overall counter aggregation
			}
		} else { warn "Hey, this guy's drunk: $line\n"; } #error handler

	} close FILE; 	#typical file closing
	if ($input eq "M") { $input = "Male"; }
	if ($input eq "F") { $input = "Female"; }
	print "\nTotal $input" . "s in $year: $count\n"; #total count
}
else
{ #year is not number meaning all
	while (my $line = <FILE>) 
	{
		chomp $line;

		if($csv->parse($line))
		{
			my @fields = $csv->fields();

			if ($fields[$i] eq $input) #adjusted to not test for $fields[2] == $year; Same operations
			{
				print "$line\n";
				$state_array[$states{$fields[4]}] += $fields[5];
				$count += $fields[5];
			}
		} else { warn "This line caused an error: $line\n"; }

	} close FILE;
	if ($input eq "M") { $input = "Male"; }
	if ($input eq "F") { $input = "Female"; }
	print "\nTotal $input" . "s from 1910 to 2014: $count\n";
}

my $high_pos=0; #will store position of highest state's count to be used in array later
my $low_pos=0;  #will store position of lowest state's count to be used in array later
my $high = $state_array[0]; #value of highest state's count
my $low = $state_array[0];  #value of lowest state's count

foreach my $y (0 .. $#state_array) #typical high/low finder loop
{
	if ($state_array[$y] > $high) { $high = $state_array[$y]; $high_pos = $y; }
	if ($state_array[$y] < $low) { $low = $state_array[$y]; $low_pos = $y; }
}
%states = reverse %states; #reverse states so that state abbreviation is now referenced by position

#glorious, glorious output. Like a star in the night sky.
print "State with most $input" . "s is $states{$high_pos}: $high\n";
print "State with least $input" . "s is $states{$low_pos}: $low\n";