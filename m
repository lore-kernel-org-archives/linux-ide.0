From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on
 boot on parisc
Date: Mon, 18 Apr 2011 15:50:02 -0500
Message-ID: <1303159802.7167.30.camel@mulgrave.site>
References: <1303152147.7167.12.camel@mulgrave.site>
	 <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51059 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290Ab1DRUuF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Apr 2011 16:50:05 -0400
In-Reply-To: <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>

On Mon, 2011-04-18 at 20:52 +0100, Alan Cox wrote:
> You shouldn't need to touch a single line of the core libata code,
> although it might be the best way of doing it.

So how about this, using the dummy port info mechanism.  I get a
spurious ata2: DUMMY message, but I suppose libata people are used to
that.  I still have to fix libata to prevent spurious irq information,
but that's cosmetic.

James

---

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index f8380ce..b1b926c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2447,13 +2447,18 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 		return -ENOMEM;
 
 	if (!legacy_mode && pdev->irq) {
+		int i;
+
 		rc = devm_request_irq(dev, pdev->irq, irq_handler,
 				      IRQF_SHARED, drv_name, host);
 		if (rc)
 			goto out;
 
-		ata_port_desc(host->ports[0], "irq %d", pdev->irq);
-		ata_port_desc(host->ports[1], "irq %d", pdev->irq);
+		for (i = 0; i < 2; i++) {
+			if (ata_port_is_dummy(host->ports[i]))
+				continue;
+			ata_port_desc(host->ports[i], "irq %d", pdev->irq);
+		}
 	} else if (legacy_mode) {
 		if (!ata_port_is_dummy(host->ports[0])) {
 			rc = devm_request_irq(dev, ATA_PRIMARY_IRQ(pdev),
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 905ff76..10dabe9 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -41,6 +41,9 @@
 enum {
 	CFR 		= 0x50,
 		CFR_INTR_CH0  = 0x04,
+	ENPORT		= 0x51,
+		ENPORT_PRIMARY   = 0x04,
+		ENPORT_SECONDARY = 0x08,
 	CMDTIM 		= 0x52,
 	ARTTIM0 	= 0x53,
 	DRWTIM0 	= 0x54,
@@ -328,8 +331,12 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &cmd648_port_ops
 		}
 	};
-	const struct ata_port_info *ppi[] = { &cmd_info[id->driver_data], NULL };
-	u8 mrdmode;
+	const struct ata_port_info *ppi[] = { 
+		&cmd_info[id->driver_data],
+		&cmd_info[id->driver_data],
+		NULL
+	};
+	u8 mrdmode, reg;
 	int rc;
 
 	rc = pcim_enable_device(pdev);
@@ -354,6 +361,19 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	mrdmode |= 0x02;	/* Memory read line enable */
 	pci_write_config_byte(pdev, MRDMODE, mrdmode);
 
+	/* check for enabled ports */
+	pci_read_config_byte(pdev, ENPORT, &reg);
+	/* the cm643 primary port is always enabled */
+	if (id->driver_data != 0 && !(reg & ENPORT_PRIMARY)) {
+		dev_printk(KERN_ERR, &pdev->dev, "Primary port is disabled; detaching\n");
+		ppi[0] = &ata_dummy_port_info;
+		
+	}
+	if (!(reg & ENPORT_SECONDARY)) {
+		dev_printk(KERN_NOTICE, &pdev->dev, "Secondary port is disabled\n");
+		ppi[1] = &ata_dummy_port_info;
+	}
+
 	/* Force PIO 0 here.. */
 
 	/* PPC specific fixup copied from old driver */


