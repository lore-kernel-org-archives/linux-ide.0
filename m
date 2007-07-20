From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 10/11] iomap: sort out the broken address reporting caused
 by the iomap layer
Date: Fri, 20 Jul 2007 08:11:53 -0400
Message-ID: <46A0A689.9020800@garzik.org>
References: <200707091846.l69IkNop001393@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49973 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762263AbXGTMLz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 08:11:55 -0400
In-Reply-To: <200707091846.l69IkNop001393@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Add an iomap_name() function which translates an I/O map into a string to
> print.
> 
> Use it for the Libata layer
> 
> For now we use 0xXXXX for I/O and 0xXXXXXXXX for MMIO.  I'm assuming that
> eventually some other platforms will want to use their own iomap_name() and
> we can add ARCH_HAVE_IOMAP_NAME later as such a platform needs it.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/asm-generic/iomap.h |    5 +++++
>  lib/iomap.c                 |   12 ++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff -puN include/asm-generic/iomap.h~iomap-sort-out-the-broken-address-reporting-caused-by-the-iomap-layer include/asm-generic/iomap.h
> --- a/include/asm-generic/iomap.h~iomap-sort-out-the-broken-address-reporting-caused-by-the-iomap-layer
> +++ a/include/asm-generic/iomap.h
> @@ -65,4 +65,9 @@ struct pci_dev;
>  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
>  extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
>  
> +/* Convert an iomap to text for this platform */
> +extern char *iomap_name(void __iomem *addr, char *buf, size_t len);
> +#define IOMAP_NAMELEN	12

this will truncate on 64-bit addresses

otherwise OK


