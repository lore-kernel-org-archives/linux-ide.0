From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 01/11] drivers/ide: use printk_ratelimited() instead of
 printk_ratelimit()
Date: Mon, 20 Jun 2011 12:22:16 +0400
Message-ID: <4DFF0338.7000407@ru.mvista.com>
References: <cover.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>	<0a1488254bd51475a90133c0fc41a4d34b533ef4.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>	<20110616141930.GA12872@eferding.osrc.amd.com> <BANLkTim=yg+tCxa-JhMYw5zsnBSzQqVnqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40659 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab1FTIXW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2011 04:23:22 -0400
In-Reply-To: <BANLkTim=yg+tCxa-JhMYw5zsnBSzQqVnqg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>
Cc: Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, christian.dietrich@informatik.uni-erlangen.de, sshtylyov@mvista.com

Hello.

On 20-06-2011 12:17, Manuel Zerpies wrote:

>> Does the printk fit on one line if you do

>>         pr_warn_ratelimited(...)

>> instead?

>> Thanks.

>> --
>> Regards/Gruss,
>> Boris.

> No I'm affraid. I tried it, but it didn't fit the 80 chars per line
> code-styling.

    It's enough that the string literal fits on one line.

>> Why not pr_warn_ratelimited()?

>> WBR, Sergei

> I just kind of ignored it. As you see, I built it in.

> Here my new patch:

> Since printk_ratelimit() shouldn't be used anymore (see comment in
> include/linux/printk.h), replace it with printk_ratelimited().

    This doesn't match the patch anymore...

> Signed-off-by: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>
> ---
>   drivers/ide/ide-atapi.c |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
> diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> index 6f218e01..c9e69d7 100644
> --- a/drivers/ide/ide-atapi.c
> +++ b/drivers/ide/ide-atapi.c
> @@ -8,6 +8,7 @@
>   #include<linux/ide.h>
>   #include<linux/scatterlist.h>
>   #include<linux/gfp.h>
> +#include<linux/ratelimit.h>
>
>   #include<scsi/scsi.h>
>
> @@ -200,9 +201,8 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
>    err = blk_rq_map_kern(drive->queue, sense_rq, sense, sense_len,
>         GFP_NOIO);
>    if (unlikely(err)) {
> - if (printk_ratelimit())
> - printk(KERN_WARNING PFX "%s: failed to map sense "
> -    "buffer\n", drive->name);
> + pr_warn_ratelimited(PFX "%s: failed to map sense buffer\n",
> +    drive->name);
>    return;
>    }

    Unfortunately, the new patch is whitespace-damaged.

WBR, Sergei
