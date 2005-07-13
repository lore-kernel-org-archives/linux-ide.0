From: Lorenzo De Carli <ldk@katamail.com>
Subject: SATA ich6 problem on Acer notebook
Date: Wed, 13 Jul 2005 20:54:24 +0200
Message-ID: <42D56360.2020708@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vsmtp4.tin.it ([212.216.176.224]:8880 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S262389AbVGMSyb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2005 14:54:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

I hope this won't be a duplicated bug report... I'm unable to get the
SATA controller working on a Centrino notebook, specifically an Acer
Travelmate 4152 Lmi. The controller is Intel 82801FBM integrated in the 
ICH6.
The machine seems to have the hard disk (60 GB) and the cdrom drive 
connected to channel 1, while channel 0 isn't used (?!).

I've tried the following steps:

first, i've compiled the kernel without pata drivers, only ahci:
	CFG_SCSI_SATA=y
	CFG_SCSI_SATA_AHCI=y
this didn't work, I obtained an error -12 while scanning drives.

then, i've tried with ata_piix:
	CFG_SCSI_SATA=y
	CFG_SCSI_ATA_PIIX=y
this time, the kernel ended up saying "SATA port has no device"

in both cases, the boot process hung because the kernel couldn't find 
the root device.

I've experimented with the PATA drivers, but the piix driver doesn't 
work; the only module that can detect the hd is ide_generic and this 
means no DMA.

If I compile in the same kernel ide-generic and ata_piix, the generic 
driver is used and ata_piix does nothing. If I boot the kernel with the 
ide1=noprobe option, the generic driver is not loaded but ata_piix again 
finds no drives.

The kernel used is the 2.6.11 with debian patches; I think that also the 
2.6.12 has the same problem, because the most recent version of SUSE 
(which use 2.6.12) hangs during the installation process saying that no 
cd drive can be found. Same does Ubuntu Hoary with 2.6.10.

I've found many other people having the same problem, for example with 
some Dell notebooks. I think is some kind of bios related bug, because 
in other machines the controller works.

If you're interested in fixing this, I can provide more specific error 
messages and the resources used by the driver under Windows XP.

best regards,
Lorenzo De Carli

-- 
Lorenzo De Carli                                        ldk@katamail.com
   "I lay my head on the railroad track and wait for the double-E
     The railroad don't run no more poor, poor pitiful me" (Warren Zevon)

