From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.24-rc1] sata_promise: fix endianess bug in ASIC PRD
 bug workaround
Date: Sat, 03 Nov 2007 08:48:33 -0400
Message-ID: <472C6E21.6020303@garzik.org>
References: <200710311221.l9VCLTiG008243@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35163 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755408AbXKCMsf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 08:48:35 -0400
In-Reply-To: <200710311221.l9VCLTiG008243@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, Alexander Sabourenkov <screwdriver@lxnt.info>

Mikael Pettersson wrote:
> The original workaround for the Promise ASIC PRD bug
> contained an endianess bug which I failed to detect:
> the adjustment of the last PRD entry's length field
> applied host arithmetic to little-endian data, which
> is incorrect on big-endian machines.
> 
> We have the length available in host-endian format, so
> do the adjustment on host-endian data and then convert
> and store it in the PRD entry's little-endian data field.
> 
> Thanks to an anonymous reviewer for detecting this bug.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
> Jeff: please include this fix in any backport(s) of the
> ASIC PRD bug workaround.
> 
>  drivers/ata/sata_promise.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -rupN linux-2.6.24-rc1/drivers/ata/sata_promise.c linux-2.6.24-rc1.sata_promise-endianess-fix/drivers/ata/sata_promise.c
> --- linux-2.6.24-rc1/drivers/ata/sata_promise.c	2007-10-31 11:47:13.000000000 +0100
> +++ linux-2.6.24-rc1.sata_promise-endianess-fix/drivers/ata/sata_promise.c	2007-10-31 11:47:25.000000000 +0100
> @@ -585,7 +585,7 @@ static void pdc_fill_sg(struct ata_queue
>  			VPRINTK("Splitting last PRD.\n");
>  
>  			addr = le32_to_cpu(ap->prd[idx - 1].addr);
> -			ap->prd[idx - 1].flags_len -= cpu_to_le32(SG_COUNT_ASIC_BUG);
> +			ap->prd[idx - 1].flags_len = cpu_to_le32(len - SG_COUNT_ASIC_BUG);
>  			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);
>  
>  			addr = addr + len - SG_COUNT_ASIC_BUG;
> -

applied


