From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/11] ata_piix: convert to new EH
Date: Thu, 11 May 2006 22:21:28 +0900
Message-ID: <11473536883879-git-send-email-htejun@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.192]:5193 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751732AbWEKNVi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:38 -0400
Received: by wx-out-0102.google.com with SMTP id t5so1389wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:38 -0700 (PDT)
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_piix can use stock BMDMA EH routines.  Convert to new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

9a3ac8d5632a5209d3b6fb1efd94b7bd86af24a3
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index af1d46e..e3184a7 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -243,7 +243,10 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -271,7 +274,10 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
-- 
1.2.4


