From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: implement cached PCS and apply it to ICH5
Date: Thu, 29 Jun 2006 01:58:53 +0900
Message-ID: <20060628165853.GE23844@htj.dyndns.org>
References: <20060628165828.GD23844@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:36284 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751453AbWF1Q6e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 12:58:34 -0400
Received: by nz-out-0102.google.com with SMTP id z31so94882nzd
        for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 09:58:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060628165828.GD23844@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Some ICH5s (bug#6724) clear PCS while devices on the first port are
being probed.  This happens whether PCS itself is written to or not
during probe_init.  This patch implements cached PCS - PCS value is
cached during driver init and probing uses the cached value - and
apply it to ICH5.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

41e6b6fe4bb03941017439726422cca9d7c59e7e
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index bf41dd3..cbb3293 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -101,6 +101,7 @@ enum {
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
 
+	PIIX_FLAG_CACHED_PCS	= (1 << 24), /* cache PCS on driver init */
 	PIIX_FLAG_IGNORE_PCS	= (1 << 25), /* ignore PCS present bits */
 	PIIX_FLAG_SCR		= (1 << 26), /* SCR available */
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
@@ -146,6 +147,7 @@ struct piix_map_db {
 
 struct piix_host_priv {
 	const int *map;
+	u8 cached_pcs;
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -370,7 +372,7 @@ #endif
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED |
-				  PIIX_FLAG_CHECKINTR,
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_CACHED_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -523,21 +525,27 @@ static int piix_sata_prereset(struct ata
 	int port, i;
 	u8 pcs;
 
-	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
-	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
-
-	/* enable all ports on this ap and wait for them to settle */
-	for (i = 0; i < 2; i++) {
-		port = map[base + i];
-		if (port >= 0)
-			pcs |= 1 << port;
-	}
+	if (ap->flags & PIIX_FLAG_CACHED_PCS) {
+		pcs = hpriv->cached_pcs;
+		DPRINTK("ata%u: ENTER, cached_pcs=0x%x base=%d\n",
+			ap->id, pcs, base);
+	} else {
+		pci_read_config_byte(pdev, ICH5_PCS, &pcs);
+		DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
+
+		/* enable all ports on this ap and wait for them to settle */
+		for (i = 0; i < 2; i++) {
+			port = map[base + i];
+			if (port >= 0)
+				pcs |= 1 << port;
+		}
 
-	pci_write_config_byte(pdev, ICH5_PCS, pcs);
-	msleep(100);
+		pci_write_config_byte(pdev, ICH5_PCS, pcs);
+		msleep(100);
 
-	/* let's see which devices are present */
-	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
+		/* let's see which devices are present */
+		pci_read_config_byte(pdev, ICH5_PCS, &pcs);
+	}
 
 	for (i = 0; i < 2; i++) {
 		port = map[base + i];
@@ -550,7 +558,7 @@ static int piix_sata_prereset(struct ata
 	}
 
 	/* disable offline ports on non-AHCI controllers */
-	if (!(ap->flags & PIIX_FLAG_AHCI))
+	if (!(ap->flags & (PIIX_FLAG_AHCI | PIIX_FLAG_CACHED_PCS)))
 		pci_write_config_byte(pdev, ICH5_PCS, pcs);
 
 	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
@@ -871,9 +879,12 @@ static int piix_init_one (struct pci_dev
 	}
 
 	/* Initialize SATA map */
-	if (host_flags & ATA_FLAG_SATA)
+	if (host_flags & ATA_FLAG_SATA) {
 		piix_init_sata_map(pdev, port_info,
 				   piix_map_db_table[ent->driver_data]);
+		if (host_flags & PIIX_FLAG_CACHED_PCS)
+			pci_read_config_byte(pdev, ICH5_PCS, &hpriv->cached_pcs);
+	}
 
 	/* On ICH5, some BIOSen disable the interrupt using the
 	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.
-- 
1.3.2

