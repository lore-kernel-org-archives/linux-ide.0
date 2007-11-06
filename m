From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pata_hpt37x: Fix outstanding bug reports on the HPT374
 and 37x cable detect
Date: Mon, 5 Nov 2007 18:42:45 -0800
Message-ID: <20071105184245.e45bc3b9.akpm@linux-foundation.org>
References: <20071105225338.20ef476f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43008 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754535AbXKFCnE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 21:43:04 -0500
In-Reply-To: <20071105225338.20ef476f@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Mon, 5 Nov 2007 22:53:38 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> +static u32 hpt374_read_freq(struct pci_dev *pdev)
> +{
> +	u32 freq;
> +	unsigned long io_base = pci_resource_start(pdev, 4);
> +	if (PCI_FUNC(pdev->devfn) & 1) {
> +		struct pci_dev *pdev_0 = pci_get_slot(pdev->bus, pdev->devfn - 1);
> +		/* Someone hot plugged the controller on us ? */
> +		if (pdev_0 == NULL)
> +			return 0;
> +		io_base = pci_resource_start(pdev_0, 4);
> +		freq = inl(io_base + 0x90);
> +		pci_dev_put(pdev_0);
> +	}
> +	else
> +		freq = inl(io_base + 0x90);
> +	return freq;
> +}

hm, pci_resource_start() returns a resource_size_t and I guess this (and a
heck of a lot of other) code is bust on (whatever machine we added that for).
