From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 54321] New: Strange behaviour SD-->IDE(PATA) converter
Date: Sat, 23 Feb 2013 15:40:19 +0000 (UTC)
Message-ID: <bug-54321-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44312 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758248Ab3BWPka (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Feb 2013 10:40:30 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 65EB120237
	for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2013 15:40:22 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id BB81520230
	for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2013 15:40:20 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=54321

           Summary: Strange behaviour SD-->IDE(PATA) converter
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 3.8
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: forest76@gmail.com
        Regression: No


Hi, last time I bought SD-->IDE converter (on fc1306t chipset) to my Vaio
pcg-v505cp notebook (pentium M on Intel 855 chipset). After connected it (with
32G Medion SD class 6 SD card) and instaled ArchLinux distribution, I checked
out disk performance.

Dmesg seem to be fine (on my previously CF-->IDE adapter with 16G 233x CF card,
looks similar and everything working fine):

--------------------------------- dmesg --------------------------------


[    0.950448] libata version 3.00 loaded.
[    0.952659] ata_piix 0000:00:1f.1: version 2.13
[    0.952693] ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
[    0.952710] ata_piix 0000:00:1f.1: can't derive routing for PCI INT A
[    0.952805] ata_piix 0000:00:1f.1: setting latency timer to 64
[    0.960091] scsi0 : ata_piix
[    0.962763] scsi1 : ata_piix
[    0.964038] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x1860 irq 14
[    0.964050] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1868 irq 15
[    1.120227] ata2.01: NODEV after polling detection
[    1.123777] ata1.00: CFA: Memory Card Adapter, 67281306, max UDMA/66
[    1.123788] ata1.00: 61497344 sectors, multi 0: LBA 
[    1.123802] ata1.00: limited to UDMA/33 due to 40-wire cable
[    1.127477] ata2.00: ATAPI: UJDA745 DVD/CDRW, 1.05, max UDMA/33
[    1.130302] ata1.00: configured for UDMA/33
[    1.130643] scsi 0:0:0:0: Direct-Access     ATA      Memory Card Adap 6728
PQ: 0 ANSI: 5
[    1.135125] sd 0:0:0:0: [sda] 61497344 512-byte logical blocks: (31.4
GB/29.3 GiB)
[    1.135307] sd 0:0:0:0: [sda] Write Protect is off
[    1.135319] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.135397] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled,
doesn't support DPO or FUA
[    1.139221]  sda: sda1 sda2
[    1.140765] ata2.00: configured for UDMA/33
[    1.140995] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    1.144802] scsi 1:0:0:0: CD-ROM            MATSHITA UJDA745 DVD/CDRW 1.05
PQ: 0 ANSI: 5
[    1.178283] sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[    1.178298] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.179504] sr 1:0:0:0: Attached scsi CD-ROM sr0

--------------------------------------------------------------------------

but hdparm v9.43 (hdparm -i /dev/sda) show no selected current active mode:

---------------------------------- hdparm ---------------------------------

/dev/sda:

 Model=Memory Card Adapter, FwRev=67281306, SerialNo=0
 Config={ HardSect NotMFM Removeable DTR>10Mbs nonMagnetic }
 RawCHS=61009/16/63, TrkSize=2048, SectSize=512, ECCbytes=4
 BuffType=1Sect, BuffSize=1kB, MaxMultSect=1, MultSect=off
 CurCHS=61009/16/63, CurSects=61497072, LBA=yes, LBAsects=61497344
 IORDY=no, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 
 AdvancedPM=no
 Drive conforms to: unknown:  ATA/ATAPI-1,2,3,4,5,6

 * signifies the current active mode

------------------------------------------------------------------------

and disk performance is low (buffered disk reads about 9M/s due to hdparm
measurement). Moreover I can't get any information about DMA mode. (hdparm -v
/dev/sda don't display dma field at all). In normal desktop works I see
significant degrees in compare to CF-->IDE converter.

When I tested this configuration DOS lowlevel program it show me excelent read
performance (about 35M/s), so I preclude hardware or compability problems.


Greetings, and sorry for english grammar mistakes.
Miroslaw

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
