From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Boot failure due to some interaction between per-port MSI-X and
 Intel RST
Date: Sun, 3 Sep 2017 23:16:34 -0700
Message-ID: <20170904061634.GA16590@infradead.org>
References: <fc6edbd0-d720-4112-550c-fbed78ee8b32@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdIDGQe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Sep 2017 02:16:34 -0400
Content-Disposition: inline
In-Reply-To: <fc6edbd0-d720-4112-550c-fbed78ee8b32@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Loy <john.robert.loy@gmail.com>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

On Sun, Sep 03, 2017 at 06:42:35PM -0700, John Loy wrote:
> I have a system that stopped booting Linux between kernel versions 4.4.9 and
> 4.5.3.  It has a SATA + NVMe accelerated volume that I use with Windows and
> a separate SATA drive with my Linux installation.  I'm not expecting the
> remapped NVMe thing to be accessible, just the Linux disk, but none of the
> drives are accessible.
> 
> Bisecting the changes turned up d684a90 as the first failing change. Passing
> pci=nomsi also allows the system to boot newer kernels.  Just to be sure, I
> built a recent kernel (4.12.9) with the PCI_IRQ_MSIX flag removed from the
> per-port call to pci_alloc_irq_vectors in ahci_init_msi.  This also allowed
> the system to boot normally.
> 
> I'm totally out of my depth though so I'd really appreciate it if anyone has
> some ideas on how to proceed with a proper fix.

Something like the patch below should work.  Maybe Intel can provide
an explanation on why their chipset is so fucked up that we can add
as a comment.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5a5fd0b404eb..b8c8ecc854c4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1470,6 +1470,7 @@ static void ahci_remap_check(struct pci_dev *pdev, int bar,
 
 	dev_warn(&pdev->dev, "Found %d remapped NVMe devices.\n", count);
 	dev_warn(&pdev->dev, "Switch your BIOS from RAID to AHCI mode to use them.\n");
+	hpriv->flags |= AHCI_HFLAG_NO_MSI;
 }
 
 static int ahci_get_irq_vector(struct ata_host *host, int port)
