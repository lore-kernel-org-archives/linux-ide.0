From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata-dev-2.6: pdc2027x timing register fix for 100MHz
 adapters
Date: Thu, 24 Feb 2005 13:57:00 +0800
Message-ID: <421D6CAC.3020308@tw.ibm.com>
References: <003f01c50905$c8090d10$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:3559 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261794AbVBXF5J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 00:57:09 -0500
In-Reply-To: <003f01c50905$c8090d10$6401a8c0@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>


> Albert Lee wrote:
>   I did not get the pdc2027x timing registers right for the 100 MHz adapters.
> For the 100MHz adapters, the hardware will automatically set the timing registers to the correct value.
> No need to set the timing register by software table lookup.
> (The values in the lookup table are for 133Mhz adapters, which are incorrect for 100MHz adapters.)
> 
>   Attached please find the patch against the libata-dev-2.6 tree for your review. Thanks.
> 

Jeff,

  Please ignore my previous pdc2027x timing registers patch.
Attached please find the resubmitted patch against libata-dev-2.6 tree for your review. Thanks.

  Changes:
1. For the 100MHz pdc20268 and pdc20270 adapters, rely on the hardware to set the timing registers.

2. Add the new .bmdma_stop and .bmdma_status to pdc2027x_pata100_ops and pdc2027x_pata133_ops.


Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
=============================================================================================
--- libata-dev-2.6/drivers/scsi/pata_pdc2027x.c	2005-02-21 17:23:03.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/pata_pdc2027x.c	2005-02-24 13:55:03.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>

 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.55"
+#define DRV_VERSION	"0.57"
 #undef PDC_DEBUG

 #ifdef PDC_DEBUG
@@ -130,7 +130,34 @@
 	.bios_param		= ata_std_bios_param,
 };

-static struct ata_port_operations pdc2027x_pata_ops = {
+static struct ata_port_operations pdc2027x_pata100_ops = {
+	.port_disable		= ata_port_disable,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.phy_reset		= pdc2027x_phy_reset,
+
+	.check_atapi_dma	= pdc2027x_check_atapi_dma,
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.eng_timeout		= ata_eng_timeout,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+};
+
+static struct ata_port_operations pdc2027x_pata133_ops = {
 	.port_disable		= ata_port_disable,
 	.set_piomode		= pdc2027x_set_piomode,
 	.set_dmamode		= pdc2027x_set_dmamode,
@@ -147,6 +174,8 @@
 	.check_atapi_dma	= pdc2027x_check_atapi_dma,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -167,7 +196,7 @@
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5, /* udma0-5 */
-		.port_ops	= &pdc2027x_pata_ops,
+		.port_ops	= &pdc2027x_pata100_ops,
 	},
 	/* PDC_UDMA_133 */
 	{
@@ -177,7 +206,7 @@
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6, /* udma0-6 */
-		.port_ops	= &pdc2027x_pata_ops,
+		.port_ops	= &pdc2027x_pata133_ops,
 	},
 };



