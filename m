Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE45C3524B
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E7220674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgBDQ4L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:34568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbgBDQ4H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 87EB0AFBB;
        Tue,  4 Feb 2020 16:56:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 04/46] libata: move ata_{port,link,dev}_dbg to standard dev_XXX() macros
Date:   Tue,  4 Feb 2020 17:55:05 +0100
Message-Id: <20200204165547.115220-5-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use standard dev_{dbg,info,notice,warn,err} macros instead of the
hand-crafted printk helpers.
Also change the name for 'ata_device' structure to ataX:Y to be
inline with the other ata object names.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/ata/ahci.c             |  3 +--
 drivers/ata/libata-acpi.c      | 48 ++++++++++++++++++---------------
 drivers/ata/libata-core.c      | 61 ------------------------------------------
 drivers/ata/libata-transport.c |  4 +--
 include/linux/libata.h         | 48 +++++++++++----------------------
 5 files changed, 45 insertions(+), 119 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4bfd1b14b390..b2719c64fc04 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -796,8 +796,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
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
index 6f4ab5c5b52d..cee815ecd7df 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7236,67 +7236,6 @@ const struct ata_port_info ata_dummy_port_info = {
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
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 4ccfeb85ec66..db42bd05c4cf 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -666,9 +666,9 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	dev->parent = &link->tdev;
 	dev->release = ata_tdev_release;
 	if (ata_is_host_link(link))
-		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
+		dev_set_name(dev, "ata%d.%d", ap->print_id, ata_dev->devno);
 	else
-		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
+		dev_set_name(dev, "ata%d.%d.0", ap->print_id, link->pmp);
 
 	transport_setup_device(dev);
 	ata_acpi_bind_dev(ata_dev);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 19c9c32bd339..437d2f27bfdd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1414,51 +1414,38 @@ static inline int sata_srst_pmp(struct ata_link *link)
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
+	dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
 
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
+	dev_dbg(&link->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
 
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
+	dev_dbg(&dev->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
 
 void ata_print_version(const struct device *dev, const char *version);
 
@@ -1980,11 +1967,8 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
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

