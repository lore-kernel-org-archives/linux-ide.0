Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99F3C3F2D9
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F4E205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgCCJjp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:47514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgCCJjp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2C6A7B1D1;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/40] libata: move ata_{port,link,dev}_dbg to standard dev_XXX() macros
Date:   Tue,  3 Mar 2020 10:37:37 +0100
Message-Id: <20200303093813.18523-5-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use standard dev_{dbg,info,notice,warn,err} macros instead of the
hand-crafted printk helpers.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/ahci.c        |  3 +--
 drivers/ata/libata-acpi.c | 48 ++++++++++++++++++++-----------------
 drivers/ata/libata-core.c | 61 -----------------------------------------------
 include/linux/libata.h    | 48 +++++++++++++------------------------
 4 files changed, 43 insertions(+), 117 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 11ea1aff40db..77aa657e7c45 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -798,8 +798,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 				(sstatus & 0xf) != 1)
 			break;
 
-		ata_link_printk(link, KERN_INFO, "avn bounce port%d\n",
-				port);
+		ata_link_info(link, "avn bounce port%d\n", port);
 
 		pci_read_config_word(pdev, 0x92, &val);
 		val &= ~(1 << port);
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 224e3486e9a5..9a7c25252e50 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -649,9 +649,7 @@ static int ata_acpi_run_tf(struct ata_device *dev,
 	struct ata_taskfile *pptf = NULL;
 	struct ata_taskfile tf, ptf, rtf;
 	unsigned int err_mask;
-	const char *level;
 	const char *descr;
-	char msg[60];
 	int rc;
 
 	if ((gtf->tf[0] == 0) && (gtf->tf[1] == 0) && (gtf->tf[2] == 0)
@@ -665,6 +663,10 @@ static int ata_acpi_run_tf(struct ata_device *dev,
 		pptf = &ptf;
 	}
 
+	descr = ata_get_cmd_descript(tf.command);
+	if (!descr)
+		descr = "unknown";
+
 	if (!ata_acpi_filter_tf(dev, &tf, pptf)) {
 		rtf = tf;
 		err_mask = ata_exec_internal(dev, &rtf, NULL,
@@ -672,40 +674,42 @@ static int ata_acpi_run_tf(struct ata_device *dev,
 
 		switch (err_mask) {
 		case 0:
-			level = KERN_DEBUG;
-			snprintf(msg, sizeof(msg), "succeeded");
+			ata_dev_dbg(dev,
+				"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
+				"(%s) succeeded\n",
+				tf.command, tf.feature, tf.nsect, tf.lbal,
+				tf.lbam, tf.lbah, tf.device, descr);
 			rc = 1;
 			break;
 
 		case AC_ERR_DEV:
-			level = KERN_INFO;
-			snprintf(msg, sizeof(msg),
-				 "rejected by device (Stat=0x%02x Err=0x%02x)",
-				 rtf.command, rtf.feature);
+			ata_dev_info(dev,
+				"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
+				"(%s) rejected by device (Stat=0x%02x Err=0x%02x)",
+				tf.command, tf.feature, tf.nsect, tf.lbal,
+				tf.lbam, tf.lbah, tf.device, descr,
+				rtf.command, rtf.feature);
 			rc = 0;
 			break;
 
 		default:
-			level = KERN_ERR;
-			snprintf(msg, sizeof(msg),
-				 "failed (Emask=0x%x Stat=0x%02x Err=0x%02x)",
-				 err_mask, rtf.command, rtf.feature);
+			ata_dev_err(dev,
+				"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
+				"(%s) failed (Emask=0x%x Stat=0x%02x Err=0x%02x)",
+				tf.command, tf.feature, tf.nsect, tf.lbal,
+				tf.lbam, tf.lbah, tf.device, descr,
+				err_mask, rtf.command, rtf.feature);
 			rc = -EIO;
 			break;
 		}
 	} else {
-		level = KERN_INFO;
-		snprintf(msg, sizeof(msg), "filtered out");
+		ata_dev_info(dev,
+			"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
+			"(%s) filtered out\n",
+			tf.command, tf.feature, tf.nsect, tf.lbal,
+			tf.lbam, tf.lbah, tf.device, descr);
 		rc = 0;
 	}
-	descr = ata_get_cmd_descript(tf.command);
-
-	ata_dev_printk(dev, level,
-		       "ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x (%s) %s\n",
-		       tf.command, tf.feature, tf.nsect, tf.lbal,
-		       tf.lbam, tf.lbah, tf.device,
-		       (descr ? descr : "unknown"), msg);
-
 	return rc;
 }
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 42c8728f6117..5bf6e4da218a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7256,67 +7256,6 @@ const struct ata_port_info ata_dummy_port_info = {
 	.port_ops		= &ata_dummy_port_ops,
 };
 
-/*
- * Utility print functions
- */
-void ata_port_printk(const struct ata_port *ap, const char *level,
-		     const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	printk("%sata%u: %pV", level, ap->print_id, &vaf);
-
-	va_end(args);
-}
-EXPORT_SYMBOL(ata_port_printk);
-
-void ata_link_printk(const struct ata_link *link, const char *level,
-		     const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	if (sata_pmp_attached(link->ap) || link->ap->slave_link)
-		printk("%sata%u.%02u: %pV",
-		       level, link->ap->print_id, link->pmp, &vaf);
-	else
-		printk("%sata%u: %pV",
-		       level, link->ap->print_id, &vaf);
-
-	va_end(args);
-}
-EXPORT_SYMBOL(ata_link_printk);
-
-void ata_dev_printk(const struct ata_device *dev, const char *level,
-		    const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	printk("%sata%u.%02u: %pV",
-	       level, dev->link->ap->print_id, dev->link->pmp + dev->devno,
-	       &vaf);
-
-	va_end(args);
-}
-EXPORT_SYMBOL(ata_dev_printk);
-
 void ata_print_version(const struct device *dev, const char *version)
 {
 	dev_printk(KERN_DEBUG, dev, "version %s\n", version);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a19ede5644e7..6b1ffb78a410 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1415,51 +1415,38 @@ static inline int sata_srst_pmp(struct ata_link *link)
 	return link->pmp;
 }
 
-/*
- * printk helpers
- */
-__printf(3, 4)
-void ata_port_printk(const struct ata_port *ap, const char *level,
-		     const char *fmt, ...);
-__printf(3, 4)
-void ata_link_printk(const struct ata_link *link, const char *level,
-		     const char *fmt, ...);
-__printf(3, 4)
-void ata_dev_printk(const struct ata_device *dev, const char *level,
-		    const char *fmt, ...);
-
 #define ata_port_err(ap, fmt, ...)				\
-	ata_port_printk(ap, KERN_ERR, fmt, ##__VA_ARGS__)
+	dev_err(&ap->tdev, fmt, ##__VA_ARGS__)
 #define ata_port_warn(ap, fmt, ...)				\
-	ata_port_printk(ap, KERN_WARNING, fmt, ##__VA_ARGS__)
+	dev_warn(&ap->tdev, fmt, ##__VA_ARGS__)
 #define ata_port_notice(ap, fmt, ...)				\
-	ata_port_printk(ap, KERN_NOTICE, fmt, ##__VA_ARGS__)
+	dev_notice(&ap->tdev, fmt, ##__VA_ARGS__)
 #define ata_port_info(ap, fmt, ...)				\
-	ata_port_printk(ap, KERN_INFO, fmt, ##__VA_ARGS__)
+	dev_info(&ap->tdev, fmt, ##__VA_ARGS__)
 #define ata_port_dbg(ap, fmt, ...)				\
-	ata_port_printk(ap, KERN_DEBUG, fmt, ##__VA_ARGS__)
+	dev_dbg(&ap->tdev, fmt, ##__VA_ARGS__)
 
 #define ata_link_err(link, fmt, ...)				\
-	ata_link_printk(link, KERN_ERR, fmt, ##__VA_ARGS__)
+	dev_err(&link->tdev, fmt, ##__VA_ARGS__)
 #define ata_link_warn(link, fmt, ...)				\
-	ata_link_printk(link, KERN_WARNING, fmt, ##__VA_ARGS__)
+	dev_warn(&link->tdev, fmt, ##__VA_ARGS__)
 #define ata_link_notice(link, fmt, ...)				\
-	ata_link_printk(link, KERN_NOTICE, fmt, ##__VA_ARGS__)
+	dev_notice(&link->tdev, fmt, ##__VA_ARGS__)
 #define ata_link_info(link, fmt, ...)				\
-	ata_link_printk(link, KERN_INFO, fmt, ##__VA_ARGS__)
+	dev_info(&link->tdev, fmt, ##__VA_ARGS__)
 #define ata_link_dbg(link, fmt, ...)				\
-	ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
+	dev_dbg(&link->tdev, fmt, ##__VA_ARGS__)
 
 #define ata_dev_err(dev, fmt, ...)				\
-	ata_dev_printk(dev, KERN_ERR, fmt, ##__VA_ARGS__)
+	dev_err(&dev->tdev, fmt, ##__VA_ARGS__)
 #define ata_dev_warn(dev, fmt, ...)				\
-	ata_dev_printk(dev, KERN_WARNING, fmt, ##__VA_ARGS__)
+	dev_warn(&dev->tdev, fmt, ##__VA_ARGS__)
 #define ata_dev_notice(dev, fmt, ...)				\
-	ata_dev_printk(dev, KERN_NOTICE, fmt, ##__VA_ARGS__)
+	dev_notice(&dev->tdev, fmt, ##__VA_ARGS__)
 #define ata_dev_info(dev, fmt, ...)				\
-	ata_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
+	dev_info(&dev->tdev, fmt, ##__VA_ARGS__)
 #define ata_dev_dbg(dev, fmt, ...)				\
-	ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
+	dev_dbg(&dev->tdev, fmt, ##__VA_ARGS__)
 
 void ata_print_version(const struct device *dev, const char *version);
 
@@ -1981,11 +1968,8 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
 {
 	u8 status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-#ifdef ATA_DEBUG
 	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
-		ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
-				status);
-#endif
+		ata_port_dbg(ap, "abnormal Status 0x%X\n", status);
 
 	return status;
 }
-- 
2.16.4

