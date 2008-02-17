From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/5] ide-generic: use ide_find_port()
Date: Sun, 17 Feb 2008 19:51:33 +0100
Message-ID: <20080217185133.16210.73293.sendpatchset@localhost.localdomain>
References: <20080217185105.16210.26582.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:63272 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbYBQSg6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 13:36:58 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1438294fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 10:36:57 -0800 (PST)
In-Reply-To: <20080217185105.16210.26582.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -90,18 +90,27 @@ static int __init ide_generic_init(void)
 	int i;
 
 	for (i = 0; i < MAX_HWIFS; i++) {
-		ide_hwif_t *hwif = &ide_hwifs[i];
+		ide_hwif_t *hwif;
 		unsigned long io_addr = ide_default_io_base(i);
 		hw_regs_t hw;
 
-		if (hwif->chipset == ide_unknown && io_addr) {
-			u8 oldnoprobe = hwif->noprobe;
+		if (io_addr) {
+			u8 oldnoprobe;
+
+			/*
+			 * Skip probing if the corresponding
+			 * slot entry is already occupied.
+			 */
+			hwif = ide_find_port();
+			if (hwif == NULL || hwif->index != i)
+				continue;
 
 			memset(&hw, 0, sizeof(hw));
 			ide_std_init_ports(&hw, io_addr, io_addr + 0x206);
 			hw.irq = ide_default_irq(io_addr);
-			ide_init_port_hw(hwif, &hw);
 
+			oldnoprobe = hwif->noprobe;
+			ide_init_port_hw(hwif, &hw);
 			hwif->noprobe = oldnoprobe;
 
 			idx[i] = i;
