From: Mark Lord <liml@rtr.ca>
Subject: hdparm-8.1 now available
Date: Sat, 16 Feb 2008 10:56:28 -0500
Message-ID: <47B707AC.20305@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3660 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbYBPP43 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Feb 2008 10:56:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Bruce Allen <ballen@gravity.phys.uwm.edu>

hdparm has now been updated to version 8.1,
and includes some significant new features of
potential interest to Linux kernel storage hackers:

The new --make-bad-sector flag can be used to deliberately
corrupt a sector on the media (creating a media error situation).
This can be very handy for testing error recovery strategies
and timeouts for devices and RAIDs.

It uses the new ATA WRITE_UNC_EXT command (designed for the purpose)
when the drive supports it, otherwise it will try and fall back on
the older WRITE_LONG command (which is limited to LBA28).

The manpage has more information on this option.

There is also a new --write-sector (aka. --repair-sector) flag
to *fix* a bad sector.  This can be used later to undo the bad
sectors created by the --make-bad-sector flag.

The new --read-sector flag can be used to test a sector
for media errors.  I generally use the following sequence here:

   hdparm --make-bad-sector nnnnnnnn /dev/sdb  ## corrup a sector
   hdparm --read-sector nnnnnnnn /dev/sdb    ## verify that it is now bad

   test my device driver etc..

   hdparm --repair-sector nnnnnnn /dev/sdb  ## fix the bad sector
   hdparm --read-sector nnnnnnn /dev/sdb  ## verify that it is now fixed


hdparm also now has a new -N flag for dealing with Host-Protected-Areas (HPA),
and other, more minor, fixes and enhancements.

hdparm-8.1 is available at http://sourceforge.net/projects/hdparm/

Thanks to Bruce Allen for supplying me with test drives
which implement the new WRITE_UNC_EXT command.

Cheers

Mark Lord
