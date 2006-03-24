From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: cosmetic change in ata_bus_softreset()
Date: Fri, 24 Mar 2006 10:16:30 -0500
Message-ID: <44240D4E.3090309@pobox.com>
References: <20060324034556.GF25706@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090206010800060509010103"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:63722 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750727AbWCXPQe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 10:16:34 -0500
In-Reply-To: <20060324034556.GF25706@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090206010800060509010103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> ata_bus_softreset() should return AC_ERR_* on failure not arbitrary
> positive number.  While at it, kill trailing indentations and reformat
> comment.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Please pull #upstream, make sure you have
2e9edbf815e42f93dd29a9981f27bd421acc47df, and then resend.  I ran chomp 
(attached) on a bunch of files.

	Jeff



--------------090206010800060509010103
Content-Type: application/x-perl;
 name="chomp.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chomp.pl"

#!/usr/bin/perl -w

use strict;

my ($argv_fn);
my $bytes_saved = 0;

while ($argv_fn = shift @ARGV) {
	&chomp_file($argv_fn);
}
printf "%u bytes chomped.\n", $bytes_saved;
exit(0);


sub chomp_file {
	my ($fn) = @_;
	my ($s, $i);
	my $chomped = 0;

	# read entire data file into memory
	open (F, $fn) or die "cannot open $fn: $!\n";
	my @data = <F>;
	close (F);

	# trim trailing whitespace
	foreach $i (0 .. $#data) {
		$s = $data[$i];
		if ($s =~ /\s$/) {
			while (($s) && ($s =~ /\s$/)) {
				chop $s;
				$bytes_saved++;
			}
			$s .= "\n";
			$bytes_saved--;
			if ($s ne $data[$i]) {
				$chomped = 1;
				$data[$i] = $s;
			}
		}
	}

	# dump data back to disk
	if ($chomped) {
		open (F, ">$fn") or die "cannot overwrite $fn: $!\n";
		print F @data;
		close (F);

		print "$fn modified.\n";
	}
}


--------------090206010800060509010103--
