From: Alexander Gordeev <agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
Date: Fri, 4 Jul 2014 11:54:34 +0200
Message-ID: <20140704095434.GC12247@dhcp-26-207.brq.redhat.com>
References: <cover.1402405331.git.agordeev@redhat.com>
	<4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
	<20140702202201.GA28852@google.com>
	<063D6719AE5E284EB5DD2968C1650D6D1726BF4E@AcuExch.aculab.com>
	<20140704085816.GB12247@dhcp-26-207.brq.redhat.com>
	<063D6719AE5E284EB5DD2968C1650D6D1726C717@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1726C717-VkEWCZq2GCInGFn1LkZF6NBPR1lH4CV8@public.gmane.org>
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

On Fri, Jul 04, 2014 at 09:11:50AM +0000, David Laight wrote:
> > I might be missing something, but we are talking of MSI address space
> > here, aren't we? I am not getting how we could end up with a 'write'
> > to a random kernel location when a unclaimed MSI vector sent. We could
> > only expect a spurious interrupt at worst, which is handled and reported.
> > 
> > Anyway, as I described in my reply to Bjorn, this is not a concern IMO.
> 
> I'm thinking of the following - which might be MSI-X ?
> 1) Hardware requests some interrupts and tells the host the BAR (and offset)
>    where the 'vectors' should be written.
> 2) To raise an interrupt the hardware uses the 'vector' as the address
>    of a normal PCIe write cycle.
> 
> So if the hardware requests 4 interrupts, but the driver (believing it
> will only use 3) only write 3 vectors, and then the hardware uses the
> 4th vector it can write to a random location.
> 
> Debugging that would be hard!

MSI base address is kind of hardcoded for a platform. A combination of
MSI base address, PCI function number and MSI vector makes a PCI host to
raise interrupt on a CPU. I might be inaccurate in details, but the scenario
you described is impossible AFAICT.

> 	David
> 
> 
> 

-- 
Regards,
Alexander Gordeev
agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
