From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Sun, 2 Nov 2008 23:45:16 +0100
Message-ID: <20081102224516.GB10622@nuty>
References: <20081101164545.GB10321@nuty> <1225562973-8843-1-git-send-email-n0-1@freewrt.org> <490E23EC.2030907@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:37774 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbYKBWoE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Nov 2008 17:44:04 -0500
Content-Disposition: inline
In-Reply-To: <490E23EC.2030907@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

Hi,

On Mon, Nov 03, 2008 at 01:04:28AM +0300, Sergei Shtylyov wrote:
> >After applying the following changes I could verify functionality by
> >mounting a filesystem on the cfdisk and reading/writing files in it.
> >
> >The symbols rb532_gpio_set_ilevel and rb532_gpio_set_istat are not yet
> >available in a vanilla kernel, an appropriate patch has already been
> >sent to the linux-mips mailinglist.
> >
> >Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> [...]
> >@@ -62,7 +64,7 @@ static inline void rb532_pata_finish_io(struct ata_port 
> >*ap)
> > 	ata_sff_dma_pause(ap);
> > 	ndelay(RB500_CF_IO_DELAY);
> > 
> >-	set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
> >+	rb532_gpio_set_ilevel(1, info->gpio_line);
> > }
> > 
> > static void rb532_pata_exec_command(struct ata_port *ap,
> >@@ -109,13 +111,15 @@ static irqreturn_t rb532_pata_irq_handler(int irq, 
> >void *dev_instance)
> > 	struct rb532_cf_info *info = ah->private_data;
> > 
> > 	if (gpio_get_value(info->gpio_line)) {
> >-		set_irq_type(info->irq, IRQ_TYPE_LEVEL_LOW);
> >+		rb532_gpio_set_ilevel(0, info->gpio_line);
> > 		if (!info->frozen)
> > 			ata_sff_interrupt(info->irq, dev_instance);
> > 	} else {
> >-		set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
> >+		rb532_gpio_set_ilevel(1, info->gpio_line);
> >  
> 
>   I wonder why is this IRQ level switching magic is necessary... I'd 
> think that the interrupt trigger level should be programmed only once, 
> at init time. Ah, you're masking them on/off that way...

Well, that's not really clear to me. But likely the interrupt level register
turns the interrupt source functionality of the GPIOs on and off, as you
say. As a little exerpt of what I've gone through the last days:

| GPIO Interrupt Level. When the value of a GPIO pin matches the value of
| the corresponding bit in this field, the corresponding bit is set in the
| GPIOISTAT field is set.

It's maybe because of my english, but I can only guess what is meant
here.

I'm at least sure that set_irq_type() is wrong. The lack of a set_type()
function should make them expand to no ops. IIRC the idea for this
change came by looking at the callers of prepare_cf_irq() in the
standalone driver, combined with a lot of trial and error. :)

Greetings, Phil
