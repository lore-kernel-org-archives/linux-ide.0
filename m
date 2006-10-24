From: "Danny Sung" <dsung@lantronix.com>
Subject: SATA driver issues?
Date: Mon, 23 Oct 2006 18:27:05 -0700
Message-ID: <2F0FC2A92C0B154BB406D5E74CB3E6930336BD5F@3putt.int.lantronix.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ltrxmail.lantronix.com ([67.134.254.86]:32137 "EHLO
	double-bogey.int.lantronix.com") by vger.kernel.org with ESMTP
	id S964924AbWJXB2v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Oct 2006 21:28:51 -0400
Content-Class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi guys, I'm just writing to report some strange problems I'm seeing on
an IBM system with SATA drives.  I'm following the comments in the
sata_svw.c file, so hopefully I'm writing the correct people.

First my configuration:

 - IBM 7969AC1 - xSeries 326m  (2x dual core AMD Opteron 285, 2GB RAM)
 - Fedora Core 5, kernel 2.6.18  (package 2.6.18-1.220.fc5smp)
   I specifically chose to run the 32-bit version of Fedora as well.
 - IBM BIOS has the latest firmware from IBM (which did resolve the
issue of the system crashing).
 - Hard drives are 2x WD2500JS's
 - This particular server is using the BCM5785 (aka HT-1000) broadcom
chipset
 - If it matters I am running the drives under linux software RAID
mirroring, with a mixture of ext3 and xfs filesystems.

I've run short and long SMART tests on both drives, so I know it's not a
drive problem.  And this is a completely new server, just got it a
couple weeks ago.  The MFG date is 09/23/2006.


Prior to the firmware update, I got errors like these, along with
periodic system hangs:
Oct 15 03:50:40 aeolus kernel: ata2: command 0xea timeout, stat 0x50
host_stat 0x0
Oct 15 03:50:40 aeolus kernel: ata2: status=0x50 { DriveReady
SeekComplete }
Oct 15 03:50:40 aeolus kernel: ata2: error=0x01 { AddrMarkNotFound }

The firmware release notes did mention specifically having timing
problems that would cause Suse to hang.  So that's not entirely
unexpected.

But now I'm getting errors like these:
Oct 23 12:33:00 aeolus kernel: ATA: abnormal status 0xD0 on port
0xF881C11C
Oct 23 12:33:00 aeolus kernel: ATA: abnormal status 0xD0 on port
0xF881C11C
Oct 23 12:33:00 aeolus kernel: ATA: abnormal status 0xD0 on port
0xF881C11C
Oct 23 12:33:00 aeolus kernel: ATA: abnormal status 0xD0 on port
0xF881C01C
Oct 23 12:33:00 aeolus last message repeated 2 times
Oct 23 12:33:30 aeolus kernel: ata2.00: exception Emask 0x10 SAct 0x0
SErr 0x44050000 action 0x2 frozen
Oct 23 12:33:30 aeolus kernel: ata2.00: tag 0 cmd 0xea Emask 0x14 stat
0x40 err 0x0 (ATA bus error)
Oct 23 12:33:30 aeolus kernel: ata1.00: exception Emask 0x10 SAct 0x0
SErr 0x44050000 action 0x2 frozen
Oct 23 12:33:30 aeolus kernel: ata1.00: tag 0 cmd 0xea Emask 0x14 stat
0x40 err 0x0 (ATA bus error)
Oct 23 12:33:30 aeolus kernel: ata2: soft resetting port
Oct 23 12:33:30 aeolus kernel: ata1: soft resetting port
Oct 23 12:33:31 aeolus kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Oct 23 12:33:31 aeolus kernel: ata2.00: configured for UDMA/133
Oct 23 12:33:31 aeolus kernel: ata2: EH complete
Oct 23 12:33:31 aeolus kernel: SCSI device sdb: 488397168 512-byte hdwr
sectors (250059 MB)
Oct 23 12:33:31 aeolus kernel: sdb: Write Protect is off
Oct 23 12:33:31 aeolus kernel: SCSI device sdb: drive cache: write back
Oct 23 12:33:31 aeolus kernel: ata1: SATA link up 1.5 Gbps (SStatus 113
SControl 300)

The system no longer hangs completely.  There is a good pause during the
soft reset (probably about 5 to 10 seconds), but then things seem to
return to normal.  Some of my filesystems are a little corrupted (may
have been due to the firmware bug, though), but I can more or less use
the system.  Obviously I'd like to fix the problem and
reformat/reinstall everything.  But I'm just trying to narrow down the
problem.

My latest test was to boot up with the following kernel parameters:
"pci=noacpi idebus=66".  I'm not quite sure if I should be using 66 or
133.  But I figured it was worth a shot.  The "noacpi" flag was given to
me by other kernel messages on bootup.

It's only been a couple hours now without errors, so it's hard to say if
that's completely fixed my problem.  But I thought I'd report it in case
anyone else has seen the problem or has any suggestions on how I can fix
this.

Even going the RHEL route seems problematic as IBM only lists RHEL3
drivers on their website.  In addition, that division of Broadcom seems
to have been sold to another company and they're in transition in
offering driver support.  *sigh* to closed drivers...

Thanks in advance for any advice/suggestions,
Danny Sung
**********************************************************************
This e-mail is the property of Lantronix. It is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential, or otherwise protected from disclosure. Distribution or copying of this e-mail, or the information contained herein, to anyone other than the intended recipient is prohibited.

