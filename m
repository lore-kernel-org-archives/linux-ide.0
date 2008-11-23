From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Mon, 24 Nov 2008 01:56:58 +0300
Message-ID: <4929DFBA.8080904@ru.mvista.com>
References: <1226952247-1328-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:39681 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750818AbYKWW5G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Nov 2008 17:57:06 -0500
In-Reply-To: <1226952247-1328-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello.

Phil Sutter wrote:

> I applied the latest comments to my set of changes for pata-rb532-cf, i.e.:
> * add missing Acket-by statements
> * switch order of the last two patches
> * have some cosmetics for the 4-byte-blocks patch
>
> The rb532_gpio_set_i{level,stat} symbols aren't upstream yet, though
> Ralf Baechle has the according patch in his linux-mips tree (branch
> master), so they should be available soon.
>
> Greetings, Phil
>
> ---
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
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Acked-by: Florian Fainelli <florian@openwrt.org>
>   

   You mixed up the order: your comments about the recent patch changes 
should be below --- and the patch description/signoff/ACKs above it.

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
>   

   I think you need to split off the RB500_CF_REG_* changes as they're 
unrelated to IRQ trickery and can be applied right now.

> @@ -62,7 +64,7 @@ static inline void rb532_pata_finish_io(struct ata_port *ap)
>  	ata_sff_dma_pause(ap);
>  	ndelay(RB500_CF_IO_DELAY);
>  
> -	set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
> +	rb532_gpio_set_ilevel(1, info->gpio_line);
>  }
>  
>  static void rb532_pata_exec_command(struct ata_port *ap,
> @@ -109,13 +111,15 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
>  	struct rb532_cf_info *info = ah->private_data;
>  
>  	if (gpio_get_value(info->gpio_line)) {
> -		set_irq_type(info->irq, IRQ_TYPE_LEVEL_LOW);
> +		rb532_gpio_set_ilevel(0, info->gpio_line);
>  		if (!info->frozen)
>  			ata_sff_interrupt(info->irq, dev_instance);
>  	} else {
> -		set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
> +		rb532_gpio_set_ilevel(1, info->gpio_line);
>   

   I'm still perplexed with why this IRQ sensitivity trick is needed...

MBR, Sergei


