From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] ide: mask interrupt in ide_config_drive_speed()
Date: Wed, 15 Oct 2008 16:10:29 +0400
Message-ID: <48F5DDB5.6060608@ru.mvista.com>
References: <200810150018.31003.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26347 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751557AbYJOMKe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 08:10:34 -0400
In-Reply-To: <200810150018.31003.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

> Apparently, there is no sense in unmasking IRQ on the controller when you call
> disable_irq_nosync() before doing this, set the nIEN bit afterwards, and then
> unmask IRQ again after the command completion, hence 1 passed to SELECT_MASK()
>   

   s/1/0/, of course...

> before issuing the command in ide_config_drive_speed() is probably just a typo.
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
>  drivers/ide/ide-iops.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6/drivers/ide/ide-iops.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/ide-iops.c
> +++ linux-2.6/drivers/ide/ide-iops.c
> @@ -840,7 +840,7 @@ int ide_config_drive_speed(ide_drive_t *
>  	 
>  	udelay(1);
>  	SELECT_DRIVE(drive);
> -	SELECT_MASK(drive, 0);
> +	SELECT_MASK(drive, 1);
>  	udelay(1);
>  	tp_ops->set_irq(hwif, 0);
>   

MBR, Sergei


