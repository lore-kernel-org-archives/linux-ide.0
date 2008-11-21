From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Fri, 21 Nov 2008 19:59:51 +0300
Message-ID: <4926E907.20706@ru.mvista.com>
References: <49263552.8090602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3602 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756152AbYKUQ7u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Nov 2008 11:59:50 -0500
In-Reply-To: <49263552.8090602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello.

Tejun Heo wrote:

> The DMA_IRQ bit in the bmdma status register is always set when IDEIRQ
> is asserted allowing spurious IRQ detection.  Detect spurious IRQs and
> clear them.  This protects ata_piix against nobody-cared which gets
> reported not so rarely.

    This should be more generic, as several IDE controllers have the separate 
IDE interrupt status bits.

> Signed-off-by: Tejun Heo <tj@kernel.org>

> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 8e37be1..b438edc 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -922,6 +922,58 @@ static int piix_sidpr_scr_read(struct ata_link *link,
>  	return 0;
>  }
>  
> +static irqreturn_t piix_interrupt(int irq, void *dev_instance)
> +{
[...]
> +		/*
> +		 * Control reaches here if HSM is not expecting IRQ.
> +		 * If the controller is actually asserting IRQ line,
> +		 * this will lead to nobody cared.  Fortuantely,
> +		 * DMA_INTR of PIIX is set whenever IDEIRQ is set so

    Frankly speaking, I'm not sure about the PIIX chips themselves... Is that 
documented by Intel?

MBR, Sergei
