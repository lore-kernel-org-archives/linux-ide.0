Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A88C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhLJHc6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:32:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47012 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbhLJHcx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A29111F3A2;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgmxHjGx6n4lTXK6h8fIiBH2zvgLimYbejTEzzXP+Uw=;
        b=CLyXKsqGXi5qOTfIRLbVeNlayEWqespVvOwPqF5dXCvRJF6RNUhti3mASwDGpfqL4ygMVT
        3TA5Dd96qJ33YnbkHYd1SjVcGtJTRNLGKZkTIDCf41bDN3z5eEI9uzJi59IrgvQ8dPObes
        qdtd7G9iJTxIXVpT6YRXSKgvG3NH0qA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgmxHjGx6n4lTXK6h8fIiBH2zvgLimYbejTEzzXP+Uw=;
        b=fdIFT9YqH0gJfRr3umdmx9PCHfS5nrmp+l3A+2GbHsNwVRkYGwHJCJqb3NXYI6bxdJAMOH
        6cKrpMI28mvGLLAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 999A6A3BA2;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 88F165192039; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/68] libata: move ata_{port,link,dev}_dbg to standard dev_XXX() macros
Date:   Fri, 10 Dec 2021 08:28:09 +0100
Message-Id: <20211210072905.15666-13-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use standard dev_{dbg,info,notice,warn,err} macros instead of the
hand-crafted printk helpers.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-acpi.c    | 48 +++++++++++++++-------------
 drivers/ata/libata-core.c    | 61 ------------------------------------
 drivers/ata/pata_ixp4xx_cf.c |  6 ++--
 include/linux/libata.h       | 48 ++++++++++------------------
 4 files changed, 45 insertions(+), 118 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 7a7d6642edcc..7007377880ce 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -650,9 +650,7 @@ static int ata_acpi_run_tf(struct ata_device *dev,
 	struct ata_taskfile *pptf = NULL;
 	struct ata_taskfile tf, ptf, rtf;
 	unsigned int err_mask;
-	const char *level;
 	const char *descr;
-	char msg[60];
 	int rc;
 
 	if ((gtf->tf[0] == 0) && (gtf->tf[1] == 0) && (gtf->tf[2] == 0)
@@ -666,6 +664,10 @@ static int ata_acpi_run_tf(struct ata_device *dev,
 		pptf = &ptf;
 	}
 
+	descr = ata_get_cmd_descript(tf.command);
+	if (!descr)
+		descr = "unknown";
+
 	if (!ata_acpi_filter_tf(dev, &tf, pptf)) {
 		rtf = tf;
 		err_mask = ata_exec_internal(dev, &rtf, NULL,
@@ -673,40 +675,42 @@ static int ata_acpi_run_tf(struct ata_device *dev,
 
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
index 4a1e61d46d29..1d1cfab5d780 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6503,67 +6503,6 @@ const struct ata_port_info ata_dummy_port_info = {
 };
 EXPORT_SYMBOL_GPL(ata_dummy_port_info);
 
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
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 99c63087c8ae..17b557c91e1c 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -114,7 +114,7 @@ static void ixp4xx_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct ixp4xx_pata *ixpp = ap->host->private_data;
 
-	ata_dev_printk(adev, KERN_INFO, "configured for PIO%d 8bit\n",
+	ata_dev_info(adev, "configured for PIO%d 8bit\n",
 		       adev->pio_mode - XFER_PIO_0);
 	ixp4xx_set_8bit_timing(ixpp, adev->pio_mode);
 }
@@ -132,8 +132,8 @@ static unsigned int ixp4xx_mmio_data_xfer(struct ata_queued_cmd *qc,
 	struct ixp4xx_pata *ixpp = ap->host->private_data;
 	unsigned long flags;
 
-	ata_dev_printk(adev, KERN_DEBUG, "%s %d bytes\n", (rw == READ) ? "READ" : "WRITE",
-		       buflen);
+	ata_dev_dbg(adev, "%s %d bytes\n", (rw == READ) ? "READ" : "WRITE",
+		    buflen);
 	spin_lock_irqsave(ap->lock, flags);
 
 	/* set the expansion bus in 16bit mode and restore
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 235fdbeb19ea..a807d2d43d70 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1489,51 +1489,38 @@ static inline int sata_srst_pmp(struct ata_link *link)
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
 
@@ -2067,11 +2054,8 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
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
2.29.2

