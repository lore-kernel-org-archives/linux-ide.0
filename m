From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] pdc_adma: inherit ata_sff_port_ops
Date: Tue, 25 Mar 2008 21:35:30 +0900
Message-ID: <47E8F192.7000709@gmail.com>
References: <47E8F15F.50601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:41234 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbYCYMff (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 08:35:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3992568wah.23
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 05:35:34 -0700 (PDT)
In-Reply-To: <47E8F15F.50601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

With the previous ops standardization, pdc_adma now can inherit
ata_sff_port_ops instead of ata_base_port_ops.  Make the change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>
---
 drivers/ata/pdc_adma.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 577a0e5..6a4654e 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -147,25 +147,15 @@ static struct scsi_host_template adma_ata_sht = {
 };
 
 static struct ata_port_operations adma_ata_ops = {
-	.inherits		= &ata_base_port_ops,
-
-	.dev_select		= ata_std_dev_select,
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.data_xfer		= ata_data_xfer,
+	.inherits		= &ata_sff_port_ops,
+
 	.check_atapi_dma	= adma_check_atapi_dma,
 	.qc_prep		= adma_qc_prep,
 	.qc_issue		= adma_qc_issue,
-	.irq_on			= ata_irq_on,
 
 	.freeze			= adma_freeze,
 	.thaw			= adma_thaw,
 	.prereset		= adma_prereset,
-	.softreset		= ata_std_softreset,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
-- 
1.5.2.4

