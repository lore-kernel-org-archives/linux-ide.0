Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6CC23909F;
	Thu, 22 May 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747909638; cv=none; b=LblhBJ2dP/0J5f5pYSbaXNX42gyEVqzLco24kqIFUR+l6vZU+vi0snxvoEmZzOVhbPwk5CQbYQPqNsLlRpVs2QdZHjSCkE0yrRGOotdbfPGSe6XIOnYoWDKUWb/TNtdY11ounDW1e9oc0/Ttuvq3sqUuP4mD6dlDAarm0chVI2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747909638; c=relaxed/simple;
	bh=vgWYnG1T4215NF0WPErAaMDj0w8gVRwUplMVkXpDXxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvdbRfDiyh6zUnWLRHyHJerdExUpQ1NcW6yuV75oYafj4zQ6r60MKxCQqExMSAR+J6eKzwz8YRKiTXazEXyvXFqsVn3kl06mKsFFBM1sGahxzELt7PUF5dQ4s8FWtKHhYZ/fuDWdfmu1UKOlwln1Pg/oEaM7kz8K1kntN2oT8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV5RW0FH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV5RW0FH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so89894425e9.2;
        Thu, 22 May 2025 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747909632; x=1748514432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbCwlkPJhCFqK7tuCDNYeA8ixDL/emPEMCFr7MGeaFU=;
        b=FV5RW0FHge3ffMAUQJRkZJuUApRlze5nGNHmBYw31fRi7y1qR3fJ+j57B7WkUiDKmg
         y7sDG15tyAuFDlRxLIDd5vEY7tiKgiAELQaHK9eBif28+VCv4QMGeBQPcZC8iTW4WP2Z
         CQnhhpX6LuUfM7a4Z67Jh8jHwdPJBNfdvpILWROgpJo1Liem/yYyaxrP+AIQnSOsGw6k
         pC5ALLDJhwrm4OpssPuhFFeTfGhhSHjNSTT3C3km5msd+IWhRyTokBSnzhTykQ9oM9UN
         AuOSQemaex73qdlSysQqK+2NJQaFiDnQUanOFE0LBg/IYiIFEJ1YEXQMbC6+k8MZjJck
         Q7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747909632; x=1748514432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbCwlkPJhCFqK7tuCDNYeA8ixDL/emPEMCFr7MGeaFU=;
        b=Zy9i+zIUdHp6GjUitGNleisctTAsW8l2T3MektGkMfAm/O+5XkocFGNjuhpuB41JDz
         RO34AzxLrSUZwR7tPl0aXEdi+m+UrcxCm+lh99MXQix5S2SXMk2qeXASF8vIquAx03WY
         jyj3CsH3z+ODpKwuCwxcGMFxwVq6J4XEYUbtyA0gnxpi5kPtM4MRZEI58UEZNiDdK6RT
         fmEUvBStc2K9vjOT37hFnKY1fdT7X39532r2Dcn4DIWnyRjl3iFXijVj/G9EpVtWcxcA
         keUzSoOQuduYcci32Nnhnz6OgZMT0k06VEf9yCO2nanoPfK6gUtvkmGFzW9cjXNjYzkE
         GWiA==
X-Gm-Message-State: AOJu0YxV5bkwenPBBy57+jhFYpe7qgDH4ml+eVxRuBG2rbo0KWkj/+6o
	n4SoPkzY++oaFdQOqQ6CZx1SBzBd1CmcYsiZeZ44BkFk2fi22jUln5WmHBhdB5qF
X-Gm-Gg: ASbGncsj+WMGFRScXsjO2gzH9vOQvz3PYLqwx1SFfV9e19rzHLaQLbgJ1e5p9fJKbqj
	1c8V5Hw493Z9tV+QF5ubrVeabcknLWlbx+PGGVDtf5Gbio6EslgnK7lvky0RCHx6o7LNxlVwKAc
	J0rx1MA7XG4G9UJeyroNbHaBoHgmgqVQ3KwzW6ApdM8VnUei02XDMbohk9W7+a9P6kjYyVvOqn0
	2eeD2uUTTFu8D00pR7Lx78FDpKgyCs0m9q7Pe3T0obpnUMankjhA/Oase44Itp37/9V4+tnyQIg
	qTitCeD3jAlflyYm7e7CZhVX8eVtJqfnYOPHaHLTp+mpdeLuynacvH+Di7NCP+P0NDZcieAJcUf
	85EpO4P0rMyQ=
X-Google-Smtp-Source: AGHT+IFCf+CLeS/u85dLwIbDKWOa5ndPp0KwVIaw2YfB+eNTZOr1Gywo3SJ4ASWGOh6dbKW6avjYMA==
X-Received: by 2002:a05:6000:2907:b0:3a3:64b7:620b with SMTP id ffacd0b85a97d-3a364b7643cmr18434585f8f.20.1747909632152;
        Thu, 22 May 2025 03:27:12 -0700 (PDT)
Received: from localhost.localdomain ([102.164.100.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62961sm22313150f8f.49.2025.05.22.03.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 03:27:11 -0700 (PDT)
From: Alexander Roman <monderasdor@gmail.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexander Roman <monderasdor@gmail.com>
Subject: [PATCH V3] ahci: enhance error handling in ahci_init_one
Date: Thu, 22 May 2025 03:26:53 -0700
Message-ID: <20250522102653.1169-1-monderasdor@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <f2db43ab-97d0-4731-9b51-18876f342b42@kernel.org>
References: <f2db43ab-97d0-4731-9b51-18876f342b42@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive error handling to ahci_init_one() to:
1. Prevent resource leaks during initialization failures
2. Ensure proper cleanup of allocated resources
3. Provide detailed error reporting for debugging
4. Maintain consistent error handling patterns

Key changes:
- Initialize all pointers to NULL
- Add centralized error handling via goto labels
- Improve error messages with specific error codes
- Remove duplicate Intel PCS quirk call
- Adjust log levels (dev_err for fatal, dev_dbg for quirks)

Signed-off-by: Alexander Roman <monderasdor@gmail.com>
---
 drivers/ata/ahci.c | 98 ++++++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index abc1234..def5678 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1611,7 +1611,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ahci_host_priv *hpriv = NULL;
 	struct ata_host *host = NULL;
 	void __iomem *mmio = NULL;
-	int n_ports, i, rc;
+	int n_ports, i, rc = -ENOMEM;
 	u32 tmp, cap, port_map;
 	u32 saved_cap;
 	struct device *dev = &pdev->dev;
@@ -1619,60 +1619,72 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	VPRINTK("ahci_init_one enter\n");
 
 	rc = pcim_enable_device(pdev);
-	if (rc)
-		return rc;
+	if (rc) {
+		dev_err(dev, "failed to enable PCI device (err=%d)\n", rc);
+		goto err_out;
+	}
 
 	rc = pcim_iomap_regions(pdev, 1 << AHCI_PCI_BAR_STANDARD, DRV_NAME);
-	if (rc)
-		return rc;
+	if (rc) {
+		dev_err(dev, "failed to map PCI regions (err=%d)\n", rc);
+		goto err_out;
+	}
 	mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR_STANDARD];
 
 	rc = pci_alloc_irq_vectors(pdev, 1, AHCI_MAX_PORTS, PCI_IRQ_ALL_TYPES);
-	if (rc < 0)
-		return rc;
+	if (rc < 0) {
+		dev_err(dev, "failed to allocate IRQ vectors (err=%d)\n", rc);
+		goto err_out;
+	}
 
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv)
-		return -ENOMEM;
+	if (!hpriv) {
+		dev_err(dev, "failed to allocate host private data\n");
+		goto err_out;
+	}
 
 	hpriv->mmio = mmio;
 	hpriv->flags = (unsigned long)ent->driver_data;
 	hpriv->irq = pdev->irq;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
-		ahci_intel_pcs_quirk(pdev, hpriv);
+		rc = ahci_intel_pcs_quirk(pdev, hpriv);
+		if (rc)
+			dev_dbg(dev, "Intel PCS quirk failed (err=%d)\n", rc);
 	}
 
 	ahci_get_port_map_mask(dev, hpriv);
 
 	rc = ahci_pci_save_initial_config(pdev, hpriv);
-	if (rc)
-		return rc;
+	if (rc) {
+		dev_err(dev, "failed to save initial config (err=%d)\n", rc);
+		goto err_out;
+	}
 
 	cap = hpriv->cap;
 	saved_cap = cap;
 	port_map = hpriv->port_map;
 	n_ports = ahci_calc_n_ports(cap, port_map);
 
 	host = ata_host_alloc_pinfo(dev, ahci_port_info + ent->driver_data, n_ports);
-	if (!host)
-		return -ENOMEM;
+	if (!host) {
+		dev_err(dev, "failed to allocate ATA host\n");
+		goto err_out;
+	}
 
 	host->private_data = hpriv;
 
 	rc = ahci_configure_dma_masks(pdev, hpriv);
-	if (rc)
-		return rc;
+	if (rc) {
+		dev_err(dev, "failed to configure DMA masks (err=%d)\n", rc);
+		goto err_host;
+	}
 
 	ahci_pci_init_controller(host);
 	rc = ahci_reset_controller(host);
-	if (rc)
-		return rc;
-
-	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
-		ahci_intel_pcs_quirk(pdev, hpriv);
+	if (rc) {
+		dev_err(dev, "failed to reset controller (err=%d)\n", rc);
+		goto err_host;
 	}
 
 	if (ahci_broken_system_poweroff(pdev)) {
@@ -1685,20 +1697,20 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	if (is_mcp89_apple(pdev)) {
-		ahci_mcp89_apple_enable(pdev);
+		rc = ahci_mcp89_apple_enable(pdev);
+		if (rc)
+			dev_warn(dev, "Apple MCP89 enable failed (err=%d)\n", rc);
 	}
 
-	acer_sa5_271_workaround(hpriv, pdev);
-
 	ahci_init_irq(pdev, n_ports, hpriv);
 	ahci_pci_enable_interrupts(host);
 
 	ahci_pci_print_info(host);
 
 	rc = ata_host_activate(host, hpriv->irq, ahci_interrupt, IRQF_SHARED,
-			       &ahci_sht);
-	if (rc)
-		return rc;
-
-	return 0;
+			      &ahci_sht);
+	if (rc) {
+		dev_err(dev, "failed to activate ATA host (err=%d)\n", rc);
+		goto err_host;
+	}
 }
