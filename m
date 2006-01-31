From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: PATA vs. SATA
Date: Mon, 30 Jan 2006 16:49:17 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0601301639270.6538@shark.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:34247 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965053AbWAaAtR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2006 19:49:17 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2006 16:49:17 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


It's confusing enough using libata for PATA/IDE instead of
drivers/ide/* and using a PIIX driver for SATA.  :)

Yes, it Works For Me.  However, I see this one little thing
that still seems odd to me.


Intel SATA controller in IDE mode:  libata-core says:

ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
      ~~~~
 This ^^^^ is the confusing part to me.

Intel SATA controller in AHCI (SATA) mode:  libata-core says:

ata1: SATA max UDMA/133 cmd 0x30C8 ctl 0x30E6 bmdma 0x30A0 irq 193
ata2: SATA max UDMA/133 cmd 0x30C0 ctl 0x30E2 bmdma 0x30A8 irq 193

Yes, ata_piix.c sets host_flags: ATA_FLAG_SATA in this case.
What does it do?  What is it for?  (this flag)

Yes, lspci reports SATA controller in IDE mode.

Thanks,
-- 
~Randy
