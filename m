Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AAE1F03FA
	for <linux-ide@vger.kernel.org>; Wed,  4 Dec 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332250; cv=none; b=nho/qpK4Kpdw3QcYGuov+k6BaR/lixyMynyOVa210oTVW/1fT7AkJvwHu9BUpdVvb2OHDzxVedSDDlKkN2fkE9l4HJbxvq6S6Z5QhkDQIOp87kz6jr1AOMfCM9MZ8XeFgCz8KRKhVCd+/GioYHFAf5SFsK7ZmfLtrqWU1JmHHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332250; c=relaxed/simple;
	bh=nJVxEQ2LyzNxAnSv+cp9c2mn6OvxbvFMrsBWsXIGANg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDLFLPiQqfgeWL/b8Ng5afFesmOMTvRYxKGpzXjll6p5Tw997ekEOl6KvEBsscQxPq+ImrvIN+yvOkkVXcesyGYxH9cCRNgyFEOm3Ks5eGRNrspuEi17jtDPZFY+rHHXn1PJNBlJhx8zBcn/wO37jg98i0VhBC6i+bw3lMu+CZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE+60rt+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE+60rt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733332247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWTBpB49wNu2pt+oDVgR6qB/uhd/iFTqIN1YIXfGuUQ=;
	b=JE+60rt+6iC77WS9nTZm/6VUmZVARHvuga72Y1O4BqFXnsRCosFQqHaQqnCaXu2Synza81
	JxTJa1cqj28tB5rVV3QeD7IGZHkUIgUAWce9e64kyuyWe/TwFgZkomiJXo1nQw67PgPvwR
	bwhRpL7YIQxcsXMLS6DdNSvIK7RapEw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-B1eQBdmeM-GaC2p1eqs7wQ-1; Wed, 04 Dec 2024 12:10:46 -0500
X-MC-Unique: B1eQBdmeM-GaC2p1eqs7wQ-1
X-Mimecast-MFC-AGG-ID: B1eQBdmeM-GaC2p1eqs7wQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a72b08d9so153685e9.2
        for <linux-ide@vger.kernel.org>; Wed, 04 Dec 2024 09:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332244; x=1733937044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWTBpB49wNu2pt+oDVgR6qB/uhd/iFTqIN1YIXfGuUQ=;
        b=wXKRqmweTNQSb/kHiLKHQmbbuP+E67QbY4vCWvmIqqudMIjIfbzTzW5MXrBmpc83kN
         XvTkodJK4AszXSvk+wJXgQ/4toiyh1EdFDhQmyV4dD0OLpz77hD2/2LV0OwPGEI+gAlY
         +xgOgkygWoigKz3rAWld5vYvyGVTPtSoBHmyeen13VTwUbFu+PGpT4SB/MXJaFLv4QEc
         pbb7reY30wfR1K4pCSL4qf1dHaczfLVQL6QdI74kZz6ZufT+K4xCxu8NdbmPWClJWqSc
         FYR+yu+GBpQfj6N9MSoEUsVgidPbU4N6krEg3BMhFkibl0nFzDZ0Z+UZVp3EaGKa6v3X
         wlLQ==
X-Gm-Message-State: AOJu0YyGsdbrVc3zEkILfdjffKr34+GzFmiChWff07s5gY8K1vi+Rzvl
	XqN4Ua9fhTqyan/8Crq2hqLY+UxM8DipDMPSZz8v3Ig7qucVL0KrvjifNhqMIRnPI3uX/3Kjp2e
	9oqfEEEwB+ki0wi0sI8tSnzjVfaqkeDYOypZXDMHIGQgEI6ZuXqkN79DmcQ==
X-Gm-Gg: ASbGncuEyMY62n6MaqCLmD3Pv33vK4d6rMwM3inw6T0jjSXffZKaOMMeuspCxzgH21Q
	x89a8W1yANbWA8iq20IdQ4eMEIlBf6wQ6T7NtuG0J+BCylwJOzAmLQf1RL0oeG9LsLIuIj9XyS6
	S5HdVk5qBEzo257WqucTqcgWbfXQeQEbkLHiHUNsHSYCJP/g84RBb1QR/90uYfk+fWEhYsRLuVc
	bVkBej0fzpjNqmYEbpl3qTHmrca7H+LJ5fXtlewWhfSukIPBERTfU2fZU0LxvoE4q3/eO+4mJMr
	wCgSuXcU
X-Received: by 2002:a05:600c:1d21:b0:42c:c401:6d8b with SMTP id 5b1f17b1804b1-434d09b1521mr59608225e9.7.1733332243832;
        Wed, 04 Dec 2024 09:10:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvmgi1usGgX8MMIoGNCsTveBOoaPEeYZezkOgDE8jfrTZXf6pKd4tH/iyX6cE/5JG6dut3aw==
X-Received: by 2002:a05:600c:1d21:b0:42c:c401:6d8b with SMTP id 5b1f17b1804b1-434d09b1521mr59607875e9.7.1733332243264;
        Wed, 04 Dec 2024 09:10:43 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3860bbba038sm2179511f8f.24.2024.12.04.09.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:10:42 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [RFC PATCH 2/3] ata: Replace deprecated PCI functions
Date: Wed,  4 Dec 2024 18:10:33 +0100
Message-ID: <20241204171033.86804-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204171033.86804-2-pstanner@redhat.com>
References: <20241204171033.86804-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ata subsystem uses the deprecated PCI devres functions
pcim_iomap_table() and pcim_request_regions().

These functions internally already use their successors, notably
pcim_request_region(), so they are quite trivial to replace.

Replace all calls to pcim_request_regions() with ones to
pcim_request_region().

Remove all calls to pcim_iomap_table().

The last remaining user, libata-sff.c, is very complicated to port and
left for future work.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/ata/ata_piix.c      |  7 +++----
 drivers/ata/pata_atp867x.c  | 13 ++++++++-----
 drivers/ata/pata_hpt3x3.c   | 10 ++++++----
 drivers/ata/pata_ninja32.c  | 11 ++++++-----
 drivers/ata/pata_pdc2027x.c | 11 +++++------
 drivers/ata/pata_sil680.c   | 12 +++++++-----
 drivers/ata/pdc_adma.c      |  9 ++++-----
 drivers/ata/sata_inic162x.c | 10 ++++------
 drivers/ata/sata_mv.c       |  9 +++++----
 drivers/ata/sata_nv.c       |  8 ++++----
 drivers/ata/sata_promise.c  |  8 +++++---
 drivers/ata/sata_qstor.c    |  7 +++----
 drivers/ata/sata_sil.c      |  8 +++++---
 drivers/ata/sata_sil24.c    | 20 +++++++++++---------
 drivers/ata/sata_sis.c      |  8 ++++----
 drivers/ata/sata_svw.c      | 10 ++++++----
 drivers/ata/sata_sx4.c      | 19 ++++++++++++++++---
 drivers/ata/sata_via.c      | 31 +++++++++++++++++++------------
 drivers/ata/sata_vsc.c      |  8 +++++---
 19 files changed, 126 insertions(+), 93 deletions(-)

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
index d65c586b5ad0..c811c774eafb 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -199,7 +199,7 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	static const u8 offset_ctl[2] = { 0x36, 0x3E };
 	const struct ata_port_info *ppi[] = { &info, NULL };
 	struct ata_host *host;
-	int i, rc;
+	int i, rc = 0;
 	void __iomem *base;
 
 	hpt3x3_init_chipset(pdev);
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
index 76a91013d27d..7b06e241be9f 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -116,13 +116,16 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	rc = pcim_enable_device(dev);
 	if (rc)
 		return rc;
-	rc = pcim_iomap_regions(dev, 1 << 0, DRV_NAME);
+
+	rc = 0;
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
@@ -130,9 +133,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
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
index abe64b5f83cf..1f74666a0f37 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -360,15 +360,17 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* Try to acquire MMIO resources and fallback to PIO if
 	 * that fails
 	 */
-	rc = pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR, DRV_NAME);
-	if (rc)
+	rc = 0;
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
@@ -376,8 +378,8 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
index b8f363370e1a..074ecba9c719 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4083,7 +4083,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 	host->private_data = hpriv;
 	hpriv->board_idx = chip_soc;
 
-	host->iomap = NULL;
 	hpriv->base = devm_ioremap(&pdev->dev, res->start,
 				   resource_size(res));
 	if (!hpriv->base)
@@ -4392,13 +4391,15 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << MV_PRIMARY_BAR, DRV_NAME);
+	rc = 0;
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
index 2df1a070b25a..60855da49b89 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -1163,12 +1163,14 @@ static int pdc_ata_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << PDC_MMIO_BAR, DRV_NAME);
+	rc = 0;
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
@@ -1193,7 +1195,7 @@ static int pdc_ata_init_one(struct pci_dev *pdev,
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
index 3a99f66198a9..3918613c877a 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -751,18 +751,20 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << SIL_MMIO_BAR, DRV_NAME);
+	rc = 0;
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
index 598a872f6a08..a7d17e0eb790 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -451,14 +451,16 @@ static int k2_sata_init_one(struct pci_dev *pdev, const struct pci_device_id *en
 		return -ENODEV;
 	}
 
-	/* Request and iomap PCI regions */
-	rc = pcim_iomap_regions(pdev, 1 << bar_pos, DRV_NAME);
+	/* Request and iomap PCI region */
+	rc = 0;
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
index a482741eb181..f4644ba5f095 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1390,6 +1390,7 @@ static int pdc_sata_init_one(struct pci_dev *pdev,
 	struct ata_host *host;
 	struct pdc_host_priv *hpriv;
 	int i, rc;
+	void __iomem *io_tmp;
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
 
@@ -1406,13 +1407,25 @@ static int pdc_sata_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, (1 << PDC_MMIO_BAR) | (1 << PDC_DIMM_BAR),
-				DRV_NAME);
+	rc = 0;
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
+	rc = 0;
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
index d39b87537168..462f61fc5b98 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -349,14 +349,16 @@ static int vsc_sata_init_one(struct pci_dev *pdev,
 		return -ENODEV;
 
 	/* map IO regions and initialize host accordingly */
-	rc = pcim_iomap_regions(pdev, 1 << VSC_MMIO_BAR, DRV_NAME);
+	rc = 0;
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
-- 
2.47.0

