From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Some IDE chipsets are architecture-specific
Date: Mon, 07 Mar 2005 11:58:59 -0500
Message-ID: <422C8853.3030404@pobox.com>
References: <20050307152803.GF28741@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53126 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261860AbVCGQ7R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2005 11:59:17 -0500
In-Reply-To: <20050307152803.GF28741@parcelfarce.linux.theplanet.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> Mark some chipset support as being for specific architectures.
> I may have got some wrong, so please double-check.
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> 
> Index: ./drivers/ide/Kconfig
> ===================================================================
> RCS file: /var/cvs/linux-2.6/drivers/ide/Kconfig,v
> retrieving revision 1.25.2.1
> diff -u -p -r1.25.2.1 Kconfig
> --- ./drivers/ide/Kconfig	2 Mar 2005 11:19:06 -0000	1.25.2.1
> +++ ./drivers/ide/Kconfig	7 Mar 2005 04:49:26 -0000
> @@ -457,6 +457,7 @@ config BLK_DEV_AEC62XX
>  
>  config BLK_DEV_ALI15X3
>  	tristate "ALI M15x3 chipset support"
> +	depends on X86
>  	help
>  	  This driver ensures (U)DMA support for ALI 1533, 1543 and 1543C
>  	  onboard chipsets.  It also tests for Simplex mode and enables

these are in alphas, and others I think


> @@ -485,6 +486,7 @@ config WDC_ALI15X3
>  
>  config BLK_DEV_AMD74XX
>  	tristate "AMD and nVidia IDE support"
> +	depends on X86 || PPC
>  	help
>  	  This driver adds explicit support for AMD-7xx and AMD-8111 chips
>  	  and also for the nVidia nForce chip.  This allows the kernel to

x86-64 too I presume

