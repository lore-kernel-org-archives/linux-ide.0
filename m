From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Date: Thu, 26 Sep 2013 12:34:36 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7360@saturn3.aculab.com>
References: <20130918094759.GA2353@dhcp-26-207.brq.redhat.com> <20130918142231.GA21650@mtj.dyndns.org> <20130918165045.GB2353@dhcp-26-207.brq.redhat.com> <20130920082458.GA10507@dhcp-26-207.brq.redhat.com> <20130920122736.GD7630@mtj.dyndns.org> <20130925180220.GB26273@google.com> <20130925205804.GA21737@dhcp-26-207.brq.redhat.com> <20130925210016.GA8926@htj.dyndns.org> <20130926074646.GA16774@dhcp-26-207.brq.redhat.com> <AE90C24D6B3A694183C094C60CF0A2F6026B735D@saturn3.aculab.com> <20130926104548.GB16774@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pci-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20130926104548.GB16774@dhcp-26-207.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-Id: linux-ide@vger.kernel.org

> On Thu, Sep 26, 2013 at 09:58:53AM +0100, David Laight wrote:
> > Would it be possible to do some kind of 2-stage allocation.
> > In the first pass the driver would pass a minimum and desired
> > number of MSI-X interrupts, but not actually be given any.
> 
> Repeated calls to msi_enable_msi/msix() is what we are trying to avoid.

I was thinking that the first call would be done during driver probe
(assuming such a time exists) so that the subsystem could determine
how many interrupts all the drivers would like, so it can then
hand out a smaller number to some of the early drivers in order
to have some left to satisfy the minimum requirement of later
ones.

So all it would do is sum the requirements of all the drivers.

	David
