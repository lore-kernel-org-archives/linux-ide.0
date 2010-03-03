From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 10/11] ahci: Export generic AHCI symbols, turn libahci
 into a separate module
Date: Wed, 03 Mar 2010 20:53:30 +0300
Message-ID: <4B8EA21A.2040601@ru.mvista.com>
References: <20100303171713.GA6322@oksana.dev.rtsoft.ru> <20100303171749.GJ12362@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100303171749.GJ12362@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

Anton Vorontsov wrote:

> This is needed for non-PCI drivers that will be added soon.
>
> Since the symbols are exported now, libahci and ahci can be built as
> a separate modules.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/ata/Kconfig   |    8 +++++++-
>  drivers/ata/Makefile  |    3 ++-
>  drivers/ata/libahci.c |   20 ++++++++++++++++++++
>  3 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 01c52c4..365a9da 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -59,12 +59,18 @@ config SATA_PMP
>  
>  config SATA_AHCI
>  	tristate "AHCI SATA support"
> -	depends on PCI
>  	help
>  	  This option enables support for AHCI Serial ATA.
>  
>  	  If unsure, say N.
>  
> +config SATA_AHCI_PCI
> +	tristate "PCI AHCI SATA support"
> +	depends on SATA_AHCI && PCI
>   

   Perhaps it's worth to turn that into select SATA_AHCI and make 
SATA_AHCI invisible to users instead, so that each particular AHCI 
implementation could select it.

> +	default y
>   

   Why force the default "y" if the predecessor option SATA_AHCI didn't 
do it?

MBR, Sergei
