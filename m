From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/02] sata_mv: workaround for multi_count errata sata24
Date: Mon, 13 Apr 2009 11:29:34 -0400
Message-ID: <49E35A5E.4020204@rtr.ca>
References: <49E359D6.1090309@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:60649 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbZDMP3g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 11:29:36 -0400
In-Reply-To: <49E359D6.1090309@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Workaround for errata SATA#24 in sata_mv.
This errata affects WRITE_MULTI* commands when
the device multi_count produces a DRQ block size >= 4Kbytes.

We work around it here by converting such operations
into ordinary PIO_WRITEs instead.

Note that this might result in a PIO FUA write unavoidably being converted
into a non-FUA write.  In practice, any system using FUA is also going to be
using DMA rather than PIO, so this shouldn't affect anyone in the real world.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
For upstream-linus, please.

--- old/drivers/ata/sata_mv.c.upstream	2009-04-13 09:46:51.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-04-13 10:11:26.000000000 -0400
@@ -1881,6 +1881,39 @@
 	return status;
 }
 
+static void mv_rw_multi_errata_sata24(struct ata_queued_cmd *qc)
+{
+	struct ata_taskfile *tf = &qc->tf;
+	/*
+	 * Workaround for 88SX60x1 FEr SATA#24.
+	 *
+	 * Chip may corrupt WRITEs if multi_count >= 4kB.
+	 * Note that READs are unaffected.
+	 *
+	 * It's not clear if this errata really means "4K bytes",
+	 * or if it always happens for multi_count > 7
+	 * regardless of device sector_size.
+	 *
+	 * So, for safety, any write with multi_count > 7
+	 * gets converted here into a regular PIO write instead:
+	 */
+	if ((tf->flags & ATA_TFLAG_WRITE) && is_multi_taskfile(tf)) {
+		if (qc->dev->multi_count > 7) {
+			switch (tf->command) {
+			case ATA_CMD_WRITE_MULTI:
+				tf->command = ATA_CMD_PIO_WRITE;
+				break;
+			case ATA_CMD_WRITE_MULTI_FUA_EXT:
+				tf->flags &= ~ATA_TFLAG_FUA; /* ugh */
+				/* fall through */
+			case ATA_CMD_WRITE_MULTI_EXT:
+				tf->command = ATA_CMD_PIO_WRITE_EXT;
+				break;
+			}
+		}
+	}
+}
+
 /**
  *      mv_qc_prep - Host specific command preparation.
  *      @qc: queued command to prepare
@@ -1902,9 +1935,16 @@
 	u16 flags = 0;
 	unsigned in_index;
 
-	if ((tf->protocol != ATA_PROT_DMA) &&
-	    (tf->protocol != ATA_PROT_NCQ))
+	switch (tf->protocol) {
+	case ATA_PROT_DMA:
+	case ATA_PROT_NCQ:
+		break;	/* continue below */
+	case ATA_PROT_PIO:
+		mv_rw_multi_errata_sata24(qc);
+		return;
+	default:
 		return;
+	}
 
 	/* Fill in command request block
 	 */
