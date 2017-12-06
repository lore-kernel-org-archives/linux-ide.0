From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] pata_pdc2027x: Fix coding sytle errors
Date: Wed, 6 Dec 2017 12:43:14 +0300
Message-ID: <3a37d055-8ded-a8d3-8af8-b58f58726849@cogentembedded.com>
References: <1512498399-23577-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:41347 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754603AbdLFJn5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2017 04:43:57 -0500
Received: by mail-lf0-f54.google.com with SMTP id f18so3517210lfg.8
        for <linux-ide@vger.kernel.org>; Wed, 06 Dec 2017 01:43:56 -0800 (PST)
In-Reply-To: <1512498399-23577-1-git-send-email-arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 12/5/2017 9:26 PM, Arvind Yadav wrote:

> Fix these checkpatch.pl errors:
> Fix checkpatch.pl error:

    Why repeat it twice?

> ERROR: space prohibited before open square bracket '['.
> 
> ERROR: space prohibited after that '~' (ctx:WxW)
> +		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
> 
> ERROR: spaces required around that '?' (ctx:VxW)
> +	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
> 
> ERROR: that open brace { should be on the previous line
> +	const struct ata_port_info *ppi[] =
> +		{ &pdc2027x_port_info[board_idx], NULL };
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>               Subject and description was not correct.
>               *s/sytle error/style errors/ in the patch summary

    You didn't really fix the subject. :-/

[...]

MBR, Sergei
