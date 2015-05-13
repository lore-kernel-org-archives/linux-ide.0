From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
Date: Wed, 13 May 2015 10:33:53 -0400
Message-ID: <20150513143353.GU11388@htj.duckdns.org>
References: <1430725538-22162-1-git-send-email-rric@kernel.org>
 <20150504160652.GB1971@htj.duckdns.org>
 <20150511171810.GB29499@rric.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150511171810.GB29499@rric.localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: Robert Richter <rric@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alexander Gordeev <agordeev@redhat.com>
List-Id: linux-ide@vger.kernel.org

Hello, Robert.

On Mon, May 11, 2015 at 07:18:10PM +0200, Robert Richter wrote:
> static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
> 			  struct ahci_host_priv *hpriv)
> {
> 	int rc, nvec;
> 	struct msix_entry entry = {};
> 
> 	/* check if msix is supported */
> 	nvec = pci_msix_vec_count(pdev);
> 	if (nvec <= 0)
> 		return 0;
> 
> 	/*
> 	 * Per-port msix interrupts are not supported. Assume single
> 	 * port interrupts for:
> 	 *
> 	 *  n_ports == 1, or
> 	 *  nvec < n_ports.
> 	 *
> 	 * We also need to check for n_ports != 0 which is implicitly
> 	 * covered here since nvec > 0.
> 	 */
> 	if (n_ports != 1 && nvec >= n_ports)
> 		return -ENOSYS;

Why are failing the whole thing when nvec >= n_ports?  Can't we just
print some warning and configure it for single interrupt mode?

> > Also, shouldn't we be printing a warning message here explaining why
> > probing is failing?
> 
> I didn't want to print a warning in case -ENOSYS for backward
> compatability. Only if msi-x code fails there is a message, see
> __ahci_init_interrupts(). In any other case the behaviour is as
> before, thus no message is printed.

I'm confused here.  Why are we implementing msix support at all if it
only support single interrupt mode?  I kinda assumed that that was
because you're trying to support a controller which does only msix,
no?  At any rate, I don't think it's wrong to print an informational /
warning message when a controller declares msix support but has wacko
parameters.

> > > +
> > > +   /* only enable the first entry (entry.entry = 0) */
> > > +   rc = pci_enable_msix_exact(pdev, &entry, 1);
> >
> > So, enabling the first msix works if nvec > 1 && nvec < n_ports but
> > not if nvec >= n_ports?
> 
> For n_ports > 1 && nvec >= n_ports we need to assume per-port
> interrupts. There are enough vectors for all ports then.

Again, and we fail irq init in that case?

Thanks.

-- 
tejun
