Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F171F03F1
	for <linux-ide@vger.kernel.org>; Wed,  4 Dec 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332249; cv=none; b=lXzq7XxrHnjucnikiAathe8givepvMIO+E/vfmG0VwEsqJMamPVLGfchNj1deFc/+Jd9wLY5LfMeUmLq3Zfb0bAXZkWR7bHPMJk3RUpGRyhB4+S6PdKzppUiKBRa8TqoNCJ2AeKImUIUix5l2gSVFv/+gdTQXr3x/mWMO9RM1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332249; c=relaxed/simple;
	bh=6TTwfGPFIWFczOWcfnDq+V9viCPV7/G6Js5yV44vQHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hId+sKwvvmfG8U5JBchLmdtGDE+ovZLFFDVFuVRy0Ty8eN86R8CU+n0F8+Q+Ctrd/7bvvUyGFcoUgS6jmUI0uuL7JJr5HTkpOoPm3iWuowNMO7I5BEZ+TCB3R55JFsm+/ZiMEeVFfx/W44OUhQuW3tc6Oh9DBGU0Rzhm3sz8xG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHxdyize; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHxdyize"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733332247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG1/2+soXrCZJT+4aLn7BzvFulsaukH4/7W/e6kTCqA=;
	b=HHxdyizeKfw17X/xZlmK7MQSUrcGCeQ7OXzcU/J1oc796t0gimy9B4WKiB5Qy3Hjl53pkZ
	gn99TbIrZ222DWMz1YGGDsL8svr11b6AaulcEwosPoZr6an11DvhQnxMEMb2ZtVeL2u/Lt
	TJP4TOmtnlZwtdaETJvdtRzskNBGLII=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-dl6JkEdiM7ecuylHX6kbMg-1; Wed, 04 Dec 2024 12:10:45 -0500
X-MC-Unique: dl6JkEdiM7ecuylHX6kbMg-1
X-Mimecast-MFC-AGG-ID: dl6JkEdiM7ecuylHX6kbMg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385eb060d4fso605323f8f.1
        for <linux-ide@vger.kernel.org>; Wed, 04 Dec 2024 09:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332244; x=1733937044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG1/2+soXrCZJT+4aLn7BzvFulsaukH4/7W/e6kTCqA=;
        b=LILaNTpTPPFaub52MLBVAdc6lcLUBA9WrVLS6MdU3Qd94p3l+eIFVtj+DdbxFsH9/9
         xZuPWxyceoz0I2QO6FvslM/625NugwGNSkNeEvhdUKeTMcOIObGYZwVIBqkskrEcU49D
         FYPaiuWDY1x2QqQ1EIOp896bmsODKCZnnDQ3QoTml+6QEOSdU1Z5rraRjqbGiNrRoxNJ
         QUbMN4EnhTxobnh7Gll6wf1MKPT7KycmtrWpQvjhGoxifFvyVnsMozbavelsv3BV0wTL
         85wZfT5Podd8nhWHhAlwaIPY69hj+SWmi7N899V2jH7Ty/6lCW4+7nmPZ/kxOiHKXekM
         pjMA==
X-Gm-Message-State: AOJu0YyClvZxT/hExTMTB6843yTHgM49GEjjdPb94e4NcV6M6+Cr+Mhe
	Dz/sVmdnKC6iNd17+SFmPs7EF6QjT90JNaj0zYqGPRffLEIkZylg+7+0P4SQaTN9rysqF7GxHOF
	Y0qF6t0Lt27TEMDMwmCxLWH8KE3xncKXeEa6NWsrWK33to24NCHJchSe4pw==
X-Gm-Gg: ASbGncvBz/SMs5tgULW4IgIZsHdjSOo3JlGhsPzazryB/eHIfgRh6hxFa+lFYrzL3dn
	i8nw3Uf9Gik9KvLBm6cHFTNBO0l93e+r8xHAY/4Y9jlvrBWLIQSHcowngaZyGFkG64QwfpxXtc2
	pGi7aSnqGLr2RdcbfWXLx5LvHWtBorFB2ljve6UlVe9DhniHsltB9FJldr5iYyIUp+r37H6kSSv
	I4aqox20HFUxTPnzCT3403BfkhngOvja13UcAXWd3Y5wPw5wbaNwq7vYVfz2IfyZ/G0s7e6IL56
	I9KK/HDv
X-Received: by 2002:a5d:6daf:0:b0:385:f79d:2196 with SMTP id ffacd0b85a97d-3861bb84f06mr161791f8f.13.1733332244557;
        Wed, 04 Dec 2024 09:10:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8gqG0x5z6r+CpCNJZYk6IwXVAInAa+0ev2uqKnvVIxSzQStTv5+56YC+HQsvFIshU1b8iHg==
X-Received: by 2002:a5d:6daf:0:b0:385:f79d:2196 with SMTP id ffacd0b85a97d-3861bb84f06mr161763f8f.13.1733332244246;
        Wed, 04 Dec 2024 09:10:44 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3860bbba038sm2179511f8f.24.2024.12.04.09.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:10:43 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [RFC PATCH 3/3] libata-sff: Simplify request of PCI resources
Date: Wed,  4 Dec 2024 18:10:34 +0100
Message-ID: <20241204171033.86804-5-pstanner@redhat.com>
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

pcim_iomap_regions() has been deprecated by the PCI subsystem.

Unfortunately, libata-sff uses quite complicated bit mask magic to
obtain its PCI resources.

Restructure and simplify the PCI resource request code.

Replace pcim_iomap_regions() with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/ata/libata-sff.c | 130 +++++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 46 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 67f277e1c3bf..1d2273c0f447 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2127,6 +2127,73 @@ static bool ata_resources_present(struct pci_dev *pdev, int port)
 	return true;
 }
 
+static void ata_pci_sff_set_ap_data(struct ata_port *ap, struct ata_host *host,
+		struct pci_dev *pdev, unsigned short base)
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
+/*
+ * ata_pci_sff_obtain_bars - obtain the PCI BARs associated with an ATA port
+ * @pdev: the PCI device
+ * @host: the ATA host
+ * @ap: the ATA port
+ * @port: @ap's port index in @host
+ *
+ * Returns: Number of successfully ioremaped BARs, a negative code on failure
+ */
+static int ata_pci_sff_obtain_bars(struct pci_dev *pdev, struct ata_host *host,
+		struct ata_port *ap, unsigned short port)
+{
+	int ret = 0, bars_mapped = 0;
+	unsigned short i, base;
+	void __iomem *io_tmp;
+	const char *name = dev_driver_string(&pdev->dev);
+
+	/*
+	 * Port can be 0 or 1.
+	 * Port 0 corresponds to PCI BARs 0 and 1, port 1 to BARs 2 and 3.
+	 */
+	base = port * 2;
+
+       /*
+	* Discard disabled ports. Some controllers show their unused channels
+	* this way. Disabled ports are made dummy.
+	*/
+	if (!ata_resources_present(pdev, port))
+		goto try_next;
+
+	for (i = 0; i < 2; i++) {
+		io_tmp = pcim_iomap_region(pdev, base + i, name);
+		ret = PTR_ERR_OR_ZERO(io_tmp);
+		if (ret != 0)
+			goto try_next;
+
+		bars_mapped++;
+	}
+
+	ata_pci_sff_set_ap_data(ap, host, pdev, base);
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
@@ -2148,59 +2215,31 @@ static bool ata_resources_present(struct pci_dev *pdev, int port)
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
+	if (operational_ports == 0)
 		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -3094,12 +3133,11 @@ void ata_pci_bmdma_init(struct ata_host *host)
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
-- 
2.47.0

