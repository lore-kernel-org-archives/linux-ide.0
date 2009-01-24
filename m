From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] macide: use struct ide_port_info
Date: Sat, 24 Jan 2009 15:18:30 +0100
Message-ID: <200901241518.30926.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:28108 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063AbZAXOVZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 09:21:25 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] macide: use struct ide_port_info

This fixes hwif->channel and drive->dn assignments.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/macide.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: b/drivers/ide/macide.c
===================================================================
--- a/drivers/ide/macide.c
+++ b/drivers/ide/macide.c
@@ -80,6 +80,10 @@ static void __init macide_setup_ports(hw
 	hw->chipset = ide_generic;
 }
 
+static const struct ide_port_info macide_port_info = {
+	.host_flags		= IDE_HFLAG_NO_DMA,
+};
+
 static const char *mac_ide_name[] =
 	{ "Quadra", "Powerbook", "Powerbook Baboon" };
 
@@ -122,7 +126,7 @@ static int __init macide_init(void)
 
 	macide_setup_ports(&hw, base, irq, ack_intr);
 
-	return ide_host_add(NULL, hws, NULL);
+	return ide_host_add(&macide_port_info, hws, NULL);
 }
 
 module_init(macide_init);
