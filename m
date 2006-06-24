From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/15] sata_sil: separate out sil_init_controller()
Date: Sat, 24 Jun 2006 20:30:20 +0900
Message-ID: <11511486203801-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:27944 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S933050AbWFXLaQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:16 -0400
Received: by py-out-1112.google.com with SMTP id t32so931835pyc
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:16 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out controller initialization from sil_init_one() into
sil_init_controller().  This will be used by resume.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   86 ++++++++++++++++++++++++++---------------------
 1 files changed, 48 insertions(+), 38 deletions(-)

a8e0d30d07481375e455c83a4f55c05ccc6ffc2e
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index bc9f918..5c78fe8 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -544,6 +544,52 @@ static void sil_dev_config(struct ata_po
 	}
 }
 
+static void sil_init_controller(struct pci_dev *pdev,
+				int n_ports, unsigned long host_flags,
+				void __iomem *mmio_base)
+{
+	u8 cls;
+	u32 tmp;
+	int i;
+
+	/* Initialize FIFO PCI bus arbitration */
+	cls = sil_get_device_cache_line(pdev);
+	if (cls) {
+		cls >>= 3;
+		cls++;  /* cls = (line_size/8)+1 */
+		for (i = 0; i < n_ports; i++)
+			writew(cls << 8 | cls,
+			       mmio_base + sil_port[i].fifo_cfg);
+	} else
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "cache line size not set.  Driver may not function\n");
+
+	/* Apply R_ERR on DMA activate FIS errata workaround */
+	if (host_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
+		int cnt;
+
+		for (i = 0, cnt = 0; i < n_ports; i++) {
+			tmp = readl(mmio_base + sil_port[i].sfis_cfg);
+			if ((tmp & 0x3) != 0x01)
+				continue;
+			if (!cnt)
+				dev_printk(KERN_INFO, &pdev->dev,
+					   "Applying R_ERR on DMA activate "
+					   "FIS errata fix\n");
+			writel(tmp & ~0x3, mmio_base + sil_port[i].sfis_cfg);
+			cnt++;
+		}
+	}
+
+	if (n_ports == 4) {
+		/* flip the magic "make 4 ports work" bit */
+		tmp = readl(mmio_base + sil_port[2].bmdma);
+		if ((tmp & SIL_INTR_STEERING) == 0)
+			writel(tmp | SIL_INTR_STEERING,
+			       mmio_base + sil_port[2].bmdma);
+	}
+}
+
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -553,8 +599,6 @@ static int sil_init_one (struct pci_dev 
 	int rc;
 	unsigned int i;
 	int pci_dev_busy = 0;
-	u32 tmp;
-	u8 cls;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -613,42 +657,8 @@ static int sil_init_one (struct pci_dev 
 		ata_std_ports(&probe_ent->port[i]);
 	}
 
-	/* Initialize FIFO PCI bus arbitration */
-	cls = sil_get_device_cache_line(pdev);
-	if (cls) {
-		cls >>= 3;
-		cls++;  /* cls = (line_size/8)+1 */
-		for (i = 0; i < probe_ent->n_ports; i++)
-			writew(cls << 8 | cls,
-			       mmio_base + sil_port[i].fifo_cfg);
-	} else
-		dev_printk(KERN_WARNING, &pdev->dev,
-			   "cache line size not set.  Driver may not function\n");
-
-	/* Apply R_ERR on DMA activate FIS errata workaround */
-	if (probe_ent->host_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
-		int cnt;
-
-		for (i = 0, cnt = 0; i < probe_ent->n_ports; i++) {
-			tmp = readl(mmio_base + sil_port[i].sfis_cfg);
-			if ((tmp & 0x3) != 0x01)
-				continue;
-			if (!cnt)
-				dev_printk(KERN_INFO, &pdev->dev,
-					   "Applying R_ERR on DMA activate "
-					   "FIS errata fix\n");
-			writel(tmp & ~0x3, mmio_base + sil_port[i].sfis_cfg);
-			cnt++;
-		}
-	}
-
-	if (ent->driver_data == sil_3114) {
-		/* flip the magic "make 4 ports work" bit */
-		tmp = readl(mmio_base + sil_port[2].bmdma);
-		if ((tmp & SIL_INTR_STEERING) == 0)
-			writel(tmp | SIL_INTR_STEERING,
-			       mmio_base + sil_port[2].bmdma);
-	}
+	sil_init_controller(pdev, probe_ent->n_ports, probe_ent->host_flags,
+			    mmio_base);
 
 	pci_set_master(pdev);
 
-- 
1.3.2


