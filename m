From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 20/21] ide: fix host drivers depending on ide_generic
 to probe for interfaces
Date: Wed, 12 Dec 2007 16:33:35 +0300
Message-ID: <475FE32F.2000601@ru.mvista.com>
References: <200711182341.27444.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:13046 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751925AbXLLNdQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Dec 2007 08:33:16 -0500
In-Reply-To: <200711182341.27444.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Add mpc8xx_ide_probe() to mpc8xx.c and call it from probe_for_hwifs().

> * Convert ide_arm, ide-cris, ide-h8300, ide-pnp, buddha, falconide, gayle,
>   macide, q40ide, cmd640 and mpc8xx host drivers to use ide_device_add().

>   This removes dependency on ide_generic for these drivers so update
>   ide/Kconfig accordingly.

> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Roman Zippel <zippel@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/arm/ide_arm.c
> ===================================================================
> --- a/drivers/ide/arm/ide_arm.c
> +++ b/drivers/ide/arm/ide_arm.c
> @@ -28,6 +28,7 @@ void __init ide_arm_init(void)
>  {
>  	ide_hwif_t *hwif;
>  	hw_regs_t hw;
> +	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
>  
>  	memset(&hw, 0, sizeof(hw));
>  	ide_std_init_ports(&hw, IDE_ARM_IO, IDE_ARM_IO + 0x206);
> @@ -36,5 +37,8 @@ void __init ide_arm_init(void)
>  	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
>  	if (hwif) {
>  		ide_init_port_hw(hwif, &hw);
> +		idx[0] = hwif->index;
> +
> +		ide_device_idx(idx);

    You surely meant ide_device_add() here. Worth test compiling the files 
you're changing... ;-)

MBR, Sergei
