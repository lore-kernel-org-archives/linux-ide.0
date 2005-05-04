From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: ata_piix timeout during software suspend
Date: Tue, 3 May 2005 18:15:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0505031813580.5750@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from harlech.math.ucla.edu ([128.97.4.250]:42895 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S261968AbVEDBPs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 May 2005 21:15:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, pavel@suse.cz

Distro:		SuSE 9.3
Kernel:		2.6.12-rc3
Hardware:	Dell Inspiron 6000d, Pentium-M, chipset 915PM
		(ICH6M, 82801FBM), PCI ID of SATA controller: 8086:2653
Discs:		FUJITSU MHT2040A; SATA, UDMA/100
		Toshiba-Samsung CDRW/DVD SN-324S 24X; ATAPI, UDMA/33

I have been using ata_piix (with ATA_ENABLE_ATAPI enabled, and the patch
to recognize combined mode on this chipset) without problems, except for
one issue during software suspend.  After tasks are stopped and drivers
are put to sleep, it sometimes (not always) reports writing 0% of the
image to the swap device, then hangs for 30 seconds and prints "ata1:
command 0xca timed out, stat 0x50 host_stat 0x24".  Then it retries and
writes the image successfully.

In kernel 2.6.11.4 it would usually (always?) report writing 0% of the 
image, hang for 30 seconds, then panic saying "unable to resolve kernel
page fault at..." (can't read quick enough to get the whole message).

I wonder if the problem might be that ata_piix is getting de-initialized
before being used to write the resume image.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
