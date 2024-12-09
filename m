Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5823873D
	for <linux-ide@vger.kernel.org>; Mon,  9 Dec 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749632; cv=none; b=JaZqWcGUImsR4wJ0OFKYtjVJflnbHzJS5UzRbKGMsNya6Tzbu+N7HpMrmH5fnasWqIrh2ueECahTwR4bSKBHEy9+bUvJDQGOsvkmLTCCtz05+ZFJZOxas33faeePubX/UMN+GDlIjGThzZoTT8yi66k3JyVwvmZtYCAk8c2W8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749632; c=relaxed/simple;
	bh=wJE9vV/l3hdW8HDPZeW2FSJ+9CxTJ0aSSSqG6rS2R+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5KF9vlWwWzVbhf0aJuNeJt8dyBEoljDRUEX4xuBGVMnQGJRY95+IZqPBfSWFYWahQr0QcdoSwxiFH4AujwTtudRkv2Huqm7ZUy5pUnL/FrdCuUQAXTnrUvoU1Cl6MW0IljLOHy50M2+iyUZMklflVlQE7ElioonKxLuEvv5fbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/eZTrDE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/eZTrDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnuXTvhYTlwCBDrOS1s2G6F9Hq/4HeIeK8aJfi4Wc90=;
	b=h/eZTrDERO9I7rhSz6SseShkKpIQvCqbw6hZO1vbf6PuoVJMEYMcuGE+JmfMiDeiEnXxcc
	Mk4vqqbmuUgaECEkDLAR14616xGE5E9t18YV9ueGSgn80MBSafBpfZhTY1+zdDhrsPUoaX
	iwOJEwHVV/DHKmzdIjPAnCQZLbbCsc8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-eVPTx3OzOxCwRxDD8QLdvw-1; Mon, 09 Dec 2024 08:07:05 -0500
X-MC-Unique: eVPTx3OzOxCwRxDD8QLdvw-1
X-Mimecast-MFC-AGG-ID: eVPTx3OzOxCwRxDD8QLdvw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862c67763dso1832545f8f.3
        for <linux-ide@vger.kernel.org>; Mon, 09 Dec 2024 05:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749624; x=1734354424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnuXTvhYTlwCBDrOS1s2G6F9Hq/4HeIeK8aJfi4Wc90=;
        b=rAGeoXd/3u1NSHPZQ5iL8RWvCA68RpXS9xB2E4++bTRfopzFw0rjpVqu3egHPBZnmg
         i7IpwHcZwcAjtjSJ91/Ru5mftFb3Wkzkw7DHTl6S7ZT7drJBwzcdYEk0tRJZBLQQyxnR
         JKTmH2ib20Je3/tBOpFCiyMU/M94oB0ILt7YPELDS86y0ACw5ZaSWhum0a1EW5eEgwTA
         aiGkveDfZ3/KuS6EZevlVk5yYd/2VT/yTpFoxJ823P+gmv9cUusdsYC0ZR8YkIgC6aXf
         RXcAzydnp7uwGO3TzcysVrF5tAVHoF8E6ionVN9OXzjN2cxMCD9+wHONg2kAnPAhUr10
         lfcw==
X-Gm-Message-State: AOJu0YxK2WOwdg/uy5OJGTqKhzaI1KDtk7HOFURVGJcp4MWVqAdHGCUH
	sEeA3ROu2oezOLJIr79iiy+AtqXeoJilVNCyaqb/jb3P7k5B1iZUU9iy2OhEF2o3yZssxlcQmRy
	S/xxTwQn2PDof3RzRJd8kNC947L3KEv6XyPTt6BT1SrHa7xM7BxxdLUq8BA==
X-Gm-Gg: ASbGncu1GnwcB2xI7XBJhWxNGsichumxBUk8qEH6HVp2JEw6fzQOfgxTESemHhi+upV
	wPLalOZvgGgwK8zU2oJ+qHlpNrP6ZqQ5tJv5YaDMXFCbrzWm2eK/400N/Ql+NFPvT9gjM7V4foY
	GQ8EkqfR2IGAZXtOC8H1C/1veodrpZtBricVRoJKBiU7HNuJ/4mXyKOj2vKqFiiNUk5y68tkELG
	cQXwxfcGQOkMqMnOxplGzg92UOjnjm9H+5cZRqK/zymSXPr6f8WRUYWuNOztC1Y/h0v3YCAaS7d
	JB++8iAg
X-Received: by 2002:a05:6000:a07:b0:386:1ba1:37dc with SMTP id ffacd0b85a97d-3862b3d02a7mr10541534f8f.47.1733749624052;
        Mon, 09 Dec 2024 05:07:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED6lK+xP3ASai9pzso97+PoKUV4QmBIbg3KzJDkAOewaSmInet03lP+u9hg0Iot8N8fifU+Q==
X-Received: by 2002:a05:6000:a07:b0:386:1ba1:37dc with SMTP id ffacd0b85a97d-3862b3d02a7mr10541452f8f.47.1733749623572;
        Mon, 09 Dec 2024 05:07:03 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:07:03 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: amien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 08/11] ata: Use always-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:30 +0100
Message-ID: <20241209130632.132074-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209130632.132074-2-pstanner@redhat.com>
References: <20241209130632.132074-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

All users in ata enable their PCI-Device with pcim_enable_device(). Thus,
they need the always-managed version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Acked-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c       | 2 +-
 drivers/ata/ata_piix.c   | 2 +-
 drivers/ata/pata_rdc.c   | 2 +-
 drivers/ata/sata_sil24.c | 2 +-
 drivers/ata/sata_sis.c   | 2 +-
 drivers/ata/sata_uli.c   | 2 +-
 drivers/ata/sata_vsc.c   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8d27c567be1c..f813dbdc2346 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1987,7 +1987,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
 		/* legacy intx interrupts */
-		pci_intx(pdev, 1);
+		pcim_intx(pdev, 1);
 	}
 	hpriv->irq = pci_irq_vector(pdev, 0);
 
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 093b940bc953..d441246fa357 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1725,7 +1725,7 @@ static int piix_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * message-signalled interrupts currently).
 	 */
 	if (port_flags & PIIX_FLAG_CHECKINTR)
-		pci_intx(pdev, 1);
+		pcim_intx(pdev, 1);
 
 	if (piix_check_450nx_errata(pdev)) {
 		/* This writes into the master table but it does not
diff --git a/drivers/ata/pata_rdc.c b/drivers/ata/pata_rdc.c
index 0a9689862f71..09792aac7f9d 100644
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -340,7 +340,7 @@ static int rdc_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return rc;
 	host->private_data = hpriv;
 
-	pci_intx(pdev, 1);
+	pcim_intx(pdev, 1);
 
 	host->flags |= ATA_HOST_PARALLEL_SCAN;
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 72c03cbdaff4..b771ebd41252 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1317,7 +1317,7 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (sata_sil24_msi && !pci_enable_msi(pdev)) {
 		dev_info(&pdev->dev, "Using MSI\n");
-		pci_intx(pdev, 0);
+		pcim_intx(pdev, 0);
 	}
 
 	pci_set_master(pdev);
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index ef8724986de3..b8b6d9eff3b8 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -290,7 +290,7 @@ static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	pci_set_master(pdev);
-	pci_intx(pdev, 1);
+	pcim_intx(pdev, 1);
 	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &sis_sht);
 }
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 60ea45926cd1..52894ff49dcb 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -221,7 +221,7 @@ static int uli_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	pci_set_master(pdev);
-	pci_intx(pdev, 1);
+	pcim_intx(pdev, 1);
 	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &uli_sht);
 }
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index d39b87537168..a53a2dfc1e17 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -384,7 +384,7 @@ static int vsc_sata_init_one(struct pci_dev *pdev,
 		pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
 
 	if (pci_enable_msi(pdev) == 0)
-		pci_intx(pdev, 0);
+		pcim_intx(pdev, 0);
 
 	/*
 	 * Config offset 0x98 is "Extended Control and Status Register 0"
-- 
2.47.1

