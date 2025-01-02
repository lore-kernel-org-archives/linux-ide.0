Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA95148304;
	Thu,  2 Jan 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835780; cv=none; b=CoAkT9DZMK+3GpkAKOM4JAsngobvuPkSQx+XBGefvTstimEEX2evbBMheKPozOvfZZ2wBJbPd82ZU6yt4rx0GO0Hs/UO4sHgBCckMA5w7AUkpCXSCZ/OUyPLZlDNRuuoMa6HC2f1cVwNloudZrpDjlKlBBMHP7SWVmmstb74fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835780; c=relaxed/simple;
	bh=0Md6c+b+wpcjvX1QpcwZdOFUz1aQd23eKmAYPL+lzgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTQ9PH3kH6AqJ8XxddVv3tbexmDXUT4uWQZpMFSCaASqqdU8qW7Zcn1U0cMaCLOs8+WYFjY/U4jUPGFTMJNq7Ob8lHaqL9O+9WAQH2nPFVXwVsiYe+b2O633q8Y6EDN9WRAo7jrvidSmqMZ/p2xlw8gYSeamMathL8ZgX9qBC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2gf2AuT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2gf2AuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D91C4CEDC;
	Thu,  2 Jan 2025 16:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735835780;
	bh=0Md6c+b+wpcjvX1QpcwZdOFUz1aQd23eKmAYPL+lzgk=;
	h=From:To:Cc:Subject:Date:From;
	b=s2gf2AuTNFSnTIkfAR7KPeJ528qKMZG0BPq2l+/c3RyTe8ighka7Hc0ODZkQ2cOwK
	 wyAmOuHnlkh9vfUbENShP24qnYA5vjwqO6WNYGXZC7ktKVK4tf4/fIGvi9IBHaeU+q
	 RBis6VDcPRea7XD+CSpvLX2N8iUNR53ydB6D04yvFvZgOcOUg5PjtqB0Zq1WqFKDjS
	 i3/u2IMhQwlQcvwRyeKh81rcZyNG6vWCFE+2+s6po85HA4J1xCP708AZPHmJVh53S0
	 eUqtlKEtzs4fFiLNpEDHEgQU1sMRa++33ox78LJ4wQce4dVLRH1beqiyRRgN9Sj4Q/
	 aKehbjQZMuBig==
From: Philipp Stanner <phasta@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] ata: Replace deprecated PCI functions
Date: Thu,  2 Jan 2025 17:35:32 +0100
Message-ID: <20250102163531.63839-2-phasta@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

struct ata_host.iomap has been created and administrated so far by
pcim_iomap_table(), a problematic function that has been deprecated in
commit e354bb84a4c1c ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()")

Ideally, drivers should not need a global table at all and should store
ioremaped BARs in their respective structs separately. For ATA, however,
it's far easier to deprecate pcim_iomap_table() by allocating
struct ata_host.iomap statically as an array of iomem pointers. Since
PCI_STD_NUM_BARS is currently defined to be 6, the memory overhead is
irrelevant.

Make struct ata_host.iomap a static iomem pointer table.

Remove all calls to pcim_iomap_table() and pcim_iomap_regions(), and
fill the aforementioned table directly through pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Happy New Year folks.

Squased version (so that everything compiles without hacks) of my RFC
from a while back [1].

Mostly identical to the RFC, just some formatting comments taken into
account.

The changes in libata-sff.c will probably be happy about a careful
review. It wasn't easy to figure out the bitmask sorcery there.

Cheers,
P.

[1] https://lore.kernel.org/all/20241204171033.86804-2-pstanner@redhat.com/
---
 drivers/ata/ata_piix.c      |   7 +-
 drivers/ata/libata-sff.c    | 133 +++++++++++++++++++++++-------------
 drivers/ata/pata_atp867x.c  |  13 ++--
 drivers/ata/pata_hpt3x3.c   |   7 +-
 drivers/ata/pata_ninja32.c  |   9 ++-
 drivers/ata/pata_pdc2027x.c |  11 ++-
 drivers/ata/pata_sil680.c   |  11 +--
 drivers/ata/pdc_adma.c      |   9 ++-
 drivers/ata/sata_inic162x.c |  10 ++-
 drivers/ata/sata_mv.c       |   7 +-
 drivers/ata/sata_nv.c       |   8 +--
 drivers/ata/sata_promise.c  |   6 +-
 drivers/ata/sata_qstor.c    |   7 +-
 drivers/ata/sata_sil.c      |   6 +-
 drivers/ata/sata_sil24.c    |  20 +++---
 drivers/ata/sata_sis.c      |   8 +--
 drivers/ata/sata_svw.c      |   8 +--
 drivers/ata/sata_sx4.c      |  15 +++-
 drivers/ata/sata_via.c      |  31 +++++----
 drivers/ata/sata_vsc.c      |   6 +-
 include/linux/libata.h      |   7 +-
 21 files changed, 200 insertions(+), 139 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 093b940bc953..8db14065a256 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1456,10 +1456,9 @@ static int piix_init_sidpr(struct ata_host *host)
 	    pci_resource_len(pdev, PIIX_SIDPR_BAR) != PIIX_SIDPR_LEN)
 		return 0;
 
-	if (pcim_iomap_regions(pdev, 1 << PIIX_SIDPR_BAR, DRV_NAME))
-		return 0;
-
-	hpriv->sidpr = pcim_iomap_table(pdev)[PIIX_SIDPR_BAR];
+	hpriv->sidpr = pcim_iomap_region(pdev, PIIX_SIDPR_BAR, DRV_NAME);
+	if (IS_ERR(hpriv->sidpr))
+		return PTR_ERR(hpriv->sidpr);
 
 	/* SCR access via SIDPR doesn't work on some configurations.
 	 * Give it a test drive by inhibiting power save modes which
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 67f277e1c3bf..181741b8db36 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2127,6 +2127,76 @@ static bool ata_resources_present(struct pci_dev *pdev, int port)
 	return true;
 }
 
+static void ata_pci_sff_set_port_data(struct ata_port *ap, struct ata_host *host,
+					struct pci_dev *pdev, unsigned short base)
+{
+	void __iomem *ctl_addr;
+
+	ctl_addr = host->iomap[base + 1];
+	ctl_addr = (void __iomem *)((unsigned long)ctl_addr | ATA_PCI_CTL_OFS);
+
+	ap->ioaddr.cmd_addr = host->iomap[base];
+	ap->ioaddr.altstatus_addr = ctl_addr;
+	ap->ioaddr.ctl_addr = ctl_addr;
+
+	ata_sff_std_ports(&ap->ioaddr);
+
+	ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
+		(unsigned long long)pci_resource_start(pdev, base),
+		(unsigned long long)pci_resource_start(pdev, base + 1));
+}
+
+/**
+ * ata_pci_sff_obtain_bars - obtain the PCI BARs associated with an ATA port
+ * @pdev: the PCI device
+ * @host: the ATA host
+ * @ap: the ATA port
+ * @port: @ap's port index in @host
+ *
+ * Returns: Number of successfully ioremaped BARs, a negative code on failure
+ */
+static int ata_pci_sff_obtain_bars(struct pci_dev *pdev, struct ata_host *host,
+					struct ata_port *ap, unsigned short port)
+{
+	int ret = 0, bars_mapped = 0;
+	unsigned short i, base, bar_index;
+	void __iomem *iomem;
+	const char *name = dev_driver_string(&pdev->dev);
+
+	/*
+	 * Port can be 0 or 1.
+	 * Port 0 corresponds to PCI BARs 0 and 1, port 1 to BARs 2 and 3.
+	 */
+	base = port * 2;
+
+	/*
+	 * Discard disabled ports. Some controllers show their unused channels
+	 * this way. Disabled ports are made dummy.
+	 */
+	if (!ata_resources_present(pdev, port))
+		goto try_next;
+
+	for (i = 0; i < 2; i++) {
+		bar_index = base + i;
+
+		iomem = pcim_iomap_region(pdev, bar_index, name);
+		ret = PTR_ERR_OR_ZERO(iomem);
+		if (ret)
+			goto try_next;
+
+		host->iomap[bar_index] = iomem;
+		bars_mapped++;
+	}
+
+	ata_pci_sff_set_port_data(ap, host, pdev, base);
+
+	return bars_mapped;
+
+try_next:
+	ap->ops = &ata_dummy_port_ops;
+	return ret;
+}
+
 /**
  *	ata_pci_sff_init_host - acquire native PCI ATA resources and init host
  *	@host: target ATA host
@@ -2148,59 +2218,31 @@ static bool ata_resources_present(struct pci_dev *pdev, int port)
  */
 int ata_pci_sff_init_host(struct ata_host *host)
 {
-	struct device *gdev = host->dev;
-	struct pci_dev *pdev = to_pci_dev(gdev);
-	unsigned int mask = 0;
-	int i, rc;
-
-	/* request, iomap BARs and init port addresses accordingly */
-	for (i = 0; i < 2; i++) {
-		struct ata_port *ap = host->ports[i];
-		int base = i * 2;
-		void __iomem * const *iomap;
+	int ret;
+	unsigned short port_nr, operational_ports = 0;
+	struct device *dev = host->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct ata_port *ap;
 
+	for (port_nr = 0; port_nr < 2; port_nr++) {
+		ap = host->ports[port_nr];
 		if (ata_port_is_dummy(ap))
 			continue;
 
-		/* Discard disabled ports.  Some controllers show
-		 * their unused channels this way.  Disabled ports are
-		 * made dummy.
-		 */
-		if (!ata_resources_present(pdev, i)) {
-			ap->ops = &ata_dummy_port_ops;
-			continue;
-		}
-
-		rc = pcim_iomap_regions(pdev, 0x3 << base,
-					dev_driver_string(gdev));
-		if (rc) {
-			dev_warn(gdev,
+		ret = ata_pci_sff_obtain_bars(pdev, host, ap, port_nr);
+		if (ret > 0) {
+			operational_ports += ret;
+		} else if (ret < 0) {
+			dev_warn(dev,
 				 "failed to request/iomap BARs for port %d (errno=%d)\n",
-				 i, rc);
-			if (rc == -EBUSY)
+				 port_nr, ret);
+			if (ret == -EBUSY)
 				pcim_pin_device(pdev);
-			ap->ops = &ata_dummy_port_ops;
-			continue;
 		}
-		host->iomap = iomap = pcim_iomap_table(pdev);
-
-		ap->ioaddr.cmd_addr = iomap[base];
-		ap->ioaddr.altstatus_addr =
-		ap->ioaddr.ctl_addr = (void __iomem *)
-			((unsigned long)iomap[base + 1] | ATA_PCI_CTL_OFS);
-		ata_sff_std_ports(&ap->ioaddr);
-
-		ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
-			(unsigned long long)pci_resource_start(pdev, base),
-			(unsigned long long)pci_resource_start(pdev, base + 1));
-
-		mask |= 1 << i;
 	}
 
-	if (!mask) {
-		dev_err(gdev, "no available native port\n");
+	if (!operational_ports)
 		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -3094,12 +3136,11 @@ void ata_pci_bmdma_init(struct ata_host *host)
 		ata_bmdma_nodma(host, "failed to set dma mask");
 
 	/* request and iomap DMA region */
-	rc = pcim_iomap_regions(pdev, 1 << 4, dev_driver_string(gdev));
-	if (rc) {
+	host->iomap[4] = pcim_iomap_region(pdev, 4, dev_driver_string(gdev));
+	if (IS_ERR(host->iomap[4])) {
 		ata_bmdma_nodma(host, "failed to request/iomap BAR4");
 		return;
 	}
-	host->iomap = pcim_iomap_table(pdev);
 
 	for (i = 0; i < 2; i++) {
 		struct ata_port *ap = host->ports[i];
diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index aaef5924f636..4b47cb92cbe6 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -405,17 +405,20 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
 	struct device *gdev = host->dev;
 	struct pci_dev *pdev = to_pci_dev(gdev);
 	unsigned int mask = 0;
+	void __iomem *iomem;
 	int i, rc;
 
 	/*
 	 * do not map rombase
 	 */
-	rc = pcim_iomap_regions(pdev, 1 << ATP867X_BAR_IOBASE, DRV_NAME);
-	if (rc == -EBUSY)
-		pcim_pin_device(pdev);
-	if (rc)
+	iomem = pcim_iomap_region(pdev, ATP867X_BAR_IOBASE, DRV_NAME);
+	if (IS_ERR(iomem)) {
+		rc = PTR_ERR(iomem);
+		if (rc == -EBUSY)
+			pcim_pin_device(pdev);
 		return rc;
-	host->iomap = pcim_iomap_table(pdev);
+	}
+	host->iomap[ATP867X_BAR_IOBASE] = iomem;
 
 	atp867x_check_res(pdev);
 
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index d65c586b5ad0..2dd62317eb4f 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -215,17 +215,18 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 
 	/* Everything is relative to BAR4 if we set up this way */
-	rc = pcim_iomap_regions(pdev, 1 << 4, DRV_NAME);
+	base = pcim_iomap_region(pdev, 4, DRV_NAME);
+	rc = PTR_ERR_OR_ZERO(base);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
-	host->iomap = pcim_iomap_table(pdev);
+
 	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 
-	base = host->iomap[4];	/* Bus mastering base */
+	host->iomap[4] = base;	/* Bus mastering base */
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 76a91013d27d..d1edcd504044 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -116,13 +116,14 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	rc = pcim_enable_device(dev);
 	if (rc)
 		return rc;
-	rc = pcim_iomap_regions(dev, 1 << 0, DRV_NAME);
+
+	base = pcim_iomap_region(dev, 0, DRV_NAME);
+	rc = PTR_ERR_OR_ZERO(base);
 	if (rc == -EBUSY)
 		pcim_pin_device(dev);
 	if (rc)
 		return rc;
 
-	host->iomap = pcim_iomap_table(dev);
 	rc = dma_set_mask_and_coherent(&dev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
@@ -130,9 +131,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 	/* Set up the register mappings. We use the I/O mapping as only the
 	   older chips also have MMIO on BAR 1 */
-	base = host->iomap[0];
-	if (!base)
-		return -ENOMEM;
+	host->iomap[0] = base;
 	ap->ops = &ninja32_port_ops;
 	ap->pio_mask = ATA_PIO4;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 6820c5597b14..360b8d7e08bf 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -702,17 +702,16 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << PDC_MMIO_BAR, DRV_NAME);
-	if (rc)
-		return rc;
-	host->iomap = pcim_iomap_table(pdev);
+	mmio_base = pcim_iomap_region(pdev, PDC_MMIO_BAR, DRV_NAME);
+	if (IS_ERR(mmio_base))
+		return PTR_ERR(mmio_base);
+
+	host->iomap[PDC_MMIO_BAR] = mmio_base;
 
 	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 
-	mmio_base = host->iomap[PDC_MMIO_BAR];
-
 	for (i = 0; i < 2; i++) {
 		struct ata_port *ap = host->ports[i];
 
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index abe64b5f83cf..8a17df73412e 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -360,15 +360,16 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* Try to acquire MMIO resources and fallback to PIO if
 	 * that fails
 	 */
-	rc = pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR, DRV_NAME);
-	if (rc)
+	mmio_base = pcim_iomap_region(pdev, SIL680_MMIO_BAR, DRV_NAME);
+	if (IS_ERR(mmio_base)) {
+		rc = PTR_ERR(mmio_base);
 		goto use_ioports;
+	}
 
 	/* Allocate host and set it up */
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 2);
 	if (!host)
 		return -ENOMEM;
-	host->iomap = pcim_iomap_table(pdev);
 
 	/* Setup DMA masks */
 	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
@@ -376,8 +377,8 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 	pci_set_master(pdev);
 
-	/* Get MMIO base and initialize port addresses */
-	mmio_base = host->iomap[SIL680_MMIO_BAR];
+	/* Set MMIO base in table and initialize port addresses */
+	host->iomap[SIL680_MMIO_BAR] = mmio_base;
 	host->ports[0]->ioaddr.bmdma_addr = mmio_base + 0x00;
 	host->ports[0]->ioaddr.cmd_addr = mmio_base + 0x80;
 	host->ports[0]->ioaddr.ctl_addr = mmio_base + 0x8a;
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 8e6b2599f0d5..f6fe0645c4b8 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -568,11 +568,10 @@ static int adma_ata_init_one(struct pci_dev *pdev,
 	if ((pci_resource_flags(pdev, 4) & IORESOURCE_MEM) == 0)
 		return -ENODEV;
 
-	rc = pcim_iomap_regions(pdev, 1 << ADMA_MMIO_BAR, DRV_NAME);
-	if (rc)
-		return rc;
-	host->iomap = pcim_iomap_table(pdev);
-	mmio_base = host->iomap[ADMA_MMIO_BAR];
+	mmio_base = pcim_iomap_region(pdev, ADMA_MMIO_BAR, DRV_NAME);
+	if (IS_ERR(mmio_base))
+		return PTR_ERR(mmio_base);
+	host->iomap[ADMA_MMIO_BAR] = mmio_base;
 
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc) {
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index db9c255dc9f2..9512c920e4f6 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -817,7 +817,6 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	const struct ata_port_info *ppi[] = { &inic_port_info, NULL };
 	struct ata_host *host;
 	struct inic_host_priv *hpriv;
-	void __iomem * const *iomap;
 	int mmio_bar;
 	int i, rc;
 
@@ -845,11 +844,10 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	else
 		mmio_bar = MMIO_BAR_CARDBUS;
 
-	rc = pcim_iomap_regions(pdev, 1 << mmio_bar, DRV_NAME);
-	if (rc)
-		return rc;
-	host->iomap = iomap = pcim_iomap_table(pdev);
-	hpriv->mmio_base = iomap[mmio_bar];
+	hpriv->mmio_base = pcim_iomap_region(pdev, mmio_bar, DRV_NAME);
+	if (IS_ERR(hpriv->mmio_base))
+		return PTR_ERR(hpriv->mmio_base);
+	host->iomap[mmio_bar] = hpriv->mmio_base;
 	hpriv->cached_hctl = readw(hpriv->mmio_base + HOST_CTL);
 
 	for (i = 0; i < NR_PORTS; i++) {
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index b8f363370e1a..dfb0f51bfc53 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4083,7 +4083,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 	host->private_data = hpriv;
 	hpriv->board_idx = chip_soc;
 
-	host->iomap = NULL;
 	hpriv->base = devm_ioremap(&pdev->dev, res->start,
 				   resource_size(res));
 	if (!hpriv->base)
@@ -4392,13 +4391,13 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << MV_PRIMARY_BAR, DRV_NAME);
+	hpriv->base = pcim_iomap_region(pdev, MV_PRIMARY_BAR, DRV_NAME);
+	rc = PTR_ERR_OR_ZERO(hpriv->base);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
-	host->iomap = pcim_iomap_table(pdev);
-	hpriv->base = host->iomap[MV_PRIMARY_BAR];
+	host->iomap[MV_PRIMARY_BAR] = hpriv->base;
 
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc) {
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 36d99043ef50..771f73452670 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -2353,12 +2353,12 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	host->private_data = hpriv;
 
 	/* request and iomap NV_MMIO_BAR */
-	rc = pcim_iomap_regions(pdev, 1 << NV_MMIO_BAR, DRV_NAME);
-	if (rc)
-		return rc;
+	base = pcim_iomap_region(pdev, NV_MMIO_BAR, DRV_NAME);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	/* configure SCR access */
-	base = host->iomap[NV_MMIO_BAR];
+	host->iomap[NV_MMIO_BAR] = base;
 	host->ports[0]->ioaddr.scr_addr = base + NV_PORT0_SCR_REG_OFFSET;
 	host->ports[1]->ioaddr.scr_addr = base + NV_PORT1_SCR_REG_OFFSET;
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 2df1a070b25a..0f98e784fbe7 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -1163,12 +1163,12 @@ static int pdc_ata_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << PDC_MMIO_BAR, DRV_NAME);
+	host_mmio = pcim_iomap_region(pdev, PDC_MMIO_BAR, DRV_NAME);
+	rc = PTR_ERR_OR_ZERO(host_mmio);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
-	host_mmio = pcim_iomap_table(pdev)[PDC_MMIO_BAR];
 
 	/* determine port configuration and setup host */
 	n_ports = 2;
@@ -1193,7 +1193,7 @@ static int pdc_ata_init_one(struct pci_dev *pdev,
 		return -ENOMEM;
 	spin_lock_init(&hpriv->hard_reset_lock);
 	host->private_data = hpriv;
-	host->iomap = pcim_iomap_table(pdev);
+	host->iomap[PDC_MMIO_BAR] = host_mmio;
 
 	is_sataii_tx4 = pdc_is_sataii_tx4(pi->flags);
 	for (i = 0; i < host->n_ports; i++) {
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 8a6286159044..2b645404687b 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -560,10 +560,9 @@ static int qs_ata_init_one(struct pci_dev *pdev,
 	if ((pci_resource_flags(pdev, QS_MMIO_BAR) & IORESOURCE_MEM) == 0)
 		return -ENODEV;
 
-	rc = pcim_iomap_regions(pdev, 1 << QS_MMIO_BAR, DRV_NAME);
-	if (rc)
-		return rc;
-	host->iomap = pcim_iomap_table(pdev);
+	host->iomap[QS_MMIO_BAR] = pcim_iomap_region(pdev, QS_MMIO_BAR, DRV_NAME);
+	if (IS_ERR(host->iomap[QS_MMIO_BAR]))
+		return PTR_ERR(host->iomap[QS_MMIO_BAR]);
 
 	rc = qs_set_dma_masks(pdev, host->iomap[QS_MMIO_BAR]);
 	if (rc)
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 3a99f66198a9..9935eb61a694 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -751,18 +751,18 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << SIL_MMIO_BAR, DRV_NAME);
+	mmio_base = pcim_iomap_region(pdev, SIL_MMIO_BAR, DRV_NAME);
+	rc = PTR_ERR_OR_ZERO(mmio_base);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
-	host->iomap = pcim_iomap_table(pdev);
 
 	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 
-	mmio_base = host->iomap[SIL_MMIO_BAR];
+	host->iomap[SIL_MMIO_BAR] = mmio_base;
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 72c03cbdaff4..fc6e7c42ad23 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1261,7 +1261,7 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	extern int __MARKER__sil24_cmd_block_is_sized_wrongly;
 	struct ata_port_info pi = sil24_port_info[ent->driver_data];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
-	void __iomem * const *iomap;
+	void __iomem *host_iomem, *port_iomem;
 	struct ata_host *host;
 	int rc;
 	u32 tmp;
@@ -1277,16 +1277,17 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev,
-				(1 << SIL24_HOST_BAR) | (1 << SIL24_PORT_BAR),
-				DRV_NAME);
-	if (rc)
-		return rc;
-	iomap = pcim_iomap_table(pdev);
+	host_iomem = pcim_iomap_region(pdev, SIL24_HOST_BAR, DRV_NAME);
+	if (IS_ERR(host_iomem))
+		return PTR_ERR(host_iomem);
+
+	port_iomem = pcim_iomap_region(pdev, SIL24_PORT_BAR, DRV_NAME);
+	if (IS_ERR(port_iomem))
+		return PTR_ERR(port_iomem);
 
 	/* apply workaround for completion IRQ loss on PCI-X errata */
 	if (pi.flags & SIL24_FLAG_PCIX_IRQ_WOC) {
-		tmp = readl(iomap[SIL24_HOST_BAR] + HOST_CTRL);
+		tmp = readl(host_iomem + HOST_CTRL);
 		if (tmp & (HOST_CTRL_TRDY | HOST_CTRL_STOP | HOST_CTRL_DEVSEL))
 			dev_info(&pdev->dev,
 				 "Applying completion IRQ loss on PCI-X errata fix\n");
@@ -1299,7 +1300,8 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				    SIL24_FLAG2NPORTS(ppi[0]->flags));
 	if (!host)
 		return -ENOMEM;
-	host->iomap = iomap;
+	host->iomap[SIL24_HOST_BAR] = host_iomem;
+	host->iomap[SIL24_PORT_BAR] = port_iomem;
 
 	/* configure and activate the device */
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index ef8724986de3..45e4ae8c8996 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -280,10 +280,10 @@ static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!(pi.flags & SIS_FLAG_CFGSCR)) {
 		void __iomem *mmio;
 
-		rc = pcim_iomap_regions(pdev, 1 << SIS_SCR_PCI_BAR, DRV_NAME);
-		if (rc)
-			return rc;
-		mmio = host->iomap[SIS_SCR_PCI_BAR];
+		mmio = pcim_iomap_region(pdev, SIS_SCR_PCI_BAR, DRV_NAME);
+		if (IS_ERR(mmio))
+			return PTR_ERR(mmio);
+		host->iomap[SIS_SCR_PCI_BAR] = mmio;
 
 		host->ports[0]->ioaddr.scr_addr = mmio;
 		host->ports[1]->ioaddr.scr_addr = mmio + port2_start;
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 598a872f6a08..f67f5b0dc5d9 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -451,14 +451,14 @@ static int k2_sata_init_one(struct pci_dev *pdev, const struct pci_device_id *en
 		return -ENODEV;
 	}
 
-	/* Request and iomap PCI regions */
-	rc = pcim_iomap_regions(pdev, 1 << bar_pos, DRV_NAME);
+	/* Request and iomap PCI region */
+	mmio_base = pcim_iomap_region(pdev, bar_pos, DRV_NAME);
+	rc = PTR_ERR_OR_ZERO(mmio_base);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
-	host->iomap = pcim_iomap_table(pdev);
-	mmio_base = host->iomap[bar_pos];
+	host->iomap[bar_pos] = mmio_base;
 
 	/* different controllers have different number of ports - currently 4 or 8 */
 	/* All ports are on the same function. Multi-function device is no
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index a482741eb181..8fc411701374 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1390,6 +1390,7 @@ static int pdc_sata_init_one(struct pci_dev *pdev,
 	struct ata_host *host;
 	struct pdc_host_priv *hpriv;
 	int i, rc;
+	void __iomem *iomem;
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
 
@@ -1406,13 +1407,21 @@ static int pdc_sata_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, (1 << PDC_MMIO_BAR) | (1 << PDC_DIMM_BAR),
-				DRV_NAME);
+	iomem = pcim_iomap_region(pdev, PDC_MMIO_BAR, DRV_NAME);
+	rc = PTR_ERR_OR_ZERO(iomem);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
-	host->iomap = pcim_iomap_table(pdev);
+	host->iomap[PDC_MMIO_BAR] = iomem;
+
+	iomem = pcim_iomap_region(pdev, PDC_DIMM_BAR, DRV_NAME);
+	rc = PTR_ERR_OR_ZERO(iomem);
+	if (rc == -EBUSY)
+		pcim_pin_device(pdev);
+	if (rc)
+		return rc;
+	host->iomap[PDC_DIMM_BAR] = iomem;
 
 	for (i = 0; i < 4; i++) {
 		struct ata_port *ap = host->ports[i];
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 57cbf2cef618..73b78834fa3f 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -457,6 +457,7 @@ static int vt6420_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 {
 	const struct ata_port_info *ppi[] = { &vt6420_port_info, NULL };
 	struct ata_host *host;
+	void __iomem *iomem;
 	int rc;
 
 	if (vt6420_hotplug) {
@@ -469,11 +470,12 @@ static int vt6420_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 		return rc;
 	*r_host = host;
 
-	rc = pcim_iomap_regions(pdev, 1 << 5, DRV_NAME);
-	if (rc) {
+	iomem = pcim_iomap_region(pdev, 5, DRV_NAME);
+	if (IS_ERR(iomem)) {
 		dev_err(&pdev->dev, "failed to iomap PCI BAR 5\n");
-		return rc;
+		return PTR_ERR(iomem);
 	}
+	host->iomap[5] = iomem;
 
 	host->ports[0]->ioaddr.scr_addr = svia_scr_addr(host->iomap[5], 0);
 	host->ports[1]->ioaddr.scr_addr = svia_scr_addr(host->iomap[5], 1);
@@ -486,6 +488,7 @@ static int vt6421_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 	const struct ata_port_info *ppi[] =
 		{ &vt6421_sport_info, &vt6421_sport_info, &vt6421_pport_info };
 	struct ata_host *host;
+	void __iomem *iomem;
 	int i, rc;
 
 	*r_host = host = ata_host_alloc_pinfo(&pdev->dev, ppi, ARRAY_SIZE(ppi));
@@ -494,13 +497,17 @@ static int vt6421_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 		return -ENOMEM;
 	}
 
-	rc = pcim_iomap_regions(pdev, 0x3f, DRV_NAME);
-	if (rc) {
-		dev_err(&pdev->dev, "failed to request/iomap PCI BARs (errno=%d)\n",
-			rc);
-		return rc;
+	/* Request and ioremap _all_ PCI BARs. */
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		iomem = pcim_iomap_region(pdev, i, DRV_NAME);
+		if (IS_ERR(iomem)) {
+			rc = PTR_ERR(iomem);
+			dev_err(&pdev->dev, "failed to request/iomap PCI BARs (errno=%d)\n",
+				rc);
+			return rc;
+		}
+		host->iomap[i] = iomem;
 	}
-	host->iomap = pcim_iomap_table(pdev);
 
 	for (i = 0; i < host->n_ports; i++)
 		vt6421_init_addrs(host->ports[i]);
@@ -519,10 +526,10 @@ static int vt8251_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 		return rc;
 	*r_host = host;
 
-	rc = pcim_iomap_regions(pdev, 1 << 5, DRV_NAME);
-	if (rc) {
+	host->iomap[5] = pcim_iomap_region(pdev, 5, DRV_NAME);
+	if (IS_ERR(host->iomap[5])) {
 		dev_err(&pdev->dev, "failed to iomap PCI BAR 5\n");
-		return rc;
+		return PTR_ERR(host->iomap[5]);
 	}
 
 	/* 8251 hosts four sata ports as M/S of the two channels */
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index d39b87537168..2a1c9a9fc558 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -349,14 +349,14 @@ static int vsc_sata_init_one(struct pci_dev *pdev,
 		return -ENODEV;
 
 	/* map IO regions and initialize host accordingly */
-	rc = pcim_iomap_regions(pdev, 1 << VSC_MMIO_BAR, DRV_NAME);
+	mmio_base = pcim_iomap_region(pdev, VSC_MMIO_BAR, DRV_NAME);
+	rc = PTR_ERR_OR_ZERO(mmio_base);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
-	host->iomap = pcim_iomap_table(pdev);
 
-	mmio_base = host->iomap[VSC_MMIO_BAR];
+	host->iomap[VSC_MMIO_BAR] = mmio_base;
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c1a85d46eba6..d12a9627c96e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -23,6 +23,9 @@
 #include <linux/cdrom.h>
 #include <linux/sched.h>
 #include <linux/async.h>
+#ifdef CONFIG_PCI
+#include <linux/pci_regs.h> /* for PCI_STD_NUM_BARS */
+#endif /* CONFIG_PCI */
 
 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -615,7 +618,9 @@ struct ata_ioports {
 struct ata_host {
 	spinlock_t		lock;
 	struct device 		*dev;
-	void __iomem * const	*iomap;
+#ifdef CONFIG_PCI
+	void __iomem		*iomap[PCI_STD_NUM_BARS];
+#endif /* CONFIG_PCI */
 	unsigned int		n_ports;
 	unsigned int		n_tags;			/* nr of NCQ tags */
 	void			*private_data;
-- 
2.47.1

