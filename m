Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C861FBCA6
	for <linux-ide@vger.kernel.org>; Tue, 14 Jan 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879408; cv=none; b=smjkIOV0flMVNeuSwDQOaZBFM1Id9/aaSDV4f5oqa8kK8uQD1gblAMYs1x4RyxH20ZmE8xZ7bGYbgYZ9bqr64jukRKxh2rzTFUpo/rW3vy0bm7c0gIFXLY8PjtiQPbYlCIQEHftzyLEV1xT6Xw7ZIrFIkWVJpKAdGVlP9uho58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879408; c=relaxed/simple;
	bh=whlKAUqHTjHNeBRrU/4cu9r+dtq512gjYmyTllNSWdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1NaptLKQ3Oxmb1sWLTEjwx0SlJ8fqcXboW0+rf+SgHw8mRUoJQS3i7L5Ljk68UTtRzmEqAPdOzC30lyPNhh2/RaGG+6VfFX54EYru42l441JASvFW2HBxyNjgVOhaN9i37YxhgfjsZkAcnI4mAPb9YbdcErjo++R2y4DMMlUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmHiD2nB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmHiD2nB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736879404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gK0plPin2RxhhztabRQdzIpqQ2ZS97wHUb0vR9SYhgc=;
	b=XmHiD2nBPSjn6tKi2gAS1GyWWgm9jP4YvjjGoS85m92t3Pi1+6/M+uvanGzGElmAswjnNA
	UJfRLLRtu+LGG1R9pXLmd6shcmEtjcq/eX/OTXIMcNemAdM4GEdY/a2bhC6P+S6XQMJcq+
	4pr4RFL8GxKEo4C3yM4gLGU8XlqXWXs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-lHs1yXv5NU2i8gpEXLbXvw-1; Tue,
 14 Jan 2025 13:30:00 -0500
X-MC-Unique: lHs1yXv5NU2i8gpEXLbXvw-1
X-Mimecast-MFC-AGG-ID: lHs1yXv5NU2i8gpEXLbXvw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75D931956050;
	Tue, 14 Jan 2025 18:29:59 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.45.224.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2178119560A3;
	Tue, 14 Jan 2025 18:29:57 +0000 (UTC)
From: Tomas Henzl <thenzl@redhat.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	Niklas.Cassel@wdc.com
Subject: [PATCH V3] ata: ahci: simplify init function
Date: Tue, 14 Jan 2025 19:29:56 +0100
Message-ID: <20250114182956.40923-1-thenzl@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

by removing few lines. No functional change.

The main part of this change is done by adding a PCI_IRQ_INTX flag into
an already existing pci_alloc_irq_vectors invocation.
In the current implementation of the pci_alloc_irq_vectors is the sequence of calls
msi-x -> msi -> legacy irq and whatever there succeeds stops the
call chain. That makes it impossible to merge all instances into as a single call
to pci_alloc_irq_vectors since the order of calls there is:
multiple msi-x
a single msi
a single msi-x
a legacy irq.
but the two last steps can be merged into one which are the msi-x and legacy
irq option. With this change we remove a pci(m)_intx call.
When PCI_IRQ_INTX flag is set the pci_alloc_irq_vectors succeeds in almost
all cases - that makes it possible to convert ahci_init_irq(msi) into a void function.
The exception is when dev->irq is zero then the pci_alloc_irq_vectors
may return with an error code also pci_intx isn't called from  pci_alloc_irq_vectors
and thus certain pci calls aren't performed.
That's just a negligible issue as later in ahci_init_one the (zero)
value of dev->irq is via pci_irq_vector assigned to hpriv->irq.
That value is then later tested in ahci_host_activate->ata_host_activate where
it is welcomed with a WARN_ON message and fails with setting up irq and
then the probe function (ahci_init_one) fails. The special zero value's
meaning is that polling mode is being be set up which isn't the case.


Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
V2: ahci_init_irq is now a void function
V3: a) added an explanation of why we may convert ahci_init_irq into
	a void function
    b) fixed the subject line
    c) added an explanation of why calling pci_alloc_irq_vectors instead
	of pci_intx is safe
    d) rebased to latest code state (pci_intx->pcim_intx)

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
-		pcim_intx(pdev, 1);
-	}
+	ahci_init_irq(pdev, n_ports, hpriv);
+
 	hpriv->irq = pci_irq_vector(pdev, 0);
 
 	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
-- 
2.47.1

