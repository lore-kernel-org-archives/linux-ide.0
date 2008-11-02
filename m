From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Mon, 03 Nov 2008 01:04:28 +0300
Message-ID: <490E23EC.2030907@ru.mvista.com>
References: <20081101164545.GB10321@nuty> <1225562973-8843-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:53311 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754333AbYKBWEe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Nov 2008 17:04:34 -0500
In-Reply-To: <1225562973-8843-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org

Hello.

Phil Sutter wrote:

> After applying the following changes I could verify functionality by
> mounting a filesystem on the cfdisk and reading/writing files in it.
>
> The symbols rb532_gpio_set_ilevel and rb532_gpio_set_istat are not yet
> available in a vanilla kernel, an appropriate patch has already been
> sent to the linux-mips mailinglist.
>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
[...]
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

   I wonder why is this IRQ level switching magic is necessary... I'd 
think that the interrupt trigger level should be programmed only once, 
at init time. Ah, you're masking them on/off that way...

MBR, Sergei


