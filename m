From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 3/3] AHCI: Add generic MSI-X interrupt support to SATA
 PCI driver
Date: Wed, 3 Jun 2015 14:44:22 +0900
Message-ID: <20150603054422.GD20091@mtj.duckdns.org>
References: <1433073319-13796-1-git-send-email-rric@kernel.org>
 <1433073319-13796-4-git-send-email-rric@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35815 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbbFCFod (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jun 2015 01:44:33 -0400
Content-Disposition: inline
In-Reply-To: <1433073319-13796-4-git-send-email-rric@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <rric@kernel.org>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>

Hello, Robert.

Maybe qualifying the subject that it's only for single IRQ would be a
good idea?

> @@ -52,6 +53,7 @@
>  
>  enum {
>  	AHCI_PCI_BAR_STA2X11	= 0,
> +	AHCI_PCI_BAR_CAVIUM	= 0,
>  	AHCI_PCI_BAR_ENMOTUS	= 2,
>  	AHCI_PCI_BAR_STANDARD	= 5,

I thought I already asked but please separate out CAVIUM specific
changes from msix implementation and follow up with why cavium depends
on msix support.

> +static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
> +			  struct ahci_host_priv *hpriv)
> +{

Please add a comment describing that it's for single msix only and why
that'd be necessary for certain controllers.

...
> +	/*
> +	 * Per-port msix interrupts are not supported. Assume single
> +	 * port interrupts for:
> +	 *
> +	 *  n_ports == 1, or
> +	 *  nvec < n_ports.
> +	 *
> +	 * We also need to check for n_ports != 0 which is implicitly
> +	 * covered here since nvec > 0.
> +	 */
> +	if (n_ports != 1 && nvec >= n_ports) {
> +		rc = -ENOSYS;
> +		goto fail;
> +	}

Didn't I ask this one too the last time?  Can you explain why we can't
initialize single IRQ mode if nvec >= n_ports?

> @@ -1260,6 +1339,10 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
>  	if (nvec >= 0)
>  		return nvec;
>  
> +	nvec = ahci_init_msix(pdev, n_ports, hpriv);
> +	if (nvec >= 0)
> +		return nvec;

Please add a comment explaining why we're doing msix after msi.

Thanks.

-- 
tejun
