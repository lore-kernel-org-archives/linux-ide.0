Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21708C3F2DB
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0768921741
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgCCJjp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:47674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbgCCJjp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A4706B1E1;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/40] libata: move __func__ into ata_{port,link,dev}_dbg() helper
Date:   Tue,  3 Mar 2020 10:37:38 +0100
Message-Id: <20200303093813.18523-6-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Move the __func__ argument into the ata_{port,link,dev}_dbg()
helper and drop the explicit argument from the caller.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-acpi.c | 14 ++++++--------
 drivers/ata/libata-core.c |  9 ++++-----
 drivers/ata/libata-sff.c  |  2 +-
 include/linux/libata.h    |  6 +++---
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 9a7c25252e50..d5bcf5718fd3 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -419,8 +419,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
 
 	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev, "%s: ENTER: port#: %d\n",
-			    __func__, ap->port_no);
+		ata_dev_dbg(dev, "ENTER: port#: %d\n", ap->port_no);
 
 	/* _GTF has no input parameters */
 	status = acpi_evaluate_object(ata_dev_acpi_handle(dev), "_GTF", NULL,
@@ -438,8 +437,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 
 	if (!output.length || !output.pointer) {
 		if (ata_msg_probe(ap))
-			ata_dev_dbg(dev, "%s: Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
-				    __func__,
+			ata_dev_dbg(dev, "Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
 				    (unsigned long long)output.length,
 				    output.pointer);
 		rc = -EINVAL;
@@ -465,8 +463,8 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 	if (gtf) {
 		*gtf = (void *)out_obj->buffer.pointer;
 		if (ata_msg_probe(ap))
-			ata_dev_dbg(dev, "%s: returning gtf=%p, gtf_count=%d\n",
-				    __func__, *gtf, rc);
+			ata_dev_dbg(dev, "returning gtf=%p, gtf_count=%d\n",
+				    *gtf, rc);
 	}
 	return rc;
 
@@ -780,8 +778,8 @@ static int ata_acpi_push_id(struct ata_device *dev)
 	union acpi_object in_params[1];
 
 	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev, "%s: ix = %d, port#: %d\n",
-			    __func__, dev->devno, ap->port_no);
+		ata_dev_dbg(dev, "ix = %d, port#: %d\n",
+			    dev->devno, ap->port_no);
 
 	/* Give the drive Identify data to the drive via the _SDD method */
 	/* _SDD: set up input parameters */
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5bf6e4da218a..3a8af0fef540 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1846,7 +1846,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	int rc;
 
 	if (ata_msg_ctl(ap))
-		ata_dev_dbg(dev, "%s: ENTER\n", __func__);
+		ata_dev_dbg(dev, "ENTER\n");
 
 retry:
 	ata_tf_init(dev, &tf);
@@ -2447,7 +2447,7 @@ int ata_dev_configure(struct ata_device *dev)
 	}
 
 	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev, "%s: ENTER\n", __func__);
+		ata_dev_dbg(dev, "ENTER\n");
 
 	/* set horkage */
 	dev->horkage |= ata_dev_blacklisted(dev);
@@ -2498,9 +2498,8 @@ int ata_dev_configure(struct ata_device *dev)
 	/* print device capabilities */
 	if (ata_msg_probe(ap))
 		ata_dev_dbg(dev,
-			    "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
+			    "cfg 49:%04x 82:%04x 83:%04x 84:%04x "
 			    "85:%04x 86:%04x 87:%04x 88:%04x\n",
-			    __func__,
 			    id[49], id[82], id[83], id[84],
 			    id[85], id[86], id[87], id[88]);
 
@@ -2767,7 +2766,7 @@ int ata_dev_configure(struct ata_device *dev)
 
 err_out_nosup:
 	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev, "%s: EXIT, err\n", __func__);
+		ata_dev_dbg(dev, "EXIT, err\n");
 	return rc;
 }
 
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 038db94216a9..277398427e4e 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1266,7 +1266,7 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
 	ap->sff_pio_task_link = NULL;
 
 	if (ata_msg_ctl(ap))
-		ata_port_dbg(ap, "%s: EXIT\n", __func__);
+		ata_port_dbg(ap, "EXIT\n");
 }
 
 static void ata_sff_pio_task(struct work_struct *work)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6b1ffb78a410..508f501095c9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1424,7 +1424,7 @@ static inline int sata_srst_pmp(struct ata_link *link)
 #define ata_port_info(ap, fmt, ...)				\
 	dev_info(&ap->tdev, fmt, ##__VA_ARGS__)
 #define ata_port_dbg(ap, fmt, ...)				\
-	dev_dbg(&ap->tdev, fmt, ##__VA_ARGS__)
+	dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
 
 #define ata_link_err(link, fmt, ...)				\
 	dev_err(&link->tdev, fmt, ##__VA_ARGS__)
@@ -1435,7 +1435,7 @@ static inline int sata_srst_pmp(struct ata_link *link)
 #define ata_link_info(link, fmt, ...)				\
 	dev_info(&link->tdev, fmt, ##__VA_ARGS__)
 #define ata_link_dbg(link, fmt, ...)				\
-	dev_dbg(&link->tdev, fmt, ##__VA_ARGS__)
+	dev_dbg(&link->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
 
 #define ata_dev_err(dev, fmt, ...)				\
 	dev_err(&dev->tdev, fmt, ##__VA_ARGS__)
@@ -1446,7 +1446,7 @@ static inline int sata_srst_pmp(struct ata_link *link)
 #define ata_dev_info(dev, fmt, ...)				\
 	dev_info(&dev->tdev, fmt, ##__VA_ARGS__)
 #define ata_dev_dbg(dev, fmt, ...)				\
-	dev_dbg(&dev->tdev, fmt, ##__VA_ARGS__)
+	dev_dbg(&dev->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
 
 void ata_print_version(const struct device *dev, const char *version);
 
-- 
2.16.4

