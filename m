From: Chris Toth <chris@message.hu>
Subject: Unknown partition table after kernel upgrade
Date: Fri, 19 Nov 2004 19:22:38 +0000
Message-ID: <419E47FE.6010305@message.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.interware.hu ([195.70.32.130]:24299 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP id S261523AbUKSSJG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Nov 2004 13:09:06 -0500
Received: from caracas-2699.adsl.interware.hu ([213.178.110.139] helo=[192.168.1.202])
	by mail.interware.hu with esmtp (Exim 4.34 #1 (Debian))
	id 1CVDBx-0002xC-SF
	for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2004 19:09:06 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have run into a strange problem when I upgraded to the 2.6.9 kernel 
version from 2.6.6. When the system boots the kernel no longer 
recognises the partition tables of two of my hard drives. Using the same 
config anything below 2.6.6 works flawlessly but all the newer versions 
give this same error. Both drives are identical, have two primary 
partitions and are on the secondary IDE bus.

I have tried enabling advanced partition selection in the kernel config 
as well as ide stroke but neither did help.

Dmesg gives the following output:

PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6Y160P0, ATA DISK drive
hdb: CD-W512EB, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IC35L090AVV207-0, ATA DISK drive
hdd: IC35L090AVV207-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, 
UDMA(33)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: max request size: 1024KiB
hdc: 160836480 sectors (82348 MB) w/1821KiB Cache, CHS=16383/255/63, 
UDMA(33)
hdc: cache flushes supported
 /dev/ide/host0/bus1/target0/lun0: unknown partition table
hdd: max request size: 1024KiB
hdd: 160836480 sectors (82348 MB) w/1821KiB Cache, CHS=16383/255/63, 
UDMA(33)
hdd: cache flushes supported
 /dev/ide/host0/bus1/target1/lun0: unknown partition table
hdb: ATAPI 32X CD-ROM CD-R/RW drive, 2976kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

For reference here is the output of the working 2.6.6 kernel:

PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y160P0, ATA DISK drive
hdb: CD-W512EB, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IC35L090AVV207-0, ATA DISK drive
hdd: IC35L090AVV207-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, 
UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: max request size: 1024KiB
hdc: 160836480 sectors (82348 MB) w/1821KiB Cache, CHS=16383/255/63, 
UDMA(33)
 /dev/ide/host0/bus1/target0/lun0: p1 p2
hdd: max request size: 1024KiB
hdd: 160836480 sectors (82348 MB) w/1821KiB Cache, CHS=16383/255/63, 
UDMA(33)
 /dev/ide/host0/bus1/target1/lun0: p1 p2
hdb: ATAPI 32X CD-ROM CD-R/RW drive, 2976kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20


Thank you very much for any help you can give.
Regards,
Chris
