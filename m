From: Robert Richter <robert.richter@cavium.com>
Subject: Re: [PATCH] ahci: use pci_alloc_irq_vectors
Date: Tue, 25 Oct 2016 11:25:31 +0200
Message-ID: <20161025092531.GG2151@rric.localdomain>
References: <1473088905-27670-1-git-send-email-hch@lst.de>
 <1473088905-27670-2-git-send-email-hch@lst.de>
 <20160906163946.GB24268@htj.duckdns.org>
 <20161020154722.GH22012@rric.localdomain>
 <20161021125918.GA18082@lst.de>
 <20161021140106.GU25086@rric.localdomain>
 <20161022141123.GA25500@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:27136
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757228AbcJYJZv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 25 Oct 2016 05:25:51 -0400
Content-Disposition: inline
In-Reply-To: <20161022141123.GA25500@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Robert Richter <rric@kernel.org>, Auger Eric <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-ide@vger.kernel.org, dan.j.williamps@intel.com, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org

On 22.10.16 16:11:23, Christoph Hellwig wrote:
> Hi Robert,
> 
> is this a controller that's using MSI-X?
> 
> If so can you try the patch below?

Great, that fixes the issue. Thanks.

Tested-by: Robert Richter <rrichter@cavium.com>

> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ba5f11c..5fe852d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1617,7 +1617,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		/* legacy intx interrupts */
>  		pci_intx(pdev, 1);
>  	}
> -	hpriv->irq = pdev->irq;
> +	hpriv->irq = pci_irq_vector(pdev, 0);
>  
>  	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>  		host->flags |= ATA_HOST_PARALLEL_SCAN;
