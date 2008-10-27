From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] irq handler must disable the handled irq
Date: Mon, 27 Oct 2008 14:15:09 +0000
Message-ID: <20081027141509.2d0be2c7@lxorguk.ukuu.org.uk>
References: <1225116107-9753-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47723 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750790AbYJ0OPJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 10:15:09 -0400
In-Reply-To: <1225116107-9753-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Florian Fainelli <florian@openwrt.org>

On Mon, 27 Oct 2008 15:01:47 +0100
Phil Sutter <n0-1@freewrt.org> wrote:

> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  drivers/ata/pata_rb532_cf.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index f8b3ffc..a1d44a6 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -116,6 +116,8 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
>  		set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
>  	}
>  
> +	disable_irq(irq);
> +

You can't call disable_irq in an IRQ handler. What are you actually
trying to do ?

Alan
