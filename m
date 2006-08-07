From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/17] libata: make ata_host_set_alloc() take care of hpriv alloc/free
Date: Mon, 7 Aug 2006 12:04:02 +0900
Message-ID: <11549198423828-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:16454 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750949AbWHGDEW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:22 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855381pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:21 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Transfer responsibility to allocate/init hpriv from LLD/port_info to
host_set allocation.  All host_set allocation/prepare routines now
take @hpriv_hz and initialize host_set->private_data accordingly.
hpriv area is aligned to __alignof__(long long) and zeroed.

As hpriv handling is moved to host_set allocation, pinfo->private_data
is removed.  The only user of pinfo->private_data was
ata_pci_init_one() which is updated to take @hpriv argument directly.
This change makes port_info carry one less host_set-wide info - which
is good because mismatched scope causes confusion and bug
(e.g. ata_piix private_data init bug).

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |   29 ++++++++---------------------
 drivers/scsi/ata_piix.c     |    9 +++------
 drivers/scsi/libata-bmdma.c |   13 +++++++++----
 drivers/scsi/libata-core.c  |   37 +++++++++++++++++++++++--------------
 drivers/scsi/pdc_adma.c     |    2 +-
 drivers/scsi/sata_mv.c      |   27 +++++++--------------------
 drivers/scsi/sata_nv.c      |    2 +-
 drivers/scsi/sata_promise.c |   29 +++++++++--------------------
 drivers/scsi/sata_qstor.c   |    3 ++-
 drivers/scsi/sata_sil.c     |    2 +-
 drivers/scsi/sata_sil24.c   |   18 +++++++-----------
 drivers/scsi/sata_sis.c     |    2 +-
 drivers/scsi/sata_svw.c     |    3 ++-
 drivers/scsi/sata_sx4.c     |   19 ++++++++-----------
 drivers/scsi/sata_uli.c     |   31 +++++++++----------------------
 drivers/scsi/sata_via.c     |    2 +-
 drivers/scsi/sata_vsc.c     |    3 ++-
 include/linux/libata.h      |   15 +++++++++------
 18 files changed, 103 insertions(+), 143 deletions(-)

62ea6f411bd27f3e723649e8397cae79bc5c7294
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 87e43f2..03952d1 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
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
-	struct ata_host_set *host_set = NULL;
-	struct ahci_host_priv *hpriv = NULL;
+	struct ata_host_set *host_set;
 	void __iomem *mmio_base = NULL;
+	struct ahci_host_priv *hpriv;
 	const char *reason;
 	u64 dma_mask;
 	u32 cap;
@@ -1479,15 +1478,14 @@ static int ahci_init_one(struct pci_dev 
 			return -ENODEV;
 	}
 
-	/* allocate host_set and private_data */
-	host_set = ata_host_set_alloc(&pdev->dev, NULL, 0);
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!host_set || !hpriv) {
-		reason = "failed to allocate host_set and private_data";
+	/* allocate host_set */
+	host_set = ata_host_set_alloc(&pdev->dev, NULL, 0, sizeof(*hpriv));
+	if (!host_set) {
+		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host_set->private_data = hpriv;
+	hpriv = host_set->private_data;
 
 	/* acquire ATA PCI resources */
 	rc = ata_pci_acquire_resources(host_set, 0, &reason);
@@ -1564,22 +1562,11 @@ static int ahci_init_one(struct pci_dev 
 	if (mmio_base)
 		pci_iounmap(pdev, mmio_base);
 	ata_pci_host_set_destroy(host_set);
-	kfree(hpriv);
 
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
 }
 
-static void ahci_remove_one (struct pci_dev *pdev)
-{
-	struct device *dev = pci_dev_to_dev(pdev);
-	struct ata_host_set *host_set = dev_get_drvdata(dev);
-	struct ahci_host_priv *hpriv = host_set->private_data;
-
-	ata_pci_remove_one(pdev);
-	kfree(hpriv);
-}
-
 static int __init ahci_init(void)
 {
 	return pci_module_init(&ahci_pci_driver);
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index c472348..00ae454 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
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
 
 	host_flags = port_info[0].host_flags;
 
@@ -907,7 +904,7 @@ static int piix_init_one (struct pci_dev
 
 	/* Initialize SATA map */
 	if (host_flags & ATA_FLAG_SATA) {
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
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 6b7c9b4..15d6560 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -1205,6 +1205,7 @@ void ata_pci_host_set_destroy(struct ata
  *	@pinfo_ar: array of pointers to ATA port_info
  *	@mask: available port mask
  *	@legacy_mask: legacy port mask
+ *	@hpriv_sz: size of host private data
  *	@r_host_set: out arg for prepared ATA host_set
  *
  *	Allocate and initialize ATA host_set for PCI ATA device @pdev.
@@ -1222,7 +1223,7 @@ void ata_pci_host_set_destroy(struct ata
 int ata_pci_host_set_prepare(struct pci_dev *pdev,
 			     struct ata_port_info **pinfo_ar,
 			     unsigned int mask, unsigned int legacy_mask,
-			     struct ata_host_set **r_host_set)
+			     size_t hpriv_sz, struct ata_host_set **r_host_set)
 {
 	static const unsigned long irq_flags[3] = { 0, 0, IRQF_SHARED };
 	static const unsigned long irq_res_mask[3] = { ATA_HOST_PCI_RES_IRQ14,
@@ -1258,7 +1259,8 @@ int ata_pci_host_set_prepare(struct pci_
 	}
 
 	/* allocate host_set */
-	host_set = ata_host_set_alloc_pinfo_ar(&pdev->dev, pi, n_ports);
+	host_set = ata_host_set_alloc_pinfo_ar(&pdev->dev, pi, n_ports,
+					       hpriv_sz);
 	if (!host_set) {
 		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
@@ -1348,6 +1350,7 @@ int ata_pci_host_set_prepare(struct pci_
  *	@pdev: Controller to be initialized
  *	@pinfo_ar: Information from low-level host driver
  *	@n_ports: Number of ports attached to host controller
+ *	@hpriv: host_set private data
  *
  *	This is a helper function which can be called from a driver's
  *	xxx_init_one() probe function if the hardware uses traditional
@@ -1364,7 +1367,7 @@ int ata_pci_host_set_prepare(struct pci_
  *	Zero on success, negative on errno-based value on error.
  */
 int ata_pci_init_one(struct pci_dev *pdev, struct ata_port_info **pinfo_ar,
-		     unsigned int n_ports)
+		     unsigned int n_ports, void *hpriv)
 {
 	unsigned int mask = ATA_PORT_PRIMARY | ATA_PORT_SECONDARY;
 	unsigned int legacy_mask = 0;
@@ -1390,11 +1393,13 @@ int ata_pci_init_one(struct pci_dev *pde
 	}
 
 	/* prep */
-	rc = ata_pci_host_set_prepare(pdev, pinfo_ar, mask, legacy_mask,
+	rc = ata_pci_host_set_prepare(pdev, pinfo_ar, mask, legacy_mask, 0,
 				      &host_set);
 	if (rc)
 		return rc;
 
+	host_set->private_data = hpriv;
+
 	/* attach */
 	rc = ata_host_set_attach(host_set);
 	if (rc)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f944ca0..afff768 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5278,11 +5278,16 @@ #endif
  *	@dev: generic device this host_set is associated with
  *	@sht: template for SCSI host
  *	@n_ports: number of ATA ports associated with this host_set (can be 0)
+ *	@hpriv_sz: size of host private data
  *
  *	Allocate and initialize basic ATA host_set resources.  LLD
  *	calls this function to allocate a host_set, initializes it
  *	fully and attaches it using ata_host_set_attach().
  *
+ *	If @hpriv_sz is not zero, host private data of the specified
+ *	size is allocated together with host_set.  Host private data
+ *	is aligned to __alignof__(long long).
+ *
  *	RETURNS:
  *	Allocate ATA host_set on success, NULL on failure.
  *
@@ -5291,22 +5296,27 @@ #endif
  */
 struct ata_host_set *ata_host_set_alloc(struct device *dev,
 					struct scsi_host_template *sht,
-					int n_ports)
+					int n_ports, size_t hpriv_sz)
 {
 	struct ata_host_set *host_set;
-	size_t sz;
+	size_t hs_sz;
 
 	DPRINTK("ENTER\n");
 
 	/* alloc a container for our list of ATA ports (buses) */
-	sz = sizeof(struct ata_host_set) + n_ports * sizeof(void *);
+	hs_sz = sizeof(struct ata_host_set) + n_ports * sizeof(void *);
 	if (n_ports == 0)
-		sz += ATA_MAX_PORTS * sizeof(void *);
+		hs_sz += ATA_MAX_PORTS * sizeof(void *);
+	if (hpriv_sz)
+		hs_sz = ALIGN(hs_sz, __alignof__(long long));
 
-	host_set = kzalloc(sz, GFP_KERNEL);
+	host_set = kzalloc(hs_sz + hpriv_sz, GFP_KERNEL);
 	if (!host_set)
 		return NULL;
 
+	if (hpriv_sz)
+		host_set->private_data = (void *)host_set + hs_sz;
+
 	spin_lock_init(&host_set->lock);
 	host_set->dev = dev;
 
@@ -5369,8 +5379,6 @@ static void __ata_host_set_init_pinfo(st
 {
 	int i;
 
-	if (host_set->private_data == NULL)
-		host_set->private_data = pinfo[0]->private_data;
 	host_set->ops = pinfo[0]->port_ops;
 
 	for (i = 0; i < host_set->n_ports; i++) {
@@ -5387,9 +5395,6 @@ static void __ata_host_set_init_pinfo(st
 		ap->udma_mask = pi->udma_mask;
 		ap->flags |= pi->host_flags;
 		ap->ops = pi->port_ops;
-
-		WARN_ON(pi->private_data &&
-			pi->private_data != host_set->private_data);
 	}
 }
 
@@ -5398,6 +5403,7 @@ static void __ata_host_set_init_pinfo(st
  *	@dev: generic device this host_set is associated with
  *	@pinfo: ATA port_info to initialize host_set with
  *	@n_ports: number of ATA ports attached to this host_set
+ *	@hpriv_sz: size of host private data
  *
  *	Allocate ATA host_set and initialize with info from @pi.
  *
@@ -5409,14 +5415,15 @@ static void __ata_host_set_init_pinfo(st
  */
 struct ata_host_set *
 ata_host_set_alloc_pinfo(struct device *dev,
-			 const struct ata_port_info *pinfo, int n_ports)
+			 const struct ata_port_info *pinfo, int n_ports,
+			 size_t hpriv_sz)
 {
 	struct ata_host_set *host_set;
 
 	if (!n_ports)
 		return NULL;
 
-	host_set = ata_host_set_alloc(dev, pinfo->sht, n_ports);
+	host_set = ata_host_set_alloc(dev, pinfo->sht, n_ports, hpriv_sz);
 	if (host_set)
 		__ata_host_set_init_pinfo(host_set, &pinfo, n_ports, 0);
 	return host_set;
@@ -5427,6 +5434,7 @@ ata_host_set_alloc_pinfo(struct device *
  *	@dev: generic device this host_set is associated with
  *	@pinfo_ar: array of ATA port_info to initialize host_set with
  *	@n_ports: number of ATA ports attached to this host_set
+ *	@hpriv_sz: size of host private data
  *
  *	Allocate ATA host_set and initialize with info from @pinfo_ar.
  *
@@ -5438,14 +5446,15 @@ ata_host_set_alloc_pinfo(struct device *
  */
 struct ata_host_set *
 ata_host_set_alloc_pinfo_ar(struct device *dev,
-			    const struct ata_port_info **pinfo_ar, int n_ports)
+			    const struct ata_port_info **pinfo_ar, int n_ports,
+			    size_t hpriv_sz)
 {
 	struct ata_host_set *host_set;
 
 	if (!n_ports)
 		return NULL;
 
-	host_set = ata_host_set_alloc(dev, pinfo_ar[0]->sht, n_ports);
+	host_set = ata_host_set_alloc(dev, pinfo_ar[0]->sht, n_ports, hpriv_sz);
 	if (host_set)
 		__ata_host_set_init_pinfo(host_set, pinfo_ar, n_ports, 1);
 	return host_set;
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index afe1fd4..055297e 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -620,7 +620,7 @@ static int adma_ata_init_one(struct pci_
 	/* alloc host_set */
 	host_set = ata_host_set_alloc_pinfo(&pdev->dev,
 					    &adma_port_info[board_idx],
-					    ADMA_PORTS);
+					    ADMA_PORTS, 0);
 	if (!host_set) {
 		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 3da1c69..f52452e 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
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
@@ -2310,8 +2309,7 @@ static int mv_init_one(struct pci_dev *p
 	static int printed_version = 0;
 	unsigned int board_idx = (unsigned int)ent->driver_data;
 	const struct ata_port_info *pinfo = &mv_port_info[board_idx];
-	struct ata_host_set *host_set = NULL;
-	struct mv_host_priv *hpriv = NULL;
+	struct ata_host_set *host_set;
 	void __iomem *mmio_base = NULL;
 	const char *reason;
 	int n_ports, rc;
@@ -2319,17 +2317,16 @@ static int mv_init_one(struct pci_dev *p
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* alloc host_set and hpriv */
+	/* alloc host_set */
 	n_ports = MV_PORTS_PER_HC * mv_get_hc_count(pinfo->host_flags);
 
-	host_set = ata_host_set_alloc_pinfo(&pdev->dev, pinfo, n_ports);
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!host_set || !hpriv) {
-		reason = "failed to allocate host_set and private_data";
+	host_set = ata_host_set_alloc_pinfo(&pdev->dev, pinfo, n_ports,
+					    sizeof(struct mv_host_priv));
+	if (!host_set) {
+		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host_set->private_data = hpriv;
 
 	/* acquire generic ATA PCI resources */
 	rc = ata_pci_acquire_resources(host_set, DMA_64BIT_MASK, &reason);
@@ -2373,21 +2370,11 @@ static int mv_init_one(struct pci_dev *p
 	if (mmio_base)
 		pci_iounmap(pdev, mmio_base);
 	ata_pci_host_set_destroy(host_set);
-	kfree(hpriv);
 
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
 }
 
-static void mv_remove_one(struct pci_dev *pdev)
-{
-	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
-	struct mv_host_priv *hpriv = host_set->private_data;
-
-	ata_pci_remove_one(pdev);
-	kfree(hpriv);
-}
-
 static int __init mv_init(void)
 {
 	return pci_module_init(&mv_pci_driver);
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 27085cc..9da8782 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -499,7 +499,7 @@ static int nv_init_one (struct pci_dev *
 	/* alloc host_set */
 	host_set = ata_host_set_alloc_pinfo(&pdev->dev,
 					    &nv_port_info[ent->driver_data],
-					    NV_PORTS);
+					    NV_PORTS, 0);
 	if (!host_set) {
 		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 3bd7753..3f6b98e 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
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
-	struct ata_host_set *host_set = NULL;
-	struct pdc_host_priv *hp = NULL;
+	struct ata_host_set *host_set;
+	struct pdc_host_priv *hp;
 	void __iomem *mmio_base = NULL;
 	unsigned long base;
 	const char *reason;
@@ -703,16 +702,16 @@ static int pdc_ata_init_one(struct pci_d
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* allocate host_set and private_data */
+	/* allocate host_set */
 	host_set = ata_host_set_alloc_pinfo(&pdev->dev, pinfo,
-					    PDC_FLAG2NPORTS(pinfo->host_flags));
-	hp = kzalloc(sizeof(*hp), GFP_KERNEL);
-	if (!host_set || !hp) {
-		reason = "failed to allocate host_set and private_data";
+					    PDC_FLAG2NPORTS(pinfo->host_flags),
+					    sizeof(*hp));
+	if (!host_set) {
+		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host_set->private_data = hp;
+	hp = host_set->private_data;
 
 	/* acquire generic ATA PCI resources */
 	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
@@ -770,21 +769,11 @@ static int pdc_ata_init_one(struct pci_d
 	if (mmio_base)
 		pci_iounmap(pdev, mmio_base);
 	ata_pci_host_set_destroy(host_set);
-	kfree(hp);
 
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
 }
 
-static void pdc_ata_remove_one(struct pci_dev *pdev)
-{
-	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
-	struct pdc_host_priv *hp = host_set->private_data;
-
-	ata_pci_remove_one(pdev);
-	kfree(hp);
-}
-
 static int __init pdc_ata_init(void)
 {
 	return pci_module_init(&pdc_ata_pci_driver);
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 399fee7..2c7610e 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -609,7 +609,8 @@ static int qs_ata_init_one(struct pci_de
 
 	/* alloc host_set */
 	host_set = ata_host_set_alloc_pinfo(&pdev->dev,
-					    &qs_port_info[board_idx], QS_PORTS);
+					    &qs_port_info[board_idx],
+					    QS_PORTS, 0);
 	if (!host_set) {
 		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 7c128bd..ef9ba6a 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -623,7 +623,7 @@ static int sil_init_one (struct pci_dev 
 	/* alloc host_set */
 	host_set = ata_host_set_alloc_pinfo(&pdev->dev,
 				&sil_port_info[ent->driver_data],
-				(ent->driver_data == sil_3114) ? 4 : 2);
+				(ent->driver_data == sil_3114) ? 4 : 2, 0);
 	if (!host_set) {
 		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index ef58622..8d1ed7c 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -1046,8 +1046,8 @@ static int sil24_init_one(struct pci_dev
 	static int printed_version = 0;
 	unsigned int board_id = (unsigned int)ent->driver_data;
 	struct ata_port_info *pinfo = &sil24_port_info[board_id];
-	struct ata_host_set *host_set = NULL;
-	struct sil24_host_priv *hpriv = NULL;
+	struct ata_host_set *host_set;
+	struct sil24_host_priv *hpriv;
 	void __iomem *host_base = NULL;
 	void __iomem *port_base = NULL;
 	const char *reason;
@@ -1057,17 +1057,15 @@ static int sil24_init_one(struct pci_dev
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* alloc host_set and hpriv */
+	/* alloc host_set */
 	host_set = ata_host_set_alloc_pinfo(&pdev->dev, pinfo,
-					SIL24_FLAG2NPORTS(pinfo->host_flags));
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-
-	if (!host_set || !hpriv) {
-		reason = "failed to allocate host_set and private_data";
+			SIL24_FLAG2NPORTS(pinfo->host_flags), sizeof(*hpriv));
+	if (!host_set) {
+		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host_set->private_data = hpriv;
+	hpriv = host_set->private_data;
 
 	/* acquire generic ATA PCI resources */
 	rc = ata_pci_acquire_resources(host_set, DMA_64BIT_MASK, &reason);
@@ -1136,7 +1134,6 @@ static int sil24_init_one(struct pci_dev
 	if (port_base)
 		pci_iounmap(pdev, port_base);
 	ata_pci_host_set_destroy(host_set);
-	kfree(hpriv);
 
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
@@ -1154,7 +1151,6 @@ static void sil24_remove_one(struct pci_
 	pci_iounmap(pdev, hpriv->port_base);
 
 	ata_pci_host_set_destroy(host_set);
-	kfree(hpriv);
 }
 
 static int sil24_pci_device_resume(struct pci_dev *pdev)
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 5c9758f..19818c3 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -247,7 +247,7 @@ static int sis_init_one (struct pci_dev 
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/* alloc host_set */
-	host_set = ata_host_set_alloc_pinfo(&pdev->dev, &sis_port_info, 2);
+	host_set = ata_host_set_alloc_pinfo(&pdev->dev, &sis_port_info, 2, 0);
 	if (!host_set) {
 		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 56a74be..b6c7783 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -386,7 +386,8 @@ static int k2_sata_init_one (struct pci_
 	 * ent->driver_data and the same is done here.  Verify the bug
 	 * and fix.
 	 */
-	host_set = ata_host_set_alloc_pinfo(&pdev->dev, &k2_sata_port_info, 4);
+	host_set = ata_host_set_alloc_pinfo(&pdev->dev, &k2_sata_port_info,
+					    4, 0);
 	if (!host_set) {
 		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 170b341..36cf01d 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -1353,8 +1353,8 @@ static int pdc_sata_init_one(struct pci_
 {
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	struct ata_host_set *host_set = NULL;
-	struct pdc_host_priv *hpriv = NULL;
+	struct ata_host_set *host_set;
+	struct pdc_host_priv *hpriv;
 	void __iomem *mmio_base = NULL;
 	void __iomem *dimm_mmio = NULL;
 	unsigned long base;
@@ -1364,17 +1364,16 @@ static int pdc_sata_init_one(struct pci_
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* alloc host_set and hpriv */
+	/* alloc host_set */
 	host_set = ata_host_set_alloc_pinfo(&pdev->dev,
-					    &pdc_port_info[board_idx], 4);
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-
-	if (!host_set || !hpriv) {
-		reason = "failed to allocate host_set and private_data";
+					    &pdc_port_info[board_idx],
+					    4, sizeof(*hpriv));
+	if (!host_set) {
+		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host_set->private_data = hpriv;
+	hpriv = host_set->private_data;
 
 	/* acquire generic ATA PCI resources */
 	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
@@ -1436,7 +1435,6 @@ static int pdc_sata_init_one(struct pci_
 	if (dimm_mmio)
 		pci_iounmap(pdev, dimm_mmio);
 	ata_pci_host_set_destroy(host_set);
-	kfree(hpriv);
 
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
@@ -1455,7 +1453,6 @@ static void pdc_sata_remove_one(struct p
 	pci_iounmap(pdev, hpriv->dimm_mmio);
 
 	ata_pci_host_set_destroy(host_set);
-	kfree(hpriv);
 }
 
 
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 97e5e7e..183d4e6 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
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
-	struct ata_host_set *host_set = NULL;
-	struct uli_priv *hpriv = NULL;
+	struct ata_host_set *host_set;
+	struct uli_priv *hpriv;
 	struct ata_ioports *ioaddr;
 	const char *reason;
 	int rc;
@@ -193,17 +192,16 @@ static int uli_init_one(struct pci_dev *
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* alloc host_set and hpriv */
+	/* alloc host_set */
 	host_set = ata_host_set_alloc_pinfo(&pdev->dev, &uli_port_info,
-					    board_idx == uli_5287 ? 4 : 2);
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-
-	if (!host_set || !hpriv) {
-		reason = "failed to allocate host_set and private_data";
+					    board_idx == uli_5287 ? 4 : 2,
+					    sizeof(*hpriv));
+	if (!host_set) {
+		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
 		goto err;
 	}
-	host_set->private_data = hpriv;
+	hpriv = host_set->private_data;
 
 	/* acquire generic ATA PCI resources */
 	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
@@ -271,21 +269,10 @@ static int uli_init_one(struct pci_dev *
 
  err:
 	ata_pci_host_set_destroy(host_set);
-	kfree(hpriv);
-
 	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
 	return rc;
 }
 
-static void uli_remove_one(struct pci_dev *pdev)
-{
-	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
-	struct uli_priv *hpriv = host_set->private_data;
-
-	ata_pci_remove_one(pdev);
-	kfree(hpriv);
-}
-
 static int __init uli_init(void)
 {
 	return pci_module_init(&uli_pci_driver);
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 637682f..9920050 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -255,7 +255,7 @@ static int svia_init_one(struct pci_dev 
 
 	/* alloc host_set */
 	host_set = ata_host_set_alloc_pinfo(&pdev->dev, &svia_port_info,
-					    N_PORTS);
+					    N_PORTS, 0);
 	if (!host_set) {
 		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 6806514..b99387d 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -357,7 +357,8 @@ static int __devinit vsc_sata_init_one (
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/* alloc host_set */
-	host_set = ata_host_set_alloc_pinfo(&pdev->dev, &vsc_sata_port_info, 4);
+	host_set = ata_host_set_alloc_pinfo(&pdev->dev, &vsc_sata_port_info,
+					    4, 0);
 	if (!host_set) {
 		reason = "failed to allocate host_set";
 		rc = -ENOMEM;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e2305a7..46e3c10 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -628,7 +628,6 @@ struct ata_port_info {
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
 	const struct ata_port_operations *port_ops;
-	void 			*private_data;
 	/* fields for BMDMA init */
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 };
@@ -682,8 +681,8 @@ extern int ata_dev_revalidate(struct ata
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
-extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
-			     unsigned int n_ports);
+extern int ata_pci_init_one(struct pci_dev *pdev, struct ata_port_info **port_info,
+			    unsigned int n_ports, void *hpriv);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
 extern void ata_pci_device_do_resume(struct pci_dev *pdev);
@@ -692,13 +691,16 @@ extern int ata_pci_device_resume(struct 
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern struct ata_host_set *ata_host_set_alloc(struct device *dev,
-			struct scsi_host_template *sht, int n_ports);
+			struct scsi_host_template *sht, int n_ports,
+			size_t hpriv_sz);
 extern int ata_host_set_add_ports(struct ata_host_set *host_set,
 			struct scsi_host_template *sht, int n_ports);
 extern struct ata_host_set *ata_host_set_alloc_pinfo(struct device *dev,
-			const struct ata_port_info *pinfo, int n_ports);
+			const struct ata_port_info *pinfo, int n_ports,
+			size_t hpriv_sz);
 extern struct ata_host_set *ata_host_set_alloc_pinfo_ar(struct device *dev,
-			const struct ata_port_info **pinfo_ar, int n_ports);
+			const struct ata_port_info **pinfo_ar, int n_ports,
+			size_t hpriv_sz);
 extern int ata_host_set_add_ports_pinfo(struct ata_host_set *host_set,
 			const struct ata_port_info *pinfo, int n_ports);
 extern int ata_host_set_add_ports_pinfo_ar(struct ata_host_set *host_set,
@@ -850,6 +852,7 @@ extern void ata_pci_host_set_destroy(str
 extern int ata_pci_host_set_prepare(struct pci_dev *pdev,
 				    struct ata_port_info **pinfo_ar,
 				    unsigned int mask, unsigned int legacy_mask,
+				    size_t hpriv_sz,
 				    struct ata_host_set **r_host_set);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
 extern unsigned long ata_pci_default_filter(const struct ata_port *, struct ata_device *, unsigned long);
-- 
1.3.2


