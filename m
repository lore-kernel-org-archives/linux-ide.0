From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream] libata: implement dump_id force param
Date: Sun, 23 May 2010 12:59:11 +0200
Message-ID: <4BF90A7F.80309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50228 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab0EWK7Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 May 2010 06:59:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Larry Baker <baker@usgs.gov>

Add dump_id libata.force parameter.  If specified, libata dumps full
IDENTIFY data during device configuration.  This is to aid debugging.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Larry Baker <baker@usgs.gov>
---
 Documentation/kernel-parameters.txt |    2 ++
 drivers/ata/libata-core.c           |    9 +++++++++
 include/linux/libata.h              |    1 +
 3 files changed, 12 insertions(+)

Index: ata/drivers/ata/libata-core.c
===================================================================
--- ata.orig/drivers/ata/libata-core.c
+++ ata/drivers/ata/libata-core.c
@@ -2122,6 +2122,14 @@ retry:
 		goto err_out;
 	}

+	if (dev->horkage & ATA_HORKAGE_DUMP_ID) {
+		ata_dev_printk(dev, KERN_DEBUG, "dumping IDENTIFY data, "
+			       "class=%d may_fallback=%d tried_spinup=%d\n",
+			       class, may_fallback, tried_spinup);
+		print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET,
+			       16, 2, id, ATA_ID_WORDS * sizeof(*id), true);
+	}
+
 	/* Falling back doesn't make sense if ID data was read
 	 * successfully at least once.
 	 */
@@ -6372,6 +6380,7 @@ static int __init ata_parse_force_one(ch
 		{ "3.0Gbps",	.spd_limit	= 2 },
 		{ "noncq",	.horkage_on	= ATA_HORKAGE_NONCQ },
 		{ "ncq",	.horkage_off	= ATA_HORKAGE_NONCQ },
+		{ "dump_id",	.horkage_on	= ATA_HORKAGE_DUMP_ID },
 		{ "pio0",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 0) },
 		{ "pio1",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 1) },
 		{ "pio2",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 2) },
Index: ata/include/linux/libata.h
===================================================================
--- ata.orig/include/linux/libata.h
+++ ata/include/linux/libata.h
@@ -386,6 +386,7 @@ enum {
 	ATA_HORKAGE_1_5_GBPS	= (1 << 13),	/* force 1.5 Gbps */
 	ATA_HORKAGE_NOSETXFER	= (1 << 14),	/* skip SETXFER, SATA only */
 	ATA_HORKAGE_BROKEN_FPDMA_AA	= (1 << 15),	/* skip AA */
+	ATA_HORKAGE_DUMP_ID	= (1 << 16),	/* dump IDENTIFY data */

 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
Index: ata/Documentation/kernel-parameters.txt
===================================================================
--- ata.orig/Documentation/kernel-parameters.txt
+++ ata/Documentation/kernel-parameters.txt
@@ -1227,6 +1227,8 @@ and is between 256 and 4096 characters.
 			* nohrst, nosrst, norst: suppress hard, soft
                           and both resets.

+			* dump_id: dump IDENTIFY data.
+
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.

