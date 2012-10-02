From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v3 -tip 5/5] AHCI: Support multiple MSIs
Date: Tue, 2 Oct 2012 18:42:21 +0200
Message-ID: <20121002164220.GB2258@dhcp-26-207.brq.redhat.com>
References: <cover.1349074231.git.agordeev@redhat.com>
 <cc6441a31a2c600ad9ae33e7715de65b8d46a66f.1349074231.git.agordeev@redhat.com>
 <20121002050929.GD7756@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121002050929.GD7756@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Yinghai Lu <yinghai@kernel.org>, Matthew Wilcox <willy@linux.intel.com>, x86@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Oct 02, 2012 at 07:09:29AM +0200, Ingo Molnar wrote:
> > +irqreturn_t ahci_hw_interrupt(int irq, void *dev_instance)
> > +{
> > +	struct ata_port *ap_this = dev_instance;
> > +	struct ahci_port_priv *pp = ap_this->private_data;
> > +	struct ata_host *host = ap_this->host;
> > +	struct ahci_host_priv *hpriv = host->private_data;
> > +	void __iomem *mmio = hpriv->mmio;
> > +	unsigned int i;
> > +	u32 irq_stat, irq_masked;
> > +
> > +	VPRINTK("ENTER\n");
> 
> Is this per IRQ handler execution debugging code still needed? 
> Same for the other VPRINTK() lines in this patch.

These VPRINKs are only to make new handlers look like ahci_interrupt()
which did not change. I believe, if they need to go it is better to
remove them altogether, with a separate followup patch.

Jeff, what do you think?

Thanks!

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
