From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/2] pata_hpt{37x|3x2n}: use pr_*(DRV_NAME ...) instead
 of printk(KERN_* ...)
Date: Sat, 08 Jan 2011 23:03:38 +0300
Message-ID: <4D28C31A.4020703@ru.mvista.com>
References: <201101082257.33954.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59863 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab1AHUFC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 15:05:02 -0500
Received: by ewy5 with SMTP id 5so8261944ewy.19
        for <linux-ide@vger.kernel.org>; Sat, 08 Jan 2011 12:05:00 -0800 (PST)
In-Reply-To: <201101082257.33954.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Hello.

I wrote:

> ... the same as the 'pata_hpt366' driver does.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
[...]

> Index: linux-2.6/drivers/ata/pata_hpt37x.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/pata_hpt37x.c
> +++ linux-2.6/drivers/ata/pata_hpt37x.c
[...]
> @@ -1024,9 +1021,8 @@ static int hpt37x_init_one(struct pci_de
>  		else
>  			private_data = (void *)hpt37x_timings_50;
>  
> -		printk(KERN_INFO
> -		       "pata_hpt37x: bus clock %dMHz, using %dMHz DPLL.\n",
> -		       MHz[clock_slot], MHz[dpll]);
> +		pr_info(DVR_NAME ": bus clock %dMHz, using %dMHz DPLL.\n",

    Oops, should be DRV_NAME here! :-/

> +			MHz[clock_slot], MHz[dpll]);

WBR, Sergei
