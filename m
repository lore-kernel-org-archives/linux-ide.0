From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ahci: use pci_alloc_irq_vectors
Date: Sat, 22 Oct 2016 16:11:23 +0200
Message-ID: <20161022141123.GA25500@lst.de>
References: <1473088905-27670-1-git-send-email-hch@lst.de> <1473088905-27670-2-git-send-email-hch@lst.de> <20160906163946.GB24268@htj.duckdns.org> <20161020154722.GH22012@rric.localdomain> <20161021125918.GA18082@lst.de> <20161021140106.GU25086@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56828 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934258AbcJVOL0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 22 Oct 2016 10:11:26 -0400
Content-Disposition: inline
In-Reply-To: <20161021140106.GU25086@rric.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <rric@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robert Richter <robert.richter@cavium.com>, Auger Eric <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-ide@vger.kernel.org, dan.j.williamps@intel.com, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org

Hi Robert,

is this a controller that's using MSI-X?

If so can you try the patch below?

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ba5f11c..5fe852d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1617,7 +1617,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		/* legacy intx interrupts */
 		pci_intx(pdev, 1);
 	}
-	hpriv->irq = pdev->irq;
+	hpriv->irq = pci_irq_vector(pdev, 0);
 
 	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
 		host->flags |= ATA_HOST_PARALLEL_SCAN;
