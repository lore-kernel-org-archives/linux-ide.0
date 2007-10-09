From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: implement ATA_PFLAG_RESETTING
Date: Tue, 9 Oct 2007 15:06:10 +0900
Message-ID: <20071009060610.GM12186@htj.dyndns.org>
References: <20071009060544.GL12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:25964 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbXJIGGS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 02:06:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1919519wah
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 23:06:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071009060544.GL12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Implement ATA_PFLAG_RESETTING.  This flag is set while reset is in
progress.  It's set before prereset is called and cleared after reset
fails or postreset is finished.

This flag itself doesn't have any function.  It will be used by LLDs
to tell whether reset is in progress if it needs to behave differently
during reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   11 +++++++++++
 include/linux/libata.h  |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c0e9a42..1f84e40 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2063,6 +2063,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		 ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 		 ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
+	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
@@ -2071,9 +2072,14 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	unsigned long deadline;
 	unsigned int action;
 	ata_reset_fn_t reset;
+	unsigned long flags;
 	int rc;
 
 	/* about to reset */
+	spin_lock_irqsave(ap->lock, flags);
+	ap->pflags |= ATA_PFLAG_RESETTING;
+	spin_unlock_irqrestore(ap->lock, flags);
+
 	ata_eh_about_to_do(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
 
 	/* Determine which reset to use and record in ehc->i.action.
@@ -2231,6 +2237,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
  out:
 	/* clear hotplug flag */
 	ehc->i.flags &= ~ATA_EHI_HOTPLUGGED;
+
+	spin_lock_irqsave(ap->lock, flags);
+	ap->pflags &= ~ATA_PFLAG_RESETTING;
+	spin_unlock_irqrestore(ap->lock, flags);
+
 	return rc;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 84dfc23..9f2da92 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -210,6 +210,7 @@ enum {
 	ATA_PFLAG_UNLOADING	= (1 << 5), /* module is unloading */
 	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
 	ATA_PFLAG_INITIALIZING	= (1 << 7), /* being initialized, don't touch */
+	ATA_PFLAG_RESETTING	= (1 << 8), /* reset in progress */
 
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
-- 
1.5.0.3

