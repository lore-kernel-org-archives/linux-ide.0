Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC81C3F2C6
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9E6214DB
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgCCJju (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:47674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgCCJjs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0BD80B236;
        Tue,  3 Mar 2020 09:39:42 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 27/40] libata: drop DPRINTK() calls during ATA error handling
Date:   Tue,  3 Mar 2020 10:38:00 +0100
Message-Id: <20200303093813.18523-28-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The information is now logged with tracepoints, so the DPRINTK()
calls can be dropped.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c  | 12 ------------
 drivers/ata/libata-pmp.c |  8 --------
 2 files changed, 20 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a068b5370aac..f37dad5f9c17 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -526,8 +526,6 @@ void ata_scsi_error(struct Scsi_Host *host)
 	unsigned long flags;
 	LIST_HEAD(eh_work_q);
 
-	DPRINTK("ENTER\n");
-
 	spin_lock_irqsave(host->host_lock, flags);
 	list_splice_init(&host->eh_cmd_q, &eh_work_q);
 	spin_unlock_irqrestore(host->host_lock, flags);
@@ -541,7 +539,6 @@ void ata_scsi_error(struct Scsi_Host *host)
 	/* finish or retry handled scmd's and clean up */
 	WARN_ON(!list_empty(&eh_work_q));
 
-	DPRINTK("EXIT\n");
 }
 
 /**
@@ -2123,8 +2120,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	u32 serror;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	if (ehc->i.flags & ATA_EHI_NO_AUTOPSY)
 		return;
 
@@ -2231,7 +2226,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
 		trace_ata_eh_link_autopsy(dev, ehc->i.action, all_err_mask);
 	}
-	DPRINTK("EXIT\n");
 }
 
 /**
@@ -3130,8 +3124,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	unsigned long flags;
 	int rc = 0;
 
-	DPRINTK("ENTER\n");
-
 	/* For PATA drive side cable detection to work, IDENTIFY must
 	 * be done backwards such that PDIAG- is released by the slave
 	 * device before the master device is identified.
@@ -3245,7 +3237,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 
  err:
 	*r_failed_dev = dev;
-	DPRINTK("EXIT rc=%d\n", rc);
 	return rc;
 }
 
@@ -3759,8 +3750,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	int rc, nr_fails;
 	unsigned long flags, deadline;
 
-	DPRINTK("ENTER\n");
-
 	/* prep for recovery */
 	ata_for_each_link(link, ap, EDGE) {
 		struct ata_eh_context *ehc = &link->eh_context;
@@ -3968,7 +3957,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	if (rc && r_failed_link)
 		*r_failed_link = link;
 
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 3ff14071617c..438caf3a7d8c 100644
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
 		goto fail;
@@ -827,7 +821,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	/* okay, PMP resurrected */
 	ehc->i.flags = 0;
 
-	DPRINTK("EXIT, rc=0\n");
 	return 0;
 
  fail:
@@ -837,7 +830,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	else
 		ata_dev_disable(dev);
 
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
-- 
2.16.4

