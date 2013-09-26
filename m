From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Date: Thu, 26 Sep 2013 14:13:25 +0200
Message-ID: <20130926121325.GC16774@dhcp-26-207.brq.redhat.com>
References: <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org>
 <20130925180220.GB26273@google.com>
 <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
 <20130925210016.GA8926@htj.dyndns.org>
 <20130926074646.GA16774@dhcp-26-207.brq.redhat.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B735D@saturn3.aculab.com>
 <20130926104548.GB16774@dhcp-26-207.brq.redhat.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7360@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7360@saturn3.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: Tejun Heo <tj@kernel.org>, linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Sep 26, 2013 at 12:34:36PM +0100, David Laight wrote:
> I was thinking that the first call would be done during driver probe
> (assuming such a time exists) so that the subsystem could determine
> how many interrupts all the drivers would like, so it can then
> hand out a smaller number to some of the early drivers in order
> to have some left to satisfy the minimum requirement of later
> ones.
> 
> So all it would do is sum the requirements of all the drivers.

It is already implemented - please see commit 448e2ca ("powerpc/pseries:
Implement a quota system for MSIs")

All other archs do not have MSI vector space limitations.

> 	David

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
