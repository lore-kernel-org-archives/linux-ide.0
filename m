Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE4CC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbhLJHd3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35118 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbhLJHdH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 016D22114D;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fT/QpL576P3xyvXrdFXu87cWuVVfvpXgBcf5gawmNrA=;
        b=QuWMrYnaYa3TYCqVl6cyPXRiEv5QBCo/7j7hDYLpcgEYNzhFOFUxQDIH9E4XrXPiXvOZXM
        ZwzHD6m05Y0qNUitqHctzG6Yp6GhU3bvNrIjfzX+kUYKuBEgbfbv6Jg0ftob+lR6Ls38YZ
        RAyVQfL1jtKNIYCzCnLkUv/5pOrrdAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fT/QpL576P3xyvXrdFXu87cWuVVfvpXgBcf5gawmNrA=;
        b=HAhA2O70h7IVsPehXxKS+ewnEwtKs1/eTwqAJ3WRgUSJB1GcFuUAs+BglyoA0SKxzVtQ3F
        AeKQQX+B2ow4VJDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id F1D14A3BBC;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id EF29C519206F; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 39/68] libata: drop ata_msg_ctl()
Date:   Fri, 10 Dec 2021 08:28:36 +0100
Message-Id: <20211210072905.15666-40-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The one caller have been converted to dynamic debugging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 7 ++-----
 include/linux/libata.h    | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cda8c21602b9..fb613d8821a2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1763,9 +1763,6 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	int may_fallback = 1, tried_spinup = 0;
 	int rc;
 
-	if (ata_msg_ctl(ap))
-		ata_dev_dbg(dev, "%s: ENTER\n", __func__);
-
 retry:
 	ata_tf_init(dev, &tf);
 
@@ -5338,9 +5335,9 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
-	ap->msg_enable = 0x003F;
+	ap->msg_enable = 0x001F;
 #elif defined(ATA_DEBUG)
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN;
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_WARN;
 #else
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_WARN;
 #endif
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a3f35735fd27..fc7f64646e5b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -77,7 +77,6 @@ enum {
 	ATA_MSG_PROBE	= 0x0004,
 	ATA_MSG_WARN	= 0x0008,
 	ATA_MSG_MALLOC	= 0x0010,
-	ATA_MSG_CTL	= 0x0020,
 };
 
 #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
@@ -85,7 +84,6 @@ enum {
 #define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
 #define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
 #define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
-#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
 
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
-- 
2.29.2

