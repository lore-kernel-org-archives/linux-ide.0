Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE9CC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbhLJHdU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:20 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35094 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbhLJHdA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F17462113D;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIzHCsyud2ctKlYFewcyF1YtljO/1PKpRz99DRbtwZ0=;
        b=IpAXpPMOSGLiNXYX9uvIQWOa0zrGCftvoSDNN2N1Drn1HUKczMB3FSEAl7xRhn5KEJ6C7Y
        teOqtpHY0u1gl4BO1FY8no2bPgDsWkvSHmO31L9uNDoSuuGzpScSx7zTOzxXztUSKW0562
        OnkLV7Gx3iqrDBi7nI3hMVYV3Sv3AuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIzHCsyud2ctKlYFewcyF1YtljO/1PKpRz99DRbtwZ0=;
        b=eGZc+9Cdz5BNEcV9y47Fm5Eqe+feBz+qx868VMPBOddVLeKI82/N4loqloHuNSOC6kMqwp
        5aiaJCQ9GwRXv7AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id EDA37A3BBB;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id EBCD8519206D; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 38/68] libata: drop ata_msg_error() and ata_msg_intr()
Date:   Fri, 10 Dec 2021 08:28:35 +0100
Message-Id: <20211210072905.15666-39-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Unused.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 6 +++---
 include/linux/libata.h    | 4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 75120f647b41..cda8c21602b9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5338,11 +5338,11 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
-	ap->msg_enable = 0x00FF;
+	ap->msg_enable = 0x003F;
 #elif defined(ATA_DEBUG)
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN;
 #else
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_WARN;
 #endif
 
 	mutex_init(&ap->scsi_scan_mutex);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a807d2d43d70..a3f35735fd27 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -78,8 +78,6 @@ enum {
 	ATA_MSG_WARN	= 0x0008,
 	ATA_MSG_MALLOC	= 0x0010,
 	ATA_MSG_CTL	= 0x0020,
-	ATA_MSG_INTR	= 0x0040,
-	ATA_MSG_ERR	= 0x0080,
 };
 
 #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
@@ -88,8 +86,6 @@ enum {
 #define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
 #define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
 #define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
-#define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
-#define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
 
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
-- 
2.29.2

