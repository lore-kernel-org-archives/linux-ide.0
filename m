From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] libata: fix spurious WARN_ON_ONCE() on port freeze
Date: Thu, 17 Sep 2009 18:45:27 +0900
Message-ID: <4AB20537.4080903@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37800 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbZIQJpt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 05:45:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>, stable@kernel.org

Commit 54c38444fad6a99b4b19512f8f0055d69115e69e makes libata abort qcs
after the port is frozen.  This is necessary to guarantee that TF
registers are accessed after the DMA engine is shutdown after an
error.  However, this triggers WARN_ON_ONCE() check in
ata_qc_complete() spuriously.  Move WARN_ON_ONCE() downwards such that
failing commands while frozen doesn't trigger it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable <stable@kernel.org>
---
 drivers/ata/libata-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index df31dea..0ddaf43 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5024,8 +5024,6 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		struct ata_device *dev = qc->dev;
 		struct ata_eh_info *ehi = &dev->link->eh_info;
 
-		WARN_ON_ONCE(ap->pflags & ATA_PFLAG_FROZEN);
-
 		if (unlikely(qc->err_mask))
 			qc->flags |= ATA_QCFLAG_FAILED;
 
@@ -5038,6 +5036,8 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 			}
 		}
 
+		WARN_ON_ONCE(ap->pflags & ATA_PFLAG_FROZEN);
+
 		/* read result TF if requested */
 		if (qc->flags & ATA_QCFLAG_RESULT_TF)
 			fill_result_tf(qc);
