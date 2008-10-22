From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pci: use pci_ioremap_bar() in drivers/ide
Date: Thu, 23 Oct 2008 00:38:19 +0400
Message-ID: <48FF8F3B.1090302@ru.mvista.com>
References: <20081020214830.1586704c@infradead.org>	<48FDA8BF.20206@ru.mvista.com>	<48FF6595.5040203@ru.mvista.com> <20081022132346.38fbc84a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:50046 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753572AbYJVUij (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 16:38:39 -0400
In-Reply-To: <20081022132346.38fbc84a@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Arjan van de Ven wrote:

>>>>Use the newly introduced pci_ioremap_bar() function in drivers/ide.
>>>>pci_ioremap_bar() just takes a pci device and a bar number, with
>>>>the goal of making it really hard to get wrong, while also having
>>>>a central place to stick sanity checks.

>>>>Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

>>>Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>    No, I'm takign back my ACK.
>>    Since the patch intends to address all drivers/ide/, it's clearly
>>no compolete -- siimage.c and scc_pata.c beg for the alike change (it
>>will even permit to kill 4 local variables in the latter driver).

> like this ?

    Exactly.

> From 3f88a6936f7802a5d4af6c54a1ef353d14ff1ab2 Mon Sep 17 00:00:00 2001
> From: Arjan van de Ven <arjan@linux.intel.com>
> Date: Wed, 22 Oct 2008 13:21:07 -0700
> Subject: [PATCH] ide: two more pci_ioremap_bar() conversions

> based on suggestion from Sergei Shtylyov, there are two more places
> where using pci_ioremap_bar() makes sense.

> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/drivers/ide/pci/scc_pata.c b/drivers/ide/pci/scc_pata.c
> index 9ce1d80..b4be295 100644
> --- a/drivers/ide/pci/scc_pata.c
> +++ b/drivers/ide/pci/scc_pata.c
[...]
> @@ -557,10 +553,12 @@ static int setup_mmio_scc (struct pci_dev *dev, const char *name)
>  		return ret;
>  	}
>  
> -	if ((ctl_addr = ioremap(ctl_base, ctl_size)) == NULL)
> +	ctl_addr = pci_ioremap_bar(dev, 0);
> +	if (!ctl_addr)
>  		goto fail_0;
>  
> -	if ((dma_addr = ioremap(dma_base, dma_size)) == NULL)
> +	dma_addr = pci_ioremap_bar(dev, 1);
> +	if (!dma_addr)
>  		goto fail_1;
>  
>  	pci_set_master(dev);

    An added bonus here is fixing couple checkpatch.pl's warnings.
    There were 22 errors and 18 warnings total before this patch. :-)

MBR, Sergei
