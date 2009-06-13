From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ata: add ata_id_pio_need_iordy() helper
Date: Sat, 13 Jun 2009 18:21:06 +0200
Message-ID: <200906131821.07018.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f206.google.com ([209.85.220.206]:65246 "EHLO
	mail-fx0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862AbZFMQdZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Jun 2009 12:33:25 -0400
Received: by fxm2 with SMTP id 2so34418fxm.37
        for <linux-ide@vger.kernel.org>; Sat, 13 Jun 2009 09:33:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

Cc: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
against Linus' tree

 include/linux/ata.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: b/include/linux/ata.h
===================================================================
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -800,6 +800,17 @@ static inline int ata_id_is_ssd(const u1
 	return id[ATA_ID_ROT_SPEED] == 0x01;
 }
 
+static inline int ata_id_pio_need_iordy(const u16 *id, const u8 pio)
+{
+	/* CF spec. r4.1 Table 22 says no IORDY on PIO5 and PIO6.  */
+	if (ata_id_is_cfa(id) && pio > 4)
+		return 0;
+	/* PIO3 and higher it is mandatory. */
+	if (pio > 2 || ata_id_has_iordy(id))
+		return 1;
+	return 0;
+}
+
 static inline int ata_drive_40wire(const u16 *dev_id)
 {
 	if (ata_id_is_sata(dev_id))
