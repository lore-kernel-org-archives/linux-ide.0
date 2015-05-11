From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
Date: Mon, 11 May 2015 19:18:10 +0200
Message-ID: <20150511171810.GB29499@rric.localhost>
References: <1430725538-22162-1-git-send-email-rric@kernel.org>
 <20150504160652.GB1971@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150504160652.GB1971@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Richter <rric@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alexander Gordeev <agordeev@redhat.com>
List-Id: linux-ide@vger.kernel.org

Tejun,

thanks for your review and answer.

On 04.05.15 12:06:52, Tejun Heo wrote:
> > This patch also enables AHCI for Cavium Thunder SoCs that uses MSI-X.
>
> Please don't mix these two changes in the same patch.

I will split the patch.

> > +   /* per-port msix interrupts are not supported */
> > +   if (n_ports > 1 && nvec >= n_ports)
> > +           return -ENOSYS;
>
> Hmm... can you please elaborate why the condition isn't nvec > 1?

I slightly changed the check and added a comment that explains that's
going on in the function. This is the new version:

static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
			  struct ahci_host_priv *hpriv)
{
	int rc, nvec;
	struct msix_entry entry = {};

	/* check if msix is supported */
	nvec = pci_msix_vec_count(pdev);
	if (nvec <= 0)
		return 0;

	/*
	 * Per-port msix interrupts are not supported. Assume single
	 * port interrupts for:
	 *
	 *  n_ports == 1, or
	 *  nvec < n_ports.
	 *
	 * We also need to check for n_ports != 0 which is implicitly
	 * covered here since nvec > 0.
	 */
	if (n_ports != 1 && nvec >= n_ports)
		return -ENOSYS;

	/*
	 * There can exist more than one vector (e.g. for error
	 * detection or hdd hotplug). Then the first vector is used,
	 * all others are ignored. Only enable the first entry here
	 * (entry.entry = 0).
	 */
	rc = pci_enable_msix_exact(pdev, &entry, 1);
	if (rc < 0)
		return rc;

	return 1;
}

Note that the check changed to n_ports != 1 to also cover the case
n_ports == 0 which should return -ENOSYS.

> Also, shouldn't we be printing a warning message here explaining why
> probing is failing?

I didn't want to print a warning in case -ENOSYS for backward
compatability. Only if msi-x code fails there is a message, see
__ahci_init_interrupts(). In any other case the behaviour is as
before, thus no message is printed.

> > +
> > +   /* only enable the first entry (entry.entry = 0) */
> > +   rc = pci_enable_msix_exact(pdev, &entry, 1);
>
> So, enabling the first msix works if nvec > 1 && nvec < n_ports but
> not if nvec >= n_ports?

For n_ports > 1 && nvec >= n_ports we need to assume per-port
interrupts. There are enough vectors for all ports then.

> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	return 1;
> > +}
> > +
> > +static int __ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
> > +				  struct ahci_host_priv *hpriv)
> >  {
> >  	int rc, nvec;
> >
> > +	nvec = ahci_init_msix(pdev, n_ports, hpriv);
> > +	if (nvec > 0)
> > +		return nvec;
> > +
> > +	if (nvec && nvec != -ENOSYS)
> > +		dev_err(&pdev->dev, "failed to enable MSI-X: %d", nvec);
> > +
> >  	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
> >  		goto intx;
> >
> > @@ -1250,6 +1285,35 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
> >  	return 0;
> >  }
> >
> > +static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry)
> > +{
> > +	struct msi_desc *desc;
> > +
> > +	list_for_each_entry(desc, &dev->msi_list, list) {
> > +		if (desc->msi_attrib.entry_nr == entry)
> > +			return desc;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
> > +                           struct ahci_host_priv *hpriv)
> > +{
> > +   struct msi_desc *desc;
> > +
> > +   __ahci_init_interrupts(pdev, n_ports, hpriv);
> > +
> > +   if (!pdev->msix_enabled)
> > +           return pdev->irq;
> > +
> > +   desc = msix_get_desc(pdev, 0);  /* first entry */
> > +   if (!desc)
> > +           return -ENODEV;
> > +
> > +   return desc->irq;
> > +}
>
> Can we please do this properly?  We should be able to move port priv
> allocation to host allocaotion time and add and use pp->irq instead,
> right?

I started working implementing this.

Will send an updated patch set once finished.

Thanks,

-Robert
