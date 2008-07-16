From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: it821x in pass-through mode segfaults in 2.6.26-stable
Date: Wed, 16 Jul 2008 17:02:14 +0200
Message-ID: <200807161702.15131.bzolnier@gmail.com>
References: <20080714211133.514936a4@laphroaig>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:20548 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbYGOPKA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jul 2008 11:10:00 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1791047mue.1
        for <linux-ide@vger.kernel.org>; Tue, 15 Jul 2008 08:09:58 -0700 (PDT)
In-Reply-To: <20080714211133.514936a4@laphroaig>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dimitri Gorokhovik <dimitri.gorokhovik@free.fr>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org


Hi,

On Monday 14 July 2008, Dimitri Gorokhovik wrote:
> (Let me know if you need the kernel config for this.) 
> ---
> The driver of ITE8212 in pass-through mode (it8212.noraid=1 on cmndline)
> attempts to use the field `.dma_host_set' of the struct ide_dma_ops in
> `ide_config_drive_speed' which is set to NULL by default.
> 
> So give a value to all fields of the struct ide_dma_ops.

Thank your for fixing it.

Please resend with your Signed-off-by: so I could apply it.

> ---
> diff --git a/drivers/ide/pci/it821x.c b/drivers/ide/pci/it821x.c
> index 6ab0411..cbf6472 100644
> --- a/drivers/ide/pci/it821x.c
> +++ b/drivers/ide/pci/it821x.c
> @@ -512,8 +512,14 @@ static void __devinit it821x_quirkproc(ide_drive_t *drive)
>  }
>  
>  static struct ide_dma_ops it821x_pass_through_dma_ops = {
> +	.dma_host_set		= ide_dma_host_set,
> +	.dma_setup		= ide_dma_setup,
> +	.dma_exec_cmd		= ide_dma_exec_cmd,
>  	.dma_start		= it821x_dma_start,
>  	.dma_end		= it821x_dma_end,
> +	.dma_test_irq		= ide_dma_test_irq,
> +	.dma_timeout		= ide_dma_timeout,
> +	.dma_lost_irq		= ide_dma_lost_irq,
>  };
>  
>  /**
