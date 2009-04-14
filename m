From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13086] New: pata_via can't initialize 2nd HDD on VIA VX800
 chipsets (problem in via_tf_load)
Date: Tue, 14 Apr 2009 05:55:33 GMT
Message-ID: <bug-13086-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:54673 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbZDNFze (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2009 01:55:34 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n3E5tX84027370
	for <linux-ide@vger.kernel.org>; Tue, 14 Apr 2009 05:55:33 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13086

           Summary: pata_via can't initialize 2nd HDD on VIA VX800
                    chipsets (problem in via_tf_load)
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.28.9
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: chris@bispingweb.de
        Regression: No


I'm using Ubuntu 9.04 Server beta (Kernel 2.6.28.9) on a VIA ARTiGO A2000
barebone system (VIA C7-D, VX800 chipset, see
http://www.via.com.tw/en/products/embedded/artigo/a2000).

My boot device is a CF-card connected to the 1st (and only) PATA port. On the
1st SATA port I've attached a hdd which is working fine with acceptable
performance. Now I've tried to connect another hdd to the 2nd SATA port ...
without success.

It seems that the pata_via module can't initialize the 2nd (SATA) hdd:

[ 3.142195] pata_via 0000:00:0f.0: version 0.3.3
[ 3.142461] scsi0 : pata_via
[ 3.142661] scsi1 : pata_via
[ 3.146248] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
[ 3.146255] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
[ 3.316571] ata1.00: ATA-8: WDC WD10EACS-00D6B1, 01.01A01, max UDMA/133
[ 3.316578] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[ 3.316751] ata1.01: ATA-8: SAMSUNG HD501LJ, CR100-11, max UDMA7
[ 3.316757] ata1.01: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[ 3.324580] ata1.00: configured for UDMA/133
[ 3.340339] ata1.01: failed to set xfermode (err_mask=0x1)
[ 8.496854] ata1.00: configured for UDMA/133
[ 8.512338] ata1.01: failed to set xfermode (err_mask=0x1)
[ 8.512397] ata1.01: limiting speed to UDMA/133:PIO3
[ 13.637110] ata1.00: configured for UDMA/133
[ 13.652338] ata1.01: failed to set xfermode (err_mask=0x1)
[ 13.652393] ata1.01: disabled
[ 13.661144] ata1.00: configured for UDMA/133
[ 13.816526] ata2.00: CFA: SanDisk SDCFX3-004G, HDX 4.32, max UDMA/66
[ 13.816533] ata2.00: 8027712 sectors, multi 0: LBA
[ 13.817033] ata2.00: configured for UDMA/66

When I switch the two drives, the problem also switches.

I was able to track down the problem to the via_tf_load function in pata_via.c
and found a proposed patch in http://markmail.org/message/bildjl47nchykx3i

After applying the patch, everything seems to work as expected.

Please consider integrating the changes in future kernels.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
