From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support (v2)
Date: Thu, 23 Oct 2008 17:37:59 +0400
Message-ID: <49007E37.5080605@ru.mvista.com>
References: <20081023.011646.51867355.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:9636 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756526AbYJWNiJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2008 09:38:09 -0400
In-Reply-To: <20081023.011646.51867355.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

> Add a helper routine to register tx4938ide driver and use it on
> RBTX4938 board.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/arch/mips/include/asm/txx9/tx4938.h b/arch/mips/include/asm/txx9/tx4938.h
> index 989e775..3dada66 100644
> --- a/arch/mips/include/asm/txx9/tx4938.h
> +++ b/arch/mips/include/asm/txx9/tx4938.h
> @@ -292,4 +292,17 @@ void tx4938_setup_pcierr_irq(void);
>  void tx4938_irq_init(void);
>  void tx4938_mtd_init(int ch);
>  
> +struct tx4938ide_platform_info {
> +	/*
> +	 * I/O port shift, for platforms with ports that are
> +	 * constantly spaced and need larger than the 1-byte
> +	 * spacing used by ata_std_ports().
> +	 */
> +	unsigned int ioport_shift;
> +	unsigned int gbus_clock;	/*  0 means no-autotune. */
>   

   I'd say "no PIO mode tuning" since the mode can also be changed via 
HDIO_SET_PIO_MODE which e.g. 'hdparm -p' calls...

> diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
> index af724e5..e6c558e 100644
> --- a/arch/mips/txx9/generic/setup_tx4938.c
> +++ b/arch/mips/txx9/generic/setup_tx4938.c
>   
[...]
> @@ -335,6 +336,52 @@ void __init tx4938_mtd_init(int ch)
>  	txx9_physmap_flash_init(ch, start, size, &pdata);
>  }
>  
> +void __init tx4938_ata_init(unsigned int irq, unsigned int shift, int tune)
> +{
> +	struct platform_device *pdev;
> +	struct resource res[] = {
> +		{
> +			/* .start and .end are filled in later */
> +			.flags = IORESOURCE_MEM,
> +		}, {
> +			.start = irq,
> +			.flags = IORESOURCE_IRQ,
> +		},
> +	};
> +	struct tx4938ide_platform_info pdata = {
> +		.ioport_shift = shift,
> +		/*
> +		 * The ide driver should not do autotune if other ISA
>   

  "The IDE driver should not change bus timings", I'd say.

MBR, Sergei


