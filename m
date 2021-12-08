Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D6C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhLHQgv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40656 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbhLHQgh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0908521B3A;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfxmiitASZwqmLpuJYtJGaKYAbtAOOe2g53ddMnS/uw=;
        b=nmT4nrqafiHRuzd9cI4qmXh7HKy1rK4Km0dplfJmEisj50xfGKnxU8lkLlkqpQiYV6o6Gj
        U48VMJCEEs+lEEQkPHcenkHpC/dq3xcBFdXJuknaWEpSGE648/jfYDyIpfvfNzP6Xp6Yyc
        waoTwWgBAmfvHdRJgIfQGZZxdMkP++4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfxmiitASZwqmLpuJYtJGaKYAbtAOOe2g53ddMnS/uw=;
        b=6R0/FEnQWwoZ+zSHdk61mC2SCKYcHL2B+kTmM9JsmWi1yuFMx/urogmlR69E5VtJygYKTN
        kFwHPKdyuM7cwMDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 052C4A3BC5;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 005415191FBF; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 49/73] libata: drop ata_msg_probe()
Date:   Wed,  8 Dec 2021 17:32:31 +0100
Message-Id: <20211208163255.114660-50-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
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
index 7007377880ce..bc2414da2731 100644
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
 
@@ -780,9 +772,8 @@ static int ata_acpi_push_id(struct ata_device *dev)
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
index 363714fcb950..501b08ee652a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2576,9 +2576,6 @@ int ata_dev_configure(struct ata_device *dev)
 		return 0;
 	}
 
-	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev, "%s: ENTER\n", __func__);
-
 	/* set horkage */
 	dev->horkage |= ata_dev_blacklisted(dev);
 	ata_force_horkage(dev);
@@ -2626,13 +2623,12 @@ int ata_dev_configure(struct ata_device *dev)
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
@@ -2832,8 +2828,6 @@ int ata_dev_configure(struct ata_device *dev)
 	return 0;
 
 err_out_nosup:
-	if (ata_msg_probe(ap))
-		ata_dev_dbg(dev, "%s: EXIT, err\n", __func__);
 	return rc;
 }
 
@@ -5378,7 +5372,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
-	ap->msg_enable = 0x0007;
+	ap->msg_enable = 0x0003;
 #elif defined(ATA_DEBUG)
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO;
 #else
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index e0cbabaad9e7..41ba992a4ef9 100644
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

