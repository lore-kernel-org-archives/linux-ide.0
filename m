From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.6 patch] xtensa: don't offer ATA
Date: Thu, 17 Apr 2008 15:39:29 -0400
Message-ID: <4807A771.2020405@pobox.com>
References: <20080414195521.GB26885@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754152AbYDQTj5@vger.kernel.org>
In-Reply-To: <20080414195521.GB26885@cs181133002.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: chris@zankel.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Adrian Bunk wrote:
> Trying to build libata for xtensa fails with the following error:
> 
> <--  snip  -->
> 
> ...
>   CC [M]  drivers/ata/libata-core.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-core.c: In function 'ata_devchk':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-core.c:1034: error: implicit declaration of function 'iowrite8'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-core.c:1043: error: implicit declaration of function 'ioread8'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-core.c: In function 'ata_data_xfer':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-core.c:5027: error: implicit declaration of function 'ioread16_rep'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-core.c:5029: error: implicit declaration of function 'iowrite16_rep'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-core.c:5037: error: implicit declaration of function 'ioread16'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-core.c:5041: error: implicit declaration of function 'iowrite16'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-core.c: In function 'ata_wait_register':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-core.c:7700: error: implicit declaration of function 'ioread32'
> make[3]: *** [drivers/ata/libata-core.o] Error 1
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> aa579e7ab065e41a9d1e27e1f4b7af6b0508018c diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 25aba69..f34e9d1 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -6,7 +6,7 @@ menuconfig ATA
>  	tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"
>  	depends on HAS_IOMEM
>  	depends on BLOCK
> -	depends on !(M32R || M68K) || BROKEN
> +	depends on !(M32R || M68K || XTENSA) || BROKEN
>  	depends on !SUN4 || BROKEN
>  	select SCSI

XTENSA offers HAS_IOMEM but not iomem functions?  That seems like the 
problem to me.

Overall, we should not be adding specific arches to an exclusion list, 
we should defining HAS_IOFOO or MISSING_IOFOO or another symbol in the 
appropriate arch.

	Jeff
