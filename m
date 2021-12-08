Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1958DC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbhLHQgz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40734 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbhLHQgh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0D23821B3D;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhvzFY36ZbUtbUmdKYGNQjfm3kNY9t8mc13l1K+xLdA=;
        b=mWsW8B4zyOpasOmyiMs0QTHeU2ZpPv8ioYysHQU70sOAQwigRqvRTQA5KJNXXgrXAc9e+f
        tPN1icQgECYuV54OymysxLnUt09hg7Q9k74RXlzb7e1OWuGAH4L+JTRiEm/K9zzca9T/cK
        Xc/1ZwbTMMFiYw+n0WEXrl94g0cCAY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhvzFY36ZbUtbUmdKYGNQjfm3kNY9t8mc13l1K+xLdA=;
        b=PMDHQc2GTp8Imeymau/7uS0e+6rdMpqgevSbLFpu4VtHv2WJBpr8+YjhAbE6FmxZqiAmS9
        xSo5rZqcFjEqScCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 09351A3BC6;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 05D155191FC1; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 50/73] libata: drop ata_msg_info()
Date:   Wed,  8 Dec 2021 17:32:32 +0100
Message-Id: <20211208163255.114660-51-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert the sole caller to ata_dev_deb() and remove the definition.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 10 +++-------
 include/linux/libata.h    |  2 --
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 501b08ee652a..c23e96163f95 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2571,8 +2571,8 @@ int ata_dev_configure(struct ata_device *dev)
 	char modelbuf[ATA_ID_PROD_LEN+1];
 	int rc;
 
-	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
-		ata_dev_info(dev, "%s: ENTER/EXIT -- nodev\n", __func__);
+	if (!ata_dev_enabled(dev)) {
+		ata_dev_dbg(dev, "no device\n");
 		return 0;
 	}
 
@@ -5372,11 +5372,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
-	ap->msg_enable = 0x0003;
-#elif defined(ATA_DEBUG)
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO;
-#else
-	ap->msg_enable = ATA_MSG_DRV;
+	ap->msg_enable = 0x0001;
 #endif
 
 	mutex_init(&ap->scsi_scan_mutex);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bce3b50112c0..9895414492cb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -73,11 +73,9 @@
 
 enum {
 	ATA_MSG_DRV	= 0x0001,
-	ATA_MSG_INFO	= 0x0002,
 };
 
 #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
-#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
 
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
-- 
2.29.2

