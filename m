From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [PATCH] Some IDE chipsets are architecture-specific
Date: Mon, 7 Mar 2005 16:47:55 +0100
Message-ID: <20050307154755.GA31844@harddisk-recovery.com>
References: <20050307152803.GF28741@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from users.linvision.com ([62.58.92.114]:62092 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261481AbVCGPsE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Mar 2005 10:48:04 -0500
Content-Disposition: inline
In-Reply-To: <20050307152803.GF28741@parcelfarce.linux.theplanet.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

On Mon, Mar 07, 2005 at 03:28:03PM +0000, Matthew Wilcox wrote:
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

AFAIK the ALI 1533 and 1543 are generic PCI southbridges that can be
used on any PCI bus, so I wouldn't limit them to X86 only.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
