From: Mikael Pettersson <mikpe@it.uu.se>
Subject: 2.6.24-rc1 IDE regression on PMAC?
Date: Sat, 27 Oct 2007 19:56:20 +0200 (MEST)
Message-ID: <200710271756.l9RHuKub021729@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:59835 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbXJ0R41 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Oct 2007 13:56:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

As shown by this dmesg diff between 2.6.23 and 2.6.24-rc1,
IDE's PMAC driver now decides to downgrade itself to PIO2
on this box. Is this intensional or a bug?

--- dmesg-2.6.23
+++ dmesg-2.6.24-rc1
@@ -84,8 +89,9 @@
 ide0: Found Apple Heathrow ATA controller, bus ID 0, irq 28
 Probing IDE interface ide0...
 hda: MATSHITA CR-585, ATAPI CD/DVD-ROM drive
+hda: applying conservative PIO "downgrade"
+hda: host max PIO4 wanted PIO255(auto-tune) selected PIO2
 hda: selected mode 0x21
-hda: Enabling MultiWord DMA 1
 ide0 at 0xf1008000-0xf1008007,0xf1008160 on irq 28
 ide1: Found Apple Heathrow ATA controller, bus ID 1, irq 30
 Probing IDE interface ide1...

/Mikael
