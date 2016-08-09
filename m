From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] Fix interface autodetection in legacy IDE driver
Date: Tue, 9 Aug 2016 16:50:15 +0300
Message-ID: <041bab68-35ac-a319-e353-a48ce43eafb8@cogentembedded.com>
References: <1370547790.13391287.1470739631878.JavaMail.yahoo.ref@mail.yahoo.com>
 <1370547790.13391287.1470739631878.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38549 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398AbcHINuY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2016 09:50:24 -0400
Received: by mail-wm0-f47.google.com with SMTP id o80so36622643wme.1
        for <linux-ide@vger.kernel.org>; Tue, 09 Aug 2016 06:50:23 -0700 (PDT)
In-Reply-To: <1370547790.13391287.1470739631878.JavaMail.yahoo@mail.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lramos.prof@yahoo.com.br, "davem@davemloft.net" <davem@davemloft.net>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello.

On 08/09/2016 01:47 PM, lramos.prof@yahoo.com.br wrote:

> This patch fixes the automatic setting of ide_generic.probe_mask,
> when it is set to zero (like when default options are used) AND
> the PCI subsystem has detected primary and/or secondary interfaces.
>
> The effect is that those interfaces go undetected under those
> conditions.
>
> The former implementation misunderstands the information detected by
> the PCI subsystem, and may only work if one use ide_generic.probe_mask
> set to 0x3f (or 0x03, minimally), like the suggestion echoed to the
> console.
>
> Probably this has been stayed under the radar because everybody

    Has stayed, maybe?

> migrated to libata. Anyway, IMHO it's worth to fix it, as the code isn't
> entirely dead.
>
> If I'm not wrong, this change applies to kernels from 2009 up to now.
>
> Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> ---
> diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
> index 54d7c4685d23aa5e62ce606e7b994a57bb54b08a..419818a39c270d3ad219e8f7b5df56a9aea3d640 100644
> --- a/drivers/ide/ide-generic.c
> +++ b/drivers/ide/ide-generic.c
> @@ -96,10 +96,10 @@ static int __init ide_generic_init(void)
> printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" "
> "module parameter for probing all legacy ISA IDE ports\n");
>
> -               if (primary == 0)
> +               if (primary)
> probe_mask |= 0x1;

    Your patch is line wrapped...

>
> -               if (secondary == 0)
> +               if (secondary)
> probe_mask |= 0x2;
> } else
> printk(KERN_INFO DRV_NAME ": enforcing probing of I/O ports "

    ... and whitespace damaged too. :-(

MBR, Sergei

