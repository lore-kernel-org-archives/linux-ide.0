From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc5] libata: remove unused variable from ata_eh_reset()
Date: Mon, 25 Jun 2007 21:43:04 +0900
Message-ID: <467FB858.1060907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:38115 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbXFYMnK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 08:43:10 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1338766nzf
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 05:43:09 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Removed unused variable did_followup_srst from ata_eh_reset().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d807098..48d2d54 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1616,7 +1616,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 	unsigned long deadline;
 	unsigned int action;
 	ata_reset_fn_t reset;
-	int i, did_followup_srst, rc;
+	int i, rc;
 
 	/* about to reset */
 	ata_eh_about_to_do(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
@@ -1689,11 +1689,9 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 
 	rc = ata_do_reset(ap, reset, classes, deadline);
 
-	did_followup_srst = 0;
 	if (reset == hardreset &&
 	    ata_eh_followup_srst_needed(rc, classify, classes)) {
 		/* okay, let's do follow-up softreset */
-		did_followup_srst = 1;
 		reset = softreset;
 
 		if (!reset) {
