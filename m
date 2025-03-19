Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591614D70E
	for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2025 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399452; cv=none; b=s2Poj2+4NAcexfu6urO/G5bSkF0Phfp+b9SmQAhOFEafjxypWU0Js4Ha1NOdKXzcN7X/JF/CrE/41iRiMhHHWBrLD/+TZQ3/6EMbu05UruwCaNWifLmfsfUDSXRFy7sGIz0Dm/LLTCQ9SiEAPv9Gn/JRvzQlHFfqlAtlDPdNTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399452; c=relaxed/simple;
	bh=h30EzyNzNUrOhjQs5StFSqFlRCsMRnBYj+6xdWlDM6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Of97m8ZN9U6XZ9duLFeEkXSyc+MQWNI0jJajX2SS5ce7gqHEXON6Bp0bQOseZCysz1/iq2kJ3q1l7YQMLlU1luMl8zBMltcwewtwUROTMec5vaLljhryX+2lN3RgS4nvehTyIcCRY51ygEyK/UtXRks4iNRPHDJMvlDChspRxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqTNGEe9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqTNGEe9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742399449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ONSSW+lDtcy67CGlKnTfWFGqfsXrG9kWt/D/ofwwX/c=;
	b=eqTNGEe9T9DxHHBCinLR2J6eRpujHzuO5Zz9YItdOUdW7JOoxix34toVe4/L0MOcbbDzbf
	2Xm7upy4EW/Int9vGsjmtrUjp9NsgAqGTvGiaailp+pj+NAf7HRhbeUjnakal3SIm3+gnY
	OrkO+aWzoHBZualKYFWSCvUFBzONWqk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-crK9uLY2N_m_1FsVWc75Ew-1; Wed,
 19 Mar 2025 11:50:46 -0400
X-MC-Unique: crK9uLY2N_m_1FsVWc75Ew-1
X-Mimecast-MFC-AGG-ID: crK9uLY2N_m_1FsVWc75Ew_1742399445
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 593EB1800258;
	Wed, 19 Mar 2025 15:50:45 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.44.32.101])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9578F1800946;
	Wed, 19 Mar 2025 15:50:42 +0000 (UTC)
From: Tomas Henzl <thenzl@redhat.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	Niklas.Cassel@wdc.com
Subject: [PATCH V4] ata: ahci: simplify init function
Date: Wed, 19 Mar 2025 16:50:30 +0100
Message-ID: <20250319155030.16410-1-thenzl@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

There is no functional change done with this patch.

This patch moves all the IRQ vector allocations into a single
function. Instead of having the allocations spread out over
two separate call sites everything will be handled in ahci_init_irq.
Also a direct call into pci(m)_intx will be removed.

The main part of this change is done by adding a PCI_IRQ_INTX flag into
an already existing pci_alloc_irq_vectors invocation.
In the current implementation of the pci_alloc_irq_vectors is the sequence
of calls msi-x -> msi -> legacy irq and whatever there succeeds stops the
call chain. That makes it impossible to merge all instances into as
a single call to pci_alloc_irq_vectors since the order of calls there is:
multiple msi-x
a single msi
a single msi-x
a legacy irq.
The two last steps can be merged into a single one which are
the msi-x and legacy irq option.

When PCI_IRQ_INTX flag is set the pci_alloc_irq_vectors succeeds in almost
all cases - that makes it possible to convert ahci_init_irq(msi) into
a void function. The exception is when dev->irq is zero then the
pci_alloc_irq_vectors may return with an error code also pci_intx isn't
called from  pci_alloc_irq_vectors and thus certain pci calls aren't
performed.
That's just a negligible issue as later in ahci_init_one the (zero)
value of dev->irq is via pci_irq_vector assigned to hpriv->irq.
That value is then later tested in ahci_host_activate->ata_host_activate
where it is welcomed with a WARN_ON message and fails with setting up
irq and then the probe function (ahci_init_one) fails.
The special zero value's meaning is that polling mode is being be set
up which isn't the case.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
V2: ahci_init_irq is now a void function
V3: a) added an explanation of why we may convert ahci_init_irq into
	a void function
    b) fixed the subject line
    c) added an explanation of why calling pci_alloc_irq_vectors instead
	of pci_intx is safe
    d) rebased to latest code state (pci_intx->pcim_intx)
V4: done changes in patch body asked for by Niklas, like removing
    double newlines and few others
---
 drivers/ata/ahci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 52ae8f9a7dd6..76d3654a879c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1667,13 +1667,15 @@ static int ahci_get_irq_vector(struct ata_host *host, int port)
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
@@ -1687,7 +1689,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 			if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
 				hpriv->get_irq_vector = ahci_get_irq_vector;
 				hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
-				return nvec;
+				return;
 			}
 
 			/*
@@ -1702,12 +1704,13 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 
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
@@ -1987,10 +1990,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
2.48.1

