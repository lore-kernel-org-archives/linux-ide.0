From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support
Date: Thu, 11 Sep 2008 13:35:14 +0400
Message-ID: <48C8E652.5000800@ru.mvista.com>
References: <20080910.010830.51865999.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:35446 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752455AbYIKJfV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Sep 2008 05:35:21 -0400
In-Reply-To: <20080910.010830.51865999.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

> Add a helper routine to register tx4939ide driver and use it on
> RBTX4939 board.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   
[...]
> diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
> index f14a497..ee00bde 100644
> --- a/arch/mips/txx9/generic/setup_tx4939.c
> +++ b/arch/mips/txx9/generic/setup_tx4939.c
>   
[...]
> @@ -389,6 +390,34 @@ void __init tx4939_mtd_init(int ch)
>  	txx9_physmap_flash_init(ch, start, size, &pdata);
>  }
>  
> +void __init tx4939_ata_init(void)
> +{
> +	__u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
> +	if (pcfg & (TX4939_PCFG_ATA0MODE | TX4939_PCFG_ATA1MODE)) {
> +		struct resource res[2];
> +		int i;
> +		memset(res, 0, sizeof(res));
> +		for (i = 0; i < 2; i++) {
> +			if (i == 0 &&
> +			    !(pcfg & TX4939_PCFG_ATA0MODE))
> +				continue;
> +			if (i == 1 &&
> +			    (pcfg & (TX4939_PCFG_ATA1MODE |
> +				     TX4939_PCFG_ET1MODE |
> +				     TX4939_PCFG_ET0MODE)) !=
> +			    TX4939_PCFG_ATA1MODE)
> +				continue;
> +			res[0].start = TX4939_ATA_REG(i) & 0xfffffffffULL;
> +			res[0].end = res[0].start + 0x1000 - 1;
> +			res[0].flags = IORESOURCE_MEM;
> +			res[1].start = TXX9_IRQ_BASE + TX4939_IR_ATA(i);
> +			res[1].flags = IORESOURCE_IRQ;
> +			platform_device_register_simple("tx4939ide", i,
> +							res, ARRAY_SIZE(res));
>   

   Hm, why not declare both IDE platform devices statically an then 
register them depending on the TX4939_PCFG_ATA[01]MODE bits?
This loop doesn't look nice. You could at least have used an array to 
check TX4939_PCFG_ATA[01]MODE bitmasks but I think it's better to just 
declare devices statically...

MBR, Sergei


