Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A21A23BE
	for <linux-ide@vger.kernel.org>; Mon, 30 Dec 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735560955; cv=none; b=awX5gbOrUxscpJSVfUpnI2nnVGrBJ2bOvz5QJLBMuvFQ3JkXjRk/faCXyiUIivTVtZr5kIlRJho20l37R6wPhGKzc4r2F8dT7IhiCIOqQxT64iVlC7FJ/2pXuZGHPj68hxjxuFJsKJVIurnJc9zsQ+xzvtEO0vaF1bjRQQAOBqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735560955; c=relaxed/simple;
	bh=qKTMm+gLoTyyZi7X1EinY3eeb26Vih65nin8UQHaxlA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=keLhNp9ZbECZ4olWGRQgVEioq2WCHmkoQE8aY3OzHAW7x5t045F9co9fwlwICMebUaJlqTRTKcxncJnrx6uw0mhu9oKm7AGhvMyT+tIrU3+KdTvGyP1X9UUCtWLXh7jHRrEkV5g7GyXBCo4y9oSWgQpfE0pFr/uFksZE7rOUKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2+rpJGW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2+rpJGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735560952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G+ezmFzKG64ZrcCZfHJcYRUrhkJV4IKQBrNwYAW2otQ=;
	b=P2+rpJGWHpiZYyexRQXA6eNyaSdrCSX2T/XvNUiLzRrQdGGxGqStPKjzRkDEbaLYRYsMAU
	OINmoHNGyiRydt5fSBugAHU2AEyJu0afnAes0NI0G31UqwlBteSe5F9ThmD39jRLUKDFZX
	hPebaaREB+XdhoHySTZnGqK5XSIzZDU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-N4uKzBhdMh2Dbpwhbyc5Dw-1; Mon,
 30 Dec 2024 07:15:51 -0500
X-MC-Unique: N4uKzBhdMh2Dbpwhbyc5Dw-1
X-Mimecast-MFC-AGG-ID: N4uKzBhdMh2Dbpwhbyc5Dw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4580D19560B3
	for <linux-ide@vger.kernel.org>; Mon, 30 Dec 2024 12:15:50 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.45.224.63])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 966223000197
	for <linux-ide@vger.kernel.org>; Mon, 30 Dec 2024 12:15:49 +0000 (UTC)
From: Tomas Henzl <thenzl@redhat.com>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ahci: simplify init function
Date: Mon, 30 Dec 2024 13:15:48 +0100
Message-ID: <20241230121548.11911-1-thenzl@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

by removing few lines. No functional change.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
 drivers/ata/ahci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8d27c567be1c..66c19039449d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1665,7 +1665,7 @@ static int ahci_get_irq_vector(struct ata_host *host, int port)
 	return pci_irq_vector(to_pci_dev(host->dev), port);
 }
 
-static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
+static int ahci_init_irq(struct pci_dev *pdev, unsigned int n_ports,
 			struct ahci_host_priv *hpriv)
 {
 	int nvec;
@@ -1700,12 +1700,13 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 
 	/*
 	 * If the host is not capable of supporting per-port vectors, fall
-	 * back to single MSI before finally attempting single MSI-X.
+	 * back to single MSI before finally attempting single MSI-X or
+	 * a legacy INTx.
 	 */
 	nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
 	if (nvec == 1)
 		return nvec;
-	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_INTX);
 }
 
 static void ahci_mark_external_port(struct ata_port *ap)
@@ -1985,10 +1986,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	host->private_data = hpriv;
 
-	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
-		/* legacy intx interrupts */
-		pci_intx(pdev, 1);
-	}
+	ahci_init_irq(pdev, n_ports, hpriv);
 	hpriv->irq = pci_irq_vector(pdev, 0);
 
 	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
-- 
2.47.1

