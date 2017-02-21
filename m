From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/2] ide-generic: added messages in case of PCI IDE
 devices
Date: Tue, 21 Feb 2017 18:52:13 +0300
Message-ID: <418946e5-38e6-ca97-fce1-543988a5f06d@cogentembedded.com>
References: <20170221142249.GC11234@giustizia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33507 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753222AbdBUPw2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Feb 2017 10:52:28 -0500
Received: by mail-lf0-f53.google.com with SMTP id l12so28986985lfe.0
        for <linux-ide@vger.kernel.org>; Tue, 21 Feb 2017 07:52:27 -0800 (PST)
In-Reply-To: <20170221142249.GC11234@giustizia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>, linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Miller <davem@davemloft.net>, petkovbb@gmail.com

On 02/21/2017 05:22 PM, Luiz Carlos Ramos wrote:

> Two messages are now displayed (at "warn" level) to make sure the user
> is aware that PCI IDE devices were detected at common addresses (0x1f0
> and 0x170) and that they will not be managed by ide-generic, but rather
> delegated to its specific driver.
>
> Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> ---
>  drivers/ide/ide-generic.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
> index ee11edcdba3170c077381d603918498d79ffa3bb..2204819ef73612deed4ebfe58c69cdadb40fa53b 100644
> --- a/drivers/ide/ide-generic.c
> +++ b/drivers/ide/ide-generic.c
> @@ -125,9 +125,19 @@ static int __init ide_generic_init(void)
>
>  		if (primary == 0)
>  			probe_mask |= 0x1;
> +		else {
> +			printk(KERN_WARN DRV_NAME ": PCI IDE device detected at 0x%4.4x."

    Also, please use pr_warn().

> +			     " ide-generic will not grab this device, delegating it to"
> +			     " the driver of its specific chipset\n", 0x1f0);
> +		}
>
>  		if (secondary == 0)
>  			probe_mask |= 0x2;
> +		else {
> +			printk(KERN_WARN DRV_NAME ": PCI IDE device detected at 0x%4.4x."

    Likewise.

> +			     " ide-generic will not grab this device, delegating it to"
> +			     " the driver of its specific chipset\n", 0x170);
> +		}
>  	} else
>  		printk(KERN_INFO DRV_NAME ": enforcing probing of I/O ports "
>  			"upon user request\n");

MBR, Sergei

