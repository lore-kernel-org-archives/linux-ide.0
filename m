From: Levente Kurusa <levex@linux.com>
Subject: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Sun, 22 Sep 2013 15:53:09 +0200
Message-ID: <523EF645.7050808@linux.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:60095 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab3IVNxM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 09:53:12 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so1189861eak.36
        for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2013 06:53:11 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi,

The following patch fixes a printk() call, which was originally used 
with pr_cont, which will however fail. Fixed that with setting up a 
buffer to save data to that first, and then printk() it. The patch also
fixes some minor typos and a comment, so that it better reflects the
documentation of ICH*.

Regards,
Levente Kurusa

Signed-off-by: Levente Kurusa <levex@linux.com>
---
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 93cb092..b7bf3df 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -100,7 +100,7 @@

  enum {
  	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
-	ICH5_PMR		= 0x90, /* port mapping register */
+	ICH5_PMR		= 0x90, /* address map register */
  	ICH5_PCS		= 0x92,	/* port control and status */
  	PIIX_SIDPR_BAR		= 5,
  	PIIX_SIDPR_LEN		= 16,
@@ -233,7 +233,7 @@ static const struct pci_device_id piix_pci_tbl[] = {
  	  PCI_CLASS_STORAGE_IDE << 8, 0xffff00, ich6m_sata },
  	/* 82801GB/GR/GH (ICH7, identical to ICH6) */
  	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
-	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
+	/* 82801GBM/GHM (ICH7M, identical to ICH6M)  */
  	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata },
  	/* Enterprise Southbridge 2 (631xESB/632xESB) */
  	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
@@ -515,7 +515,7 @@ static int ich_pata_cable_detect(struct ata_port *ap)
  	const struct ich_laptop *lap = &ich_laptop[0];
  	u8 mask;

-	/* Check for specials - Acer Aspire 5602WLMi */
+	/* Check for specials */
  	while (lap->device) {
  		if (lap->device == pdev->device &&
  		    lap->subvendor == pdev->subsystem_vendor &&
@@ -1368,34 +1368,53 @@ static const int *piix_init_sata_map(struct 
pci_dev *pdev,
  	pci_read_config_byte(pdev, ICH5_PMR, &map_value);

  	map = map_db->map[map_value & map_db->mask];
-
-	dev_info(&pdev->dev, "MAP [");
+	char* mapdata[4];
  	for (i = 0; i < 4; i++) {
  		switch (map[i]) {
  		case RV:
  			invalid_map = 1;
-			pr_cont(" XX");
+			mapdata[i] =" XX";
  			break;

  		case NA:
-			pr_cont(" --");
+			mapdata[i] = " --";
  			break;

  		case IDE:
  			WARN_ON((i & 1) || map[i + 1] != IDE);
  			pinfo[i / 2] = piix_port_info[ich_pata_100];
  			i++;
-			pr_cont(" IDE IDE");
+			mapdata[i] = " IDE IDE";
+			break;
+		case P0:
+			mapdata[i] = " P0";
+			if (i & 1)
+				pinfo[i / 2].flags |= ATA_FLAG_SLAVE_POSS;
+			break;
+		case P1:
+			mapdata[i] = " P1";
+			if (i & 1)
+				pinfo[i / 2].flags |= ATA_FLAG_SLAVE_POSS;
+			break;
+		case P2:
+			mapdata[i] = " P2";
+			if (i & 1)
+				pinfo[i / 2].flags |= ATA_FLAG_SLAVE_POSS;
+			break;
+		case P3:
+			mapdata[i] = " P3";
+			pinfo[i / 2].flags |= ATA_FLAG_SLAVE_POSS;
+			if (i & 1)
+				pinfo[i / 2].flags |= ATA_FLAG_SLAVE_POSS;
  			break;
-
  		default:
-			pr_cont(" P%d", map[i]);
+			mapdata[i] = " INV";
  			if (i & 1)
  				pinfo[i / 2].flags |= ATA_FLAG_SLAVE_POSS;
  			break;
  		}
  	}
-	pr_cont(" ]\n");
+	dev_info(&pdev->dev, "MAP [%s%s%s%s ]\n", mapdata[0], mapdata[1], 
mapdata[2], mapdata[3], map_value, map_db->mask);

  	if (invalid_map)
  		dev_err(&pdev->dev, "invalid MAP value %u\n", map_value);
@@ -1718,18 +1741,17 @@ static int piix_init_one(struct pci_dev *pdev, 
const struct pci_device_id *ent)
  		if (host->ports[0]->ops == &piix_sidpr_sata_ops)
  			sht = &piix_sidpr_sht;
  	}
-
  	/* apply IOCFG bit18 quirk */
  	piix_iocfg_bit18_quirk(host);

-	/* On ICH5, some BIOSen disable the interrupt using the
+	/* On ICH5, some BIOSes disable the interrupt using the
  	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.
  	 * On ICH6, this bit has the same effect, but only when
  	 * MSI is disabled (and it is disabled, as we don't use
  	 * message-signalled interrupts currently).
  	 */
