Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42364C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  1 Nov 2022 19:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKATxU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Nov 2022 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKATxU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2022 15:53:20 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Nov 2022 12:53:16 PDT
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874881BEA4
        for <linux-ide@vger.kernel.org>; Tue,  1 Nov 2022 12:53:16 -0700 (PDT)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=oXKoIKxSP85R+igYxobP+Cl5PAJys7riZg3Wmwo1tvQ=;
        b=oLbFn6xtjJ0wiOjBsq9a5oJcZo6oClfI2XqWx2S5VmafJ0f+L9PkBYQGRlRQto7kIoABb8R0TJeNi8sfV5aWU3dnGGa1KvkfDgg2JmfG3azTm25K+Hh80Vj8DzC2eclhHTKcxHzaYpqzA3QYMZ+vPeu/C/8hAMIYVanlBFyRCGKx4oZu6PNHdcC9shkC5ddULl4RDhE8VXDZ4/R+55kKBVLLndNoAZQmaLEQYwdgmctQ4IY9PozRVJcpPr
        TG6pk9cyxlh/V+P3uLZR5r2Cb3uvXmDtkqy2hP5n6RJ14tDWouJm6GnQeG9FzIJ5RhLT9QQyg9TOnF2T98JaJgeRscKg==
Received: from graph (86-122-18-201.dynamic.brasov.rdsnet.ro [86.122.18.201]) by mx1.wiredblade.com
 with ESMTPSA (version=TLSv1 cipher=AES128-SHA bits=128) ; Tue, 1 Nov 2022
 19:22:46 +0000
Message-ID: <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
From:   "Dinu Marius" <marius@psihoexpert.ro>
To:     <damien.lemoal@opensource.wdc.com>
Cc:     <linux-ide@vger.kernel.org>
Subject: Bug report for ahci-mvebu driver
Date:   Tue, 1 Nov 2022 21:21:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.4657
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
X-hMailServer-Reason-Score: 0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello.

I'm contacting you because your email is listed in www.kernel.org/doc/linux/MAINTAINERS
I encountered a problem with the ahci-mvebu driver. I think it's a bug.

Hardware:
Areca ARC-5040 RAID enclosure (DAS), eSATA port, 8 SATA drive bays with 1x 500GB HDD stand-alone and 7x 2TB HDDs in RAID5.
Linksys WRT-1900ACS v2 router, Marvell Armada 385 (88F6820), one eSATAp using ahci-mvebu driver with port-multiplier support.
The router runs OpenWrt with kernel version 5.15.

Problem encountered:
Areca DAS is not detected properly. When I connect it, I get these repeating errors in kernel log:

[--- from boot log ---]
<4>[    1.490840] ahci-mvebu f10a8000.sata: supply ahci not found, using dummy regulator
<4>[    1.498512] ahci-mvebu f10a8000.sata: supply phy not found, using dummy regulator
<4>[    1.506053] ahci-mvebu f10a8000.sata: supply target not found, using dummy regulator
<6>[    1.513896] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl platform mode
<6>[    1.522994] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs
<6>[    1.532212] scsi host0: ahci-mvebu
<6>[    1.535848] scsi host1: ahci-mvebu
<6>[    1.539353] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 49
<6>[    1.547313] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x180 irq 49

[--- Areca connected ---]
<6>[  742.795979] ata2: SATA link down (SStatus 100 SControl 300)
<3>[  745.465974] ata2: COMRESET failed (errno=-32)
<4>[  745.470361] ata2: reset failed (errno=-32), retrying in 8 secs
<3>[  755.365973] ata2: COMRESET failed (errno=-32)
<4>[  755.370361] ata2: reset failed (errno=-32), retrying in 8 secs
<6>[  764.655979] ata2: SATA link down (SStatus 100 SControl 300)
<6>[  766.045984] ata2: SATA link down (SStatus 101 SControl 300)
<6>[  767.576004] ata2: SATA link down (SStatus 100 SControl 300)
<6>[  768.325978] ata2: SATA link down (SStatus 100 SControl 300)
<3>[  770.865973] ata2: COMRESET failed (errno=-32)
<4>[  770.870360] ata2: reset failed (errno=-32), retrying in 8 secs
<6>[  779.515985] ata2: SATA link down (SStatus 101 SControl 300)
<6>[  780.275979] ata2: SATA link down (SStatus 100 SControl 300)

The same errors appear if I leave it connected during reboot.
I tried to limit SATA speed to 150 and to disable NCQ from Areca admin interface. It didn't work.
I found no way of making it work.

The same router works perfectly when I connect a laptop HDD.
The same DAS, including the same eSATA cable, works perfectly when connected to an older 
Linksys WRT-1900AC v1 with Marvell Armada XP (MV78230), using sata-mv driver. 
This is the kernel log from the older router:

[--- from boot log ---]
<7>[    1.612541] sata_mv f10a0000.sata: version 1.28
<6>[    1.612652] sata_mv f10a0000.sata: slots 32 ports 1
<6>[    1.618121] scsi host0: sata_mv
<6>[    1.621486] ata1: SATA max UDMA/133 irq 36

[--- Areca connected ---]
<6>[88761.966331] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
<6>[88761.975472] ata1.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 ports, feat 0xf/0x1f
<6>[88764.670933] ata1.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, max UDMA/133
<6>[88764.677860] ata1.00: 976773168 sectors, multi 0: LBA48
<6>[88764.683599] ata1.00: configured for UDMA/133
<6>[88764.688391] ata1.01: ATA-6: Areca   Archive, 0100 AX, max UDMA/133
<6>[88764.694596] ata1.01: 23437498368 sectors, multi 0: LBA48
<6>[88764.700779] ata1.01: configured for UDMA/133
<5>[88764.705557] scsi 0:0:0:0: Direct-Access     ATA      WDC WD50ARC-5040 n/a PQ: 0 ANSI: 5
<5>[88764.714802] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
<5>[88764.722521] sd 0:0:0:0: [sda] Write Protect is off
<7>[88764.727558] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
<5>[88764.727915] scsi 0:1:0:0: Direct-Access     ATA      Areca   Archive  n/a PQ: 0 ANSI: 5
<5>[88764.728706] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
<5>[88764.745574] sd 0:1:0:0: [sdb] 23437498368 512-byte logical blocks: (12.0 TB/10.9 TiB)
<5>[88764.753819] sd 0:1:0:0: [sdb] Write Protect is off
<7>[88764.758886] sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
<5>[88764.759101] sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
<5>[88764.760537] sd 0:0:0:0: [sda] Attached SCSI disk
<5>[88764.772600] sd 0:1:0:0: [sdb] Attached SCSI disk

I'm not currently using the new router, so it's available for tests.
Thanks.
Marius Dinu

