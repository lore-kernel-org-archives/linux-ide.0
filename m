From: James Cloos <cloos@jhcloos.com>
Subject: AMD 890GX vs 6Gbps SATA?
Date: Sun, 14 Nov 2010 12:50:41 -0500
Message-ID: <m3mxpbn69i.fsf@jhcloos.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eagle.jhcloos.com ([207.210.242.212]:44648 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637Ab0KNSHf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Nov 2010 13:07:35 -0500
Received: from carbon (localhost [127.0.0.1])
	by carbon.jhcloos.org (Postfix) with ESMTP id 60FD330003C
	for <linux-ide@vger.kernel.org>; Sun, 14 Nov 2010 17:50:42 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

All of the ad copy and doc I can find claim that the sata controller in
the 890gx supports 6Gbps sata3.  But I still get this:

ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-8: WDC WD1002FAEX-xxxxxx, 05.xxxxx, max UDMA/133

I hadn't noticed before because that box's first drive only supports 3 Gbps.

Does the 6Gpbs mode require that all of the disks are sata3?  (That would
be /most/ annoying, given that optical drives all seem to be 1.5Gbps.)

Did MSI screw something up on the board?

Or is the ad copy exaggerative?

I took a look though the bios config; I didn't find anything relevant.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
