From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Tue, 29 Jan 2008 21:36:38 +0300
Message-ID: <479F7236.40404@ru.mvista.com>
References: <200801251512.09836.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:8454 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754739AbYA2Sfo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 13:35:44 -0500
In-Reply-To: <200801251512.09836.asalnikov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello.

Anton Salnikov wrote:

> This is Palmchip BK3710 IDE controller support for kernel version 2.6.24.
> The IDE controller logic supports PIO, multiword DMA and ultra-DMA modes.
> Supports interface to compact Flash (CF) configured in True-IDE mode.

> Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: 2.6.24.ide/drivers/ide/arm/palm_bk3710.c
> ===================================================================
> --- /dev/null
> +++ 2.6.24.ide/drivers/ide/arm/palm_bk3710.c

> +static void palm_bk3710_setudmamode(u32 base, unsigned int dev,
> +				    unsigned int mode)
> +{
> +	u8 tenv, trp, t0;
> +	u32 val32;
> +	u16 val16;
> +
> +	/* DMA Data Setup */
> +	t0 = (palm_bk3710_udmatimings[mode].cycletime + ide_palm_clk - 1)
> +			/ ide_palm_clk - 1;
> +	tenv = (20 + ide_palm_clk - 1) / ide_palm_clk - 1;
> +	trp = (palm_bk3710_udmatimings[mode].rptime + ide_palm_clk - 1)
> +			/ ide_palm_clk - 1;
> +
> +	/* udmatim Register */
> +	val16 = hwif_read16(base, BK3710_UDMATIM) & (dev ? 0xFF0F : 0xFFF0);
> +	val16 |= (mode << (dev ? 4 : 0));

    Needless parens all over the code like this...
    Also, you could have made it either 2 (getting rid of |= operator) or 4 
lines (read/write, &=, and |=).

MBR, Sergei
