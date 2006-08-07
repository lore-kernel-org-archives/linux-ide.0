From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/17] libata: make ata_pci_acquire_resources() handle iomap
Date: Mon, 7 Aug 2006 12:04:02 +0900
Message-ID: <11549198422089-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:36166 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750982AbWHGDEX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:23 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855408pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:22 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_pci_acquire_resources() handle iomap.  @bar_mask is added and
for each set bit respective PCI BAR is iomapped and stored in
host_set->iomap[BAR#].  All iomaps stored in host_set->iomap[] are
freed by ata_pci_release_resources().

Also, acquire_resources() also map legacy IO areas and store them in
host_set->legacy_iomap[p][a] where @p is port number
(0=PRIMARY/1=SECONDARY) and @a indicates CMD or CTL.

This function only implements the feature.

Took hints from iomap patch by Jeff Garzik <jgarzik@pobox.com>.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |    2 +
 drivers/scsi/libata-bmdma.c |   65 ++++++++++++++++++++++++++++++++++++++++---
 drivers/scsi/pdc_adma.c     |    2 +
 drivers/scsi/sata_mv.c      |    2 +
 drivers/scsi/sata_nv.c      |    2 +
 drivers/scsi/sata_promise.c |    2 +
 drivers/scsi/sata_qstor.c   |    2 +
 drivers/scsi/sata_sil.c     |    2 +
 drivers/scsi/sata_sil24.c   |    2 +
 drivers/scsi/sata_sis.c     |    2 +
 drivers/scsi/sata_svw.c     |    2 +
 drivers/scsi/sata_sx4.c     |    2 +
 drivers/scsi/sata_uli.c     |    2 +
 drivers/scsi/sata_via.c     |    2 +
 drivers/scsi/sata_vsc.c     |    2 +
 include/linux/libata.h      |    5 +++
 16 files changed, 78 insertions(+), 20 deletions(-)

34fffc5383aab3af3ccbd2628ab1973d47a69f88
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 03952d1..eb3640c 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1488,7 +1488,7 @@ static int ahci_init_one(struct pci_dev 
 	hpriv = host_set->private_data;
 
 	/* acquire ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, 0, &reason);
+	rc = ata_pci_acquire_resources(host_set, 0, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 15d6560..388d91d 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -995,6 +995,7 @@ static const char *ata_drv_name(struct d
  *	ata_pci_acquire_resources - acquire default PCI resources
  *	@host_set: target ATA host_set to acquire PCI resources for
  *	@dma_mask: DMA mask
+ *	@bar_mask: mask of PCI bars to iomap
  *	@reason: output arg for error message
  *
  *	Acquire default ATA PCI resources.
@@ -1006,10 +1007,12 @@ static const char *ata_drv_name(struct d
  *	0 on success, -errno otherwise.
  */
 int ata_pci_acquire_resources(struct ata_host_set *host_set, u64 dma_mask,
-			      const char **reason)
+			      unsigned int bar_mask, const char **reason)
 {
 	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 	const char *name = ata_drv_name(&pdev->dev);
+	void __iomem **iomap = host_set->iomap;
+	void __iomem *(*legacy_iomap)[2] = host_set->legacy_iomap;
 	int nr_dummy, i, rc;
 
 	/* acquire generic resources */
@@ -1043,11 +1046,36 @@ int ata_pci_acquire_resources(struct ata
 	if (rc)
 		goto err;
 
+	/* iomap PCI BAR */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		if (!(bar_mask & (1 << i)))
+			continue;
+
+		WARN_ON(iomap[i]);
+
+		if (!pci_resource_start(pdev, i) ||
+		    !pci_resource_len(pdev, i)) {
+			*reason = "iomap requested for null PCI BAR";
+			rc = -EIO;
+			goto err;
+		}
+
+		iomap[i] = pci_iomap(pdev, i, 0);
+		if (!iomap[i]) {
+			rc = -ENOMEM;
+			*reason = "failed to iomap PCI BAR";
+			goto err;
+		}
+	}
+
 	/* Acquire legacy resources.  For legacy ports, host_set must
 	 * be popultaed with ports before calling this function.
 	 */
 	nr_dummy = 0;
 	for (i = 0; i < 2; i++) {
+		unsigned long cmd_addr = ata_legacy_addr_tbl[i][0];
+		unsigned long ctl_addr = ata_legacy_addr_tbl[i][1];
+
 		if (!(host_set->flags & (ATA_HOST_LEGACY_PRI << i)))
 			continue;
 		BUG_ON(i >= host_set->n_ports);
@@ -1055,6 +1083,15 @@ int ata_pci_acquire_resources(struct ata
 		if (ata_pci_acquire_legacy(i, name, &host_set->flags)) {
 			host_set->ports[i]->ops = &ata_dummy_port_ops;
 			nr_dummy++;
+			continue;
+		}
+
+		legacy_iomap[i][0] = ioport_map(cmd_addr, 8);
+		legacy_iomap[i][1] = ioport_map(ctl_addr, 4);
+		if (!legacy_iomap[i][0] || (ctl_addr && !legacy_iomap[i][1])) {
+			rc = -ENOMEM;
+			*reason = "failed to iomap legacy TF";
+			goto err;
 		}
 	}
 
@@ -1131,7 +1168,9 @@ int ata_pci_request_irq(struct ata_host_
 void ata_pci_release_resources(struct ata_host_set *host_set)
 {
 	struct pci_dev *pdev = to_pci_dev(host_set->dev);
-	int i;
+	void __iomem **iomap = host_set->iomap;
+	void __iomem *(*legacy_iomap)[2] = host_set->legacy_iomap;
+	int i, j;
 
 	/* stop all ports */
 	ata_host_set_stop(host_set);
@@ -1162,7 +1201,16 @@ void ata_pci_release_resources(struct at
 		host_set->flags &= ~ATA_HOST_PCI_RES_MSI;
 	}
 
-	/* release legacy resources */
+	/* unmap and release legacy resources */
+	for (i = 0; i < 2; i++) {
+		for (j = 0; j < 2; j++) {
+			if (legacy_iomap[i][j]) {
+				pci_iounmap(pdev, legacy_iomap[i][j]);
+				legacy_iomap[i][j] = NULL;
+			}
+		}
+	}
+
 	for (i = 0; i < 2; i++) {
 		if (host_set->flags & (ATA_HOST_RES_LEGACY_PRI << i)) {
 			release_region(ata_legacy_addr_tbl[i][0], 8);
@@ -1170,7 +1218,14 @@ void ata_pci_release_resources(struct at
 		}
 	}
 
-	/* release generic resources */
+	/* release PCI iomaps and resources */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		if (iomap[i]) {
+			pci_iounmap(pdev, iomap[i]);
+			iomap[i] = NULL;
+		}
+	}
+
 	if (host_set->flags & ATA_HOST_PCI_RES_GEN) {
 		pci_release_regions(pdev);
 
@@ -1270,7 +1325,7 @@ int ata_pci_host_set_prepare(struct pci_
 	host_set->flags |= legacy_mask & ATA_HOST_LEGACY_MASK;
 
 	/* acquire ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 055297e..0ad6c60 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -628,7 +628,7 @@ static int adma_ata_init_one(struct pci_
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, DMA_32BIT_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, DMA_32BIT_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index f52452e..631a175 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -2329,7 +2329,7 @@ static int mv_init_one(struct pci_dev *p
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, DMA_64BIT_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, DMA_64BIT_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 9da8782..0e66c02 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -507,7 +507,7 @@ static int nv_init_one (struct pci_dev *
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 3f6b98e..556486a 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -714,7 +714,7 @@ static int pdc_ata_init_one(struct pci_d
 	hp = host_set->private_data;
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 2c7610e..c36e6a8 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -618,7 +618,7 @@ static int qs_ata_init_one(struct pci_de
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, 0, &reason);
+	rc = ata_pci_acquire_resources(host_set, 0, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index ef9ba6a..72297e1 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -631,7 +631,7 @@ static int sil_init_one (struct pci_dev 
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 8d1ed7c..501b32e 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -1068,7 +1068,7 @@ static int sil24_init_one(struct pci_dev
 	hpriv = host_set->private_data;
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, DMA_64BIT_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, DMA_64BIT_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 19818c3..2017642 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -255,7 +255,7 @@ static int sis_init_one (struct pci_dev 
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index b6c7783..b303317 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -395,7 +395,7 @@ static int k2_sata_init_one (struct pci_
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 36cf01d..cf96fba 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -1376,7 +1376,7 @@ static int pdc_sata_init_one(struct pci_
 	hpriv = host_set->private_data;
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 183d4e6..0150561 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -204,7 +204,7 @@ static int uli_init_one(struct pci_dev *
 	hpriv = host_set->private_data;
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 9920050..da47a64 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -263,7 +263,7 @@ static int svia_init_one(struct pci_dev 
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index b99387d..0d86e8d 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -368,7 +368,7 @@ static int __devinit vsc_sata_init_one (
 	/* Acquire generic ATA PCI resources.  Use 32 bit DMA mask,
 	 * because 64 bit address support is poor.
 	 */
-	rc = ata_pci_acquire_resources(host_set, DMA_32BIT_MASK, &reason);
+	rc = ata_pci_acquire_resources(host_set, DMA_32BIT_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 46e3c10..619b918 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -379,6 +379,8 @@ struct ata_host_set {
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
+	void __iomem		*iomap[DEVICE_COUNT_RESOURCE];
+	void __iomem		*legacy_iomap[2][2];
 	struct ata_port		*ports[0];
 };
 
@@ -843,7 +845,8 @@ extern unsigned int ata_pci_legacy_mask(
 extern int ata_pci_set_dma_mask(struct pci_dev *pdev, u64 dma_mask,
 				const char **p_reason);
 extern int ata_pci_acquire_resources(struct ata_host_set *host_set,
-				     u64 dma_mask, const char **reason);
+				     u64 dma_mask, unsigned int bar_mask,
+				     const char **reason);
 extern int ata_pci_request_irq(struct ata_host_set *host_set,
 		irqreturn_t (*irq_handler)(int, void *, struct pt_regs *),
 		unsigned int flags, const char **reason);
-- 
1.3.2


