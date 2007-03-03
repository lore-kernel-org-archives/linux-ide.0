From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.21-rc2] pata_legacy: fix io/irq mismatch
Date: Sat, 3 Mar 2007 20:57:44 +0100 (MET)
Message-ID: <200703031957.l23JviQQ005254@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48662 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbXCCT5z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Mar 2007 14:57:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@redhat.com
Cc: linux-ide@vger.kernel.org

pata_legacy fails to detect the disk on my old ISA/VLB 486:
it starts to probe io=0x1f0 ctr=0x3f6 irq=15, complains
loudly about IDENTIFYs timing out, and finally fails.
(Sorry I couldn't capture the kernel's boot messages.)

It turns out that the driver's mapping from io to irq in
legacy_irq[] is wrong: index 0 for io=0x1f0 has irq=15 but
should have irq=14, and index 1 for io=0x170 has irq=14 but
should have irq=15. This is confirmed by a comparison with
include/asm-i386/ide.h:ide_default_irq().

This patch swaps the first two elements in legacy_irq[],
which makes pata_legacy work on my 486.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.21-rc2/drivers/ata/pata_legacy.c.~1~	2007-02-28 13:32:46.000000000 +0100
+++ linux-2.6.21-rc2/drivers/ata/pata_legacy.c	2007-03-03 18:40:37.000000000 +0100
@@ -69,7 +69,7 @@
 #define NR_HOST 6
 
 static int legacy_port[NR_HOST] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
-static int legacy_irq[NR_HOST] = { 15, 14, 11, 10, 8, 12 };
+static int legacy_irq[NR_HOST] = { 14, 15, 11, 10, 8, 12 };
 
 struct legacy_data {
 	unsigned long timing;
