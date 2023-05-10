Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D591BC7EE22
	for <linux-ide@archiver.kernel.org>; Wed, 10 May 2023 22:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjEJWwi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 May 2023 18:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjEJWwe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2023 18:52:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4206561B0
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2023 15:52:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E4FA721993;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683759141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LrbhorNBBTHDtPL0Fyneo0B/jBPGn7sL1T24Tk5U8u4=;
        b=rpdcximX70S2bqAomKwoHPxYlaYMf8hhhe7wpNfxaHQf4XVYS2gM+kCeBxzSxDcw9tbvqK
        Ie1jwJ38FuGlYGTTgQp5VSRy1Ccqq8+OmwDoNfLbtRfAn3KrM9e2NmUG1j+FCFycSLl5xk
        X4bAhQbHPrhXaPTw5M1oKJ5PUT6dI5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683759141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LrbhorNBBTHDtPL0Fyneo0B/jBPGn7sL1T24Tk5U8u4=;
        b=Dfz8gw9X3HOHbBcu+MsyWUG/8QwulYCC/r6ZKZq0IR1YGE/wHK0JlMVmYFsJeaRcA3HSaW
        kxXhXgIL8pfN2WDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D83112C146;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id CE7E751C34E5; Thu, 11 May 2023 00:52:21 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/6] ata,scsi: remove ata_sas_port_destroy()
Date:   Thu, 11 May 2023 00:52:08 +0200
Message-Id: <20230510225211.111113-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230510225211.111113-1-hare@suse.de>
References: <20230510225211.111113-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Is now a wrapper around kfree(), so call it directly.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-sata.c          | 18 ------------------
 drivers/scsi/libsas/sas_ata.c      |  2 +-
 drivers/scsi/libsas/sas_discover.c |  2 +-
 include/linux/libata.h             |  1 -
 4 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 3c56b15c43f1..70da34a35c54 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1156,10 +1156,6 @@ EXPORT_SYMBOL_GPL(ata_sas_sync_probe);
 
 int ata_sas_port_init(struct ata_port *ap)
 {
-	int rc = ap->ops->port_start(ap);
-
-	if (rc)
-		return rc;
 	ap->print_id = atomic_inc_return(&ata_print_id);
 	return 0;
 }
@@ -1177,20 +1173,6 @@ void ata_sas_tport_delete(struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ata_sas_tport_delete);
 
-/**
- *	ata_sas_port_destroy - Destroy a SATA port allocated by ata_sas_port_alloc
- *	@ap: SATA port to destroy
- *
- */
-
-void ata_sas_port_destroy(struct ata_port *ap)
-{
-	if (ap->ops->port_stop)
-		ap->ops->port_stop(ap);
-	kfree(ap);
-}
-EXPORT_SYMBOL_GPL(ata_sas_port_destroy);
-
 /**
  *	ata_sas_slave_configure - Default slave_config routine for libata devices
  *	@sdev: SCSI device to configure
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 7ead1f1be97f..a2eb9a2191c0 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -619,7 +619,7 @@ int sas_ata_init(struct domain_device *found_dev)
 	return 0;
 
 destroy_port:
-	ata_sas_port_destroy(ap);
+	kfree(ap);
 free_host:
 	ata_host_put(ata_host);
 	return rc;
diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 8c6afe724944..07e18cdb85c7 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -301,7 +301,7 @@ void sas_free_device(struct kref *kref)
 
 	if (dev_is_sata(dev) && dev->sata_dev.ap) {
 		ata_sas_tport_delete(dev->sata_dev.ap);
-		ata_sas_port_destroy(dev->sata_dev.ap);
+		kfree(dev->sata_dev.ap);
 		ata_host_put(dev->sata_dev.ata_host);
 		dev->sata_dev.ata_host = NULL;
 		dev->sata_dev.ap = NULL;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 395b25fea187..dbd3df0fb69d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1222,7 +1222,6 @@ extern int sata_link_debounce(struct ata_link *link,
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			     bool spm_wakeup);
 extern int ata_slave_link_init(struct ata_port *ap);
-extern void ata_sas_port_destroy(struct ata_port *);
 extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
 					   struct ata_port_info *, struct Scsi_Host *);
 extern void ata_sas_async_probe(struct ata_port *ap);
-- 
2.35.3

