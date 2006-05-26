From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: add back ->data_xfer to ata_piix.c
Date: Fri, 26 May 2006 13:49:18 +0800
Message-ID: <447696DE.5090604@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:16847 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030481AbWEZFtQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 May 2006 01:49:16 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4Q5nFrA014945
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 01:49:15 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4Q5nFjP237554
	for <linux-ide@vger.kernel.org>; Thu, 25 May 2006 23:49:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4Q5nFlR005662
	for <linux-ide@vger.kernel.org>; Thu, 25 May 2006 23:49:15 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Add back ->data_xfer and ->mode_filter to ata_piix.c.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
The ->data_xfer and ->mode_filter hooks of ata_piix.c are left out when
Alan's patches are merged. Add them back.

Patch against upstream branch of libata-dev
(957d2df1801865eb1e63864bc63b970aa9c460ba).

--- upstream0/drivers/scsi/ata_piix.c	2006-05-25 10:45:21.000000000 +0800
+++ 0_piix/drivers/scsi/ata_piix.c	2006-05-26 13:23:55.000000000 +0800
@@ -228,6 +228,7 @@ static const struct ata_port_operations 
 	.port_disable		= ata_port_disable,
 	.set_piomode		= piix_set_piomode,
 	.set_dmamode		= piix_set_dmamode,
+	.mode_filter		= ata_pci_default_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -243,6 +244,7 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_pio_data_xfer,
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
@@ -274,6 +276,7 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_pio_data_xfer,
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,

