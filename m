Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A122DFBC
	for <linux-ide@vger.kernel.org>; Wed, 15 Jan 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908203; cv=none; b=U60/LL6/Diiw/1PR2xVGd8EgqLfpqLAv0gYZ67Ko2IUO6lnE64LmLLYIcn8o1+lxvQstCfr/Ba6svn/iD8PBOt9aTlzv9TFfekuHnTneLq4JcuswusklYGBD6crm1FgeOEnGldF5pC+IwwTBUymJ/DwXWKus2tHmJib3F9Cahos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908203; c=relaxed/simple;
	bh=hDtidHG2klDA+GHJV7uxRQsGYJylJGa+fqYRLBGwfs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg5XQzsAtjBVhMZpzWlGP/OJoVs9inr3NfEM0rBG0juwZrM3UaJ432/1DYEQxFBGCW4q9SJDsg1zS0wVGET3+4QX2PkNOc7KI+rES1Z7QTEX02fShN8R3Y+4aBXJxs+UlOjhPOCaQPn/sJ19DZVO92ec3icIIknGc7IZZaULBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJrtRQ5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJrtRQ5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3D9C4CEDD;
	Wed, 15 Jan 2025 02:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736908202;
	bh=hDtidHG2klDA+GHJV7uxRQsGYJylJGa+fqYRLBGwfs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EJrtRQ5m4vIfpXHxxMOmDeyn6XVM7jsSNH7YVWzzotkxT9T02UIZJr2Lfs/xUzK5z
	 CLqYWC2ZXtLkDSB60MXof86/xrMu5Khr9Emrk/hmDtBc+IiLAayXj1r6EGDFltIlkc
	 M2bfZHbdzieFmU3NfLyKO5bO/s0mC5dNVJkgf31Vox1Pg2Lji5/qodCFBHusBITnS5
	 FanmkOIiWh1Ie7CM9+rCjuJM2/F8sLQ/IJoEP1S5qdFGxBtw7oFK++2K0jXHdDpTIL
	 vJA0fm0VffZfl4YTDldigjmN/Q4UHWDzD5OmUbML4ulQmXLVMHe7Wmslg95Dew+FJo
	 P0hK0D5Y9kymQ==
Message-ID: <0e2a0f69-7b98-4b48-8a68-6a554cbbec09@kernel.org>
Date: Wed, 15 Jan 2025 11:30:01 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] ata: ahci: simplify init function
To: Tomas Henzl <thenzl@redhat.com>, linux-ide@vger.kernel.org
Cc: Niklas.Cassel@wdc.com
References: <20250114182956.40923-1-thenzl@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250114182956.40923-1-thenzl@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 03:29, Tomas Henzl wrote:
> by removing few lines. No functional change.
> 
> The main part of this change is done by adding a PCI_IRQ_INTX flag into
> an already existing pci_alloc_irq_vectors invocation.
> In the current implementation of the pci_alloc_irq_vectors is the sequence of calls
> msi-x -> msi -> legacy irq and whatever there succeeds stops the
> call chain. That makes it impossible to merge all instances into as a single call
> to pci_alloc_irq_vectors since the order of calls there is:
> multiple msi-x
> a single msi
> a single msi-x
> a legacy irq.
> but the two last steps can be merged into one which are the msi-x and legacy
> irq option. With this change we remove a pci(m)_intx call.
> When PCI_IRQ_INTX flag is set the pci_alloc_irq_vectors succeeds in almost
> all cases - that makes it possible to convert ahci_init_irq(msi) into a void function.
> The exception is when dev->irq is zero then the pci_alloc_irq_vectors
> may return with an error code also pci_intx isn't called from  pci_alloc_irq_vectors
> and thus certain pci calls aren't performed.
> That's just a negligible issue as later in ahci_init_one the (zero)
> value of dev->irq is via pci_irq_vector assigned to hpriv->irq.
> That value is then later tested in ahci_host_activate->ata_host_activate where
> it is welcomed with a WARN_ON message and fails with setting up irq and
> then the probe function (ahci_init_one) fails. The special zero value's
> meaning is that polling mode is being be set up which isn't the case.
> 

Extra blank line not need here.

Beside that, looks OK now. But as Niklas pointed out, this conflicts with a
patch in the PCI tree. And given that it is too late to queue that for 6.14, can
you resend a rebased version once 6.14-rc1 is out in a couple of weeks ?

Thanks !

> 
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
> ---
> V2: ahci_init_irq is now a void function
> V3: a) added an explanation of why we may convert ahci_init_irq into
> 	a void function
>     b) fixed the subject line
>     c) added an explanation of why calling pci_alloc_irq_vectors instead
> 	of pci_intx is safe
>     d) rebased to latest code state (pci_intx->pcim_intx)
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
> -		pcim_intx(pdev, 1);
> -	}
> +	ahci_init_irq(pdev, n_ports, hpriv);
> +
>  	hpriv->irq = pci_irq_vector(pdev, 0);
>  
>  	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)


-- 
Damien Le Moal
Western Digital Research
