From: Alexander Gordeev <agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
Date: Mon, 7 Jul 2014 22:42:43 +0200
Message-ID: <20140707204242.GA27809@dhcp-26-207.brq.redhat.com>
References: <cover.1402405331.git.agordeev@redhat.com>
	<4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
	<20140702202201.GA28852@google.com>
	<20140704085741.GA12247@dhcp-26-207.brq.redhat.com>
	<CAErSpo6f6RXWv0DEtLBZX0jXoSUYJeWrSm7mubSJ_F-O7tQp6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo6f6RXWv0DEtLBZX0jXoSUYJeWrSm7mubSJ_F-O7tQp6w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Jul 07, 2014 at 01:40:48PM -0600, Bjorn Helgaas wrote:
> As you can tell, I'm a little skeptical about this.  It's a fairly big
> change, it affects the arch interface, it seems to be targeted for
> only a single chipset (though it's widely used), and we already
> support a standard solution (MSI-X, reducing the number of vectors
> requested, or even operating with 1 vector).

Bjorn,

I surely understand your concerns. I am answering this "summary"
question right away.

Even though an extra parameter is introduced, functionally this update
is rather small. It is only the new pci_enable_msi_partial() function
that could exploit a custom 'nvec_mme' parameter. By contrast, existing
pci_enable_msi_range() function (and therefore all device drivers) is
unaffected - it just rounds up 'nvec' to the nearest power of two and
continues exactly as it has been. All archs besides x86 just ignore it.
And x86 change is fairly small as well - all necessary functionality is
already in.

Thus, at the moment it is only AHCI of concern. And no, AHCI can not do MSI-X..

Thanks!

> Bjorn

-- 
Regards,
Alexander Gordeev
agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
