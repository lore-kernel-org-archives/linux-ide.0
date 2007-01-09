From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] pata_sis: implement laptop list and add ASUS A6K/A6U
Date: Tue, 9 Jan 2007 09:01:19 +0900
Message-ID: <20070109000119.GK10987@htj.dyndns.org>
References: <20070108173600.GJ10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:53379 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbXAIABV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Jan 2007 19:01:21 -0500
Content-Disposition: inline
In-Reply-To: <20070108173600.GJ10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: "Jakub W. Jozwicki" <jakub007@go2.pl>, Andreas Henriksson <andreas@fatal.se>

From: Jakub W. Jozwicki J <jakub007@go2.pl>

In ASUS A6K/A6U hdd is connected to SiS 96x via 40c cable, however it
is short cable and is UDMA66 capable.

tj: fixed if () conditionals
ah: fixed infinite loop

Signed-off-by: Jakub W. Jozwicki <jakub007@go2.pl>
Cc: Andreas Henriksson <andreas@fatal.se>
Signed-off-by: Tejun Heo <htejun@gmail.com>

---
lap++ was missing.  This will result in infinite loop.  Please apply
this one.  Thanks to Andreas Henriksson for spotting this.

diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index c434c4e..d9486fc 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -43,6 +43,34 @@ struct sis_chipset {
 	   up code later */
 };
 
+struct sis_laptop {
+	u16 device;
+	u16 subvendor;
+	u16 subdevice;
+};
+
+static const struct sis_laptop sis_laptop[] = {
+	/* devid, subvendor, subdev */
+	{ 0x5513, 0x1043, 0x1107 },	/* ASUS A6K */
+	/* end marker */
+	{ 0, }
+};
+
+static int sis_short_ata40(struct pci_dev *dev)
+{
+	const struct sis_laptop *lap = &sis_laptop[0];
+
+	while (lap->device) {
+		if (lap->device == dev->device &&
+		    lap->subvendor == dev->subsystem_vendor &&
+		    lap->subdevice == dev->subsystem_device)
+			return 1;
+		lap++;
+	}
+
+	return 0;
+}
+
 /**
  *	sis_port_base		-	return PCI configuration base for dev
  *	@adev: device
@@ -79,7 +107,7 @@ static int sis_133_pre_reset(struct ata_port *ap)
 
 	/* The top bit of this register is the cable detect bit */
 	pci_read_config_word(pdev, 0x50 + 2 * ap->port_no, &tmp);
-	if (tmp & 0x8000)
+	if ((tmp & 0x8000) && !sis_short_ata40(pdev))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
@@ -127,7 +155,7 @@ static int sis_66_pre_reset(struct ata_port *ap)
 	/* Older chips keep cable detect in bits 4/5 of reg 0x48 */
 	pci_read_config_byte(pdev, 0x48, &tmp);
 	tmp >>= ap->port_no;
-	if (tmp & 0x10)
+	if ((tmp & 0x10) && !sis_short_ata40(pdev))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
