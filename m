From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/2 v2] pata_hpt366: use pr_warning(...) instead of printk(KERN_WARNING
 ...)
Date: Mon, 10 Jan 2011 19:12:07 +0300
Message-ID: <4D2B2FD7.4010607@mvista.com>
References: <201101101854.17767.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42241 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab1AJQNa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 11:13:30 -0500
Received: by eye27 with SMTP id 27so8620035eye.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2011 08:13:29 -0800 (PST)
In-Reply-To: <201101101854.17767.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Hello.

I wrote:

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> The patch is against the recent Linus' tree plus the patches queued by
> Jeff Garzik in his 'upstream-linus' branch.

>  drivers/ata/pata_hpt366.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

> Index: linux-2.6/drivers/ata/pata_hpt366.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/pata_hpt366.c
> +++ linux-2.6/drivers/ata/pata_hpt366.c
> @@ -25,7 +25,7 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME	"pata_hpt366"
> -#define DRV_VERSION	"0.6.9"
> +#define DRV_VERSION	"0.6.10"
>  
>  struct hpt_clock {
>  	u8	xfer_mode;
> @@ -160,8 +160,8 @@ static int hpt_dma_blacklisted(const str
>  
>  	while (list[i] != NULL) {
>  		if (!strcmp(list[i], model_num)) {
> -			printk(KERN_WARNING DRV_NAME ": %s is not supported for %s.\n",
> -				modestr, list[i]);
> +			pr_warning(DRV_NAME ": %s is not supported for %s.\n",
> +				   modestr, list[i]);
>  			return 1;
>  		}
>  		i++;

    Disregard this patch -- I've just realized that the 'pata_hpt37x' driver has 
a similar fragment and so should be changed by this patch as well, instead of 
doing this in patch 2.

WBR, Sergei
