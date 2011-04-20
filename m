From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on
 boot on parisc
Date: Wed, 20 Apr 2011 09:52:19 -0500
Message-ID: <1303311140.2587.13.camel@mulgrave.site>
References: <1303152147.7167.12.camel@mulgrave.site>
	 <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
	 <1303159802.7167.30.camel@mulgrave.site>
	 <20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
	 <4DADF798.6010705@ru.mvista.com>
	 <20110419221900.67528a07@lxorguk.ukuu.org.uk>
	 <4DADFD2E.9070809@ru.mvista.com>
	 <20110419222838.6a6f36aa@lxorguk.ukuu.org.uk>
	 <1303254709.11237.34.camel@mulgrave.site>  <4DAEAF9A.1020704@ru.mvista.com>
	 <1303309698.2587.10.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303309698.2587.10.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, 2011-04-20 at 09:28 -0500, James Bottomley wrote:
> On Wed, 2011-04-20 at 14:04 +0400, Sergei Shtylyov wrote:
> 
> > > +		dev_printk(KERN_NOTICE, &pdev->dev, "Mobility Bridge detected, ignoring CNTRL port enable/disable\n");
> > > +	/* 643 and 646 no UDMA, primary port always enabled */
> > > +	if (port_ok && id->driver_data > 1 &&  !(reg & CNTRL_PRIMARY)) {
> > 
> >     PCI0646U and later revisions on PCI0646 do have the primary port enable 
> > bit. The same about UltraDMA -- PCI0646U2 has it. Look at what cmd64x does in 
> > cmd64x_init_one()...
> 
> Where?  All I see in drivers/ide/cmd64x.c is that it only ignores the
> primary for the id->driver_data == 0 case, which is what I originally
> coded.

OK, found it ... it's the pdev->revision < 3 check.  

James

---

>From 71be695c796eeaed7b45b3756a101f87b77827c2 Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 18 Apr 2011 13:52:36 -0700
Subject: [PATCH] pata_cm64x: latest fix for boot crash


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
index 905ff76..7bafc16 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -41,6 +41,9 @@
 enum {
 	CFR 		= 0x50,
 		CFR_INTR_CH0  = 0x04,
+	CNTRL		= 0x51,
+		CNTRL_CH0     = 0x04,
+		CNTRL_CH1     = 0x08,
 	CMDTIM 		= 0x52,
 	ARTTIM0 	= 0x53,
 	DRWTIM0 	= 0x54,
@@ -328,9 +331,19 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
+	struct pci_dev *bridge = pdev->bus->self;
+	/* mobility split bridges don't report enabled ports correctly */
+	int port_ok = !(bridge && bridge->vendor ==
+			PCI_VENDOR_ID_MOBILITY_ELECTRONICS);
+	/* all (with exceptions below) apart from 643 have CNTRL_CH0 bit */
+	int cntrl_ch0_ok = (id->driver_data != 0);
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
@@ -341,11 +354,18 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	if (pdev->device == PCI_DEVICE_ID_CMD_646) {
 		/* Does UDMA work ? */
-		if (pdev->revision > 4)
+		if (pdev->revision > 4) {
 			ppi[0] = &cmd_info[2];
+			ppi[1] = &cmd_info[2];
+		}
 		/* Early rev with other problems ? */
-		else if (pdev->revision == 1)
+		else if (pdev->revision == 1) {
 			ppi[0] = &cmd_info[3];
+			ppi[1] = &cmd_info[3];
+		}
+		/* revs 1,2 have no CNTRL_CH0 */
+		if (pdev->revision < 3)
+			cntrl_ch0_ok = 0;
 	}
 
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 64);
@@ -354,6 +374,20 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	mrdmode |= 0x02;	/* Memory read line enable */
 	pci_write_config_byte(pdev, MRDMODE, mrdmode);
 
+	/* check for enabled ports */
+	pci_read_config_byte(pdev, CNTRL, &reg);
+	if (!port_ok)
+		dev_printk(KERN_NOTICE, &pdev->dev, "Mobility Bridge detected, ignoring CNTRL port enable/disable\n");
+	if (port_ok && cntrl_ch0_ok && !(reg & CNTRL_CH0)) {
+		dev_printk(KERN_NOTICE, &pdev->dev, "Primary port is disabled\n");
+		ppi[0] = &ata_dummy_port_info;
+		
+	}
+	if (port_ok && !(reg & CNTRL_CH1)) {
+		dev_printk(KERN_NOTICE, &pdev->dev, "Secondary port is disabled\n");
+		ppi[1] = &ata_dummy_port_info;
+	}
+
 	/* Force PIO 0 here.. */
 
 	/* PPC specific fixup copied from old driver */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4e2c915..7a0ac45 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -608,6 +608,8 @@
 #define PCI_DEVICE_ID_MATROX_G550	0x2527
 #define PCI_DEVICE_ID_MATROX_VIA	0x4536
 
+#define PCI_VENDOR_ID_MOBILITY_ELECTRONICS	0x14f2
+
 #define PCI_VENDOR_ID_CT		0x102c
 #define PCI_DEVICE_ID_CT_69000		0x00c0
 #define PCI_DEVICE_ID_CT_65545		0x00d8


