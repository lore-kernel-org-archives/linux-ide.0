From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 10/20] pata_radisys: unify code for programming PIO and
 MWDMA timings
Date: Sun, 20 Feb 2011 18:01:35 +0300
Message-ID: <4D612CCF.4080102@ru.mvista.com>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site> <20110208122446.19110.16806.sendpatchset@linux-mhg7.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f180.google.com ([209.85.215.180]:60097 "EHLO
	mail-ey0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab1BTPCy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Feb 2011 10:02:54 -0500
In-Reply-To: <20110208122446.19110.16806.sendpatchset@linux-mhg7.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 08-02-2011 15:24, Bartlomiej Zolnierkiewicz wrote:

>  From 656a1d1e17b035c7de7e7ea602f03724fdcbb336 Mon Sep 17 00:00:00 2001
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Date: Tue, 8 Feb 2011 12:39:26 +0100
> Subject: [PATCH 10/20] pata_radisys: unify code for programming PIO and MWDMA timings

> Besides making things noticably simpler it results in ~6% decrease in
> the driver LOC count and also ~1% decrease in the driver binary size
> (as measured on x86-32).

> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
[...]

> diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
> index 8574b31..e85bb38 100644
> --- a/drivers/ata/pata_radisys.c
> +++ b/drivers/ata/pata_radisys.c
[...]
> @@ -62,6 +51,10 @@ static void radisys_set_piomode (struct ata_port *ap, struct ata_device *adev)
>   		control |= 1;	/* TIME1 enable */
>   	if (ata_pio_need_iordy(adev))
>   		control |= 2;	/* IE IORDY */
> +	/* If the drive MWDMA is faster than it can do PIO then
> +	   we must force PIO0 for PIO cycles. */

    Fix the comment style please.

> +	if (use_mwdma && adev->pio_mode < (XFER_PIO_0 + pio))
> +		control = 1;

    Wait, this bit is enabling fast timings for both PIO and DMA, no?

> @@ -78,6 +71,22 @@ static void radisys_set_piomode (struct ata_port *ap, struct ata_device *adev)
>   }
>
>   /**
> + *	radisys_set_piomode - Initialize host controller PATA PIO timings
> + *	@ap: ATA port
> + *	@adev: Device whose timings we are configuring
> + *
> + *	Set PIO mode for device, in host controller PCI config space.
> + *
> + *	LOCKING:
> + *	None (inherited from caller).
> + */
> +
> +static void radisys_set_piomode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	radisys_set_timings(ap, adev, adev->pio_mode - XFER_PIO_0, 0);

    s/0/false/?

> @@ -91,22 +100,10 @@ static void radisys_set_piomode (struct ata_port *ap, struct ata_device *adev)
>   static void radisys_set_dmamode (struct ata_port *ap, struct ata_device *adev)
>   {
>   	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
> -	u16 idetm_data;
>   	u8 udma_enable;
>
> -	static const	 /* ISP  RTC */
> -	u8 timings[][2]	= { { 0, 0 },
> -			    { 0, 0 },
> -			    { 1, 1 },
> -			    { 2, 2 },
> -			    { 3, 3 }, };
> -
> -	/*
> -	 * MWDMA is driven by the PIO timings. We must also enable
> -	 * IORDY unconditionally.
> -	 */
> +	/* MWDMA is driven by the PIO timings. */
>
> -	pci_read_config_word(dev, 0x40,&idetm_data);
>   	pci_read_config_byte(dev, 0x48,&udma_enable);

     You're not touching this read here also...

> @@ -115,20 +112,8 @@ static void radisys_set_dmamode (struct ata_port *ap, struct ata_device *adev)
[...]
> +		radisys_set_timings(ap, adev, pio, 1);

    s/1/true/?

WBR, Sergei
