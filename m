From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata-dev-2.6-ncq: ahci: remove ata_port_start/stop() calls
Date: Sun, 26 Jun 2005 23:52:50 +0900
Message-ID: <20050626145250.GF24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:34200 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261299AbVFZOw6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 10:52:58 -0400
Received: by zproxy.gmail.com with SMTP id l1so94311nzf
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 07:52:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, linux-ide@vger.kernel.org

 Hello, Jeff.
 Hello, Jens.

 This is the last of six misc updates to ncq.

 This patch removes unnecessary ata_port_start/stop() calls from
ahci_port_start/stop().

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-06-26 18:11:27.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-06-26 18:13:17.000000000 +0900
@@ -307,26 +307,19 @@ static int ahci_port_start(struct ata_po
 	struct device *dev = ap->host_set->dev;
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
 	struct ahci_port_priv *pp;
-	int rc;
 	void *mem, *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
 	dma_addr_t mem_dma;
 
-	rc = ata_port_start(ap);
-	if (rc)
-		return rc;
-
 	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
-	if (!pp) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
+	if (!pp)
+		return -ENOMEM;
 	memset(pp, 0, sizeof(*pp));
 
 	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
 	if (!mem) {
-		rc = -ENOMEM;
-		goto err_out_kfree;
+		kfree(pp);
+		return -ENOMEM;
 	}
 	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
 
@@ -373,12 +366,6 @@ static int ahci_port_start(struct ata_po
 	readl(port_mmio + PORT_CMD); /* flush */
 
 	return 0;
-
-err_out_kfree:
-	kfree(pp);
-err_out:
-	ata_port_stop(ap);
-	return rc;
 }
 
 
@@ -404,7 +391,6 @@ static void ahci_port_stop(struct ata_po
 	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
 			  pp->cmd_slot, pp->cmd_slot_dma);
 	kfree(pp);
-	ata_port_stop(ap);
 }
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)

