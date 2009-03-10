From: Frans Pop <elendil@planet.nl>
Subject: [RFC][PATCH] sata-mv: add module parameter msq_blink_led to enable quirk for SOC
Date: Tue, 10 Mar 2009 12:36:27 +0100
Message-ID: <200903101236.30216.elendil@planet.nl>
References: <200808261124.39282.elendil@planet.nl> <497B2C60.60608@rtr.ca> <200902240933.45874.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml103.kpnxchange.com ([195.121.3.7]:65058 "EHLO
	CPSMTPM-EML103.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751400AbZCJLvq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Mar 2009 07:51:46 -0400
In-Reply-To: <200902240933.45874.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>, Martin Michlmayr <tbm@cyrius.com>

For some Marvell chips the HDD led does not blink when there is disk
I/O if NCQ is enabled. Only enable the quirk that works around this
(by enabling blink mode for the led) if parameter msq_blink_led is
set as it is not clear whether this is a general erratum or related
to the type of hard disk connected to the controller.
    
Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Mark Lord <liml@rtr.ca>
Cc: Saeed Bishara <saeed.bishara@gmail.com>
---

This patch applies on top of my previous patch:
     sata_mv: enable HDD led blinking when NCQ is active for SOC
(see: http://marc.info/?l=linux-ide&m=123546443414518&w=2)

I hope this will make that patch more acceptable: it makes the use of the
quirk more flexible, allowing users who see the issue to activate it while
allowing others to ignore it and also allowing easy testing whether the
issue is (still) present.

I've chosen to keep the quirk disabled by default so that we'll continue
to get reports when someone's led is not working. Hopefully that will
help find out whether or not the issue is hard disk related or not.

Use of the parameter could be documented on websites such as
Martin Michlmayr's pages for the QNAP NAS devices on Debian
(http://www.cyrius.com/debian/orion/qnap/ts-109/).

Cheers,
FJP

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 59355d9..4382d2c 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -723,6 +723,15 @@ static const struct mv_hw_ops mv_soc_ops = {
 };
 
 /*
+ * module options
+ */
+static int msi;			/* Use PCI msi; either zero (off, default)
+				 * or non-zero */
+static int msq_blink_led;	/* Use blink mode for HDD activity led when
+				 * NCQ is enabled (SOC);
+				 * either zero (off, default) or non-zero */
+
+/*
  * Functions
  */
 
@@ -885,6 +894,9 @@ static int mv_has_port_using_ncq(struct ata_host *host)
 static void mv_quirk_blink_led_when_ncq(struct ata_port *ap,
 					int enable)
 {
+	if (!msq_blink_led)
+		return;
+
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	void __iomem *mmio = hpriv->base;
 
@@ -3359,12 +3371,6 @@ static struct pci_driver mv_pci_driver = {
 	.remove			= ata_pci_remove_one,
 };
 
-/*
- * module options
- */
-static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
-
-
 /* move to PCI layer or libata core? */
 static int pci_go_64(struct pci_dev *pdev)
 {
@@ -3550,6 +3556,10 @@ MODULE_ALIAS("platform:" DRV_NAME);
 module_param(msi, int, 0444);
 MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
 #endif
+/* msq_blink_led only has effect for SOC */
+module_param(msq_blink_led, int, 0444);
+MODULE_PARM_DESC(msq_blink_led,
+	"Use blink mode quirk for HDD led when MSQ is enabled (0=off, 1=on)");
 
 module_init(mv_init);
 module_exit(mv_exit);
