From: Guillaume Chazarain <gfc@altern.org>
Subject: Small problem when booting with a ZIP under 2.6
Date: Tue, 15 Jul 2003 12:00:30 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <54TNNI5GERLEBKIMO8UP63HGHD3V.3f13d0be@monpc>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nice-1-a7-62-147-79-209.dial.proxad.net ([62.147.79.209]:40452
	"EHLO monpc") by vger.kernel.org with ESMTP id S267005AbTGOJm4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jul 2003 05:42:56 -0400
List-Id: linux-ide@vger.kernel.org
To: Paul Bristow <paul@paulbristow.net>
Cc: linux-ide@vger.kernel.org

Hi,

First let me warn you, this is really a little problem. So here it is.
When I boot with a ZIP floppy inside the ZIP drive, I get this on boot:

PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1080-0x1087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1088-0x108f, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IDE/ATAPI CD-ROM 36X, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, UDMA(33)
 hda: hda1 hda2 < hda5 > hda3
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 16X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
hdd: 98304kB, 196608 blocks, 512 sector size
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
 hdd: hdd4      <=================
 hdd: hdd4      <================= !!!!!
kobject_register failed for hdd4 (-17)
Call Trace:
 [<c01aa4e9>] kobject_register+0x59/0x60
 [<c0179b89>] register_disk+0x139/0x150
 [<c01f0251>] add_disk+0x51/0x60
 [<c01f01d0>] exact_match+0x0/0x10
 [<c01f01e0>] exact_lock+0x0/0x20
 [<c0213958>] idefloppy_attach+0x138/0x1c0
 [<c020870f>] ata_attach+0xdf/0x1b0
 [<c020971e>] ide_register_driver+0x10e/0x130
 [<c02139fe>] idefloppy_init+0x1e/0x30
 [<c03187bb>] do_initcalls+0x2b/0xa0
 [<c0128732>] init_workqueues+0x12/0x30
 [<c01050a1>] init+0x31/0x1b0
 [<c0105070>] init+0x0/0x1b0
 [<c0107419>] kernel_thread_helper+0x5/0xc

Sysfs refuses to make two directories for hdd4, but why is 'hdd: hdd4'
written twice?
Anyway, after that, the system boots well, and I can use the ZIP flawlessly.


Thanks in advance.
Guillaume





