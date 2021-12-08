Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5E0C43219
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbhLHQgn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4F8451FE0F;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGANcJUSgC2qg0ieE2QF+DgYGR3exd6aG4nDzLYNHnc=;
        b=Ebty7O8FIb5JsOmW19pcKpA5OfQ4Zo3uCGLcR6+KPrAZBoTAnErkfLq8D8nk4ycmwwxZZH
        oYFJ+O4MjUWtrG0XDtwSElf3+gUc8geqrad1tYnnE67zGZuIT0BWF+nTHhGfnr7SvR99QO
        6Qh0HUV9NgLDZsIrgcPEJm3GjZGqHHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGANcJUSgC2qg0ieE2QF+DgYGR3exd6aG4nDzLYNHnc=;
        b=pq3YBvjxlrDkYa2omtvk9kfw3gk8zZdYvu1n4YKg+r6CUcFTLLizXhM0PsThuSKKPSuCCN
        oiPt//YNlZw+krCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 4C9D5A3BA6;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 486365191F83; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 19/73] libata: drop DPRINTK() calls during ATA error handling
Date:   Wed,  8 Dec 2021 17:32:01 +0100
Message-Id: <20211208163255.114660-20-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The information is now logged with tracepoints, so the DPRINTK()
calls can be dropped.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c   | 12 ------------
 drivers/ata/libata-pmp.c  |  8 --------
 drivers/ata/libata-sata.c |  3 ---
 3 files changed, 23 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2a25be588e14..a0fd38260f48 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -533,8 +533,6 @@ void ata_scsi_error(struct Scsi_Host *host)
 	unsigned long flags;
 	LIST_HEAD(eh_work_q);
 
-	DPRINTK("ENTER\n");
-
 	spin_lock_irqsave(host->host_lock, flags);
 	list_splice_init(&host->eh_cmd_q, &eh_work_q);
 	spin_unlock_irqrestore(host->host_lock, flags);
@@ -548,7 +546,6 @@ void ata_scsi_error(struct Scsi_Host *host)
 	/* finish or retry handled scmd's and clean up */
 	WARN_ON(!list_empty(&eh_work_q));
 
-	DPRINTK("EXIT\n");
 }
 
 /**
@@ -1932,8 +1929,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	u32 serror;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	if (ehc->i.flags & ATA_EHI_NO_AUTOPSY)
 		return;
 
@@ -2040,7 +2035,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
 		trace_ata_eh_link_autopsy(dev, ehc->i.action, all_err_mask);
 	}
-	DPRINTK("EXIT\n");
 }
 
 /**
@@ -2940,8 +2934,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	unsigned long flags;
 	int rc = 0;
 
-	DPRINTK("ENTER\n");
-
 	/* For PATA drive side cable detection to work, IDENTIFY must
 	 * be done backwards such that PDIAG- is released by the slave
 	 * device before the master device is identified.
@@ -3055,7 +3047,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 
  err:
 	*r_failed_dev = dev;
-	DPRINTK("EXIT rc=%d\n", rc);
 	return rc;
 }
 
@@ -3570,8 +3561,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	int rc, nr_fails;
 	unsigned long flags, deadline;
 
-	DPRINTK("ENTER\n");
-
 	/* prep for recovery */
 	ata_for_each_link(link, ap, EDGE) {
 		struct ata_eh_context *ehc = &link->eh_context;
@@ -3779,7 +3768,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	if (rc && r_failed_link)
 		*r_failed_link = link;
 
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index ba7be3f38617..e2e9cbd405fa 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -652,8 +652,6 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
 	u32 *gscr = (void *)ap->sector_buf;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	ata_eh_about_to_do(link, NULL, ATA_EH_REVALIDATE);
 
 	if (!ata_dev_enabled(dev)) {
@@ -686,12 +684,10 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
 
 	ata_eh_done(link, NULL, ATA_EH_REVALIDATE);
 
-	DPRINTK("EXIT, rc=0\n");
 	return 0;
 
  fail:
 	ata_dev_err(dev, "PMP revalidation failed (errno=%d)\n", rc);
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
@@ -759,8 +755,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	int detach = 0, rc = 0;
 	int reval_failed = 0;
 
-	DPRINTK("ENTER\n");
-
 	if (dev->flags & ATA_DFLAG_DETACH) {
 		detach = 1;
 		rc = -ENODEV;
@@ -828,7 +822,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	/* okay, PMP resurrected */
 	ehc->i.flags = 0;
 
-	DPRINTK("EXIT, rc=0\n");
 	return 0;
 
  fail:
@@ -838,7 +831,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	else
 		ata_dev_disable(dev);
 
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 4e88597aa9df..7b72c68bc9f7 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -533,8 +533,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	u32 scontrol;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	if (online)
 		*online = false;
 
@@ -610,7 +608,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 			*online = false;
 		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
 	}
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
-- 
2.29.2

