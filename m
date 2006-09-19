From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 17/20] libata: make ata_pci_acquire_resources() handle
 iomap
Date: Tue, 19 Sep 2006 01:47:29 -0400
Message-ID: <450F8471.4020004@pobox.com>
References: <11559779733267-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:1696 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750712AbWISFrl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 01:47:41 -0400
In-Reply-To: <11559779733267-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> @@ -181,6 +183,28 @@ int ata_pci_acquire_resources(struct ata
>  	if (rc)
>  		goto err;
>  
> +	/* iomap PCI BARs */
> +	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +		if (!(bar_mask & (1 << i)))
> +			continue;
> +
> +		WARN_ON(iomap[i]);
> +
> +		if (!pci_resource_start(pdev, i) ||
> +		    !pci_resource_len(pdev, i)) {
> +			reason = "iomap requested for null PCI BAR";
> +			rc = -EIO;
> +			goto err;
> +		}
> +
> +		iomap[i] = pci_iomap(pdev, i, 0);
> +		if (!iomap[i]) {
> +			rc = -ENOMEM;
> +			reason = "failed to iomap PCI BAR";
> +			goto err;
> +		}
> +	}
> +
>  	return 0;
>  
>   err:
> @@ -202,6 +226,14 @@ int ata_pci_acquire_resources(struct ata
>  void ata_pci_release_resources(struct ata_host *host)
>  {
>  	struct pci_dev *pdev = to_pci_dev(host->dev);
> +	void __iomem **iomap = host->iomap;
> +	int i;
> +
> +	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
> +		if (iomap[i]) {
> +			pci_iounmap(pdev, iomap[i]);
> +			iomap[i] = NULL;
> +		}
>  


NAK, you only should map the stuff you are going to use.

Mapped resources is finite, and you definitely don't want to map certain 
resources on certain controllers -- sometimes they are a memory area 
that's too large to be mapped, even.

