From: Alex Murphy <murphy@sgtp.samara.ru>
Subject: Promise TX4200 with kernel 2.6.x
Date: Fri, 22 Jul 2005 10:25:38 +0500
Message-ID: <200507221025.38299.murphy@sgtp.samara.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.sgtp.samara.ru ([195.128.153.202]:7901 "EHLO sgtp.samara.ru")
	by vger.kernel.org with ESMTP id S262042AbVGVGIw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jul 2005 02:08:52 -0400
Received: from bene.samgtp ([192.168.1.4] verified)
  by sgtp.samara.ru (CommuniGate Pro SMTP 4.3c2)
  with ESMTP id 340545 for linux-ide@vger.kernel.org; Fri, 22 Jul 2005 11:15:08 +0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com

Hello!

 I ask a pardon for the letter, but I see, that you are maintener kernels 
linux in the field of promise raid adapters. At me is new promise tx-4200 
sata raid, its kernel now does not support, probably there are patches 
including such support for linux 2.6.x kernel ?

Yours faithfully, Alexey.

lspci -v
0000:00:0d.0 RAID bus controller: Promise Technology, Inc. PDC40519 (FastTrak 
TX4200) (rev 02)
        Subsystem: Promise Technology, Inc. PDC40519 (FastTrak TX4200)
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
        I/O ports at b000 [size=128]
        I/O ports at ec00 [size=256]
        Memory at fde00000 (32-bit, non-prefetchable) [size=4K]
        Memory at fdd00000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fdc00000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2

lspci -nv
0000:00:0d.0 Class 0104: 105a:3519 (rev 02)
        Subsystem: 105a:3519
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
        I/O ports at b000 [size=128]
        I/O ports at ec00 [size=256]
        Memory at fde00000 (32-bit, non-prefetchable) [size=4K]
        Memory at fdd00000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fdc00000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
