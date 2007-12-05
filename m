From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: convert NCQ test in ata_qc_issue() to ata_is_ncq()
Date: Wed, 05 Dec 2007 10:36:13 +0900
Message-ID: <4756008D.4090508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:49330 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbXLEBgT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 20:36:19 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3399472rvb
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 17:36:18 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

I missed one while converting to ata_is_*() protocol test helpers.
Convert it.  Pointed out by Jeff Garzik.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 597e07c..81a6045 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5960,7 +5960,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	 */
 	WARN_ON(ap->ops->error_handler && ata_tag_valid(link->active_tag));
 
-	if (prot == ATA_PROT_NCQ) {
+	if (ata_is_ncq(prot)) {
 		WARN_ON(link->sactive & (1 << qc->tag));
 
 		if (!link->sactive)
