From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] piix: Use refcounted interface when searching for a
 450NX
Date: Fri, 15 Sep 2006 09:54:09 -0700
Message-ID: <20060915095409.d0171431.akpm@osdl.org>
References: <1158329678.29932.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:39607 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750733AbWIOQyZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Sep 2006 12:54:25 -0400
In-Reply-To: <1158329678.29932.41.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, 15 Sep 2006 15:14:38 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Simple conversion
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/piix.c linux-2.6.18-rc6-mm1/drivers/ide/pci/piix.c
> --- linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/piix.c	2006-09-11 17:00:09.000000000 +0100
> +++ linux-2.6.18-rc6-mm1/drivers/ide/pci/piix.c	2006-09-14 17:19:12.000000000 +0100
> @@ -602,7 +602,7 @@
>  	struct pci_dev *pdev = NULL;
>  	u16 cfg;
>  	u8 rev;
> -	while((pdev=pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
> +	while((pdev=pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
>  	{
>  		/* Look for 450NX PXB. Check for problem configurations
>  		   A PCI quirk checks bit 6 already */

fwiw, I have an ad450nx server upon which I occasionally test kernels.
