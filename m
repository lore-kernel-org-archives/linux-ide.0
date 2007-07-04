From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 6/10] libata: add freeze/thaw to old EH LLDDs
Date: Wed, 04 Jul 2007 16:59:57 +0800
Message-ID: <468B618D.6060003@tw.ibm.com>
References: <468B5C97.1000803@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:57257 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299AbXGDJAE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 05:00:04 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l649038T012391
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 05:00:03 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l64903OB203154
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 03:00:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l64901ZE017999
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 03:00:02 -0600
In-Reply-To: <468B5C97.1000803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 6/10:
Now that HSM polling code path uses freeze()/thaw() regardless of old EH or new EH.
Add freeze()/thaw() to old EH LLDDs for the HSM polling code.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---


diff -Nrup 05_convert_hsm_to_freeze/drivers/ata/pata_ixp4xx_cf.c 06_add_freeze_thaw_to_lldd/drivers/ata/pata_ixp4xx_cf.c
--- 05_convert_hsm_to_freeze/drivers/ata/pata_ixp4xx_cf.c	2007-07-04 12:09:29.000000000 +0800
+++ 06_add_freeze_thaw_to_lldd/drivers/ata/pata_ixp4xx_cf.c	2007-07-04 13:17:13.000000000 +0800
@@ -131,6 +131,9 @@ static struct ata_port_operations ixp4xx
 	.data_xfer	= ixp4xx_mmio_data_xfer,
 	.cable_detect	= ata_cable_40wire,
 
+	.freeze		= ata_bmdma_freeze,
+	.thaw		= ata_bmdma_thaw,
+
 	.irq_clear	= ixp4xx_irq_clear,
 	.irq_on		= ata_irq_on,
 	.irq_off	= ata_irq_off,
diff -Nrup 05_convert_hsm_to_freeze/drivers/ata/pata_scc.c 06_add_freeze_thaw_to_lldd/drivers/ata/pata_scc.c
--- 05_convert_hsm_to_freeze/drivers/ata/pata_scc.c	2007-07-04 13:12:38.000000000 +0800
+++ 06_add_freeze_thaw_to_lldd/drivers/ata/pata_scc.c	2007-07-04 13:17:13.000000000 +0800
@@ -879,6 +879,18 @@ static void scc_bmdma_freeze (struct ata
 }
 
 /**
+ *	scc_bmdma_thaw - Thaw BMDMA controller port
+ *	@ap: port to thaw
+ *
+ *	Note: Original code is ata_bmdma_thaw().
+ */
+
+static void scc_bmdma_thaw (struct ata_port *ap)
+{
+	scc_irq_on(ap);
+}
+
+/**
  *	scc_pata_prereset - prepare for reset
  *	@ap: ATA port to be reset
  *	@deadline: deadline jiffies for the operation
@@ -1025,6 +1037,7 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 
 	.freeze			= scc_bmdma_freeze,
+	.thaw			= scc_bmdma_thaw,
 	.error_handler		= scc_error_handler,
 	.post_internal_cmd	= scc_bmdma_stop,
 
diff -Nrup 05_convert_hsm_to_freeze/drivers/ata/pdc_adma.c 06_add_freeze_thaw_to_lldd/drivers/ata/pdc_adma.c
--- 05_convert_hsm_to_freeze/drivers/ata/pdc_adma.c	2007-07-04 12:09:29.000000000 +0800
+++ 06_add_freeze_thaw_to_lldd/drivers/ata/pdc_adma.c	2007-07-04 13:17:13.000000000 +0800
@@ -171,6 +171,8 @@ static const struct ata_port_operations 
 	.qc_issue		= adma_qc_issue,
 	.eng_timeout		= adma_eng_timeout,
 	.data_xfer		= ata_data_xfer,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
 	.irq_clear		= adma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
diff -Nrup 05_convert_hsm_to_freeze/drivers/ata/sata_mv.c 06_add_freeze_thaw_to_lldd/drivers/ata/sata_mv.c
--- 05_convert_hsm_to_freeze/drivers/ata/sata_mv.c	2007-07-04 12:09:29.000000000 +0800
+++ 06_add_freeze_thaw_to_lldd/drivers/ata/sata_mv.c	2007-07-04 13:17:13.000000000 +0800
@@ -453,6 +453,9 @@ static const struct ata_port_operations 
 
 	.eng_timeout		= mv_eng_timeout,
 
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
@@ -483,6 +486,9 @@ static const struct ata_port_operations 
 
 	.eng_timeout		= mv_eng_timeout,
 
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
@@ -513,6 +519,9 @@ static const struct ata_port_operations 
 
 	.eng_timeout		= mv_eng_timeout,
 
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
diff -Nrup 05_convert_hsm_to_freeze/drivers/ata/sata_qstor.c 06_add_freeze_thaw_to_lldd/drivers/ata/sata_qstor.c
--- 05_convert_hsm_to_freeze/drivers/ata/sata_qstor.c	2007-07-04 12:09:29.000000000 +0800
+++ 06_add_freeze_thaw_to_lldd/drivers/ata/sata_qstor.c	2007-07-04 13:17:13.000000000 +0800
@@ -157,6 +157,8 @@ static const struct ata_port_operations 
 	.qc_issue		= qs_qc_issue,
 	.data_xfer		= ata_data_xfer,
 	.eng_timeout		= qs_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
 	.irq_clear		= qs_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
diff -Nrup 05_convert_hsm_to_freeze/drivers/ata/sata_sx4.c 06_add_freeze_thaw_to_lldd/drivers/ata/sata_sx4.c
--- 05_convert_hsm_to_freeze/drivers/ata/sata_sx4.c	2007-07-04 12:09:29.000000000 +0800
+++ 06_add_freeze_thaw_to_lldd/drivers/ata/sata_sx4.c	2007-07-04 13:17:13.000000000 +0800
@@ -203,6 +203,8 @@ static const struct ata_port_operations 
 	.qc_issue		= pdc20621_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 	.eng_timeout		= pdc_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
 	.irq_clear		= pdc20621_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,


