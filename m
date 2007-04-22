From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.21-rc7] sata_promise: SATAII-150/300 TX4 port numbering fix
Date: Mon, 23 Apr 2007 00:28:36 +0200 (MEST)
Message-ID: <200704222228.l3MMSadi026578@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:61340 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371AbXDVW2m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Apr 2007 18:28:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

There is a known problem with sata_promise on SATAII-150/300 TX4
controller cards: it enumerates drives in an order that differs
from the port numbers printed on the controller cards. However,
Promise's BIOS and Linux driver both get the order right.

I investigated Promise's Linux driver (v1.01.0.23), and found
that it explicitly changes the mapping from logical port number
to ATA engine MMIO address on the SATAII TX4 cards. It does this
on all SATAII TX4 cards, without inspecting revision etc. The
SATAII TX2plus cards continue to use the same mapping that was
used for the first-generation chips.

This patch updates sata_promise to use the new port number to
ATA engine mapping on SATAII TX4 cards, which fixes the drive
enumeration order problem on those cards. Tested on 300 TX4,
300 TX2plus, and SATAII-150 TX2plus chips.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
This patch should apply to 2.6.21-rc7 and libata#upstream.
It won't apply to libata#ALL because of the massive changes
for the new init model. I will do a new and cleaner patch for
#ALL once I can get it as a patch in -mm (I don't do git).

--- linux-2.6.21-rc7/drivers/ata/sata_promise.c.~1~	2007-04-23 00:17:35.000000000 +0200
+++ linux-2.6.21-rc7/drivers/ata/sata_promise.c	2007-04-23 00:18:06.000000000 +0200
@@ -989,7 +989,13 @@ static int pdc_ata_init_one (struct pci_
 	switch (board_idx) {
 	case board_40518:
 		hp->flags |= PDC_FLAG_GEN_II;
-		/* Fall through */
+		printk(KERN_INFO DRV_NAME ": applying SATAII-150/300 TX4 port numbering workaround\n");
+		probe_ent->n_ports = 4;
+		pdc_ata_setup_port(&probe_ent->port[2], base + 0x200, base + 0x400);
+		pdc_ata_setup_port(&probe_ent->port[1], base + 0x280, base + 0x500);
+		pdc_ata_setup_port(&probe_ent->port[3], base + 0x300, base + 0x600);
+		pdc_ata_setup_port(&probe_ent->port[0], base + 0x380, base + 0x700);
+		break;
 	case board_20319:
        		probe_ent->n_ports = 4;
 		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300, base + 0x600);
