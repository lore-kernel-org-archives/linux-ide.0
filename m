From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/10] libata: move reset freeze/thaw handling into ata_eh_reset()
Date: Mon, 19 May 2008 01:15:07 +0900
Message-ID: <1211127315414-git-send-email-htejun@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:52680 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbYERQPY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:24 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1010112wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:23 -0700 (PDT)
In-Reply-To: <12111273141039-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

Previously reset freeze/thaw handling lived outside of ata_eh_reset()
mainly because the original PMP reset code needed the port frozen
while resetting all the fan-out ports, which is no longer the case.

This patch moves freeze/thaw handling into ata_eh_reset().
@prereset() and @postreset() are now called w/o freezing the port
although @prereset() an be called frozen if the port is frozen prior
to entering ata_eh_reset().

This makes code simpler and will help removing hotplug event related
races.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c  |   46 ++++++++++++++++++----------------------------
 drivers/ata/libata-pmp.c |    4 ----
 2 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a34adc2..06a92c5 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2170,6 +2170,9 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/*
 	 * Perform reset
 	 */
+	if (ata_is_host_link(link))
+		ata_eh_freeze_port(ap);
+
 	deadline = jiffies + ata_eh_reset_timeouts[try++];
 
 	if (reset) {
@@ -2238,6 +2241,10 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0)
 		link->sata_spd = (sstatus >> 4) & 0xf;
 
+	/* thaw the port */
+	if (ata_is_host_link(link))
+		ata_eh_thaw_port(ap);
+
 	if (postreset)
 		postreset(link, classes);
 
@@ -2589,7 +2596,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	struct ata_link *link;
 	struct ata_device *dev;
 	int nr_failed_devs, nr_disabled_devs;
-	int reset, rc;
+	int rc;
 	unsigned long flags;
 
 	DPRINTK("ENTER\n");
@@ -2632,7 +2639,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	rc = 0;
 	nr_failed_devs = 0;
 	nr_disabled_devs = 0;
-	reset = 0;
 
 	/* if UNLOADING, finish immediately */
 	if (ap->pflags & ATA_PFLAG_UNLOADING)
@@ -2646,40 +2652,24 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		if (ata_eh_skip_recovery(link))
 			ehc->i.action = 0;
 
-		/* do we need to reset? */
-		if (ehc->i.action & ATA_EH_RESET)
-			reset = 1;
-
 		ata_link_for_each_dev(dev, link)
 			ehc->classes[dev->devno] = ATA_DEV_UNKNOWN;
 	}
 
 	/* reset */
-	if (reset) {
-		/* if PMP is attached, this function only deals with
-		 * downstream links, port should stay thawed.
-		 */
-		if (!sata_pmp_attached(ap))
-			ata_eh_freeze_port(ap);
-
-		ata_port_for_each_link(link, ap) {
-			struct ata_eh_context *ehc = &link->eh_context;
+	ata_port_for_each_link(link, ap) {
+		struct ata_eh_context *ehc = &link->eh_context;
 
-			if (!(ehc->i.action & ATA_EH_RESET))
-				continue;
+		if (!(ehc->i.action & ATA_EH_RESET))
+			continue;
 
-			rc = ata_eh_reset(link, ata_link_nr_vacant(link),
-					  prereset, softreset, hardreset,
-					  postreset);
-			if (rc) {
-				ata_link_printk(link, KERN_ERR,
-						"reset failed, giving up\n");
-				goto out;
-			}
+		rc = ata_eh_reset(link, ata_link_nr_vacant(link),
+				  prereset, softreset, hardreset, postreset);
+		if (rc) {
+			ata_link_printk(link, KERN_ERR,
+					"reset failed, giving up\n");
+			goto out;
 		}
-
-		if (!sata_pmp_attached(ap))
-			ata_eh_thaw_port(ap);
 	}
 
 	/* the rest */
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index ff1822a..f3ad024 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -700,8 +700,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	if (ehc->i.action & ATA_EH_RESET) {
 		struct ata_link *tlink;
 
-		ata_eh_freeze_port(ap);
-
 		/* reset */
 		rc = ata_eh_reset(link, 0, prereset, softreset, hardreset,
 				  postreset);
@@ -711,8 +709,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 			goto fail;
 		}
 
-		ata_eh_thaw_port(ap);
-
 		/* PMP is reset, SErrors cannot be trusted, scan all */
 		ata_port_for_each_link(tlink, ap) {
 			struct ata_eh_context *ehc = &tlink->eh_context;
-- 
1.5.2.4

