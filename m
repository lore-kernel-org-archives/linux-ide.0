Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A1CC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbhLJHdY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34972 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbhLJHdG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:06 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0B844212B5;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPicdX5+mpUA0IqiralI6zJJL+vOsZw3p+wV9pauRfI=;
        b=LHntzpRfHD2MBN2jYKa0jrSdIzJH7jt/8q4yTDoiIw/60WJOOh2azwJJ9ljfU8im4ERPmY
        pKLpM3F0VKIY6u8eFIopg/iazFVzKQYbU2sPpiQGZ3WSP0Ih7DhQyCsUyXAJazLKhSMTAc
        fn2Y0S3uJANb5geK/iq1RhWI6q4C6tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPicdX5+mpUA0IqiralI6zJJL+vOsZw3p+wV9pauRfI=;
        b=mNMpor0lMnWabxI5AOqQgkE3Cc/jtm26KexDJ1maiFrZLeem0cJ9L1STzjw+juF1auNFRc
        p/rThqXd9rg+8QBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 0767FA3BBF;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 0488D5192075; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 42/68] libata: drop ata_msg_probe()
Date:   Fri, 10 Dec 2021 08:28:39 +0100
Message-Id: <20211210072905.15666-43-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

All callsites have been converted to dynamic debugging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-acpi.c | 23 +++++++----------------
 drivers/ata/libata-core.c | 20 +++++++-------------
 drivers/ata/libata-sff.c  |  4 ----
 include/linux/libata.h    |  2 --
 4 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 9e1e62b9cf63..8cfa8c96bb13 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -402,7 +402,6 @@ EXPORT_SYMBOL_GPL(ata_acpi_stm);
  */
 static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 {
-	struct ata_port *ap = dev->link->ap;
 	acpi_status status;
 	struct acpi_buffer output;
 	union acpi_object *out_obj;
@@ -418,10 +417,6 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 	output.length = ACPI_ALLOCATE_BUFFER;
 	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
 
-	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev, "%s: ENTER: port#: %d\n",
-			    __func__, ap->port_no);
-
 	/* _GTF has no input parameters */
 	status = acpi_evaluate_object(ata_dev_acpi_handle(dev), "_GTF", NULL,
 				      &output);
@@ -437,11 +432,9 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 	}
 
 	if (!output.length || !output.pointer) {
-		if (ata_msg_probe(ap))
-			ata_dev_dbg(dev, "%s: Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
-				    __func__,
-				    (unsigned long long)output.length,
-				    output.pointer);
+		ata_dev_dbg(dev, "Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
+			    (unsigned long long)output.length,
+			    output.pointer);
 		rc = -EINVAL;
 		goto out_free;
 	}
@@ -464,9 +457,8 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 	rc = out_obj->buffer.length / REGS_PER_GTF;
 	if (gtf) {
 		*gtf = (void *)out_obj->buffer.pointer;
-		if (ata_msg_probe(ap))
-			ata_dev_dbg(dev, "%s: returning gtf=%p, gtf_count=%d\n",
-				    __func__, *gtf, rc);
+		ata_dev_dbg(dev, "returning gtf=%p, gtf_count=%d\n",
+			    *gtf, rc);
 	}
 	return rc;
 
@@ -778,9 +770,8 @@ static int ata_acpi_push_id(struct ata_device *dev)
 	struct acpi_object_list input;
 	union acpi_object in_params[1];
 
-	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev, "%s: ix = %d, port#: %d\n",
-			    __func__, dev->devno, ap->port_no);
+	ata_dev_dbg(dev, "%s: ix = %d, port#: %d\n",
+		    __func__, dev->devno, ap->port_no);
 
 	/* Give the drive Identify data to the drive via the _SDD method */
 	/* _SDD: set up input parameters */
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0235f7dbdc38..c7faf71163e9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2530,9 +2530,6 @@ int ata_dev_configure(struct ata_device *dev)
 		return 0;
 	}
 
-	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev, "%s: ENTER\n", __func__);
-
 	/* set horkage */
 	dev->horkage |= ata_dev_blacklisted(dev);
 	ata_force_horkage(dev);
@@ -2580,13 +2577,12 @@ int ata_dev_configure(struct ata_device *dev)
 		return rc;
 
 	/* print device capabilities */
-	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev,
-			    "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
-			    "85:%04x 86:%04x 87:%04x 88:%04x\n",
-			    __func__,
-			    id[49], id[82], id[83], id[84],
-			    id[85], id[86], id[87], id[88]);
+	ata_dev_dbg(dev,
+		    "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
+		    "85:%04x 86:%04x 87:%04x 88:%04x\n",
+		    __func__,
+		    id[49], id[82], id[83], id[84],
+		    id[85], id[86], id[87], id[88]);
 
 	/* initialize to-be-configured parameters */
 	dev->flags &= ~ATA_DFLAG_CFG_MASK;
@@ -2786,8 +2782,6 @@ int ata_dev_configure(struct ata_device *dev)
 	return 0;
 
 err_out_nosup:
-	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev, "%s: EXIT, err\n", __func__);
 	return rc;
 }
 
@@ -5332,7 +5326,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
-	ap->msg_enable = 0x0007;
+	ap->msg_enable = 0x0003;
 #elif defined(ATA_DEBUG)
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO;
 #else
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index d5dbeb68b2bf..01f1673f3297 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -330,10 +330,6 @@ EXPORT_SYMBOL_GPL(ata_sff_dev_select);
 static void ata_dev_select(struct ata_port *ap, unsigned int device,
 			   unsigned int wait, unsigned int can_sleep)
 {
-	if (ata_msg_probe(ap))
-		ata_port_info(ap, "ata_dev_select: ENTER, device %u, wait %u\n",
-			      device, wait);
-
 	if (wait)
 		ata_wait_idle(ap);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5a4a23d38c08..bce3b50112c0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -74,12 +74,10 @@
 enum {
 	ATA_MSG_DRV	= 0x0001,
 	ATA_MSG_INFO	= 0x0002,
-	ATA_MSG_PROBE	= 0x0004,
 };
 
 #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
 #define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
-#define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
 
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
-- 
2.29.2

