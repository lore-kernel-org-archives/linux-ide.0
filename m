From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14310] New: [bisected] 2.6.31 regression sis5513 PIO Mode 0
 hang
Date: Sat, 3 Oct 2009 02:52:52 GMT
Message-ID: <bug-14310-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:39107 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbZJCCws (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Oct 2009 22:52:48 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n932qqWW032182
	for <linux-ide@vger.kernel.org>; Sat, 3 Oct 2009 02:52:52 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14310

           Summary: [bisected] 2.6.31 regression sis5513 PIO Mode 0 hang
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.31
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: David@Fries.net
        Regression: Yes


I just did a git bisection from 2.6.30 to 2.6.31 because 2.6.31 will
not boot on this system.  d.stussy@yahoo.com's post September 12th
looks the same, different CPU but both have sis5513 IDE chips.  His
would normally init the ethernet chip next, mine would do PS/2 next,
both hang right after the Uniform CD-ROM message.

This was bisected down to chaging PIO mode 0 for probing.  What
problem was that patch trying to solve?  Reverting just that patch at
the top of 2.6.31 tree works.  I can test patches.

Uniform Multi-Platform E-IDE driver
sis5513 0000:00:02.5: SiS635 ATA 100 (2nd gen) controller
sis5513 0000:00:02.5: IDE controller (0x1039:0x5513 rev 0xd0)
sis5513 0000:00:02.5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07
    ide1: BM-DMA at 0xff08-0xff0f
Probing IDE interface ide0...
Switched to high resolution mode on CPU 0
hda: ST3250823A, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive
hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/33 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide_generic: please use "probe_mask=0x3f" module parameter for probing all
legacy ISA IDE ports
ide-gd driver 1.18
hda: max request size: 512KiB
hda: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63
hda: cache flushes supported
 hda: hda1 hda2 hda3
ide-cd driver 5.00
ide-cd: hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
<hang>

commit 6029336426a2b43e4bc6f4a84be8789a047d139e
Author: Joao Ramos <joao.ramos@inov.pt>
Date:   Sun May 17 17:22:54 2009 +0200

    ide: try to use PIO Mode 0 during probe if possible

    Initially set PIO Mode 0 for all host drivers that have a 'set_pio_mode'
    method before the IDE core figures out the most suited PIO mode for the
    attached device.

    Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
    Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 7f264ed..b609a58 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1032,6 +1032,15 @@ static void ide_port_init_devices(ide_hwif_t *hwif)
         if (port_ops && port_ops->init_dev)
             port_ops->init_dev(drive);
     }
+
+    ide_port_for_each_dev(i, drive, hwif) {
+        /*
+         * default to PIO Mode 0 before we figure out
+         * the most suited mode for the attached device
+         */
+        if (port_ops && port_ops->set_pio_mode)
+            port_ops->set_pio_mode(drive, 0);
+    }
 }

 static void ide_init_port(ide_hwif_t *hwif, unsigned int port,



vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Samuel 2

lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 635 Host (rev 11)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge
(AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC
Bridge)
00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus Controller
00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.1 Controller
(rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.1 Controller
(rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controller (rev a0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] AC'97
Sound Controller (rev a0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast
Ethernet (rev 90)
00:09.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video and Audio
Decoder (rev 05)
00:09.2 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and Audio
Decoder [MPEG Port] (rev 05)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 315PRO
PCI/AGP VGA Display Adapter

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
