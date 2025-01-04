Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2851E507
	for <linux-ide@vger.kernel.org>; Sat,  4 Jan 2025 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735979575; cv=none; b=WMDU7t+bUko2/wbL6fsLZ4H8TJJ3CCy5xnySFw80XUsWrgujFq39nvvJs7OUyyLztQzSIiRopDTj9NwVLxJk+qD+46bppBDg9kOwZqfb8yHg9V541agKa7nCaeG+J2avCdzxYiAufUx4uc3RB+EyBHzu3ybBiPuWsTBzXmOFd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735979575; c=relaxed/simple;
	bh=Mt6HRdzXNpGb9KkUxUL5n2IIJvuZoM0M+cDuu8ufMMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B6pm2wccgXMEtkOIzl2H7kuxktgYpxbNDnERnEH4ARc2OdRoXjaytSSbvSUl3EWf7TsU+Fj1GePsTxloLwJldPdcY8CTDEUE8N3Ek1MugrQRB2QrEOopce7Vy9WZZuUsG934CBI9Qh/H4tq3E+IkjieTEDatYE6kVa1Igkx82IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX8Pu+zv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX8Pu+zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AB5C4CED1;
	Sat,  4 Jan 2025 08:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735979575;
	bh=Mt6HRdzXNpGb9KkUxUL5n2IIJvuZoM0M+cDuu8ufMMI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WX8Pu+zve8ooCfloQLp80xldvWLQT7v8nhtiyFyxNBM6NxWkAf1OKlLFObbdfGodR
	 w0F5J+teyXuy2ywTNt4ICjuTxpI5yE9joX8v/udWDgV2IuMxXjN4EOglb7cpy8trYi
	 ddoI730seJmCsBjOb920BO7l4HA0G88AdLuQIZDgcR8i+uquBmQP0Ex1S6XJdDVfJ5
	 3J0Go1V+9YdkepLsrKdNzy3aH/49Xk/4NTFkNw+OORbtVD9P/pYq6FV8Jk62gXPpab
	 ppLB9EYkOqKTNfoS0934nE0os+nLHT6qqPr3ylszPltF8a2xQmLFFf9lWUdcHW/Aow
	 WwVhT2uUzhCKw==
Message-ID: <70664fc3-90ef-4d29-9efb-f1cf9e1a507e@kernel.org>
Date: Sat, 4 Jan 2025 17:32:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: simplify init function
To: Tomas Henzl <thenzl@redhat.com>, linux-ide@vger.kernel.org,
 Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20241230121548.11911-1-thenzl@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241230121548.11911-1-thenzl@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/30/24 21:15, Tomas Henzl wrote:
> by removing few lines. No functional change.
> 
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>

Please send patches to the maintainers as well.

> ---
>  drivers/ata/ahci.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 8d27c567be1c..66c19039449d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1665,7 +1665,7 @@ static int ahci_get_irq_vector(struct ata_host *host, int port)
>  	return pci_irq_vector(to_pci_dev(host->dev), port);
>  }
>  
> -static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
> +static int ahci_init_irq(struct pci_dev *pdev, unsigned int n_ports,
>  			struct ahci_host_priv *hpriv)
>  {
>  	int nvec;
> @@ -1700,12 +1700,13 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>  
>  	/*
>  	 * If the host is not capable of supporting per-port vectors, fall
> -	 * back to single MSI before finally attempting single MSI-X.
> +	 * back to single MSI before finally attempting single MSI-X or
> +	 * a legacy INTx.
>  	 */
>  	nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
>  	if (nvec == 1)
>  		return nvec;
> -	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_INTX);
>  }
>  
>  static void ahci_mark_external_port(struct ata_port *ap)
> @@ -1985,10 +1986,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  	host->private_data = hpriv;
>  
> -	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
> -		/* legacy intx interrupts */
> -		pci_intx(pdev, 1);
> -	}
> +	ahci_init_irq(pdev, n_ports, hpriv);

I think this needs error return check, unless we are guaranteed that
pci_alloc_irq_vectors() always return success when PCI_IRQ_INTX is set. If that
is the case, we can make ahci_init_irq() a void function. Please check.

>  	hpriv->irq = pci_irq_vector(pdev, 0);
>  
>  	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)


-- 
Damien Le Moal
Western Digital Research
