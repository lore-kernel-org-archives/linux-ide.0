Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0441C01
	for <linux-ide@vger.kernel.org>; Tue, 14 Jan 2025 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736816626; cv=none; b=nAvTJp3uBSJk1UuZH5ULW55ve8cyJV/3kKyi3GpI39Io1UcmZqt6UVj/FaTZ+TNerl7d+ZtAQPjw1LlHGlA9kqvKq73PCz1sBxlwvIPfDJSMmurUFQUiXcX0CFTblRHSIDRgyWvUxh1B3H8J2ITrwXVg9IjsvH2ehaGJ7tb63Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736816626; c=relaxed/simple;
	bh=th3Ym4K3Gda4NapqKXpMg3QNjq5VNOzbWt/U8WFeSjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyR0Ah/4TxI0O17LAhiDUESaNXkhdDDifdtlQDXfwmrTfjgRU8e3uvuTNijceKP4skVegLsT7Vh9XS40pRg7Uhpyznef/YVkV1ewQLhtFSzIVJhYBd73fvUx90Eq9dYxJywNpilkgvGtSe+OIbLAgTnw5gDEIZI0cNhdHVfozDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPgKMFEY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPgKMFEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B57DC4CED6;
	Tue, 14 Jan 2025 01:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736816625;
	bh=th3Ym4K3Gda4NapqKXpMg3QNjq5VNOzbWt/U8WFeSjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZPgKMFEYKwyBhJobugCm0b3f3x+YjFJcrn0XB24smug2Yz05hLB51CJiAKoNS8D8y
	 L04AiMfbuXGCj5etzqj+L0KM9CBfdVY3xqpj1MZ8o2LQQKDToX5dMNmLt8DIQuiZeX
	 p0yUDmAqvpHla25bsROMTL5r0dMzKqyYVwbcc4y3iQQqrJkesAJe5cSKNGx6c9Jblz
	 u+PeJHkks1k7/PQaJ1fqJLqiswLa3hZYmRFCQjycUq2HfQik4qiEnodEgOyoKb37cO
	 6BC5f6v8WSzO3cTXf43hUrFET6AMO6clmXOm3vZ//0Qf/DFjy1kpSVGetVa2nmlAIS
	 ucGQUh05cGRTw==
Message-ID: <2826e5d0-e4d9-4aaf-aab6-4d36a9f2e73d@kernel.org>
Date: Tue, 14 Jan 2025 10:03:44 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] simplify init function
To: Tomas Henzl <thenzl@redhat.com>, linux-ide@vger.kernel.org
Cc: Niklas.Cassel@wdc.com
References: <20250113163401.35969-1-thenzl@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250113163401.35969-1-thenzl@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 01:34, Tomas Henzl wrote:
> by removing few lines. No functional change.

Looks OK to me, but:

The patch title should be: "ata: ahci: simplify init function"

And the commit message should also describe why it is OK to change
ahci_init_irq() to be a void function. Can you send a V3 with that addressed
please ?

> 
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
> ---
> V2: ahci_init_irq is now a void function
> 
>  drivers/ata/ahci.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 8d27c567be1c..3ea2f3adf354 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1665,13 +1665,15 @@ static int ahci_get_irq_vector(struct ata_host *host, int port)
>  	return pci_irq_vector(to_pci_dev(host->dev), port);
>  }
>  
> -static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
> +static void ahci_init_irq(struct pci_dev *pdev, unsigned int n_ports,
>  			struct ahci_host_priv *hpriv)
>  {
>  	int nvec;
>  
> -	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
> -		return -ENODEV;
> +	if (hpriv->flags & AHCI_HFLAG_NO_MSI) {
> +		pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
> +		return;
> +	}
>  
>  	/*
>  	 * If number of MSIs is less than number of ports then Sharing Last
> @@ -1685,7 +1687,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>  			if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
>  				hpriv->get_irq_vector = ahci_get_irq_vector;
>  				hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
> -				return nvec;
> +				return;
>  			}
>  
>  			/*
> @@ -1700,12 +1702,13 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>  
>  	/*
>  	 * If the host is not capable of supporting per-port vectors, fall
> -	 * back to single MSI before finally attempting single MSI-X.
> +	 * back to single MSI before finally attempting single MSI-X or
> +	 * a legacy INTx.
>  	 */
>  	nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
>  	if (nvec == 1)
> -		return nvec;
> -	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +		return;
> +	pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_INTX);
>  }
>  
>  static void ahci_mark_external_port(struct ata_port *ap)
> @@ -1985,10 +1988,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  	host->private_data = hpriv;
>  
> -	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
> -		/* legacy intx interrupts */
> -		pci_intx(pdev, 1);
> -	}
> +	ahci_init_irq(pdev, n_ports, hpriv);
> +
>  	hpriv->irq = pci_irq_vector(pdev, 0);
>  
>  	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)


-- 
Damien Le Moal
Western Digital Research
