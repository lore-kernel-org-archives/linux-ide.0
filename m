From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH] ahci: use pci_alloc_irq_vectors
Date: Mon, 24 Oct 2016 11:57:46 -0700
Message-ID: <580E59AA.60107@gmail.com>
References: <1473088905-27670-1-git-send-email-hch@lst.de> <1473088905-27670-2-git-send-email-hch@lst.de> <20160906163946.GB24268@htj.duckdns.org> <20161020154722.GH22012@rric.localdomain> <20161021125918.GA18082@lst.de> <20161021140106.GU25086@rric.localdomain> <20161022141123.GA25500@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36136 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934626AbcJXS5t (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2016 14:57:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id r16so17236049pfg.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2016 11:57:48 -0700 (PDT)
In-Reply-To: <20161022141123.GA25500@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Robert Richter <rric@kernel.org>, linux-ide@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Auger Eric <eric.auger@redhat.com>, Robert Richter <robert.richter@cavium.com>, dan.j.williamps@intel.com, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org

Hi Christoph,

I can answer these...

On 10/22/2016 07:11 AM, Christoph Hellwig wrote:
> Hi Robert,
>
> is this a controller that's using MSI-X?

Yes.  This is a ThunderX SoC with on-chip AHCI that use MSI-X

>
> If so can you try the patch below?

I applied it to v4.9-rc1 (really commit 
6f33d6458e35d6ba53c2635ee4b8a3177cbd912d), and this didn't seem to make 
it work.



>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ba5f11c..5fe852d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1617,7 +1617,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		/* legacy intx interrupts */
>   		pci_intx(pdev, 1);
>   	}
> -	hpriv->irq = pdev->irq;
> +	hpriv->irq = pci_irq_vector(pdev, 0);
>
>   	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>   		host->flags |= ATA_HOST_PARALLEL_SCAN;
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

