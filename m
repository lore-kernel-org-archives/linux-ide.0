From: Frans Pop <elendil@planet.nl>
Subject: [PATCH,v2][2/2] sata-mv: add module parameter msq_blink_led to enable quirk for GenIIe
Date: Wed, 11 Mar 2009 08:17:19 +0100
Message-ID: <200903110817.20835.elendil@planet.nl>
References: <200903110813.25650.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml102.kpnxchange.com ([195.121.3.6]:61668 "EHLO
	CPSMTPM-EML102.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751930AbZCKHRX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 03:17:23 -0400
In-Reply-To: <200903110813.25650.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm@vger.kernel.org
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

For some Marvell chips the HDD led does not blink when there is disk
I/O if NCQ is enabled. Only enable the quirk that works around this
(by enabling blink mode for the led) if parameter msq_blink_led is
set as it is not clear whether this is a general erratum or related
to the type of hard disk connected to the controller.

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Mark Lord <liml@rtr.ca>
Cc: Saeed Bishara <saeed.bishara@gmail.com>

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 4057647..86f8047 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -738,6 +738,15 @@ static const struct mv_hw_ops mv_soc_ops = {
 };
 
 /*
+ * module options
+ */
+static int msi;			/* Use PCI msi; either zero (off, default)
+				 * or non-zero */
+static int ncq_blink_led;	/* Use blink mode for HDD activity led when
+				 * NCQ is enabled (GenIIe quirk);
+				 * either zero (off, default) or non-zero */
+
+/*
  * Functions
  */
 
@@ -903,7 +912,7 @@ static void mv_quirk_blink_led_when_ncq(struct 
ata_port *ap,
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	void __iomem *mmio = hpriv->base;
 
-	if (!hpriv->ops->enable_led_blink)
+	if (!ncq_blink_led || !hpriv->ops->enable_led_blink)
 		return;
 
 	if (enable) {
@@ -3379,12 +3388,6 @@ static struct pci_driver mv_pci_driver = {
 	.remove			= ata_pci_remove_one,
 };
 
-/*
- * module options
- */
-static int msi;	      /* Use PCI msi; either zero (off, default) or 
non-zero */
-
-
 /* move to PCI layer or libata core? */
 static int pci_go_64(struct pci_dev *pdev)
 {
@@ -3570,6 +3573,10 @@ MODULE_ALIAS("platform:" DRV_NAME);
 module_param(msi, int, 0444);
 MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
 #endif
+/* ncq_blink_led only has effect for GenIIe chip variants */
+module_param(ncq_blink_led, int, 0444);
+MODULE_PARM_DESC(ncq_blink_led,
+	"Use blink mode quirk for HDD led when NCQ is enabled (0=off, 1=on)");
 
 module_init(mv_init);
 module_exit(mv_exit);
