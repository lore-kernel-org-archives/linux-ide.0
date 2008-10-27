From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] tx4938ide: Check minimum cycle time and SHWT range
Date: Mon, 27 Oct 2008 17:07:05 +0300
Message-ID: <4905CB09.5020805@ru.mvista.com>
References: <20081027.223913.128619425.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:38637 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751215AbYJ0OH3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 10:07:29 -0400
In-Reply-To: <20081027.223913.128619425.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

> SHWT value is used as address valid to -CSx assertion and -CSx to -DIOx
> assertion setup time, and contrarywise, -DIOx to -CSx release and -CSx
> release to address invalid hold time, so it actualy applies 4 times and
> so constitutes -DIOx recovery time.  Check requirement of the recovery
> time and cycle time.  Also check SHWT maximum value.

> Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

> diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
> index fa660f9..7e4820e 100644
> --- a/drivers/ide/tx4938ide.c
> +++ b/drivers/ide/tx4938ide.c
> @@ -39,10 +39,17 @@ static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
>  	/* Address-valid to DIOR/DIOW setup */
>  	shwt = DIV_ROUND_UP(t->setup, cycle);
>  
> +	/* -DIOx recovery time (SHWT * 4) and cycle time requirement */
> +	while (shwt * cycle * 4 + t->act8b < t->cycle)

    This can lead to adding an extra setup cycle due to use of "non-quantized" 
active time, here's more precise expression for the cycle time:

    (shwt * 4 + wt + (wt ? 2 : 3)) * cycle

or even this, more obsure:

    (shwt * 4 + wt + !wt + 2) * cycle

MBR, Sergei
