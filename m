Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CDBC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhLHQjE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37760 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhLHQgp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 133D31FE26;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbdBS9vf89fFRYEWk5QWSRn7gyyzoA5UDrcoqslp7mE=;
        b=16pIvbv2l3MmFdQ+zjnNf4Xo8swmcdggw8V4vzl2Q0HECZgvZrqn+3KjoXbKguJ/2kE+5U
        vN9kyXoDkbdQYLH4JrJrldNl9B476ZcmwNmGgoh6nPJwXmvb9/CsmbDAu9VnMllnvSj9g0
        wh0PFu4ATWo5hCcCJryFsEW2WkRET+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbdBS9vf89fFRYEWk5QWSRn7gyyzoA5UDrcoqslp7mE=;
        b=ar2UzaE41FTrg9405aFjks3kdy0RZa8oEf+MNmoWF8o1RP5aSuC1UlJSG5dUx+D8I6dNKZ
        SoRoCY473uehWiCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 0E818A3BC7;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 0B3D65191FC3; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 51/73] libata: drop ata_msg_drv()
Date:   Wed,  8 Dec 2021 17:32:33 +0100
Message-Id: <20211208163255.114660-52-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Callers are already protected by ata_dev_print_info(), so no need
to have an additional configuration parameter here.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 19 ++++++-------------
 drivers/ata/libata-eh.c   |  3 +--
 include/linux/libata.h    |  6 ------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c23e96163f95..81f96e46f64e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2396,7 +2396,6 @@ static void ata_dev_config_trusted(struct ata_device *dev)
 
 static int ata_dev_config_lba(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->link->ap;
 	const u16 *id = dev->id;
 	const char *lba_desc;
 	char ncq_desc[24];
@@ -2418,7 +2417,7 @@ static int ata_dev_config_lba(struct ata_device *dev)
 	ret = ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
 
 	/* print device info to dmesg */
-	if (ata_msg_drv(ap) && ata_dev_print_info(dev))
+	if (ata_dev_print_info(dev))
 		ata_dev_info(dev,
 			     "%llu sectors, multi %u: %s %s\n",
 			     (unsigned long long)dev->n_sectors,
@@ -2429,7 +2428,6 @@ static int ata_dev_config_lba(struct ata_device *dev)
 
 static void ata_dev_config_chs(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->link->ap;
 	const u16 *id = dev->id;
 
 	if (ata_id_current_chs_valid(id)) {
@@ -2445,7 +2443,7 @@ static void ata_dev_config_chs(struct ata_device *dev)
 	}
 
 	/* print device info to dmesg */
-	if (ata_msg_drv(ap) && ata_dev_print_info(dev))
+	if (ata_dev_print_info(dev))
 		ata_dev_info(dev,
 			     "%llu sectors, multi %u, CHS %u/%u/%u\n",
 			     (unsigned long long)dev->n_sectors,
@@ -2685,7 +2683,7 @@ int ata_dev_configure(struct ata_device *dev)
 		}
 
 		/* print device info to dmesg */
-		if (ata_msg_drv(ap) && print_info)
+		if (print_info)
 			ata_dev_info(dev, "%s: %s, %s, max %s\n",
 				     revbuf, modelbuf, fwrevbuf,
 				     ata_mode_string(xfer_mask));
@@ -2705,7 +2703,7 @@ int ata_dev_configure(struct ata_device *dev)
 		ata_dev_config_cpr(dev);
 		dev->cdb_len = 32;
 
-		if (ata_msg_drv(ap) && print_info)
+		if (print_info)
 			ata_dev_print_features(dev);
 	}
 
@@ -2762,7 +2760,7 @@ int ata_dev_configure(struct ata_device *dev)
 		}
 
 		/* print device info to dmesg */
-		if (ata_msg_drv(ap) && print_info)
+		if (print_info)
 			ata_dev_info(dev,
 				     "ATAPI: %s, %s, max %s%s%s%s\n",
 				     modelbuf, fwrevbuf,
@@ -2779,7 +2777,7 @@ int ata_dev_configure(struct ata_device *dev)
 	/* Limit PATA drive on SATA cable bridge transfers to udma5,
 	   200 sectors */
 	if (ata_dev_knobble(dev)) {
-		if (ata_msg_drv(ap) && print_info)
+		if (print_info)
 			ata_dev_info(dev, "applying bridge limits\n");
 		dev->udma_mask &= ATA_UDMA5;
 		dev->max_sectors = ATA_MAX_SECTORS;
@@ -5370,11 +5368,6 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->host = host;
 	ap->dev = host->dev;
 
-#if defined(ATA_VERBOSE_DEBUG)
-	/* turn on all debugging levels */
-	ap->msg_enable = 0x0001;
-#endif
-
 	mutex_init(&ap->scsi_scan_mutex);
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
 	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 69f51616d8bd..8d6dcabbf4f2 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1214,8 +1214,7 @@ void ata_dev_disable(struct ata_device *dev)
 	if (!ata_dev_enabled(dev))
 		return;
 
-	if (ata_msg_drv(dev->link->ap))
-		ata_dev_warn(dev, "disabled\n");
+	ata_dev_warn(dev, "disable device\n");
 	ata_acpi_on_disable(dev);
 	ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 | ATA_DNXFER_QUIET);
 	dev->class++;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9895414492cb..df10edca3433 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -71,12 +71,6 @@
 /* NEW: debug levels */
 #define HAVE_LIBATA_MSG 1
 
-enum {
-	ATA_MSG_DRV	= 0x0001,
-};
-
-#define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
-
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
 	if (dval < 0 || dval >= (sizeof(u32) * 8))
-- 
2.29.2

