From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 16/20] libata: make ata_host_alloc() take care of hpriv alloc/free
Date: Sat, 19 Aug 2006 17:59:33 +0900
Message-ID: <11559779731744-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:38148 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751655AbWHSI76 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:58 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465941pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:58 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Transfer responsibility to allocate/init hpriv from LLD/port_info to
host allocation.  All host allocation/prepare routines now
take @hpriv_hz and initialize host->private_data accordingly.
hpriv area is aligned to __alignof__(long long) and zeroed.

As hpriv handling is moved to host allocation, pinfo->private_data
is removed.  The only user of pinfo->private_data was
ata_pci_init_one() which is updated to take @hpriv argument directly.
This change makes port_info carry one less host-wide info - which
is good because mismatched scope causes confusion and bug
(e.g. ata_piix private_data init bug).

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c         |   29 ++++++++---------------------
 drivers/ata/ata_piix.c     |    9 +++------
 drivers/ata/libata-core.c  |   36 ++++++++++++++++++++++--------------
 drivers/ata/libata-pci.c   |   12 ++++++++----
 drivers/ata/pdc_adma.c     |    2 +-
 drivers/ata/sata_mv.c      |   27 +++++++--------------------
 drivers/ata/sata_nv.c      |    2 +-
 drivers/ata/sata_promise.c |   28 ++++++++--------------------
 drivers/ata/sata_qstor.c   |    4 ++--
 drivers/ata/sata_sil.c     |    2 +-
 drivers/ata/sata_sil24.c   |   19 ++++++++-----------
 drivers/ata/sata_sis.c     |    2 +-
 drivers/ata/sata_svw.c     |    2 +-
 drivers/ata/sata_sx4.c     |   19 ++++++++-----------
 drivers/ata/sata_uli.c     |   31 +++++++++----------------------
 drivers/ata/sata_via.c     |    3 +--
 drivers/ata/sata_vsc.c     |    3 ++-
 include/linux/libata.h     |   14 ++++++++------
 18 files changed, 99 insertions(+), 145 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e8f8977..1ad49fe 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -214,7 +214,6 @@ static int ahci_port_suspend(struct ata_
 static int ahci_port_resume(struct ata_port *ap);
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int ahci_pci_device_resume(struct pci_dev *pdev);
-static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -374,7 +373,7 @@ static struct pci_driver ahci_pci_driver
 	.probe			= ahci_init_one,
 	.suspend		= ahci_pci_device_suspend,
 	.resume			= ahci_pci_device_resume,
-	.remove			= ahci_remove_one,
+	.remove			= ata_pci_remove_one,
 };
 
 
@@ -1453,9 +1452,9 @@ static int ahci_init_one(struct pci_dev 
 {
 	static int printed_version;
 	const struct ata_port_info *pinfo = &ahci_port_info[ent->driver_data];
-	struct ata_host *host = NULL;
-	struct ahci_host_priv *hpriv = NULL;
+	struct ata_host *host;
 	void __iomem *mmio_base = NULL;
+	struct ahci_host_priv *hpriv;
 	const char *reason;
 	u64 dma_mask;
 	u32 cap;
@@ -1479,15 +1478,14 @@ static int ahci_init_one(struct pci_dev 
 			return -ENODEV;
 	}
 
-	/* allocate host and private_data */
-	host = ata_host_alloc(&pdev->dev, NULL, 0);
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!host || !hpriv) {
-		reason = "failed to allocate host and private_data";
+	/* allocate host */
+	host = ata_host_alloc(&pdev->dev, NULL, 0, sizeof(*hpriv));
+	if (!host) {
+		reason = "failed to allocate host";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host->private_data = hpriv;
+	hpriv = host->private_data;
 
 	/* acquire ATA PCI resources */
 	rc = ata_pci_acquire_resources(host, 0, &reason);
@@ -1565,22 +1563,11 @@ static int ahci_init_one(struct pci_dev 
 	if (mmio_base)
 		pci_iounmap(pdev, mmio_base);
 	ata_pci_host_destroy(host);
-	kfree(hpriv);
 
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
 }
 
-static void ahci_remove_one (struct pci_dev *pdev)
-{
-	struct device *dev = pci_dev_to_dev(pdev);
-	struct ata_host *host = dev_get_drvdata(dev);
-	struct ahci_host_priv *hpriv = host->private_data;
-
-	ata_pci_remove_one(pdev);
-	kfree(hpriv);
-}
-
 static int __init ahci_init(void)
 {
 	return pci_register_driver(&ahci_pci_driver);
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 21f19f2..7826bdf 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -805,9 +805,9 @@ static void __devinit piix_init_pcs(stru
 
 static void __devinit piix_init_sata_map(struct pci_dev *pdev,
 					 struct ata_port_info *pinfo,
+					 struct piix_host_priv *hpriv,
 					 const struct piix_map_db *map_db)
 {
-	struct piix_host_priv *hpriv = pinfo[0].private_data;
 	const unsigned int *map;
 	int i, invalid_map = 0;
 	u8 map_value;
@@ -831,7 +831,6 @@ static void __devinit piix_init_sata_map
 		case IDE:
 			WARN_ON((i & 1) || map[i + 1] != IDE);
 			pinfo[i / 2] = piix_port_info[ich5_pata];
-			pinfo[i / 2].private_data = hpriv;
 			i++;
 			printk(" IDE IDE");
 			break;
@@ -890,8 +889,6 @@ static int piix_init_one (struct pci_dev
 
 	port_info[0] = piix_port_info[ent->driver_data];
 	port_info[1] = piix_port_info[ent->driver_data];
-	port_info[0].private_data = hpriv;
-	port_info[1].private_data = hpriv;
 
 	port_flags = port_info[0].flags;
 
@@ -907,7 +904,7 @@ static int piix_init_one (struct pci_dev
 
 	/* Initialize SATA map */
 	if (port_flags & ATA_FLAG_SATA) {
-		piix_init_sata_map(pdev, port_info,
+		piix_init_sata_map(pdev, port_info, hpriv,
 				   piix_map_db_table[ent->driver_data]);
 		piix_init_pcs(pdev, piix_map_db_table[ent->driver_data]);
 	}
@@ -930,7 +927,7 @@ static int piix_init_one (struct pci_dev
 		port_info[1].mwdma_mask = 0;
 		port_info[1].udma_mask = 0;
 	}
-	return ata_pci_init_one(pdev, ppinfo, 2);
+	return ata_pci_init_one(pdev, ppinfo, 2, hpriv);
 }
 
 static void piix_remove_one(struct pci_dev *pdev)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 96709de..457ee4a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5408,11 +5408,16 @@ static struct ata_port *ata_port_alloc(s
  *	@dev: generic device this host is associated with
  *	@sht: template for SCSI host
  *	@n_ports: number of ATA ports associated with this host (can be 0)
+ *	@hpriv_sz: size of host private data
  *
  *	Allocate and initialize basic ATA host resources.  LLD calls
  *	this function to allocate a host, initializes it fully and
  *	attaches it using ata_host_attach().
  *
+ *	If @hpriv_sz is not zero, host private data of the specified
+ *	size is allocated together with host.  Host private data is
+ *	aligned to __alignof__(long long).
+ *
  *	RETURNS:
  *	Allocate ATA host on success, NULL on failure.
  *
@@ -5420,22 +5425,28 @@ static struct ata_port *ata_port_alloc(s
  *	Inherited from calling layer (may sleep).
  */
 struct ata_host *ata_host_alloc(struct device *dev,
-				struct scsi_host_template *sht, int n_ports)
+				struct scsi_host_template *sht, int n_ports,
+				size_t hpriv_sz)
 {
 	struct ata_host *host;
-	size_t sz;
+	size_t hs_sz;
 
 	DPRINTK("ENTER\n");
 
 	/* alloc a container for our list of ATA ports (buses) */
-	sz = sizeof(struct ata_host) + n_ports * sizeof(void *);
+	hs_sz = sizeof(struct ata_host) + n_ports * sizeof(void *);
 	if (n_ports == 0)
-		sz += ATA_MAX_PORTS * sizeof(void *);
+		hs_sz += ATA_MAX_PORTS * sizeof(void *);
+	if (hpriv_sz)
+		hs_sz = ALIGN(hs_sz, __alignof__(long long));
 
-	host = kzalloc(sz, GFP_KERNEL);
+	host = kzalloc(hs_sz + hpriv_sz, GFP_KERNEL);
 	if (!host)
 		return NULL;
 
+	if (hpriv_sz)
+		host->private_data = (void *)host + hs_sz;
+
 	spin_lock_init(&host->lock);
 	host->dev = dev;
 	INIT_LIST_HEAD(&host->irq_list);
@@ -5499,8 +5510,6 @@ static void __ata_host_init_pinfo(struct
 {
 	int i;
 
-	if (host->private_data == NULL)
-		host->private_data = pinfo[0]->private_data;
 	host->ops = pinfo[0]->port_ops;
 
 	for (i = 0; i < host->n_ports; i++) {
@@ -5517,9 +5526,6 @@ static void __ata_host_init_pinfo(struct
 		ap->udma_mask = pi->udma_mask;
 		ap->flags |= pi->flags;
 		ap->ops = pi->port_ops;
-
-		WARN_ON(pi->private_data &&
-			pi->private_data != host->private_data);
 	}
 }
 
@@ -5528,6 +5534,7 @@ static void __ata_host_init_pinfo(struct
  *	@dev: generic device this host is associated with
  *	@pinfo: ATA port_info to initialize host with
  *	@n_ports: number of ATA ports attached to this host
+ *	@hpriv_sz: size of host private data
  *
  *	Allocate ATA host and initialize with info from @pi.
  *
@@ -5539,14 +5546,14 @@ static void __ata_host_init_pinfo(struct
  */
 struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 				      const struct ata_port_info *pinfo,
-				      int n_ports)
+				      int n_ports, size_t hpriv_sz)
 {
 	struct ata_host *host;
 
 	if (!n_ports)
 		return NULL;
 
-	host = ata_host_alloc(dev, pinfo->sht, n_ports);
+	host = ata_host_alloc(dev, pinfo->sht, n_ports, hpriv_sz);
 	if (host)
 		__ata_host_init_pinfo(host, &pinfo, n_ports, 0);
 	return host;
@@ -5557,6 +5564,7 @@ struct ata_host *ata_host_alloc_pinfo(st
  *	@dev: generic device this host is associated with
  *	@pinfo_ar: array of ATA port_info to initialize host with
  *	@n_ports: number of ATA ports attached to this host
+ *	@hpriv_sz: size of host private data
  *
  *	Allocate ATA host and initialize with info from @pinfo_ar.
  *
@@ -5568,14 +5576,14 @@ struct ata_host *ata_host_alloc_pinfo(st
  */
 struct ata_host *ata_host_alloc_pinfo_ar(struct device *dev,
 					 const struct ata_port_info **pinfo_ar,
-					 int n_ports)
+					 int n_ports, size_t hpriv_sz)
 {
 	struct ata_host *host;
 
 	if (!n_ports)
 		return NULL;
 
-	host = ata_host_alloc(dev, pinfo_ar[0]->sht, n_ports);
+	host = ata_host_alloc(dev, pinfo_ar[0]->sht, n_ports, hpriv_sz);
 	if (host)
 		__ata_host_init_pinfo(host, pinfo_ar, n_ports, 1);
 	return host;
diff --git a/drivers/ata/libata-pci.c b/drivers/ata/libata-pci.c
index 997bd14..7fee3c0 100644
--- a/drivers/ata/libata-pci.c
+++ b/drivers/ata/libata-pci.c
@@ -412,6 +412,7 @@ void ata_pci_free_msix_irqs(struct ata_h
  *	@pinfo_ar: array of pointers to ATA port_info
  *	@mask: available port mask
  *	@legacy_mask: legacy port mask
+ *	@hpriv_sz: size of host private data
  *	@r_host: out arg for prepared ATA host
  *
  *	Allocate and initialize ATA host for PCI ATA device @pdev.
@@ -428,7 +429,7 @@ void ata_pci_free_msix_irqs(struct ata_h
  */
 int ata_pci_host_prepare(struct pci_dev *pdev, struct ata_port_info **pinfo_ar,
 			 unsigned int mask, unsigned int legacy_mask,
-			 struct ata_host **r_host)
+			 size_t hpriv_sz, struct ata_host **r_host)
 {
 	struct ata_host *host = NULL;
 	struct ata_port_info dummy_pinfo;
@@ -459,7 +460,7 @@ int ata_pci_host_prepare(struct pci_dev 
 	}
 
 	/* allocate host */
-	host = ata_host_alloc_pinfo_ar(&pdev->dev, pi, n_ports);
+	host = ata_host_alloc_pinfo_ar(&pdev->dev, pi, n_ports, hpriv_sz);
 	if (!host) {
 		reason = "failed to allocate host";
 		rc = -ENOMEM;
@@ -564,6 +565,7 @@ void ata_pci_host_destroy(struct ata_hos
  *	@pdev: Controller to be initialized
  *	@pinfo_ar: Information from low-level host driver
  *	@n_ports: Number of ports attached to host controller
+ *	@hpriv: host private data
  *
  *	This is a helper function which can be called from a driver's
  *	xxx_init_one() probe function if the hardware uses traditional
@@ -580,7 +582,7 @@ void ata_pci_host_destroy(struct ata_hos
  *	Zero on success, negative on errno-based value on error.
  */
 int ata_pci_init_one(struct pci_dev *pdev, struct ata_port_info **pinfo_ar,
-		     unsigned int n_ports)
+		     unsigned int n_ports, void *hpriv)
 
 {
 	unsigned int mask = ATA_PORT_PRIMARY | ATA_PORT_SECONDARY;
@@ -607,10 +609,12 @@ int ata_pci_init_one(struct pci_dev *pde
 	}
 
 	/* prep */
-	rc = ata_pci_host_prepare(pdev, pinfo_ar, mask, legacy_mask, &host);
+	rc = ata_pci_host_prepare(pdev, pinfo_ar, mask, legacy_mask, 0, &host);
 	if (rc)
 		return rc;
 
+	host->private_data = hpriv;
+
 	/* attach */
 	rc = ata_host_attach(host);
 	if (rc)
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index d999235..f21e0db 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -621,7 +621,7 @@ static int adma_ata_init_one(struct pci_
 	/* alloc host */
 	host = ata_host_alloc_pinfo(&pdev->dev,
 				    &adma_port_info[board_idx],
-				    ADMA_PORTS);
+				    ADMA_PORTS, 0);
 	if (!host) {
 		reason = "failed to allocate host";
 		rc = -ENOMEM;
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 9a87937..865cfd8 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -348,7 +348,6 @@ static void mv_qc_prep_iie(struct ata_qu
 static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
 static void mv_eng_timeout(struct ata_port *ap);
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-static void mv_remove_one(struct pci_dev *pdev);
 
 static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 			   unsigned int port);
@@ -542,7 +541,7 @@ static struct pci_driver mv_pci_driver =
 	.name			= DRV_NAME,
 	.id_table		= mv_pci_tbl,
 	.probe			= mv_init_one,
-	.remove			= mv_remove_one,
+	.remove			= ata_pci_remove_one,
 };
 
 static const struct mv_hw_ops mv5xxx_ops = {
@@ -2308,8 +2307,7 @@ static int mv_init_one(struct pci_dev *p
 	static int printed_version = 0;
 	unsigned int board_idx = (unsigned int)ent->driver_data;
 	const struct ata_port_info *pinfo = &mv_port_info[board_idx];
-	struct ata_host *host = NULL;
-	struct mv_host_priv *hpriv = NULL;
+	struct ata_host *host;
 	void __iomem *mmio_base = NULL;
 	const char *reason;
 	int n_ports, rc;
@@ -2317,17 +2315,16 @@ static int mv_init_one(struct pci_dev *p
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* alloc host and hpriv */
+	/* alloc host */
 	n_ports = MV_PORTS_PER_HC * mv_get_hc_count(pinfo->flags);
 
-	host = ata_host_alloc_pinfo(&pdev->dev, pinfo, n_ports);
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!host || !hpriv) {
-		reason = "failed to allocate host and private_data";
+	host = ata_host_alloc_pinfo(&pdev->dev, pinfo, n_ports,
+				    sizeof(struct mv_host_priv));
+	if (!host) {
+		reason = "failed to allocate host";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host->private_data = hpriv;
 
 	/* acquire generic ATA PCI resources */
 	rc = ata_pci_acquire_resources(host, DMA_64BIT_MASK, &reason);
@@ -2373,21 +2370,11 @@ static int mv_init_one(struct pci_dev *p
 	if (mmio_base)
 		pci_iounmap(pdev, mmio_base);
 	ata_pci_host_destroy(host);
-	kfree(hpriv);
 
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
 }
 
-static void mv_remove_one(struct pci_dev *pdev)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	struct mv_host_priv *hpriv = host->private_data;
-
-	ata_pci_remove_one(pdev);
-	kfree(hpriv);
-}
-
 static int __init mv_init(void)
 {
 	return pci_register_driver(&mv_pci_driver);
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 59ee99a..00894a0 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -499,7 +499,7 @@ static int nv_init_one (struct pci_dev *
 	/* alloc host */
 	host = ata_host_alloc_pinfo(&pdev->dev,
 				    &nv_port_info[ent->driver_data],
-				    NV_PORTS);
+				    NV_PORTS, 0);
 	if (!host) {
 		reason = "failed to allocate host";
 		rc = -ENOMEM;
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 92571f7..6e33abb 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -98,7 +98,6 @@ struct pdc_host_priv {
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_ata_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-static void pdc_ata_remove_one(struct pci_dev *pdev);
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
@@ -298,7 +297,7 @@ static struct pci_driver pdc_ata_pci_dri
 	.name			= DRV_NAME,
 	.id_table		= pdc_ata_pci_tbl,
 	.probe			= pdc_ata_init_one,
-	.remove			= pdc_ata_remove_one,
+	.remove			= ata_pci_remove_one,
 };
 
 
@@ -693,8 +692,8 @@ static int pdc_ata_init_one(struct pci_d
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	const struct ata_port_info *pinfo = &pdc_port_info[board_idx];
-	struct ata_host *host = NULL;
-	struct pdc_host_priv *hp = NULL;
+	struct ata_host *host;
+	struct pdc_host_priv *hp;
 	void __iomem *mmio_base = NULL;
 	unsigned long base;
 	const char *reason;
@@ -703,16 +702,15 @@ static int pdc_ata_init_one(struct pci_d
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* allocate host and private_data */
+	/* allocate host */
 	host = ata_host_alloc_pinfo(&pdev->dev, pinfo,
-				    PDC_FLAG2NPORTS(pinfo->flags));
-	hp = kzalloc(sizeof(*hp), GFP_KERNEL);
-	if (!host || !hp) {
-		reason = "failed to allocate host and private_data";
+				    PDC_FLAG2NPORTS(pinfo->flags), sizeof(*hp));
+	if (!host) {
+		reason = "failed to allocate host";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host->private_data = hp;
+	hp = host->private_data;
 
 	/* acquire generic ATA PCI resources */
 	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
@@ -771,21 +769,11 @@ static int pdc_ata_init_one(struct pci_d
 	if (mmio_base)
 		pci_iounmap(pdev, mmio_base);
 	ata_pci_host_destroy(host);
-	kfree(hp);
 
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
 }
 
-static void pdc_ata_remove_one(struct pci_dev *pdev)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	struct pdc_host_priv *hp = host->private_data;
-
-	ata_pci_remove_one(pdev);
-	kfree(hp);
-}
-
 static int __init pdc_ata_init(void)
 {
 	return pci_register_driver(&pdc_ata_pci_driver);
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index c564ac4..420eb58 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -608,8 +608,8 @@ static int qs_ata_init_one(struct pci_de
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/* alloc host */
-	host = ata_host_alloc_pinfo(&pdev->dev,
-				    &qs_port_info[board_idx], QS_PORTS);
+	host = ata_host_alloc_pinfo(&pdev->dev, &qs_port_info[board_idx],
+				    QS_PORTS, 0);
 	if (!host) {
 		reason = "failed to allocate host";
 		rc = -ENOMEM;
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 3619f86..9cabbb5 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -618,7 +618,7 @@ static int sil_init_one (struct pci_dev 
 	/* alloc host */
 	host = ata_host_alloc_pinfo(&pdev->dev,
 				    &sil_port_info[ent->driver_data],
-				    (ent->driver_data == sil_3114) ? 4 : 2);
+				    (ent->driver_data == sil_3114) ? 4 : 2, 0);
 	if (!host) {
 		reason = "failed to allocate host";
 		rc = -ENOMEM;
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 3c6d668..9f1ad0f 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1046,8 +1046,8 @@ static int sil24_init_one(struct pci_dev
 	static int printed_version = 0;
 	unsigned int board_id = (unsigned int)ent->driver_data;
 	struct ata_port_info *pinfo = &sil24_port_info[board_id];
-	struct ata_host *host = NULL;
-	struct sil24_host_priv *hpriv = NULL;
+	struct ata_host *host;
+	struct sil24_host_priv *hpriv;
 	void __iomem *host_base = NULL;
 	void __iomem *port_base = NULL;
 	const char *reason;
@@ -1057,17 +1057,16 @@ static int sil24_init_one(struct pci_dev
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* alloc host and hpriv */
+	/* alloc host */
 	host = ata_host_alloc_pinfo(&pdev->dev, pinfo,
-				    SIL24_FLAG2NPORTS(pinfo->flags));
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-
-	if (!host || !hpriv) {
-		reason = "failed to allocate host and private_data";
+				    SIL24_FLAG2NPORTS(pinfo->flags),
+				    sizeof(*hpriv));
+	if (!host) {
+		reason = "failed to allocate host";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host->private_data = hpriv;
+	hpriv = host->private_data;
 
 	/* acquire generic ATA PCI resources */
 	rc = ata_pci_acquire_resources(host, DMA_64BIT_MASK, &reason);
@@ -1137,7 +1136,6 @@ static int sil24_init_one(struct pci_dev
 	if (port_base)
 		pci_iounmap(pdev, port_base);
 	ata_pci_host_destroy(host);
-	kfree(hpriv);
 
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
@@ -1155,7 +1153,6 @@ static void sil24_remove_one(struct pci_
 	pci_iounmap(pdev, hpriv->port_base);
 
 	ata_pci_host_destroy(host);
-	kfree(hpriv);
 }
 
 static int sil24_pci_device_resume(struct pci_dev *pdev)
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 56ad81d..a696693 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -247,7 +247,7 @@ static int sis_init_one (struct pci_dev 
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/* alloc host */
-	host = ata_host_alloc_pinfo(&pdev->dev, &sis_port_info, 2);
+	host = ata_host_alloc_pinfo(&pdev->dev, &sis_port_info, 2, 0);
 	if (!host) {
 		reason = "failed to allocate host";
 		rc = -ENOMEM;
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 79c526d..d51e860 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -386,7 +386,7 @@ static int k2_sata_init_one (struct pci_
 	 * ent->driver_data and the same is done here.  Verify the bug
 	 * and fix.
 	 */
-	host = ata_host_alloc_pinfo(&pdev->dev, &k2_sata_port_info, 4);
+	host = ata_host_alloc_pinfo(&pdev->dev, &k2_sata_port_info, 4, 0);
 	if (!host) {
 		reason = "failed to allocate host";
 		rc = -ENOMEM;
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 794dbed..4a235ab 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1353,8 +1353,8 @@ static int pdc_sata_init_one(struct pci_
 {
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	struct ata_host *host = NULL;
-	struct pdc_host_priv *hpriv = NULL;
+	struct ata_host *host;
+	struct pdc_host_priv *hpriv;
 	void __iomem *mmio_base = NULL;
 	void __iomem *dimm_mmio = NULL;
 	unsigned long base;
@@ -1364,17 +1364,16 @@ static int pdc_sata_init_one(struct pci_
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* alloc host and hpriv */
+	/* alloc host */
 	host = ata_host_alloc_pinfo(&pdev->dev,
-				    &pdc_port_info[board_idx], 4);
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-
-	if (!host || !hpriv) {
-		reason = "failed to allocate host and private_data";
+					    &pdc_port_info[board_idx],
+					    4, sizeof(*hpriv));
+	if (!host) {
+		reason = "failed to allocate host";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host->private_data = hpriv;
+	hpriv = host->private_data;
 
 	/* acquire generic ATA PCI resources */
 	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
@@ -1437,7 +1436,6 @@ static int pdc_sata_init_one(struct pci_
 	if (dimm_mmio)
 		pci_iounmap(pdev, dimm_mmio);
 	ata_pci_host_destroy(host);
-	kfree(hpriv);
 
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
@@ -1456,7 +1454,6 @@ static void pdc_sata_remove_one(struct p
 	pci_iounmap(pdev, hpriv->dimm_mmio);
 
 	ata_pci_host_destroy(host);
-	kfree(hpriv);
 }
 
 
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 540bdd5..5ffdc2b 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -57,7 +57,6 @@ struct uli_priv {
 };
 
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void uli_remove_one(struct pci_dev *pdev);
 static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
@@ -73,7 +72,7 @@ static struct pci_driver uli_pci_driver 
 	.name			= DRV_NAME,
 	.id_table		= uli_pci_tbl,
 	.probe			= uli_init_one,
-	.remove			= uli_remove_one,
+	.remove			= ata_pci_remove_one,
 };
 
 static struct scsi_host_template uli_sht = {
@@ -184,8 +183,8 @@ static int uli_init_one(struct pci_dev *
 {
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	struct ata_host *host = NULL;
-	struct uli_priv *hpriv = NULL;
+	struct ata_host *host;
+	struct uli_priv *hpriv;
 	struct ata_ioports *ioaddr;
 	const char *reason;
 	int rc;
@@ -193,17 +192,16 @@ static int uli_init_one(struct pci_dev *
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* alloc host and hpriv */
+	/* alloc host */
 	host = ata_host_alloc_pinfo(&pdev->dev, &uli_port_info,
-				    board_idx == uli_5287 ? 4 : 2);
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-
-	if (!host || !hpriv) {
-		reason = "failed to allocate host and private_data";
+					    board_idx == uli_5287 ? 4 : 2,
+					    sizeof(*hpriv));
+	if (!host) {
+		reason = "failed to allocate host";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host->private_data = hpriv;
+	hpriv = host->private_data;
 
 	/* acquire generic ATA PCI resources */
 	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
@@ -272,21 +270,10 @@ static int uli_init_one(struct pci_dev *
 
  err:
 	ata_pci_host_destroy(host);
-	kfree(hpriv);
-
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
 }
 
-static void uli_remove_one(struct pci_dev *pdev)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	struct uli_priv *hpriv = host->private_data;
-
-	ata_pci_remove_one(pdev);
-	kfree(hpriv);
-}
-
 static int __init uli_init(void)
 {
 	return pci_register_driver(&uli_pci_driver);
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index db7b09e..f0bc20e 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -254,8 +254,7 @@ static int svia_init_one(struct pci_dev 
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/* alloc host */
-	host = ata_host_alloc_pinfo(&pdev->dev, &svia_port_info,
-				    N_PORTS);
+	host = ata_host_alloc_pinfo(&pdev->dev, &svia_port_info, N_PORTS, 0);
 	if (!host) {
 		reason = "failed to allocate host";
 		rc = -ENOMEM;
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index ac00d17..71ea8d9 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -357,7 +357,8 @@ static int __devinit vsc_sata_init_one (
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/* alloc host */
-	host = ata_host_alloc_pinfo(&pdev->dev, &vsc_sata_port_info, 4);
+	host = ata_host_alloc_pinfo(&pdev->dev, &vsc_sata_port_info,
+					    4, 0);
 	if (!host) {
 		reason = "failed to allocate host";
 		rc = -ENOMEM;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 791fa97..f72cc73 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -657,7 +657,6 @@ struct ata_port_info {
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
 	const struct ata_port_operations *port_ops;
-	void 			*private_data;
 	/* fields for BMDMA init */
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 };
@@ -730,10 +729,10 @@ extern void ata_pci_free_msix_irqs(struc
 extern int ata_pci_host_prepare(struct pci_dev *pdev,
 				struct ata_port_info **pinfo_ar,
 				unsigned int mask, unsigned int legacy_mask,
-				struct ata_host **r_host);
+				size_t hpriv_sz, struct ata_host **r_host);
 extern void ata_pci_host_destroy(struct ata_host *host);
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
-			     unsigned int n_ports);
+			     unsigned int n_ports, void *hpriv);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
 extern void ata_pci_device_do_resume(struct pci_dev *pdev);
@@ -742,13 +741,16 @@ extern int ata_pci_device_resume(struct 
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern struct ata_host *ata_host_alloc(struct device *dev,
-			struct scsi_host_template *sht, int n_ports);
+			struct scsi_host_template *sht, int n_ports,
+			size_t hpriv_sz);
 extern int ata_host_add_ports(struct ata_host *host,
 			struct scsi_host_template *sht, int n_ports);
 extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
-			const struct ata_port_info *pinfo, int n_ports);
+			const struct ata_port_info *pinfo, int n_ports,
+			size_t hpriv_sz);
 extern struct ata_host *ata_host_alloc_pinfo_ar(struct device *dev,
-			const struct ata_port_info **pinfo_ar, int n_ports);
+			const struct ata_port_info **pinfo_ar, int n_ports,
+			size_t hpriv_sz);
 extern int ata_host_add_ports_pinfo(struct ata_host *host,
 			const struct ata_port_info *pinfo, int n_ports);
 extern int ata_host_add_ports_pinfo_ar(struct ata_host *host,
-- 
1.4.1.1


