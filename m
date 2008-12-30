From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Question with AHCI and (UDMA/100 vs. UDMA/133)
Date: Tue, 30 Dec 2008 07:25:53 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0812300651190.11356@p34.internal.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:32853 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbYL3MZy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2008 07:25:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Do some chipsets (SiI 3132 vs. Intel ICH9) run certain drives at UDMA/100 
vs. UDMA/133?

I have several 750GB WD drives (exact make/model) and the ones on the 
intel chipset show up as:

[    1.407321] ata3.00: ATA-7: WDC WD7500AAKS-00RBA0, 30.04G30, max UDMA/133
[    1.407409] ata3.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.408300] ata3.00: configured for UDMA/133

The ones on the SiI 3132 chipset show up as:

[    9.604413] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    9.619024] ata11.00: ATA-7: WDC WD7500AAKS-00RBA0, 30.04G30, max UDMA/133
[    9.619111] ata11.00: 1465149168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    9.620029] ata11.00: configured for UDMA/100

If they are both 3.0 Gbps, are they both the same speed even though one is 
configured for a slower speed than the other?

Or is it the case that the SiI 3132 does not support AHCI and that is the 
reason for the difference?  Does it make any difference in performance?

SiI Controller:
02:00.0 RAID bus controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid 
II Controller (rev 01)

Intel Controller:
00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 
port SATA AHCI Controller (rev 02)

