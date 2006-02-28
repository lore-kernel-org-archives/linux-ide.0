From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/6] ata_piix: implement proper port map
Date: Wed, 1 Mar 2006 01:25:39 +0900
Message-ID: <1141143939927-git-send-email-htejun@gmail.com>
References: <11411439383398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:33585 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751875AbWB1QZw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 11:25:52 -0500
Received: by zproxy.gmail.com with SMTP id x7so1216802nzc
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 08:25:52 -0800 (PST)
In-Reply-To: <11411439383398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Replace combined mode handling via PIIX_COMB/COMB_PATA_P0 with proper
port map.  PIIX now prints port configuration during initialization.
ATA_FLAG_SLAVE_POSS is now turned on for SATA ports only when the
slave device is actually avaliable.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |  182 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 122 insertions(+), 60 deletions(-)

21ef3f5076ba7d651b17cbbf217cdba03d5c58f6
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 987a7cc..4080b8b 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -112,9 +112,6 @@ enum {
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.
 	 */
-	PIIX_COMB_PATA_P0	= (1 << 1),
-	PIIX_COMB		= (1 << 2), /* combined mode enabled? */
-
 	PIIX_PORT_ENABLED	= (1 << 0),
 	PIIX_PORT_PRESENT	= (1 << 4),
 
@@ -130,9 +127,23 @@ enum {
 	ich6_sata_ahci		= 5,
 	ich6m_sata_ahci		= 6,
 
+	/* constants for mapping table */
+	P0			= 0,  /* port 0 */
+	P1			= 1,  /* port 1 */
+	P2			= 2,  /* port 2 */
+	P3			= 3,  /* port 3 */
+	IDE			= -1, /* IDE */
+	NA			= -2, /* not avaliable */
+	RV			= -3, /* reserved */
+
 	PIIX_AHCI_DEVICE	= 6,
 };
 
+struct piix_map_db {
+	const u32 mask;
+	const int map[][4];
+};
+
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
 
@@ -272,6 +283,43 @@ static const struct ata_port_operations 
 	.host_stop		= ata_host_stop,
 };
 
+static struct piix_map_db ich5_map_db = {
+	.mask = 0x7,
+	.map = {
+		/* PM   PS   SM   SS       MAP  */
+		{  P0,  NA,  P1,  NA }, /* 000b */
+		{  P1,  NA,  P0,  NA }, /* 001b */
+		{  RV,  RV,  RV,  RV },
+		{  RV,  RV,  RV,  RV },
+		{  P0,  P1, IDE, IDE }, /* 100b */
+		{  P1,  P0, IDE, IDE }, /* 101b */
+		{ IDE, IDE,  P0,  P1 }, /* 110b */
+		{ IDE, IDE,  P1,  P0 }, /* 111b */
+	},
+};
+
+static struct piix_map_db ich6_map_db = {
+	.mask = 0x3,
+	.map = {
+		/* PM   PS   SM   SS       MAP */
+		{  P0,  P1,  P2,  P3 }, /* 00b */
+		{ IDE, IDE,  P1,  P3 }, /* 01b */
+		{  P0,  P2, IDE, IDE }, /* 10b */
+		{  RV,  RV,  RV,  RV },
+	},
+};
+
+static struct piix_map_db ich6m_map_db = {
+	.mask = 0x3,
+	.map = {
+		/* PM   PS   SM   SS       MAP */
+		{  P0,  P1,  P2,  P3 }, /* 00b */
+		{  RV,  RV,  RV,  RV },
+		{  P0,  P2, IDE, IDE }, /* 10b */
+		{  RV,  RV,  RV,  RV },
+	},
+};
+
 static struct ata_port_info piix_port_info[] = {
 	/* piix4_pata */
 	{
@@ -310,6 +358,7 @@ static struct ata_port_info piix_port_in
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.private_data	= &ich5_map_db,
 	},
 
 	/* i6300esb_sata */
@@ -321,42 +370,45 @@ static struct ata_port_info piix_port_in
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.private_data	= &ich5_map_db,
 	},
 
 	/* ich6_sata */
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
-				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
-				  PIIX_FLAG_SCR,
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.private_data	= &ich6_map_db,
 	},
 
 	/* ich6_sata_ahci */
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
-				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
-				  PIIX_FLAG_SCR | PIIX_FLAG_AHCI,
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.private_data	= &ich6_map_db,
 	},
 
 	/* ich6m_sata_ahci */
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
-				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
-				  PIIX_FLAG_SCR | PIIX_FLAG_AHCI,
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.private_data	= &ich6m_map_db,
 	},
 };
 
@@ -708,6 +760,54 @@ static int __devinit piix_check_450nx_er
 	return no_piix_dma;
 }		
 
+static void __devinit piix_init_sata_map(struct pci_dev *pdev,
+					 struct ata_port_info *pinfo)
+{
+	struct piix_map_db *map_db = pinfo[0].private_data;
+	const unsigned int *map;
+	int i, invalid_map = 0;
+	u8 map_value;
+
+	pci_read_config_byte(pdev, ICH5_PMR, &map_value);
+
+	map = map_db->map[map_value & map_db->mask];
+
+	dev_printk(KERN_INFO, &pdev->dev, "MAP [");
+	for (i = 0; i < 4; i++) {
+		switch (map[i]) {
+		case RV:
+			invalid_map = 1;
+			printk(" XX");
+			break;
+
+		case NA:
+			printk(" --");
+			break;
+
+		case IDE:
+			WARN_ON((i & 1) || map[i + 1] != IDE);
+			pinfo[i / 2] = piix_port_info[ich5_pata];
+			i++;
+			printk(" IDE IDE");
+			break;
+
+		default:
+			printk(" P%d", map[i]);
+			if (i & 1)
+				pinfo[i / 2].host_flags |= ATA_FLAG_SLAVE_POSS;
+			break;
+		}
+	}
+	printk(" ]\n");
+
+	if (invalid_map)
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "invalid MAP value %u\n", map_value);
+
+	pinfo[0].private_data = (void *)map;
+	pinfo[1].private_data = (void *)map;
+}
+
 /**
  *	piix_init_one - Register PIIX ATA PCI device with kernel services
  *	@pdev: PCI device to register
@@ -726,9 +826,8 @@ static int __devinit piix_check_450nx_er
 static int piix_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_port_info *port_info[2];
-	unsigned int combined = 0;
-	unsigned int pata_chan = 0, sata_chan = 0;
+	struct ata_port_info port_info[2];
+	struct ata_port_info *ppinfo[2] = { &port_info[0], &port_info[1] };
 	unsigned long host_flags;
 
 	if (!printed_version++)
@@ -739,10 +838,10 @@ static int piix_init_one (struct pci_dev
 	if (!in_module_init)
 		return -ENODEV;
 
-	port_info[0] = &piix_port_info[ent->driver_data];
-	port_info[1] = &piix_port_info[ent->driver_data];
+	port_info[0] = piix_port_info[ent->driver_data];
+	port_info[1] = piix_port_info[ent->driver_data];
 
-	host_flags = port_info[0]->host_flags;
+	host_flags = port_info[0].host_flags;
 
 	if (host_flags & PIIX_FLAG_AHCI) {
 		u8 tmp;
@@ -754,37 +853,9 @@ static int piix_init_one (struct pci_dev
 		}
 	}
 
-	if (host_flags & PIIX_FLAG_COMBINED) {
-		u8 tmp;
-		pci_read_config_byte(pdev, ICH5_PMR, &tmp);
-
-		if (host_flags & PIIX_FLAG_COMBINED_ICH6) {
-			switch (tmp & 0x3) {
-			case 0:
-				break;
-			case 1:
-				combined = 1;
-				sata_chan = 1;
-				break;
-			case 2:
-				combined = 1;
-				pata_chan = 1;
-				break;
-			case 3:
-				dev_printk(KERN_WARNING, &pdev->dev,
-					   "invalid MAP value %u\n", tmp);
-				break;
-			}
-		} else {
-			if (tmp & PIIX_COMB) {
-				combined = 1;
-				if (tmp & PIIX_COMB_PATA_P0)
-					sata_chan = 1;
-				else
-					pata_chan = 1;
-			}
-		}
-	}
+	/* Initialize SATA map */
+	if (host_flags & ATA_FLAG_SATA)
+		piix_init_sata_map(pdev, port_info);
 
 	/* On ICH5, some BIOSen disable the interrupt using the
 	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.
@@ -795,25 +866,16 @@ static int piix_init_one (struct pci_dev
 	if (host_flags & PIIX_FLAG_CHECKINTR)
 		pci_intx(pdev, 1);
 
-	if (combined) {
-		port_info[sata_chan] = &piix_port_info[ent->driver_data];
-		port_info[sata_chan]->host_flags |= ATA_FLAG_SLAVE_POSS;
-		port_info[pata_chan] = &piix_port_info[ich5_pata];
-
-		dev_printk(KERN_WARNING, &pdev->dev,
-			   "combined mode detected (p=%u, s=%u)\n",
-			   pata_chan, sata_chan);
-	}
 	if (piix_check_450nx_errata(pdev)) {
 		/* This writes into the master table but it does not
 		   really matter for this errata as we will apply it to
 		   all the PIIX devices on the board */
-		port_info[0]->mwdma_mask = 0;
-		port_info[0]->udma_mask = 0;
-		port_info[1]->mwdma_mask = 0;
-		port_info[1]->udma_mask = 0;
+		port_info[0].mwdma_mask = 0;
+		port_info[0].udma_mask = 0;
+		port_info[1].mwdma_mask = 0;
+		port_info[1].udma_mask = 0;
 	}
-	return ata_pci_init_one(pdev, port_info, 2);
+	return ata_pci_init_one(pdev, ppinfo, 2);
 }
 
 static int __init piix_init(void)
-- 
1.2.1


