From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Fri, 14 Nov 2008 18:53:44 -0500
Message-ID: <491E0F88.5000808@garzik.org>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org> <1226448783-10047-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38113 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754231AbYKNXxv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Nov 2008 18:53:51 -0500
In-Reply-To: <1226448783-10047-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Florian Fainelli <florian@openwrt.org>

Phil Sutter wrote:
> The following patch series is a complete updated set of changes I did to
> the pata-rb532-cf driver. In ordered detail: fix functionality, restore
> the behaviour of the original driver when doing transfers and eliminate
> compiler warnings.
> 
> Greetings, Phil
> 
> ---
> 
> After applying the following changes I could verify functionality by
> mounting a filesystem on the cfdisk and reading/writing files in it.
> 
> The set_irq_type() function must be wrong, as there is no set_type()
> function defined for the rb532 IRQ chip. But as the used IRQ actually is
> being triggered by a GPIO, setting it's interrupt level should be the
> right alternative. Also to clear a GPIO triggered IRQ, the source has to
> be cleared. This is being done at the end of rb532_pata_irq_handler.
> 
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> Acked-by: Florian Fainelli <florian@openwrt.org>
> ---
>  drivers/ata/pata_rb532_cf.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index f8b3ffc..7b11f40 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -31,6 +31,7 @@
>  #include <scsi/scsi_host.h>
>  
>  #include <asm/gpio.h>
> +#include <asm/mach-rc32434/gpio.h>
>  
>  #define DRV_NAME	"pata-rb532-cf"
>  #define DRV_VERSION	"0.1.0"
> @@ -39,7 +40,8 @@
>  #define RB500_CF_MAXPORTS	1
>  #define RB500_CF_IO_DELAY	400
>  
> -#define RB500_CF_REG_CMD	0x0800
> +#define RB500_CF_REG_BASE	0x0800
> +#define RB500_CF_REG_ERR	0x080D
>  #define RB500_CF_REG_CTRL	0x080E
>  #define RB500_CF_REG_DATA	0x0C00
>  
> @@ -62,7 +64,7 @@ static inline void rb532_pata_finish_io(struct ata_port *ap)
>  	ata_sff_dma_pause(ap);
>  	ndelay(RB500_CF_IO_DELAY);
>  
> -	set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
> +	rb532_gpio_set_ilevel(1, info->gpio_line);

I'll need to wait for this function to appear upstream... it's not in 
2.6.28-rc at least


