From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] ide/amd74xx: fix section references
Date: Fri, 4 Mar 2005 09:03:07 +0100
Message-ID: <20050304080307.GC1646@ucw.cz>
References: <20050303194821.55fec933.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from twilight.ucw.cz ([81.30.235.3]:38038 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262631AbVCDIC0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2005 03:02:26 -0500
Content-Disposition: inline
In-Reply-To: <20050303194821.55fec933.rddunlap@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, akpm <akpm@osdl.org>, linux-ide@vger.kernel.org

On Thu, Mar 03, 2005 at 07:48:21PM -0800, Randy.Dunlap wrote:
> 
> ide/pci/amd74xx:  data structs point to __init text which should be
>   __devinit;
> unless (a) these are going away real soon,
> or (b) this just can't happen, isn't a real problem,
> or (c) other ?

This is a problem in most of the IDE PCI drivers. It is a problem if IDE
hotplug is to be expected, and shouldn't be causing any immediate harm
if IDE controllers can't be hotplugged. AMD74xx certainly can't.

However, I believe it's correct to fix that.

> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000004d8 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000004e8 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000538 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000548 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000598 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000005a8 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000005f8 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000608 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000658 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000668 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000006b8 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000006c8 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000718 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000728 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000778 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000788 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000007d8 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000007e8 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000838 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000848 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000898 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000008a8 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000008f8 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000908 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000958 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000968 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000009b8 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000009c8 R_X86_64_64       .init.text
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000a18 R_X86_64_64       .init.text+0x0000000000000106
> Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000a28 R_X86_64_64       .init.text
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
> 
> diffstat:=
>  drivers/ide/pci/amd74xx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -Naurp ./drivers/ide/pci/amd74xx.c~ide_amd_sections ./drivers/ide/pci/amd74xx.c
> --- ./drivers/ide/pci/amd74xx.c~ide_amd_sections	2005-03-01 23:38:33.000000000 -0800
> +++ ./drivers/ide/pci/amd74xx.c	2005-03-03 15:39:21.000000000 -0800
> @@ -308,7 +308,7 @@ static int amd74xx_ide_dma_check(ide_dri
>   * and initialize its drive independent registers.
>   */
>  
> -static unsigned int __init init_chipset_amd74xx(struct pci_dev *dev, const char *name)
> +static unsigned int __devinit init_chipset_amd74xx(struct pci_dev *dev, const char *name)
>  {
>  	unsigned char t;
>  	unsigned int u;
> @@ -412,7 +412,7 @@ static unsigned int __init init_chipset_
>  	return dev->irq;
>  }
>  
> -static void __init init_hwif_amd74xx(ide_hwif_t *hwif)
> +static void __devinit init_hwif_amd74xx(ide_hwif_t *hwif)
>  {
>  	int i;
>  
> 
> 
> ---
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
