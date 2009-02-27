From: "Foster, Doug F" <doug.f.foster@intel.com>
Subject: ATAPI question
Date: Fri, 27 Feb 2009 16:50:58 -0700
Message-ID: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30350 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbZB0XvD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Feb 2009 18:51:03 -0500
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "Foster, Doug F" <doug.f.foster@intel.com>

I'm looking at the following Bugzilla sighting:  [Bug 429724] RHEL 5.4 periodic ATA error messages on Tolapai hardware.

I have reproduced the problem using these drives:  Plextor models PX-712 and PX-716 and Lite On model SHD-16S1S.
It occurs in AHCI mode only, not legacy mode.
Although I am working on an EP80579, it probably occurs on any AHCI controller.

This is a snippet from dmesg:
Jan 27 13:02:52 localhost kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Jan 27 13:02:52 localhost kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 8 in
Jan 27 13:02:52 localhost kernel:          cdb 25 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
Jan 27 13:02:52 localhost kernel:          res 40/00:03:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jan 27 13:02:52 localhost kernel: ata2.00: status: { DRDY }
Jan 27 13:02:53 localhost kernel: ata2: soft resetting link
Jan 27 13:02:53 localhost kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Jan 27 13:02:53 localhost kernel: ata2.00: configured for UDMA/25
Jan 27 13:02:53 localhost kernel: ata2: EH complete

Using a SATA analyzer, I find that on an INQUIRY (12h) ATAPI packet command, the device sets bit-6 (DRDY) and bit-4 (SERV) in the status register, and bits 0 (CoD) and 1 (IO) are set in the ATAPI Interrupt Reason Register (ATA Sector Count Register).  After SERVICE is flagged by the ATAPI device (and not serviced), it doesn't respond properly from then on.

Sections 5.7, 5.7.1, and 5.17 (overlapped commands) in the ATA Packet Interface for CD-ROMs specification (ATAPI-SFF8020i.pdf) seem to apply.  This functionality seems to be missing.  I would like to get some guidance as to where this functionality should be added.  I could either work with the appropriate maintainer on the details or take a crack at the code changes myself.  It would be a good learning experience for me, but I would like to collaborate with the appropriate Linux expert.

