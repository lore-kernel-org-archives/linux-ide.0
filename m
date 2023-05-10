Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE867C77B7C
	for <linux-ide@archiver.kernel.org>; Wed, 10 May 2023 22:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjEJWwh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 May 2023 18:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjEJWwe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2023 18:52:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F861BA
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2023 15:52:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 08EC31FD6E;
        Wed, 10 May 2023 22:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683759142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Do60blQnmeyJZc/C7T0/XWWR3kwLBVZ2+0gm0rREAPU=;
        b=m433Xc2HlkbcYTX4i/vF4RluVndQuTKnGCJsVknssRTDtFL55cwYYeFhI9Jkf92QBX0us3
        ZPIo/dwDDzM7PJMK3SYsyNSFw+h74FyNRfn4Z5AT5xdDiezGsxEcexdTmvdhdZ4E1zOR7n
        KEHv7NyWTi84bT31S05QNymmH1JPycI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683759142;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Do60blQnmeyJZc/C7T0/XWWR3kwLBVZ2+0gm0rREAPU=;
        b=5q9iNHqP4VBHUY1QjxYj+oHBCL30ey/+E6XOOXBG8NlmY+IYMfitTmSjbqzyyoTSk7bJHS
        NSBhTvR1gheFh3Aw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id EBDC82C14F;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id E4D7551C34EB; Thu, 11 May 2023 00:52:21 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/6] ata,scsi: cleanup ata_port_probe()
Date:   Thu, 11 May 2023 00:52:11 +0200
Message-Id: <20230510225211.111113-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230510225211.111113-1-hare@suse.de>
References: <20230510225211.111113-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Rename __ata_port_probe() to ata_port_probe() and drop the wrapper
ata_sas_async_probe().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c     |  5 +++--
 drivers/ata/libata-sata.c     | 13 -------------
 drivers/ata/libata.h          |  2 --
 drivers/scsi/libsas/sas_ata.c |  2 +-
 include/linux/libata.h        |  2 +-
 5 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fda2db541bf9..85635f1023e9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5674,7 +5674,7 @@ void ata_host_init(struct ata_host *host, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(ata_host_init);
 
-void __ata_port_probe(struct ata_port *ap)
+void ata_port_probe(struct ata_port *ap)
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned long flags;
@@ -5692,6 +5692,7 @@ void __ata_port_probe(struct ata_port *ap)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 }
+EXPORT_SYMBOL_GPL(ata_port_probe);
 
 static void async_port_probe(void *data, async_cookie_t cookie)
 {
@@ -5707,7 +5708,7 @@ static void async_port_probe(void *data, async_cookie_t cookie)
 	if (!(ap->host->flags & ATA_HOST_PARALLEL_SCAN) && ap->port_no != 0)
 		async_synchronize_cookie(cookie);
 
-	__ata_port_probe(ap);
+	ata_port_probe(ap);
 	ata_port_wait_eh(ap);
 
 	/* in order to keep device order, we need to synchronize at this point */
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 1580d5c880aa..82e7beedb601 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1123,19 +1123,6 @@ struct ata_port *ata_sas_port_alloc(struct ata_host *host,
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
 
-/**
- * ata_sas_async_probe - simply schedule probing and return
- * @ap: Port to probe
- *
- * For batch scheduling of probe for sas attached ata devices, assumes
- * the port has already been through ata_sas_port_init()
- */
-void ata_sas_async_probe(struct ata_port *ap)
-{
-	__ata_port_probe(ap);
-}
-EXPORT_SYMBOL_GPL(ata_sas_async_probe);
-
 /**
  *	ata_sas_port_init - Initialize a SATA device
  *	@ap: SATA port to initialize
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 926d0d33cd29..f018fca55843 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -78,8 +78,6 @@ extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern struct ata_port *ata_port_alloc(struct ata_host *host);
 extern const char *sata_spd_string(unsigned int spd);
-extern int ata_port_probe(struct ata_port *ap);
-extern void __ata_port_probe(struct ata_port *ap);
 extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 				      u8 page, void *buf, unsigned int sectors);
 
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index a2eb9a2191c0..d6bb37b3974a 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -653,7 +653,7 @@ void sas_probe_sata(struct asd_sas_port *port)
 		if (!dev_is_sata(dev))
 			continue;
 
-		ata_sas_async_probe(dev->sata_dev.ap);
+		ata_port_probe(dev->sata_dev.ap);
 	}
 	mutex_unlock(&port->ha->disco_mutex);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ad5535ee61aa..c872b1735380 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1224,7 +1224,7 @@ extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 extern int ata_slave_link_init(struct ata_port *ap);
 extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
 					   struct ata_port_info *, struct Scsi_Host *);
-extern void ata_sas_async_probe(struct ata_port *ap);
+extern void ata_port_probe(struct ata_port *ap);
 extern int ata_sas_port_init(struct ata_port *);
 extern int ata_sas_tport_add(struct device *parent, struct ata_port *ap);
 extern void ata_sas_tport_delete(struct ata_port *ap);
-- 
2.35.3

