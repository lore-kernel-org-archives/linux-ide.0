Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAF22FE18
	for <linux-ide@vger.kernel.org>; Tue, 14 Jan 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736845254; cv=none; b=dekXlPhgDGkPsvjrBPJGS13d8ihCFbbwR7wPGVaykEhfV9Z/A3X0dBSDS2fBkQsaOLMutAbc0L8wqwvq5e96sPlWoM2EsPQdVngBhKDdWLB1WdPN4h+O79c6eu0pYBE5b7SxQdK6CfrUkoTPyLN4w5+UxVRZU0henaX04mmdR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736845254; c=relaxed/simple;
	bh=7HQK5yFAGEnks1m2a50Y+ywFUJ172CJwZx1xZL23Lco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARSoi+p8iXnMc+FYxiXizEw0tPCHnUY7twDOcrETZ7pnmqZU0BlvqpCXpGN7LpjyEL2TyVle/B+uGSppiNFQ/ADEAiQcFEk8IW3pVx2h0cs6aslOLIJIq0Ctv+YUr/ywvwUC2MRsE/d54n8MasoSnV223lcVbPUYyXskB4sOh7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZsCRoO8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZsCRoO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29461C4CEDD;
	Tue, 14 Jan 2025 09:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736845254;
	bh=7HQK5yFAGEnks1m2a50Y+ywFUJ172CJwZx1xZL23Lco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZsCRoO84fq8QCS0m0LHa4Datyf/fbi3w7eLiVYYZK33ZD1Qv7YvNqUozPIzLBRJb
	 Pt6y6Qsb9ka5oXvw0DY7S4JLfCbblBjzXlcLloNrfCIropo3/gsN8UjLWwKoUA46aD
	 IY1V5ccFknFsxcCAd2It/wdBJ8y96QjePNNINJHJwPvvrqHsE8jdhbP49F9ejXYfa6
	 C2fa8MT42d4JLb4V+WZj01Tcg8LxeeRUIRCJw1pEO6nsK0kT1ukzn+DerOwAexnysG
	 fsMp4GhWYiGx0+SLt1Ti9es1I+WD0hSPSRMOPaWQ3rRBLYnp6ff7oZITL+WW9Ty5BK
	 Kx0V1pU+dJTqA==
Date: Tue, 14 Jan 2025 10:00:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Tomas Henzl <thenzl@redhat.com>, linux-ide@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: Re: [PATCH V2] simplify init function
Message-ID: <Z4Ynwp0WNjMQ4a5R@ryzen>
References: <20250113163401.35969-1-thenzl@redhat.com>
 <2826e5d0-e4d9-4aaf-aab6-4d36a9f2e73d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2826e5d0-e4d9-4aaf-aab6-4d36a9f2e73d@kernel.org>

On Tue, Jan 14, 2025 at 10:03:44AM +0900, Damien Le Moal wrote:
> On 1/14/25 01:34, Tomas Henzl wrote:
> > by removing few lines. No functional change.
> 
> Looks OK to me, but:
> 
> The patch title should be: "ata: ahci: simplify init function"
> 
> And the commit message should also describe why it is OK to change
> ahci_init_irq() to be a void function. Can you send a V3 with that addressed
> please ?

I assume that this simplification is possible because sending in flags
(PCI_IRQ_MSIX | PCI_IRQ_INTX) to pci_alloc_irq_vectors() guarantees that
it will first try to allocate MSIX, if so, that should have be mentioned
in the commit message.



Also, you are just replacing pci_intx() with
pci_alloc_irq_vectors(.., PCI_IRQ_INTX), is this always safe?
If so, it should have been mentioned in the commit message.

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), Philip has written
patches that ports users to either an always-managed or a never-managed
version.

A libata patch for this is currently queued via the PCI tree (pci/next),
see linux-next:
https://lore.kernel.org/linux-ide/Z1vFWyHkBD4d5xnG@ryzen/T/#mc20794f1e8712dafe77bc64c8da44c4d9b227b28
https://lore.kernel.org/linux-ide/Z1vFWyHkBD4d5xnG@ryzen/T/#m3a42ac564d97d10f8b1924c675efd144c845f8d5

Your patch conflicts with his series, which is already queued.


Kind regards,
Niklas


> 
> > 
> > Signed-off-by: Tomas Henzl <thenzl@redhat.com>
> > ---
> > V2: ahci_init_irq is now a void function
> > 
> >  drivers/ata/ahci.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index 8d27c567be1c..3ea2f3adf354 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -1665,13 +1665,15 @@ static int ahci_get_irq_vector(struct ata_host *host, int port)
> >  	return pci_irq_vector(to_pci_dev(host->dev), port);
> >  }
> >  
> > -static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
> > +static void ahci_init_irq(struct pci_dev *pdev, unsigned int n_ports,
> >  			struct ahci_host_priv *hpriv)
> >  {
> >  	int nvec;
> >  
> > -	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
> > -		return -ENODEV;
> > +	if (hpriv->flags & AHCI_HFLAG_NO_MSI) {
> > +		pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
> > +		return;
> > +	}
> >  
> >  	/*
> >  	 * If number of MSIs is less than number of ports then Sharing Last
> > @@ -1685,7 +1687,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
> >  			if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
> >  				hpriv->get_irq_vector = ahci_get_irq_vector;
> >  				hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
> > -				return nvec;
> > +				return;
> >  			}
> >  
> >  			/*
> > @@ -1700,12 +1702,13 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
> >  
> >  	/*
> >  	 * If the host is not capable of supporting per-port vectors, fall
> > -	 * back to single MSI before finally attempting single MSI-X.
> > +	 * back to single MSI before finally attempting single MSI-X or
> > +	 * a legacy INTx.
> >  	 */
> >  	nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> >  	if (nvec == 1)
> > -		return nvec;
> > -	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> > +		return;
> > +	pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_INTX);
> >  }
> >  
> >  static void ahci_mark_external_port(struct ata_port *ap)
> > @@ -1985,10 +1988,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  	}
> >  	host->private_data = hpriv;
> >  
> > -	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
> > -		/* legacy intx interrupts */
> > -		pci_intx(pdev, 1);
> > -	}
> > +	ahci_init_irq(pdev, n_ports, hpriv);
> > +
> >  	hpriv->irq = pci_irq_vector(pdev, 0);
> >  
> >  	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
