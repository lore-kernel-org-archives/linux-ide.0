From: Tigran Aivazian <tigran@veritas.com>
Subject: question about SATA and IDE DVD/CD drives.
Date: Fri, 2 Jul 2004 14:11:01 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0407021403120.2190-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colossus.systems.pipex.net ([62.241.160.73]:58765 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264500AbUGBNM0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 09:12:26 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Jeff,

I was a bit confused with the "SATA vs IDE" thing recently, namely the 
fact that if I compile _both_ IDE and SATA support into the kernel 
then IDE takes over and SATA gets a "busy" error, and as a result I get 
3M/sec performance instead of 56M/sec.

Now, realizing this error I have reconfigured the kernel to NOT include 
ide and ONLY include SATA plus chipset-specific ata_piix.c (I have ICH6 
device 2652). However, now the new problem is that I can't see the IDE 
DVD-ROM drive anymore. Here is dmesg:

ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
  Vendor: ATA       Model: ST3120026AS       Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
ata2: dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000 87:0000 88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

As you see, sda is there, but where is my DVD drive gone?

# mount -t iso9660 /dev/scd0 /mnt/cdrom
mount: /dev/scd0 is not a valid block device
# uname -a
Linux tank 2.6.7 #3 SMP Fri Jul 2 13:40:07 BST 2004 x86_64 x86_64 x86_64 GNU/Linux
# grep " sr" /proc/devices 
 11 sr

Kind regards
Tigran

