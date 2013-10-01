From: Levente Kurusa <levex@linux.com>
Subject: [PATCH v2 RESEND] ata_piix: minor typo and a printk fix
Date: Tue, 01 Oct 2013 19:56:48 +0200
Message-ID: <524B0CE0.70202@linux.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:59526 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab3JAR4w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Oct 2013 13:56:52 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so3575847eek.22
        for <linux-ide@vger.kernel.org>; Tue, 01 Oct 2013 10:56:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

The patch fixes a printk() being cut in half, some typos
and a change in comments to better reflect the specs.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 93cb092..1349189 100644
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
@@ -1364,38 +1364,39 @@ static const int *piix_init_sata_map(struct pci_dev *pdev,
 	const int *map;
 	int i, invalid_map = 0;
 	u8 map_value;
+	char buf[32];
+	char *p = buf, *end = buf + sizeof(buf);

 	pci_read_config_byte(pdev, ICH5_PMR, &map_value);

 	map = map_db->map[map_value & map_db->mask];

-	dev_info(&pdev->dev, "MAP [");
 	for (i = 0; i < 4; i++) {
 		switch (map[i]) {
 		case RV:
 			invalid_map = 1;
-			pr_cont(" XX");
+			p += scnprintf(p, end - p, " XX");
 			break;

 		case NA:
-			pr_cont(" --");
+			p += scnprintf(p, end - p, " --");
 			break;

 		case IDE:
 			WARN_ON((i & 1) || map[i + 1] != IDE);
 			pinfo[i / 2] = piix_port_info[ich_pata_100];
 			i++;
-			pr_cont(" IDE IDE");
+			p += scnprintf(p, end - p, " IDE IDE");
 			break;

 		default:
-			pr_cont(" P%d", map[i]);
+			p += scnprintf(p, end - p, " P%d", map[i]);
 			if (i & 1)
 				pinfo[i / 2].flags |= ATA_FLAG_SLAVE_POSS;
 			break;
 		}
 	}
-	pr_cont(" ]\n");
+	dev_info(&pdev->dev, "MAP [%s ]\n", buf);

 	if (invalid_map)
 		dev_err(&pdev->dev, "invalid MAP value %u\n", map_value);
