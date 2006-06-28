From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/2] libata-dev: pata_pdc2027x minor fix for new EH
Date: Wed, 28 Jun 2006 14:40:35 +0800
Message-ID: <44A22463.6050607@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:50635 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932746AbWF1Gkh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 02:40:37 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5S6eYn5029974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 02:40:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5S6e2Eg312604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 00:40:02 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5S6eXDh018302
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 00:40:33 -0600
Received: from [127.0.0.1] (p4ht-s.tw.ibm.com [9.191.82.23])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5S6eVWo018196
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 00:40:33 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

Changes:
- move the function pointers around for better grouping
- remove the unused ->eng_timeout()
- add ->freeze(), ->thaw() and ->post_internal_cmd() for UDMA133 pdc adapters.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Patch against the pata-drivers branch (0ab56aae451577586ecac6968d86251a83f1cb40)
(0.74-ac3). For your review, thanks.

--- pata/drivers/scsi/pata_pdc2027x.c	2006-06-27 18:25:14.000000000 +0800
+++ 01_pdc074-eh/drivers/scsi/pata_pdc2027x.c	2006-06-28 13:40:38.000000000 +0800
@@ -154,11 +154,6 @@ static struct ata_port_operations pdc202
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= pdc2027x_error_handler,
-	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
-
 	.check_atapi_dma	= pdc2027x_check_atapi_dma,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -166,9 +161,13 @@ static struct ata_port_operations pdc202
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
 	.data_xfer		= ata_mmio_data_xfer,
 
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= pdc2027x_error_handler,
+	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
+
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
@@ -181,6 +180,7 @@ static struct ata_port_operations pdc202
 	.port_disable		= ata_port_disable,
 	.set_piomode		= pdc2027x_set_piomode,
 	.set_dmamode		= pdc2027x_set_dmamode,
+	.post_set_mode		= pdc2027x_post_set_mode,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -188,9 +188,6 @@ static struct ata_port_operations pdc202
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.error_handler		= pdc2027x_error_handler,
-	.post_set_mode		= pdc2027x_post_set_mode,
-
 	.check_atapi_dma	= pdc2027x_check_atapi_dma,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -198,9 +195,13 @@ static struct ata_port_operations pdc202
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
 	.data_xfer		= ata_mmio_data_xfer,
 
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= pdc2027x_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 


