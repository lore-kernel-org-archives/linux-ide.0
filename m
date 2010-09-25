From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] hpt366: fix clock turnaround
Date: Sat, 25 Sep 2010 20:40:43 +0400
Message-ID: <4C9E260B.2050603@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200912071803.37117.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36162 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496Ab0IYQl3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Sep 2010 12:41:29 -0400
Received: by eyb6 with SMTP id 6so987514eyb.19
        for <linux-ide@vger.kernel.org>; Sat, 25 Sep 2010 09:41:28 -0700 (PDT)
In-Reply-To: <200912071803.37117.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk

Hello.

I wrote:

> DPLL clock (0x21) should be used for writes and PCI clock (0x23) for reads,
> not vice versa.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Cc: stable@kernel.org

> ---
> The patch is atop of ide-2.6.git tree.

> Not sure why I didn't fix this back in 2007... well, nobody has ever
> complained. :-)

>  drivers/ide/hpt366.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: ide-2.6/drivers/ide/hpt366.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/hpt366.c
> +++ ide-2.6/drivers/ide/hpt366.c
> @@ -901,7 +901,7 @@ static void hpt3xxn_set_clock(ide_hwif_t
>  
>  static void hpt3xxn_rw_disk(ide_drive_t *drive, struct request *rq)
>  {
> -	hpt3xxn_set_clock(drive->hwif, rq_data_dir(rq) ? 0x23 : 0x21);
> +	hpt3xxn_set_clock(drive->hwif, rq_data_dir(rq) ? 0x21 : 0x23);
>  }
>  
>  /**
> 

    David, looks like this patch posted 12/07/2009 got lost somewhere? I still 
don't see it applied...

WBR, Sergei
