From: Pavel Troller <patrol@sinus.cz>
Subject: ide-cd in 2.6.10/11: BIG problem with burning audio CDs
Date: Thu, 3 Feb 2005 09:54:52 +0100
Message-ID: <20050203085452.GA22995@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from tangens.sinus.cz ([195.39.17.8]:17316 "HELO tangens.sinus.cz")
	by vger.kernel.org with SMTP id S262903AbVBCIy6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 03:54:58 -0500
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.12.11/8.12.11) with ESMTP id j138srAl027102
	for <linux-ide@vger.kernel.org>; Thu, 3 Feb 2005 09:54:53 +0100
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.12.11/8.12.11/Submit) id j138sqwA027101
	for linux-ide@vger.kernel.org; Thu, 3 Feb 2005 09:54:52 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi!
  I've subscribed to this list temporarily to search for a help with my problems
with burning audio CDs on a recent kernels.
  Before writing here, I tried to find a solution on the Net, but just a few
people reported similar problems, they were not identical to mine, and no
solution was even given to any of them. So I decided to try the luck here.
Please excuse me if my search was not perfect and I missed it somewhere.
  The problem is that on 2.6.10 and 2.6.11-rc[1-3], burning audio CDs consumes
so much CPU cycles, that my dual Athlon 1800+ system cannot serve the process
and cd burner dies of repeated buffer underruns or totally crashes, requiring
physical reset to revive (no ide bus reset is enough).
  The only workaround for this is to force a slow speed - 12x for burning, which
is the maximum the CPUs can handle. Otherwise, cdrecord shows that FIFO buffer
starts at about 100% and after burning about 20 - 30 MB of data, it starts to
get empty, about another 10 MBs it's at 0%, device buffer is then emptied and
the process fails. Enabling burnfree sometimes helps, but is not reliable as
well.
  Burning at 12x speed makes CPU load about 1.5. Using 16x speed goes above 2.0,
which means that my 2 not-so-slow CPUs cannot serve this at real time. All this
with cdrecord run by root from text console. Using graphical frontend like k3b
is of course even worse, because it requires its own CPU cycles.
  The last kernel which worked perfectly was 2.6.7. On 2.6.8, there was the mem
exhausting problem present, so I didn't use it at all, as well as I skipped
2.6.9.
  I think that it's more than simply not using DMA (which mentioned one of
people reporting a similar problem) because normally, even with DMA off, the
CPU should handle the necessary throughput required for at least 24x speed.
  Burning data CDs and using packet mode writing works reliably and at a full
speed with minimum CPU load.
  Is this problem known generally, or is it a very special condition (specific
chipset/CDROM drive combination etc.) that it's not observed generally ? I
can't believe that it's not fixed yet...
  The following are excerpts from dmesg output as well as some info about
the driver.
  I will be happy for any kind of reply!
                                 With regards, Pavel Troller

Linux version 2.6.11-rc3 (root@arcus) (gcc version 3.3.3 (propolice)) #2 SMP Thu Feb 3 07:08:20 CET 2005
...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 0000:00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: 0000:00:07.1 (rev 04) UDMA100 controller
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SONY CD-RW CRX300E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
hdc: ATAPI 12X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
...
root@arcus:~# cat /proc/ide/hdc/settings
Warning: /proc/ide/hd?/settings interface is obsolete, and will be removed soon!
name                    value           min             max             mode
----                    -----           ---             ---             ----
current_speed           66              0               70              rw
dsc_overlap             0               0               1               rw
init_speed              12              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
nice1                   1               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw

