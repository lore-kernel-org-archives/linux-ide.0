From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Wed, 23 Jan 2008 17:32:04 +0300
Message-ID: <47974FE4.8090906@ru.mvista.com>
References: <200801212144.29511.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:8497 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752220AbYAWObO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jan 2008 09:31:14 -0500
In-Reply-To: <200801212144.29511.asalnikov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Anton Salnikov wrote:

> This is Palmchip BK3710 IDE controller support for kernel version 2.6.24-rc8.
> The IDE controller logic supports PIO, multiword DMA and ultra-DMA modes.
> Supports interface to compact Flash (CF) configured in True-IDE mode.

> Use ide_setup_dma() since BLK_DEV_PALMCHIP_BK3710 selects BLK_DEV_IDEDMA_PCI
> So I deleted exports from ide-dma.c

> Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>

    Looks like I found another issue caused by using iowrite32() for 16-bit 
registers:

> Index: 2.6.24-rc8.ide/drivers/ide/arm/palm_bk3710.c
> ===================================================================
> --- /dev/null
> +++ 2.6.24-rc8.ide/drivers/ide/arm/palm_bk3710.c
> @@ -0,0 +1,434 @@
[...]
> +#define BK3710_BMICP		0x00
> +#define BK3710_BMISP		0x02
> +#define BK3710_BMIDTP		0x04
> +#define BK3710_BMICS		0x08
> +#define BK3710_BMISS		0x0A
> +#define BK3710_BMIDTS		0x0C
> +#define BK3710_IDETIMP		0x40
> +#define BK3710_IDETIMS		0x42
> +#define BK3710_SIDETIM		0x44
> +#define BK3710_SLEWCTL		0x45
> +#define BK3710_IDESTATUS	0x47
> +#define BK3710_UDMACTL		0x48
> +#define BK3710_UDMATIM		0x4A

    Note that the above two registers are 16-bit...

> +#define BK3710_MISCCTL		0x50
> +#define BK3710_REGSTB		0x54
> +#define BK3710_REGRCVR		0x58
> +#define BK3710_DATSTB		0x5C
> +#define BK3710_DATRCVR		0x60
> +#define BK3710_DMASTB		0x64
> +#define BK3710_DMARCVR		0x68
> +#define BK3710_UDMASTB		0x6C
> +#define BK3710_UDMATRP		0x70
> +#define BK3710_UDMAENV		0x74
> +#define BK3710_IORDYTMP		0x78
> +#define BK3710_IORDYTMS		0x7C
[...]
> +static void palm_bk3710_setudmamode(unsigned int dev, unsigned int mode)
> +{
> +	u8 tenv, trp, t0;
> +	u32 val;
> +
> +	/* DMA Data Setup */
> +	t0 = (palm_bk3710_udmatimings[mode].cycletime + ide_palm_clk - 1)
> +			/ ide_palm_clk - 1;
> +	tenv = (20 + ide_palm_clk - 1) / ide_palm_clk - 1;
> +	trp = (palm_bk3710_udmatimings[mode].rptime + ide_palm_clk - 1)
> +			/ ide_palm_clk - 1;
> +
> +	/* udmatim Register */
> +	val = ioread(BK3710_UDMATIM) & ((!dev) ? 0xFFF0 : 0xFF0F);
> +	iowrite(val, BK3710_UDMATIM);
> +	val = ioread(BK3710_UDMATIM) | (mode << ((!dev) ? 0 : 4));
> +	iowrite(val, BK3710_UDMATIM);

    This register is 16-bit, so:

1) you're performing unaligned access which would end up emulated in the best
    case;
2) you're clearing MISCCTL reg. inadvertently...

[...]

> +static void palm_bk3710_setdmamode(unsigned int dev, unsigned int cycletime,
> +				  unsigned int mode)
> +{
> +	u8 td, tkw, t0;
> +	u32 val;
> +
> +	if (cycletime < ide_timing[mode].cycle)
> +		cycletime = ide_timing[mode].cycle;
> +
> +	/* DMA Data Setup */
> +	t0 = (cycletime + ide_palm_clk - 1) / ide_palm_clk;
> +	td = (ide_timing_find_mode(mode)->active + ide_palm_clk - 1)
> +			/ ide_palm_clk;
> +	tkw = t0 - td - 1;
> +	td -= 1;
> +
> +	val = ioread(BK3710_DMASTB) & (0xFF << ((!dev) << 4));
> +	iowrite(val, BK3710_DMASTB);
> +	val = ioread(BK3710_DMASTB) | (td << (dev << 4));
> +	iowrite(val, BK3710_DMASTB);
> +
> +	val = ioread(BK3710_DMARCVR) & (0xFF << ((!dev) << 4));
> +	iowrite(val, BK3710_DMARCVR);
> +	val = ioread(BK3710_DMARCVR) | (tkw << (dev << 4));
> +	iowrite(val, BK3710_DMARCVR);
> +
> +	/* Disable UDMA for Device */
> +	val = ioread(BK3710_UDMACTL) & (0xFF00 | (1 << (!dev)));
> +	iowrite(val, BK3710_UDMACTL);

    This register is also 16-bit, so:

1) you're performing unaligned access which would end up emulated in the best
    case;
2) you're clearing UDMATIM reg. inadvertently (although this seems safe as 
you're disabling UltraDMA anyway...

[...]

> +static void __devinit palm_bk3710_chipinit(void)
> +{
> +	/*
> +	 * enable the reset_en of ATA controller so that when ata signals
> +	 * are brought out, by writing into device config. at that
> +	 * time por_n signal should not be 'Z' and have a stable value.
> +	 */
> +	iowrite(0x0300, BK3710_MISCCTL);
> +
> +	/* wait for some time and deassert the reset of ATA Device. */
> +	mdelay(100);
> +
> +	/* Deassert the Reset */
> +	iowrite(0x0200, BK3710_MISCCTL);
> +
> +	/*
> +	 * Program the IDETIMP Register Value based on the following assumptions
> +	 *
> +	 * (ATA_IDETIMP_IDEEN		, ENABLE ) |
> +	 * (ATA_IDETIMP_SLVTIMEN	, DISABLE) |
> +	 * (ATA_IDETIMP_RDYSMPL		, 70NS)    |
> +	 * (ATA_IDETIMP_RDYRCVRY	, 50NS)    |
> +	 * (ATA_IDETIMP_DMAFTIM1	, PIOCOMP) |
> +	 * (ATA_IDETIMP_PREPOST1	, DISABLE) |
> +	 * (ATA_IDETIMP_RDYSEN1		, DISABLE) |
> +	 * (ATA_IDETIMP_PIOFTIM1	, DISABLE) |
> +	 * (ATA_IDETIMP_DMAFTIM0	, PIOCOMP) |
> +	 * (ATA_IDETIMP_PREPOST0	, DISABLE) |
> +	 * (ATA_IDETIMP_RDYSEN0		, DISABLE) |
> +	 * (ATA_IDETIMP_PIOFTIM0	, DISABLE)
> +	 */
> +	iowrite(0xB388, BK3710_IDETIMP);

    This register is 16-bit, so:

1) you're performing unaligned access which would end up emulated in the best
    case;
2) you're clearing IDETIMS reg. inadvertently (probably safe as your device 
doesn't seem to have a secondary channel...

[...]

> +
> +	/*
> +	 * Configure  SIDETIM  Register
> +	 * (ATA_SIDETIM_RDYSMPS1	,120NS ) |
> +	 * (ATA_SIDETIM_RDYRCYS1	,120NS )
> +	 */
> +	iowrite(0, BK3710_SIDETIM);

    This register is 8-bit, so:

1) you're performing unaligned access which would end up emulated in the best
    case;
2) you're clearing SLEWCTL/IDESTATUS regs inadvertently...

> +
> +	/*
> +	 * UDMACTL Ultra-ATA DMA Control
> +	 * (ATA_UDMACTL_UDMAP1	, 0 ) |
> +	 * (ATA_UDMACTL_UDMAP0	, 0 )
> +	 *
> +	 */
> +	iowrite(0, BK3710_UDMACTL);

    This register is 16-bit, so:

1) you're performing unaligned access which would end up emulated in the best
    case;
2) you're clearing UDMATIM regs inadvertently...

> +	/*
> +	 * Configure BMISP Register
> +	 * (ATA_BMISP_DMAEN1	, DISABLE )	|
> +	 * (ATA_BMISP_DMAEN0	, DISABLE )	|
> +	 * (ATA_BMISP_IORDYINT	, CLEAR)	|
> +	 * (ATA_BMISP_INTRSTAT	, CLEAR)	|
> +	 * (ATA_BMISP_DMAERROR	, CLEAR)
> +	 */
> +	iowrite(0, BK3710_BMISP);

    This register is 8-bit, so:

1) you're performing unaligned access which would end up emulated in the best
    case;
2) you're clearing BMIDTP regs inadvertently...

MBR, Sergei
