From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v4] pata_pdc2027x: Fix pdc_adjust_pll() to return the
 error value
Date: Wed, 6 Dec 2017 12:41:06 +0300
Message-ID: <ff019fe7-28e8-5657-1952-9485886b348a@cogentembedded.com>
References: <78542c42dcd2f21f6f7c01984061628fb4f19a42.1512499639.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40705 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754304AbdLFJlI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2017 04:41:08 -0500
Received: by mail-lf0-f66.google.com with SMTP id t197so3507429lfe.7
        for <linux-ide@vger.kernel.org>; Wed, 06 Dec 2017 01:41:07 -0800 (PST)
In-Reply-To: <78542c42dcd2f21f6f7c01984061628fb4f19a42.1512499639.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello!

On 12/5/2017 9:50 PM, Arvind Yadav wrote:

> This change is to ensure that function pdc_adjust_pll() returns the
> error value to avoid the unnecessary error check for pdc_hardware_init()
> in pdc2027x_reinit_one().
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2 :
>                 Make function return type 'void' instead of 'int.
>                 Add sapce between ':'.
> changes in v3 :
>                 Fix the checkpatch.pl errors in a sperate patch.
> changes in v4 :
>                 return the error value from pdc_adjust_pll()
> 
>   drivers/ata/pata_pdc2027x.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
> index 82bfd51..eca16b0 100644
> --- a/drivers/ata/pata_pdc2027x.c
> +++ b/drivers/ata/pata_pdc2027x.c
[...]
> @@ -664,9 +664,8 @@ static int pdc_hardware_init(struct ata_host *host, unsigned int board_idx)
>   	dev_info(host->dev, "PLL input clock %ld kHz\n", pll_clock/1000);
>   
>   	/* Adjust PLL control register */
> -	pdc_adjust_pll(host, pll_clock, board_idx);
> +	return pdc_adjust_pll(host, pll_clock, board_idx);
>   

    Please also remove this empty line (between *return* and }).

> -	return 0;
>   }
>   
>   /**

MBR, Sergei
