From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4 #upstream-fixes] libata: always do follow-up SRST if hardreset
 returned -EAGAIN
Date: Thu, 31 Jul 2008 16:08:02 +0900
Message-ID: <489164D2.9000009@kernel.org>
References: <48916498.20703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58225 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419AbYGaHJI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 03:09:08 -0400
In-Reply-To: <48916498.20703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

As an optimization, follow-up SRST used to be skipped if
classification wasn't requested even when hardreset requested it via
-EAGAIN.  However, some hardresets can't wait for device readiness and
skipping SRST can cause timeout or other failures during revalidation.
Always perform follow-up SRST if hardreset returns -EAGAIN.  This
makes reset paths more predictable and thus less error-prone.

While at it, move hardreset error checking such that it's done right
after hardreset is finished.  This simplifies followup SRST condition
check a bit and makes the reset path easier to modify.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a3c0139..b82e8ae 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2171,18 +2171,12 @@ static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 }
 
 static int ata_eh_followup_srst_needed(struct ata_link *link,
-				       int rc, int classify,
-				       const unsigned int *classes)
+				       int rc, const unsigned int *classes)
 {
 	if ((link->flags & ATA_LFLAG_NO_SRST) || ata_link_offline(link))
 		return 0;
-	if (rc == -EAGAIN) {
-		if (classify)
-			return 1;
-		rc = 0;
-	}
-	if (rc != 0)
-		return 0;
+	if (rc == -EAGAIN)
+		return 1;
 	if (sata_pmp_supported(link->ap) && ata_is_host_link(link))
 		return 1;
 	return 0;
@@ -2305,9 +2299,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			ehc->i.flags |= ATA_EHI_DID_SOFTRESET;
 
 		rc = ata_do_reset(link, reset, classes, deadline);
+		if (rc && rc != -EAGAIN)
+			goto fail;
 
 		if (reset == hardreset &&
-		    ata_eh_followup_srst_needed(link, rc, classify, classes)) {
+		    ata_eh_followup_srst_needed(link, rc, classes)) {
 			/* okay, let's do follow-up softreset */
 			reset = softreset;
 
@@ -2322,10 +2318,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
 			rc = ata_do_reset(link, reset, classes, deadline);
 		}
-
-		/* -EAGAIN can happen if we skipped followup SRST */
-		if (rc && rc != -EAGAIN)
-			goto fail;
 	} else {
 		if (verbose)
 			ata_link_printk(link, KERN_INFO, "no reset method "
-- 
1.5.4.5

