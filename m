From: Alexander Gordeev <agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
Date: Fri, 4 Jul 2014 10:58:17 +0200
Message-ID: <20140704085816.GB12247@dhcp-26-207.brq.redhat.com>
References: <cover.1402405331.git.agordeev@redhat.com>
	<4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
	<20140702202201.GA28852@google.com>
	<063D6719AE5E284EB5DD2968C1650D6D1726BF4E@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1726BF4E-VkEWCZq2GCInGFn1LkZF6NBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>
Cc: "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Bjorn Helgaas' <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org" <xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Jul 03, 2014 at 09:20:52AM +0000, David Laight wrote:
> From: Bjorn Helgaas
> > On Tue, Jun 10, 2014 at 03:10:30PM +0200, Alexander Gordeev wrote:
> > > There are PCI devices that require a particular value written
> > > to the Multiple Message Enable (MME) register while aligned on
> > > power of 2 boundary value of actually used MSI vectors 'nvec'
> > > is a lesser of that MME value:
> > >
> > > 	roundup_pow_of_two(nvec) < 'Multiple Message Enable'
> > >
> > > However the existing pci_enable_msi_block() interface is not
> > > able to configure such devices, since the value written to the
> > > MME register is calculated from the number of requested MSIs
> > > 'nvec':
> > >
> > > 	'Multiple Message Enable' = roundup_pow_of_two(nvec)
> > 
> > For MSI, software learns how many vectors a device requests by reading
> > the Multiple Message Capable (MMC) field.  This field is encoded, so a
> > device can only request 1, 2, 4, 8, etc., vectors.  It's impossible
> > for a device to request 3 vectors; it would have to round up that up
> > to a power of two and request 4 vectors.
> > 
> > Software writes similarly encoded values to MME to tell the device how
> > many vectors have been allocated for its use.  For example, it's
> > impossible to tell the device that it can use 3 vectors; the OS has to
> > round that up and tell the device it can use 4 vectors.
> > 
> > So if I understand correctly, the point of this series is to take
> > advantage of device-specific knowledge, e.g., the device requests 4
> > vectors via MMC, but we "know" the device is only capable of using 3.
> > Moreover, we tell the device via MME that 4 vectors are available, but
> > we've only actually set up 3 of them.
> ...
> 
> Even if you do that, you ought to write valid interrupt information
> into the 4th slot (maybe replicating one of the earlier interrupts).
> Then, if the device does raise the 'unexpected' interrupt you don't
> get a write to a random kernel location.

I might be missing something, but we are talking of MSI address space
here, aren't we? I am not getting how we could end up with a 'write'
to a random kernel location when a unclaimed MSI vector sent. We could
only expect a spurious interrupt at worst, which is handled and reported.

Anyway, as I described in my reply to Bjorn, this is not a concern IMO.

> Plausibly something similar should be done when a smaller number of
> interrupts is assigned.
> 
> 	David
> 

-- 
Regards,
Alexander Gordeev
agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
