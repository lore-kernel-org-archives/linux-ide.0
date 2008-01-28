From: Mark Lord <lkml@rtr.ca>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 13:20:36 -0500
Message-ID: <479E1CF4.7060706@rtr.ca>
References: <200801272122.21823.gene.heskett@gmail.com> <18333.57152.472830.608248@harpo.it.uu.se> <200801281135.14555.gene.heskett@gmail.com> <200801281156.28844.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4764 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbYA1SUi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 13:20:38 -0500
In-Reply-To: <200801281156.28844.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

> [   64.037975] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   64.038102] ata1.00: BMDMA stat 0x65
> [   64.038227] ata1.00: cmd c8/00:58:89:3d:07/00:00:00:00:00/e0 tag 0 dma 45056 in
> [   64.038229]          res 51/40:58:8b:3d:07/00:00:00:00:00/e0 Emask 0x9 (media error)
> [   64.038432] ata1.00: status: { DRDY ERR }
> [   64.038555] ata1.00: error: { UNC }
> [   64.050125] ata1.00: configured for UDMA/100
> [   64.050134] sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
> [   64.050138] sd 0:0:0:0: [sda] Sense Key : 0x3 [current] [descriptor]
> [   64.050142] Descriptor sense data with sense descriptors (in hex):
> [   64.050143]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00 
> [   64.050149]         00 07 3d 8b 
> [   64.050152] sd 0:0:0:0: [sda] ASC=0x11 ASCQ=0x4
> [   64.050155] end_request: I/O error, dev sda, sector 474507
..

This error looks somewhat different from the samples posted earlier.
This one is quite definitively a "bad sector".

It should also show up in "smartctl -a -data /dev/sda" (near the bottom)
if SMART was enabled on this drive at boot.

You could try reading that specific sector again just to make sure.
One way is to figure out how to use "dd" for this.
Another way is to use the "make_bad_sector" utility that
is included in the source tarball for hdparm-7.7, as follows:

   make_bad_sector --readback /dev/sda 474507

(when invoked as above, it does *not* "make" a bad sector; no worries).

If it reports an I/O error consistently on that, then the sector is
indeed faulty, and it's contents have long been lost.

You can repair the bad sector (but not the original contents) like this:

   make_bad_sector --rewrite /dev/sda 474507

Cheers

