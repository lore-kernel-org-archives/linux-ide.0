Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1C15217F
	for <linux-ide@vger.kernel.org>; Mon, 12 Aug 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452558; cv=none; b=tB11fcg4Z49/NslrF6ygXWMd9dtX7W8i+Kv4rOB5uKzuADPrdDv6Cy55BGpoCTuM3JwTTgttNsMwGi36tkPw7KjFthDZC0BRtG/RDfxhQd9MkCA3lBVQ5JMFHz8jExzgXK9LvXBhArgDkKQWCSpnBLWV+/TMSk37YP/fFEZdi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452558; c=relaxed/simple;
	bh=naa3UQ62lEngE/Oljw0xCf0QeCQfkZFPlntUl04iHRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCpTJWJcyF+4XfOEoZv/yFlXQZ+TO1JGYhTubuGJQ1msvaQlfSNEyHKT38PsRYgf5ORGOsfsrJaePXZWVHi1hhBLN/60iZNUpuKFt/kTlp5yjKpINGQ3amPdYRS9VOG2ZSf/uAGFwKVBRAzI8W2gAmYbvZWSxJYH3lcWidGY36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwZR+oqw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwZR+oqw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723452554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OwC4nte0loPWoH63C4xjwOSwmBjnEoY6MDdlc6Wu5Pg=;
	b=fwZR+oqwVEMeCSucKMYR3UiSs6WZptuaIKV0clprRVc6neYfJSNCqmyVvALRh9LWKqGRPI
	1OCJpXxakuKwfS1/8h5ITlnxr43XeKN2JdQ7rB6In7GXMUsLvaiuG8LeS22TRKdrxrjG1X
	NfG9AoTeZ5ImBrxbBoeHOe2VPt7fA/k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-BHO8La2XMuKHi7rjq9ngug-1; Mon, 12 Aug 2024 04:49:10 -0400
X-MC-Unique: BHO8La2XMuKHi7rjq9ngug-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2efb2c3f288so4359671fa.1
        for <linux-ide@vger.kernel.org>; Mon, 12 Aug 2024 01:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723452549; x=1724057349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwC4nte0loPWoH63C4xjwOSwmBjnEoY6MDdlc6Wu5Pg=;
        b=qFmU/4thjahIiJc8y2dWtXHg6DRcZyPOYhtWACTZra+BheRQV2PyZYLLqpyfa+j7ui
         5XcQHBEJwcBOBEfY/N5OZLxG7WjIHXvelKkZeqmi/DVCMockTi/Nw3uYsf4Ihsx2u/ru
         Hl7aDQ32pKlZQ7+E8ym+l9ggQpO+mfA+jK1fbj/aAYZCcEebKFWVpJw9zgpcKr2bfMFH
         HV+Pl8Tde5l1aRPHRuJxh4P2PgRO+fZDzTcc/fFLSqX3LD6h9xu4OsZ2K0eYDl3qDZl5
         KNMDwTm0U4/s63W8QFL56lmZevRfcb4tuYImlvGMBqgZMDzj420Uzsw2PuYGZpwVLw2c
         SGjA==
X-Gm-Message-State: AOJu0YzN4Ucd+g3cOWMmAQGUabPGmDEP+goXcFnfwEvdR7s3BfTz+1Nl
	Mm2/YVpRDUNdQXetqUq/nQ3eRdV16D0qpbfCYWMCs61ijMs7SE87bb+oyyPstSP3E65df6pbYap
	6hORbNaxr1a6HEk6dQMg3OsDC74eLNLoTnyWO9URCbPDrKoVcgFPF6FmRHw==
X-Received: by 2002:a05:651c:211f:b0:2ef:2b6e:f8c2 with SMTP id 38308e7fff4ca-2f1a6cf274dmr36734191fa.6.1723452548697;
        Mon, 12 Aug 2024 01:49:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtg0UnRsq6/C+acuJPdFrws4/jgE8uY/bhz2Utn2VvCua2/5tUPpRIYaSV8z50btB64U10CQ==
X-Received: by 2002:a05:651c:211f:b0:2ef:2b6e:f8c2 with SMTP id 38308e7fff4ca-2f1a6cf274dmr36734121fa.6.1723452547937;
        Mon, 12 Aug 2024 01:49:07 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74ff9fsm180051485e9.28.2024.08.12.01.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 01:49:07 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] ata: Replace deprecated PCI devres functions
Date: Mon, 12 Aug 2024 10:48:40 +0200
Message-ID: <20240812084839.37580-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ata subsystem uses the PCI devres functions pcim_iomap_table() and
pcim_request_regions(), which have been deprecated in commit e354bb84a4c1
("PCI: Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()").

These functions internally already use their successors, notably
pcim_request_region(), so they are quite trivial to replace.

However, one thing special about ata is that it stores the iomap table
provided by pcim_iomap_table() in struct ata_host. This can be replaced
with a __iomem pointer table, statically allocated with size
PCI_STD_NUM_BARS so it can house the maximum number of PCI BARs. The
only further modification then necessary is to explicitly fill that
table, whereas before it was filled implicitly by
pcim_request_regions().

Modify the iomap table in struct ata_host.

Replace all calls to pcim_request_region() with ones to
pcim_request_region().

Remove all calls to pcim_iomap_table().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Alright, so the most important thing first:
Why is this patch so large?
I do have it in form of a series consisting of 21 patches. Unfortunately
with that, providing a series where each commit is buildable is a bit
hacky because host->iomap contains a 'const'. So I'd have to create
separate non-const table and then phase out the const-version at the
end.

I could do that, but wanted to probe the ata subsystem first to see if
you'd like this version, too ;-)

That being said, I think the most critical parts of this patch are the
changes to:
  - sata_via.c (bitmask 0x3f -> 6 ones set == PCI_STD_NUM_BARS) and
  - libata-sff.c, which does some very.. clever.. bitmask magic. Took me
    a while to even figure out what it is supposed to do.

So I suggest to review these parts especially carefully.

This series depends on pcim_iomap_region() being public, which has been
approved by Bjorn in this series for v6.12:
https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Let me know what you think. If you prefer a separate patches version, I
can provide that at some point in the future probably.

P.
---
 drivers/ata/ata_piix.c      |  7 +++---
 drivers/ata/libata-sff.c    | 50 ++++++++++++++++++++++++++++++-------
 drivers/ata/pata_atp867x.c  | 13 ++++++----
 drivers/ata/pata_hpt3x3.c   |  8 +++---
 drivers/ata/pata_ninja32.c  | 10 ++++----
 drivers/ata/pata_pdc2027x.c | 11 ++++----
 drivers/ata/pata_sil680.c   | 11 ++++----
 drivers/ata/pdc_adma.c      |  9 +++----
 drivers/ata/sata_inic162x.c | 10 +++-----
 drivers/ata/sata_mv.c       |  8 +++---
 drivers/ata/sata_nv.c       |  8 +++---
 drivers/ata/sata_promise.c  |  7 +++---
 drivers/ata/sata_qstor.c    |  7 +++---
 drivers/ata/sata_sil.c      |  7 +++---
 drivers/ata/sata_sil24.c    | 20 ++++++++-------
 drivers/ata/sata_sis.c      |  8 +++---
 drivers/ata/sata_svw.c      |  9 ++++---
 drivers/ata/sata_sx4.c      | 17 ++++++++++---
 drivers/ata/sata_via.c      | 31 ++++++++++++++---------
 drivers/ata/sata_vsc.c      |  7 +++---
 include/linux/libata.h      |  7 +++++-
 21 files changed, 163 insertions(+), 102 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ec3c5bd1f813..c1071ca01ba4 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1457,10 +1457,9 @@ static int piix_init_sidpr(struct ata_host *host)
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
index 250f7dae05fd..d58db8226436 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2153,12 +2153,13 @@ int ata_pci_sff_init_host(struct ata_host *host)
 	struct pci_dev *pdev = to_pci_dev(gdev);
 	unsigned int mask = 0;
 	int i, rc;
+	const char *drv_name = dev_driver_string(gdev);
 
 	/* request, iomap BARs and init port addresses accordingly */
 	for (i = 0; i < 2; i++) {
 		struct ata_port *ap = host->ports[i];
 		int base = i * 2;
-		void __iomem * const *iomap;
+		void __iomem *io_tmp;
 
 		if (ata_port_is_dummy(ap))
 			continue;
@@ -2172,8 +2173,41 @@ int ata_pci_sff_init_host(struct ata_host *host)
 			continue;
 		}
 
-		rc = pcim_iomap_regions(pdev, 0x3 << base,
-					dev_driver_string(gdev));
+		/*
+		 * In a first loop run, we want to get BARs 0 and 1.
+		 * In a second run, we want BARs 2 and 3.
+		 */
+		if (i == 0) {
+			io_tmp = pcim_iomap_region(pdev, 0, drv_name);
+			if (IS_ERR(io_tmp)) {
+				rc = PTR_ERR(io_tmp);
+				goto err;
+			}
+			host->iomap[0] = io_tmp;
+
+			io_tmp = pcim_iomap_region(pdev, 1, drv_name);
+			if (IS_ERR(io_tmp)) {
+				rc = PTR_ERR(io_tmp);
+				goto err;
+			}
+			host->iomap[1] = io_tmp;
+		} else {
+			io_tmp = pcim_iomap_region(pdev, 2, drv_name);
+			if (IS_ERR(io_tmp)) {
+				rc = PTR_ERR(io_tmp);
+				goto err;
+			}
+			host->iomap[2] = io_tmp;
+
+			io_tmp = pcim_iomap_region(pdev, 3, drv_name);
+			if (IS_ERR(io_tmp)) {
+				rc = PTR_ERR(io_tmp);
+				goto err;
+			}
+			host->iomap[3] = io_tmp;
+		}
+
+err:
 		if (rc) {
 			dev_warn(gdev,
 				 "failed to request/iomap BARs for port %d (errno=%d)\n",
@@ -2183,12 +2217,11 @@ int ata_pci_sff_init_host(struct ata_host *host)
 			ap->ops = &ata_dummy_port_ops;
 			continue;
 		}
-		host->iomap = iomap = pcim_iomap_table(pdev);
 
-		ap->ioaddr.cmd_addr = iomap[base];
+		ap->ioaddr.cmd_addr = host->iomap[base];
 		ap->ioaddr.altstatus_addr =
 		ap->ioaddr.ctl_addr = (void __iomem *)
-			((unsigned long)iomap[base + 1] | ATA_PCI_CTL_OFS);
+			((unsigned long)host->iomap[base + 1] | ATA_PCI_CTL_OFS);
 		ata_sff_std_ports(&ap->ioaddr);
 
 		ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
@@ -3095,12 +3128,11 @@ void ata_pci_bmdma_init(struct ata_host *host)
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
index d65c586b5ad0..7291d66a6682 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -215,17 +215,19 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 
 	/* Everything is relative to BAR4 if we set up this way */
-	rc = pcim_iomap_regions(pdev, 1 << 4, DRV_NAME);
+	base = pcim_iomap_region(pdev, 4, DRV_NAME);
+	if (IS_ERR(base))
+		rc = PTR_ERR(base);
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
index 76a91013d27d..8769e5bb4819 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -116,13 +116,15 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	rc = pcim_enable_device(dev);
 	if (rc)
 		return rc;
-	rc = pcim_iomap_regions(dev, 1 << 0, DRV_NAME);
+
+	base = pcim_iomap_region(dev, 0, DRV_NAME);
+	if (IS_ERR(base))
+		rc = PTR_ERR(base);
 	if (rc == -EBUSY)
 		pcim_pin_device(dev);
 	if (rc)
 		return rc;
 
-	host->iomap = pcim_iomap_table(dev);
 	rc = dma_set_mask_and_coherent(&dev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
@@ -130,9 +132,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
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
index 05c905827dc5..6844654fb154 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4083,7 +4083,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 	host->private_data = hpriv;
 	hpriv->board_idx = chip_soc;
 
-	host->iomap = NULL;
 	hpriv->base = devm_ioremap(&pdev->dev, res->start,
 				   resource_size(res));
 	if (!hpriv->base)
@@ -4392,13 +4391,14 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << MV_PRIMARY_BAR, DRV_NAME);
+	hpriv->base = pcim_iomap_region(pdev, MV_PRIMARY_BAR, DRV_NAME);
+	if (IS_ERR(hpriv->base))
+		rc = PTR_ERR(hpriv->base);
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
index 2df1a070b25a..b53bdd7712b3 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -1163,12 +1163,13 @@ static int pdc_ata_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << PDC_MMIO_BAR, DRV_NAME);
+	host_mmio = pcim_iomap_region(pdev, PDC_MMIO_BAR, DRV_NAME);
+	if (IS_ERR(host_mmio))
+		rc = PTR_ERR(host_mmio);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
-	host_mmio = pcim_iomap_table(pdev)[PDC_MMIO_BAR];
 
 	/* determine port configuration and setup host */
 	n_ports = 2;
@@ -1193,7 +1194,7 @@ static int pdc_ata_init_one(struct pci_dev *pdev,
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
index cc77c0248284..a6983b92f935 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -751,18 +751,19 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << SIL_MMIO_BAR, DRV_NAME);
+	mmio_base = pcim_iomap_region(pdev, SIL_MMIO_BAR, DRV_NAME);
+	if (IS_ERR(mmio_base))
+		rc = PTR_ERR(mmio_base);
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
index 598a872f6a08..21f68de6480d 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -451,14 +451,15 @@ static int k2_sata_init_one(struct pci_dev *pdev, const struct pci_device_id *en
 		return -ENODEV;
 	}
 
-	/* Request and iomap PCI regions */
-	rc = pcim_iomap_regions(pdev, 1 << bar_pos, DRV_NAME);
+	/* Request and iomap PCI region */
+	mmio_base = pcim_iomap_region(pdev, bar_pos, DRV_NAME);
+	if (IS_ERR(mmio_base))
+		rc = PTR_ERR(mmio_base);
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
index a482741eb181..d115f6f66974 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1390,6 +1390,7 @@ static int pdc_sata_init_one(struct pci_dev *pdev,
 	struct ata_host *host;
 	struct pdc_host_priv *hpriv;
 	int i, rc;
+	void __iomem *io_tmp;
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
 
@@ -1406,13 +1407,23 @@ static int pdc_sata_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, (1 << PDC_MMIO_BAR) | (1 << PDC_DIMM_BAR),
-				DRV_NAME);
+	io_tmp = pcim_iomap_region(pdev, PDC_MMIO_BAR, DRV_NAME);
+	if (IS_ERR(io_tmp))
+		rc = PTR_ERR(io_tmp);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
-	host->iomap = pcim_iomap_table(pdev);
+	host->iomap[PDC_MMIO_BAR] = io_tmp;
+
+	io_tmp = pcim_iomap_region(pdev, PDC_DIMM_BAR, DRV_NAME);
+	if (IS_ERR(io_tmp))
+		rc = PTR_ERR(io_tmp);
+	if (rc == -EBUSY)
+		pcim_pin_device(pdev);
+	if (rc)
+		return rc;
+	host->iomap[PDC_DIMM_BAR] = io_tmp;
 
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
index d39b87537168..df6aee088809 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -349,14 +349,15 @@ static int vsc_sata_init_one(struct pci_dev *pdev,
 		return -ENODEV;
 
 	/* map IO regions and initialize host accordingly */
-	rc = pcim_iomap_regions(pdev, 1 << VSC_MMIO_BAR, DRV_NAME);
+	mmio_base = pcim_iomap_region(pdev, VSC_MMIO_BAR, DRV_NAME);
+	if (IS_ERR(mmio_base))
+		rc = PTR_ERR(mmio_base);
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
index 17394098bee9..80e8cdc1ed27 100644
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
@@ -577,7 +580,9 @@ struct ata_ioports {
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
2.45.2

