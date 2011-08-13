use feature "switch";

$interface = $ARGV[0];

@raw_list = `iwlist $interface scanning`;

#$raw_list =~ s/(.*)Cell(.*)/\1lawl\2/g;

print "Wifi scanning demo code...\n";
my $cell_index = 0;
foreach (@raw_list) {
	#print "$i : $_ \n";
	given($_) {
		when(/^(.*)Scan completed :(.*)/){
			
		}
		when(/^(.*)Cell (.*) - Address(.*)/) {
			print "---------------------------------------------------\n";
			$cell_index = $_;
			$cell_index =~ s/(.*)Cell (.*) - Address(.*)\n/$2/;
			print "CELL: [$cell_index]\n";
			$mac = $_;
			$mac =~ s/(.*)Cell (.*) - Address: (.*)\n/$3/;
			print "MAC: [$mac]\n";
		}
		when(/^(.*)Channel:\d{1,}(.*)/) {
			$channel = $_;
			$channel =~ s/(.*)Channel:(.*)\n/$2/;
			print "CHANNEL: [$channel]\n";
		}
		when(/^(.*)Frequency:(.*) GHz (.*)/) {
			$frequency = $_;
			$frequency =~ s/(.*)Frequency:(.*) GHz (.*)\n/$2/;
			print "FREQ: [$frequency]\n";
		}
		when(/^(.*)Quality=(.*)  Signal level=(.*) dBm(.*)\n/) {
			$quality = $_;
			$signal = $_;
			$quality =~ s/(.*)Quality=(.*)  Signal level=(.*) dBm(.*)\n/$2/;
			$signal =~ s/(.*)Quality=(.*)  Signal level=(.*) dBm(.*)\n/$3/;
			print "QUALITY: [$quality]\n";
			print "SIGNAL LEVEL: [$signal]\n";
		}
		when(/^(.*)Encryption key:(on|off)/) {
			$encryption = $_;
			$encryption =~ s/(.*)Encryption key:(.*)\n/$2/;
			print "ENCRYPTION: [$encryption]\n";
		}
		when(/^(.*)ESSID:"(.*)/){
			$essid = $_;
			$essid =~ s/(.*)ESSID:"(.*)"\n/$2/;
			print "ESSID: [$essid]\n"
		}
	}	
}

#printf "\n\n\n$raw_list\n";
