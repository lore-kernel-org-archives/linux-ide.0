From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
Date: Wed, 13 May 2015 19:28:28 +0200
Message-ID: <20150513172828.GA8449@rric.localhost>
References: <20150513143353.GU11388@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150513143353.GU11388@htj.duckdns.org>
 <20150513143906.GV11388@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Richter <rric@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alexander Gordeev <agordeev@redhat.com>
List-Id: linux-ide@vger.kernel.org

Tejun,

On 13.05.15 10:39:06, Tejun Heo wrote:
> On Tue, May 12, 2015 at 01:46:47PM +0200, Robert Richter wrote:
> > I don't think this is worth the effort as all internal and external
> > drivers need to be changed basically from:
> > 
> >  ahci_host_activate(host, irq, &ahci_sht);
> > 
> > to:
> > 
> >  host->irq = irq;
> >  ahci_host_activate(host, &ahci_sht);
> >
> > This looks not very useful to do. Since irq is used only a single
> > time, there is no reason to store it in the host's data structure. It
> 
> Doesn't really matter tho.

Since ahci_host_activate() is EXPORT_SYMBOL_GPL I really have concerns
changing the i/f. But I will send you a patch for this.

> > also makes the interface more error prone since host->irq might not be
> > setup. Apart from that there is an abi change.
> 
> But large part of @host needs to be initialized before activation.  I
> don't think moving irq to that pool changes much if anything.
> 
> > I agree that we will need the implemention of host->ports[i]->irq for
> > the case there irqs are no longer in sequential order as this might be
> > the case for per-port msi-x interrupts. But this is not the focus of
> > my implementation and as long there is no hardware for this available,
> > it wouldn't make sense to implement this at all.
> 
> Why are we doing msix at all?  I don't get it.

See below.

> > So how to proceed? I could send you patches that implement host->irq
> > for a single per-host interrupt, and also one that reworks multi-port
> > interrupts to use host->ports[i]->irq. But I don't see any benefit
> > here. That said, I would better keep my patch here as it is. That do
> > you think?
> 
> Let's start with why we're doing this in the first place.

Right, the sata controller is connected to a pci ecam controller, both
are on an SoC together with the processor. There are no external pci
ports for the connection of external devices. Since all pci devices on
the chip support msi-x, the controller is only capable to handle this
and not INTx nor MSI. So for enabling of the sata hc we need msix
support.

-Robert
