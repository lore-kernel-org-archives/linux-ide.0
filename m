Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920B14A4D1
	for <linux-ide@vger.kernel.org>; Mon, 13 Jan 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786052; cv=none; b=lkG90WadzerErp5Fxns7nt7SlwbJKc5gUwpYiE3WstCa2DdV9GdZNgnxG5NXQNAOSFwSWM/eEnwzYt/7g0gYE9V1VWKzfRduuKnQE5ycJ549hdscy6O/ZRN+CNRGNQ6AIqvKeJqR1kY406VS3C/vV6nNF7cm9OqM31I3a0HUKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786052; c=relaxed/simple;
	bh=+NaY/ExgsT31tmmgRLfzbwLpAUmWGgkRVatjffeyd/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHhiLA4lHYY/BaKb/UkqxnHwmga2AnhqOpSPtjQCCPJFedDWQ5ks9LzLgtjnnRzkPuTRGNuz/81aNUoNrkOrN/uQ5s/wtIxyp6K936aEJGeuYUc/R6REVpH3vS7oLn+NDWeBBs+DyIX+sUFhShjEt+efoRqatgb+6ZuYhkGKno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxV9Bz4R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxV9Bz4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736786049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zZ5CxGa88tAiFRXxfmqpwxfAj1WTV6U+mapruCaGsks=;
	b=SxV9Bz4RlZase7YmrsfwnUX93DrGT/rGYyGjSqeqiBxti8qx7C1gNMZkIaC5a20vri48m/
	fKHvCrCs1MRYgc44K/TTvPS9A4WeswN0lIz/rNueq+k1tSldOvq98cJ31sCGTAczLRpR3b
	FoJwzc5jHGB/qUY0vKCjKiOzyqtoSUM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-_cHVDxoKM2ehTjHVh274MA-1; Mon,
 13 Jan 2025 11:34:06 -0500
X-MC-Unique: _cHVDxoKM2ehTjHVh274MA-1
X-Mimecast-MFC-AGG-ID: _cHVDxoKM2ehTjHVh274MA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 803DF19560B3;
	Mon, 13 Jan 2025 16:34:05 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.45.225.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B955E19560A3;
	Mon, 13 Jan 2025 16:34:03 +0000 (UTC)
From: Tomas Henzl <thenzl@redhat.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	Niklas.Cassel@wdc.com
Subject: [PATCH V2] simplify init function
Date: Mon, 13 Jan 2025 17:34:01 +0100
Message-ID: <20250113163401.35969-1-thenzl@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

by removing few lines. No functional change.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
V2: ahci_init_irq is now a void function

 drivers/ata/ahci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8d27c567be1c..3ea2f3adf354 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1665,13 +1665,15 @@ static int ahci_get_irq_vector(struct ata_host *host, int port)
 	return pci_irq_vector(to_pci_dev(host->dev), port);
 }
 
-static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
+static void ahci_init_irq(struct pci_dev *pdev, unsigned int n_ports,
 			struct ahci_host_priv *hpriv)
 {
 	int nvec;
 
-	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
-		return -ENODEV;
+	if (hpriv->flags & AHCI_HFLAG_NO_MSI) {
+		pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
+		return;
+	}
 
 	/*
 	 * If number of MSIs is less than number of ports then Sharing Last
@@ -1685,7 +1687,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 			if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
 				hpriv->get_irq_vector = ahci_get_irq_vector;
 				hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
-				return nvec;
+				return;
 			}
 
 			/*
@@ -1700,12 +1702,13 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 
 	/*
 	 * If the host is not capable of supporting per-port vectors, fall
-	 * back to single MSI before finally attempting single MSI-X.
+	 * back to single MSI before finally attempting single MSI-X or
+	 * a legacy INTx.
 	 */
 	nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
 	if (nvec == 1)
-		return nvec;
-	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+		return;
+	pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_INTX);
 }
 
 static void ahci_mark_external_port(struct ata_port *ap)
@@ -1985,10 +1988,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	host->private_data = hpriv;
 
-	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
-		/* legacy intx interrupts */
-		pci_intx(pdev, 1);
-	}
+	ahci_init_irq(pdev, n_ports, hpriv);
+
 	hpriv->irq = pci_irq_vector(pdev, 0);
 
 	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
-- 
2.47.1

