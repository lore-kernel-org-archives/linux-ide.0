From: Francois Romieu <romieu@fr.zoreil.com>
Subject: [PATCH 2.6.9-rc1] sata_nv: really fix leak
Date: Tue, 24 Aug 2004 23:56:57 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040824215657.GA13332@electric-eye.fr.zoreil.com>
References: <200408222016.i7MKGe62011677@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:55704 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S268407AbUHXV5y
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Aug 2004 17:57:54 -0400
Content-Disposition: inline
In-Reply-To: <200408222016.i7MKGe62011677@hera.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: Andrew Chew <achew@nvidia.com>, linux-ide@vger.kernel.org

- each label used in a goto contains a part of the operation that must
  be issued. This way both the no-error and the error paths can be checked
  separately;
- ioremap() failure did not jump on the adequate label;
- host was never freed if a late error heppened;
- use an adequate status code when ioremap() fails;
- probe_ent does not need to be NULL-initialized;
- enable_hotplug() is issued after everything else has succeeded.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/scsi/sata_nv.c~sata_nv-fix-leak-really drivers/scsi/sata_nv.c
--- linux-2.6.9-rc1/drivers/scsi/sata_nv.c~sata_nv-fix-leak-really	2004-08-24 23:22:44.000000000 +0200
+++ linux-2.6.9-rc1-fr/drivers/scsi/sata_nv.c	2004-08-24 23:38:20.000000000 +0200
@@ -295,38 +295,37 @@ static int nv_init_one (struct pci_dev *
 {
 	static int printed_version = 0;
 	struct nv_host *host;
-	struct ata_probe_ent *probe_ent = NULL;
+	struct ata_probe_ent *probe_ent;
 	int rc;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
-	if (rc)
-		return rc;
+	if (rc < 0)
+		goto err_out;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
-		goto err_out;
+	if (rc < 0)
+		goto err_out_disable_device;
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		goto err_out_regions;
+	if (rc < 0)
+		goto err_out_release_regions;
+
 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		goto err_out_regions;
+	if (rc < 0)
+		goto err_out_release_regions;
+
+	rc = -ENOMEM;
 
 	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (!probe_ent) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
+	if (!probe_ent)
+		goto err_out_release_regions;
 
 	host = kmalloc(sizeof(struct nv_host), GFP_KERNEL);
-	if (!host) {
-		rc = -ENOMEM;
+	if (!host)
 		goto err_out_free_ent;
-	}
 
 	host->host_desc = &nv_device_tbl[ent->driver_data];
 
@@ -371,8 +370,10 @@ static int nv_init_one (struct pci_dev *
 
 		probe_ent->mmio_base = ioremap(pci_resource_start(pdev, 5),
 				pci_resource_len(pdev, 5));
-		if (probe_ent->mmio_base == NULL)
-			goto err_out_iounmap;
+		if (probe_ent->mmio_base == NULL) {
+			rc = -EIO;
+			goto err_out_free_host;
+		}
 
 		base = (unsigned long)probe_ent->mmio_base;
 
@@ -390,14 +391,14 @@ static int nv_init_one (struct pci_dev *
 
 	pci_set_master(pdev);
 
-	// Enable hotplug event interrupts.
-	if (host->host_desc->enable_hotplug)
-		host->host_desc->enable_hotplug(probe_ent);
-
 	rc = ata_device_add(probe_ent);
 	if (rc != NV_PORTS)
 		goto err_out_iounmap;
 
+	// Enable hotplug event interrupts.
+	if (host->host_desc->enable_hotplug)
+		host->host_desc->enable_hotplug(probe_ent);
+
 	kfree(probe_ent);
 
 	return 0;
@@ -405,15 +406,15 @@ static int nv_init_one (struct pci_dev *
 err_out_iounmap:
 	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
 		iounmap(probe_ent->mmio_base);
-
+err_out_free_host:
+	kfree(host);
 err_out_free_ent:
 	kfree(probe_ent);
-
-err_out_regions:
+err_out_release_regions:
 	pci_release_regions(pdev);
-
-err_out:
+err_out_disable_device:
 	pci_disable_device(pdev);
+err_out:
 	return rc;
 }
 

_
