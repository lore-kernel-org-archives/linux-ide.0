From: "Paul Check" <paul@thechecks.ca>
Subject: Intermittent SATA link down SStatus 0
Date: Thu, 21 Jan 2010 10:57:39 -0500
Message-ID: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from d72-38-7-254.commercial1.cgocable.net ([72.38.7.254]:2580 "EHLO
	max" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751650Ab0AUQjK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jan 2010 11:39:10 -0500
Received: from d72-38-7-254.commercial1.cgocable.net
	([72.38.7.254] helo=thechecks.ca ident=www-data)
	by max with esmtp (Exim 4.71)
	(envelope-from <paul@thechecks.ca>)
	id 1NXzPf-0003R2-W5
	for linux-ide@vger.kernel.org; Thu, 21 Jan 2010 10:57:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am having an intermittent problem:

ata1.01: SATA link down (SStatus 0 SControl 301)

which is causing one of my four hard drives to not get recognized.

This happens on ata1.01, ata2.00 or ata2.01, although it seems to happen
more on the 01 channels, I believe.  My motherboard is an ASUS P6T Deluxe
V2, with the Marvel 88SE61XX ATA controller.

I am running the 2.6.31 kernel.  A variety of ATA controllers are enabled
in my kernel (as per default?) including AHCI SATA Support (SATA_AHCI),
Marvell SATA Support (SATA_MV), Generic ATA Support (ATA_Generic), and
Marvell PATA Support via Legacy Mode (PATA_MARVELL), among others.

I see that the pata, generic and ahci are getting loaded (from lsmod):

libata                189532  4 pata_marvell,ata_generic,ahci,ata_piix

I am not using hardware RAID (although do have software RAID 1 running).

The BIOS for the board has been updated to the latest version.  The disks
are Seagate ST31000528AS 1 TB drives (4 of them, 2 sets of RAID 1).  I
also have a Sony BWU-300S plugged in.

Would deselecting the pata_marvell likely get rid of this problem? The
descriptor says:

As I look through kern.log I see that the numbering on the ATA channels is
not always consistent.  For example, sometimes the Seagates come on
ata3.00, ata3.01, ata4.00 and ata4.01. Is this usual, or indicating a
problem with the controller/driver?

Regards, Paul (on list)






