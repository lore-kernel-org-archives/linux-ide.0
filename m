From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Fri, 31 Oct 2008 02:20:54 +0300
Message-ID: <490A4156.5080302@ru.mvista.com>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:17606 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754873AbYJ3XVA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Oct 2008 19:21:00 -0400
In-Reply-To: <1225403251-15705-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org, Florian Fainelli <florian@openwrt.org>

Hello.

Phil Sutter wrote:

> After applying the following changes I could verify functionality by
> mounting a filesystem on the cfdisk and reading/writing files in it.
>   

   Some of the changes look unneeded and some just strange...

> The symbols rb532_gpio_set_ilevel and rb532_gpio_set_istat are not yet
> available in a vanilla kernel, an appropriate patch has already been
> sent to the linux-mips mailinglist.
>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> ---
>  drivers/ata/pata_rb532_cf.c |   25 +++++++++++++++++++------
>  1 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index f8b3ffc..a8b3c3a 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -39,9 +39,14 @@
>  #define RB500_CF_MAXPORTS	1
>  #define RB500_CF_IO_DELAY	400
>  
> -#define RB500_CF_REG_CMD	0x0800
> +#define RB500_CF_REG_BASE	0x0800
>  #define RB500_CF_REG_CTRL	0x080E
>  #define RB500_CF_REG_DATA	0x0C00
> +#define RB500_CF_REG_ERR	0x080D
>   

   Hm...

> +/* exported in arch/mips/rb532/gpio.c */
> +extern void rb532_gpio_set_ilevel(int bit, unsigned gpio);
> +extern void rb532_gpio_set_istat(int bit, unsigned gpio);
>   

   Those should better be in some header file...

> @@ -62,21 +67,23 @@ static inline void rb532_pata_finish_io(struct ata_port *ap)
>  static void rb532_pata_exec_command(struct ata_port *ap,
>  				const struct ata_taskfile *tf)
>  {
> +
>   

   Totally unneeded change.

>  	writeb(tf->command, ap->ioaddr.command_addr);
>  	rb532_pata_finish_io(ap);
>  }
>  
> -static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
> +static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
>  				unsigned int buflen, int write_data)
>  {
>  	struct ata_port *ap = adev->link->ap;
>  	void __iomem *ioaddr = ap->ioaddr.data_addr;
> +	unsigned int ret = buflen;
>  
>  	if (write_data) {
>  		for (; buflen > 0; buflen--, buf++)
> @@ -87,6 +94,8 @@ static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
>  	}
>  
>  	rb532_pata_finish_io(adev->link->ap);
> +
> +	return ret;
>   

   Totally unneeded variable.

> @@ -109,13 +118,16 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
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
>  	}
>  
> +	rb532_gpio_set_istat(0, info->gpio_line);
> +
> +
>   

  One line too many...

> @@ -146,12 +158,13 @@ static void rb532_pata_setup_ports(struct ata_host *ah)
>  	ap->pio_mask	= 0x1f; /* PIO4 */
>  	ap->flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO;
>  
> -	ap->ioaddr.cmd_addr	= info->iobase + RB500_CF_REG_CMD;
> +	ap->ioaddr.cmd_addr	= info->iobase + RB500_CF_REG_BASE;
>  	ap->ioaddr.ctl_addr	= info->iobase + RB500_CF_REG_CTRL;
>  	ap->ioaddr.altstatus_addr = info->iobase + RB500_CF_REG_CTRL;
>  
>  	ata_sff_std_ports(&ap->ioaddr);
>  
> +	ap->ioaddr.error_addr	= info->iobase + RB500_CF_REG_ERR;
>   

   Wait, how's that?! The error register belongs to the 8-register 
command block, not to the control block.

MBR, Sergei


