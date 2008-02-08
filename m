From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/18] ide: remove init_hwif_default()
Date: Fri, 08 Feb 2008 01:46:26 +0100
Message-ID: <20080208004626.17746.19452.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:57863 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933985AbYBHAcT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 19:32:19 -0500
Received: by py-out-1112.google.com with SMTP id u52so5202641pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 16:32:16 -0800 (PST)
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

init_hwif_default() is only used by init_ide_data() now, inline it there.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -168,19 +168,6 @@ static void ide_port_init_devices_data(i
 }
 
 
-static void init_hwif_default(ide_hwif_t *hwif, unsigned int index)
-{
-	hw_regs_t hw;
-
-	memset(&hw, 0, sizeof(hw_regs_t));
-
-	ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
-
-	memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
-
-	hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
-}
-
 /*
  * init_ide_data() sets reasonable default values into all fields
  * of all instances of the hwifs and drives, but only on the first call.
@@ -201,9 +188,9 @@ static void init_hwif_default(ide_hwif_t
 #define MAGIC_COOKIE 0x12345678
 static void __init init_ide_data (void)
 {
-	ide_hwif_t *hwif;
 	unsigned int index;
 	static unsigned long magic_cookie = MAGIC_COOKIE;
+	hw_regs_t hw;
 
 	if (magic_cookie != MAGIC_COOKIE)
 		return;		/* already initialized */
@@ -211,9 +198,15 @@ static void __init init_ide_data (void)
 
 	/* Initialise all interface structures */
 	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = &ide_hwifs[index];
+		ide_hwif_t *hwif = &ide_hwifs[index];
+
 		ide_init_port_data(hwif, index);
-		init_hwif_default(hwif, index);
+
+		memset(&hw, 0, sizeof(hw));
+		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0,
+				    &hwif->irq);
+		memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
+		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
 #if !defined(CONFIG_PPC32) || !defined(CONFIG_PCI)
 		hwif->irq =
 			ide_init_default_irq(hwif->io_ports[IDE_DATA_OFFSET]);
