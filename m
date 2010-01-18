From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 29/64] alim15x3: cleanup ali_cable_detect()
Date: Mon, 18 Jan 2010 18:18:07 +0100
Message-ID: <20100118171807.14623.50469.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:39792 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab0ARRTV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:19:21 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] alim15x3: cleanup ali_cable_detect()

Remove leftover local_irq_[save,restore]() and FIXME note.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/alim15x3.c |    8 --------
 1 file changed, 8 deletions(-)

Index: b/drivers/ide/alim15x3.c
===================================================================
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -345,19 +345,13 @@ static int ali_cable_override(struct pci
  *
  *	This checks if the controller and the cable are capable
  *	of UDMA66 transfers. It doesn't check the drives.
- *	But see note 2 below!
- *
- *	FIXME: frobs bits that are not defined on newer ALi devicea
  */
 
 static u8 ali_cable_detect(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	unsigned long flags;
 	u8 cbl = ATA_CBL_PATA40, tmpbyte;
 
-	local_irq_save(flags);
-
 	if (m5229_revision >= 0xC2) {
 		/*
 		 * m5229 80-pin cable detection (from Host View)
@@ -377,8 +371,6 @@ static u8 ali_cable_detect(ide_hwif_t *h
 		}
 	}
 
-	local_irq_restore(flags);
-
 	return cbl;
 }
 
