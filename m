From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 01/11] drivers/ide: use printk_ratelimited() instead of
 printk_ratelimit()
Date: Thu, 16 Jun 2011 18:32:20 +0400
Message-ID: <4DFA13F4.1090305@ru.mvista.com>
References: <cover.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de> <0a1488254bd51475a90133c0fc41a4d34b533ef4.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57546 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757865Ab1FPOeF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jun 2011 10:34:05 -0400
In-Reply-To: <0a1488254bd51475a90133c0fc41a4d34b533ef4.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, christian.dietrich@informatik.uni-erlangen.de

Hello.

Manuel Zerpies wrote:

> Since printk_ratelimit() shouldn't be used anymore (see comment in
> include/linux/printk.h), replace it with printk_ratelimited().

> Signed-off-by: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>
> ---
>  drivers/ide/ide-atapi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> index 6f218e01..1b04f45 100644
> --- a/drivers/ide/ide-atapi.c
> +++ b/drivers/ide/ide-atapi.c
> @@ -8,6 +8,7 @@
>  #include <linux/ide.h>
>  #include <linux/scatterlist.h>
>  #include <linux/gfp.h>
> +#include <linux/ratelimit.h>
>  
>  #include <scsi/scsi.h>
>  
> @@ -200,8 +201,7 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
>  	err = blk_rq_map_kern(drive->queue, sense_rq, sense, sense_len,
>  			      GFP_NOIO);
>  	if (unlikely(err)) {
> -		if (printk_ratelimit())
> -			printk(KERN_WARNING PFX "%s: failed to map sense "
> +		printk_ratelimited(KERN_WARNING PFX "%s: failed to map sense "

    Why not pr_warn_ratelimited()?

WBR, Sergei
