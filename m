From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] pata_pdc2027x: Remove unnecessary error check and coding
 style error.
Date: Sat, 25 Nov 2017 13:00:26 +0300
Message-ID: <4dcd6458-f289-57e0-a921-5e1b00d91800@cogentembedded.com>
References: <9c2e4c1081be44da4460072ae6129d29c7e6d6bc.1511583254.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:39376 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdKYKAa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 25 Nov 2017 05:00:30 -0500
Received: by mail-lf0-f50.google.com with SMTP id x76so23107867lfb.6
        for <linux-ide@vger.kernel.org>; Sat, 25 Nov 2017 02:00:29 -0800 (PST)
In-Reply-To: <9c2e4c1081be44da4460072ae6129d29c7e6d6bc.1511583254.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 11/25/2017 7:15 AM, Arvind Yadav wrote:

> Here, The function pdc_hardware_init always return zero. So it is not
> necessary to check its return value.
> 
> Fix these checkpatch.pl error:
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

    Please fix the checkpatch.pl errors in a sperate patch.

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
[...]

MBR, Sergei
