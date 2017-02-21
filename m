From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/2] ide-generic: added messages in case of PCI IDE
 devices
Date: Tue, 21 Feb 2017 18:31:04 +0300
Message-ID: <d35bedc6-7d05-afdf-8a04-ffb27cb2a1b0@cogentembedded.com>
References: <20170221142249.GC11234@giustizia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33950 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbdBUPbK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Feb 2017 10:31:10 -0500
Received: by mail-lf0-f51.google.com with SMTP id g134so22604651lfe.1
        for <linux-ide@vger.kernel.org>; Tue, 21 Feb 2017 07:31:09 -0800 (PST)
In-Reply-To: <20170221142249.GC11234@giustizia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>, linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Miller <davem@davemloft.net>, petkovbb@gmail.com

Hello.

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

    CodingStyle: need {} in both *if* branches if at least one branch has them.

> +			printk(KERN_WARN DRV_NAME ": PCI IDE device detected at 0x%4.4x."
> +			     " ide-generic will not grab this device, delegating it to"
> +			     " the driver of its specific chipset\n", 0x1f0);

    The messages shouldn't be split -- checkpatch.pl knows about that.

> +		}
>
>  		if (secondary == 0)
>  			probe_mask |= 0x2;
> +		else {
> +			printk(KERN_WARN DRV_NAME ": PCI IDE device detected at 0x%4.4x."
> +			     " ide-generic will not grab this device, delegating it to"
> +			     " the driver of its specific chipset\n", 0x170);
> +		}

    Same here.

[..]

MBR, Sergei

