From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 17/20] libata: make ata_pci_acquire_resources() handle iomap
Date: Sat, 19 Aug 2006 17:59:33 +0900
Message-ID: <11559779733267-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:38148 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751658AbWHSI77 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:59 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465941pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:59 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_pci_acquire_resources() handle iomap.  @bar_mask is added and
for each set bit respective PCI BAR is iomapped and stored in
host->iomap[BAR#].  All iomaps stored in host->iomap[] are freed by
ata_pci_release_resources().

Also, acquire_resources() also map legacy IO areas and store them in
host->legacy_iomap[p][a] where @p is port number
(0=PRIMARY/1=SECONDARY) and @a indicates CMD or CTL.

This function only implements the feature.

Took hints from iomap patch by Jeff Garzik <jgarzik@pobox.com>.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c          |    2 +-
 drivers/ata/libata-legacy.c |   34 ++++++++++++++++++++++++++++++----
 drivers/ata/libata-pci.c    |   38 +++++++++++++++++++++++++++++++++++---
 drivers/ata/pdc_adma.c      |    2 +-
 drivers/ata/sata_mv.c       |    2 +-
 drivers/ata/sata_nv.c       |    2 +-
 drivers/ata/sata_promise.c  |    2 +-
 drivers/ata/sata_qstor.c    |    2 +-
 drivers/ata/sata_sil.c      |    2 +-
 drivers/ata/sata_sil24.c    |    2 +-
 drivers/ata/sata_sis.c      |    2 +-
 drivers/ata/sata_svw.c      |    2 +-
 drivers/ata/sata_sx4.c      |    2 +-
 drivers/ata/sata_uli.c      |    2 +-
 drivers/ata/sata_via.c      |    2 +-
 drivers/ata/sata_vsc.c      |    2 +-
 include/linux/libata.h      |    4 ++++
 17 files changed, 83 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1ad49fe..92d0394 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1488,7 +1488,7 @@ static int ahci_init_one(struct pci_dev 
 	hpriv = host->private_data;
 
 	/* acquire ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, 0, &reason);
+	rc = ata_pci_acquire_resources(host, 0, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/libata-legacy.c b/drivers/ata/libata-legacy.c
index c519602..eac4d06 100644
--- a/drivers/ata/libata-legacy.c
+++ b/drivers/ata/libata-legacy.c
@@ -52,10 +52,12 @@ static unsigned long ata_legacy_addr(int
 	}
 }
 
-static int ata_legacy_acquire_port(struct ata_port *ap)
+static int ata_legacy_acquire_port(struct ata_port *ap, const char **p_reason)
 {
 	struct ata_host *host = ap->host;
+	void __iomem **legacy_iomap = host->legacy_iomap[ap->port_no];
 	unsigned long cmd_addr = ata_legacy_addr(ap->port_no, 0);
+	unsigned long ctl_addr = ata_legacy_addr(ap->port_no, 1);
 
 	if (request_region(cmd_addr, 8, ata_drv_name(host)) != NULL)
 		host->legacy_flags |= ATA_LEGACY_RES_PRI << ap->port_no;
@@ -75,6 +77,13 @@ static int ata_legacy_acquire_port(struc
 		printk("ata: 0x%0lX IDE port preallocated\n", cmd_addr);
 	}
 
+	legacy_iomap[0] = ioport_map(cmd_addr, 8);
+	legacy_iomap[1] = ioport_map(ctl_addr, 4);
+	if (!legacy_iomap[0] || (ctl_addr && !legacy_iomap[1])) {
+		*p_reason = "failed to iomap legacy TF";
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -97,18 +106,28 @@ static int ata_legacy_acquire_port(struc
  */
 int ata_legacy_acquire_resources(struct ata_host *host, const char **p_reason)
 {
-	int i;
+	const char *reason;
+	int i, rc;
 
 	for (i = 0; i < 2; i++) {
 		if (!(host->legacy_flags & (ATA_PORT_PRIMARY << i)))
 			continue;
 		BUG_ON(i >= host->n_ports);
 
-		if (ata_legacy_acquire_port(host->ports[i]))
+		rc = ata_legacy_acquire_port(host->ports[i], &reason);
+		if (rc == -EBUSY)
 			host->ports[i]->ops = &ata_dummy_port_ops;
+		else if (rc)
+			goto err;
 	}
 
 	return 0;
+
+ err:
+	if (p_reason)
+		*p_reason = reason;
+	ata_legacy_release_resources(host);
+	return rc;
 }
 
 /**
@@ -122,9 +141,16 @@ int ata_legacy_acquire_resources(struct 
  */
 void ata_legacy_release_resources(struct ata_host *host)
 {
-	int i;
+	void __iomem *(*legacy_iomap)[2] = host->legacy_iomap;
+	int i, j;
 
 	for (i = 0; i < 2; i++) {
+		for (j = 0; j < 2; j++)
+			if (legacy_iomap[i][j]) {
+				ioport_unmap(legacy_iomap[i][j]);
+				legacy_iomap[i][j] = NULL;
+			}
+
 		if (host->legacy_flags & (ATA_LEGACY_RES_PRI << i)) {
 			release_region(ata_legacy_addr(i, 0), 8);
 			host->legacy_flags &= ~(ATA_LEGACY_RES_PRI << i);
diff --git a/drivers/ata/libata-pci.c b/drivers/ata/libata-pci.c
index 7fee3c0..18a1952 100644
--- a/drivers/ata/libata-pci.c
+++ b/drivers/ata/libata-pci.c
@@ -133,6 +133,7 @@ int ata_pci_set_dma_mask(struct pci_dev 
  *	ata_pci_acquire_resources - acquire default PCI resources
  *	@host: target ATA host to acquire PCI resources for
  *	@dma_mask: DMA mask
+ *	@bar_mask: mask of PCI bars to iomap
  *	@p_reason: out arg for error message (can be NULL)
  *
  *	Acquire default ATA PCI resources.
@@ -144,11 +145,12 @@ int ata_pci_set_dma_mask(struct pci_dev 
  *	0 on success, -errno otherwise.
  */
 int ata_pci_acquire_resources(struct ata_host *host, u64 dma_mask,
-			      const char **p_reason)
+			      unsigned int bar_mask, const char **p_reason)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
+	void __iomem **iomap = host->iomap;
 	const char *reason;
-	int rc;
+	int i, rc;
 
 	/* acquire generic resources */
 
@@ -181,6 +183,28 @@ int ata_pci_acquire_resources(struct ata
 	if (rc)
 		goto err;
 
+	/* iomap PCI BARs */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		if (!(bar_mask & (1 << i)))
+			continue;
+
+		WARN_ON(iomap[i]);
+
+		if (!pci_resource_start(pdev, i) ||
+		    !pci_resource_len(pdev, i)) {
+			reason = "iomap requested for null PCI BAR";
+			rc = -EIO;
+			goto err;
+		}
+
+		iomap[i] = pci_iomap(pdev, i, 0);
+		if (!iomap[i]) {
+			rc = -ENOMEM;
+			reason = "failed to iomap PCI BAR";
+			goto err;
+		}
+	}
+
 	return 0;
 
  err:
@@ -202,6 +226,14 @@ int ata_pci_acquire_resources(struct ata
 void ata_pci_release_resources(struct ata_host *host)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
+	void __iomem **iomap = host->iomap;
+	int i;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
+		if (iomap[i]) {
+			pci_iounmap(pdev, iomap[i]);
+			iomap[i] = NULL;
+		}
 
 	if (host->pci_flags & ATA_PCI_RES_GEN) {
 		pci_release_regions(pdev);
@@ -470,7 +502,7 @@ int ata_pci_host_prepare(struct pci_dev 
 	/* acquire PCI and legacy resources and init host accordingly */
 	host->legacy_flags |= legacy_mask & ATA_LEGACY_MASK;
 
-	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index f21e0db..7f0c104 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -629,7 +629,7 @@ static int adma_ata_init_one(struct pci_
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, DMA_32BIT_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, DMA_32BIT_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 865cfd8..ea09e7e 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2327,7 +2327,7 @@ static int mv_init_one(struct pci_dev *p
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, DMA_64BIT_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, DMA_64BIT_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 00894a0..f9b3602 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -507,7 +507,7 @@ static int nv_init_one (struct pci_dev *
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 6e33abb..e384d80 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -713,7 +713,7 @@ static int pdc_ata_init_one(struct pci_d
 	hp = host->private_data;
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 420eb58..dc8d88c 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -617,7 +617,7 @@ static int qs_ata_init_one(struct pci_de
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, 0, &reason);
+	rc = ata_pci_acquire_resources(host, 0, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 9cabbb5..dec3c91 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -626,7 +626,7 @@ static int sil_init_one (struct pci_dev 
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 9f1ad0f..269dee0 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1069,7 +1069,7 @@ static int sil24_init_one(struct pci_dev
 	hpriv = host->private_data;
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, DMA_64BIT_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, DMA_64BIT_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index a696693..0869501 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -255,7 +255,7 @@ static int sis_init_one (struct pci_dev 
 	}
 
 	/* acquire generic ATA PCI resources and init PCI host */
-	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index d51e860..e16d1c7 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -394,7 +394,7 @@ static int k2_sata_init_one (struct pci_
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 4a235ab..3a0257d 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1376,7 +1376,7 @@ static int pdc_sata_init_one(struct pci_
 	hpriv = host->private_data;
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 5ffdc2b..3a9723e 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -204,7 +204,7 @@ static int uli_init_one(struct pci_dev *
 	hpriv = host->private_data;
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index f0bc20e..2a7513d 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -262,7 +262,7 @@ static int svia_init_one(struct pci_dev 
 	}
 
 	/* acquire generic ATA PCI resources */
-	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 71ea8d9..153403f 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -368,7 +368,7 @@ static int __devinit vsc_sata_init_one (
 	/* Acquire generic ATA PCI resources.  Use 32 bit DMA mask,
 	 * because 64 bit address support is poor.
 	 */
-	rc = ata_pci_acquire_resources(host, DMA_32BIT_MASK, &reason);
+	rc = ata_pci_acquire_resources(host, DMA_32BIT_MASK, 0, &reason);
 	if (rc)
 		goto err;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f72cc73..ed02ae9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -407,6 +407,9 @@ struct ata_host {
 	unsigned int		legacy_flags;
 	unsigned int		pci_flags;
 
+	void __iomem		*legacy_iomap[2][2];
+	void __iomem		*iomap[DEVICE_COUNT_RESOURCE];
+
 	struct list_head	irq_list;	/* list of acquired irqs */
 	struct ata_port		*ports[0];
 };
@@ -714,6 +717,7 @@ extern unsigned int ata_pci_legacy_mask(
 extern int ata_pci_set_dma_mask(struct pci_dev *pdev, u64 dma_mask,
 				const char **p_reason);
 extern int ata_pci_acquire_resources(struct ata_host *host, u64 dma_mask,
+				     unsigned int bar_mask,
 				     const char **p_reason);
 extern void ata_pci_release_resources(struct ata_host *host);
 extern void ata_pci_init_ports(struct ata_host *host);
-- 
1.4.1.1


