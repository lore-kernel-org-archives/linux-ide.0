From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/4] ide: use only ->set_pio_mode method for programming
 PIO modes
Date: Mon, 23 Jul 2007 00:25:30 +0400
Message-ID: <46A3BD3A.6050605@ru.mvista.com>
References: <200707201226.13405.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:60162 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762826AbXGVUX3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 16:23:29 -0400
In-Reply-To: <200707201226.13405.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Use ->set_pio_mode method to program PIO modes in ide_set_xfer_rate()
> (the only place which used ->speedproc to program PIO modes) and remove
> handling of PIO modes from all ->speedproc implementations.

> There should be no functionality changes caused by this patch.

    Does a missing printk(KERN_ERR, ...) in the cs5520.c count as a 
functionality change? ;-)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/cris/ide-cris.c   |    5 -----
>  drivers/ide/pci/alim15x3.c    |    5 -----
>  drivers/ide/pci/atiixp.c      |    5 -----
>  drivers/ide/pci/cmd64x.c      |    8 --------
>  drivers/ide/pci/cs5530.c      |    7 -------
>  drivers/ide/pci/it8213.c      |    5 -----
>  drivers/ide/pci/it821x.c      |    9 ---------
>  drivers/ide/pci/piix.c        |    5 -----
>  drivers/ide/pci/sc1200.c      |   10 ----------
>  drivers/ide/pci/scc_pata.c    |    7 -------
>  drivers/ide/pci/serverworks.c |    5 -----
>  drivers/ide/pci/siimage.c     |    7 -------
>  drivers/ide/pci/sis5513.c     |   12 ++----------
>  drivers/ide/pci/sl82c105.c    |    8 --------
>  drivers/ide/pci/slc90e66.c    |    5 -----

    These don't need their *_tune_pio() as a separate item anymore, however it 
should be OK as gcc will inline them...

> Index: b/drivers/ide/ide-lib.c
> ===================================================================
> --- a/drivers/ide/ide-lib.c
> +++ b/drivers/ide/ide-lib.c
> @@ -398,6 +398,18 @@ int ide_set_xfer_rate(ide_drive_t *drive
>  
>  	rate = ide_rate_filter(drive, rate);
>  
> +	if (rate >= XFER_PIO_0 && rate <= XFER_PIO_5) {
> +		if (hwif->set_pio_mode)
> +			hwif->set_pio_mode(drive, rate - XFER_PIO_0);
> +
> +		/*
> +		 * FIXME: this incorrect to return zero here but

    Missing "is" before "this"...

> +		 * since all users of ide_set_xfer_rate() ignore
> +		 * the return value it is not a problem currently
> +		 */
> +		return 0;
> +	}
> +
>  	return hwif->speedproc(drive, rate);
>  }

    Erm, what if there's no DMA mode support an therefore no speedproc() 
method, only set_pio_mode()?  I guess that moving the (speedproc() == NULL) 
check in a prior patch was somewhat rash...

> Index: b/drivers/ide/pci/cs5520.c
> ===================================================================
> --- a/drivers/ide/pci/cs5520.c
> +++ b/drivers/ide/pci/cs5520.c
> @@ -66,30 +66,13 @@ static struct pio_clocks cs5520_pio_cloc
>  	{1, 2, 1}
>  };
>  
> -static int cs5520_tune_chipset(ide_drive_t *drive, const u8 speed)
> +static void cs5520_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
>  	ide_hwif_t *hwif = HWIF(drive);
>  	struct pci_dev *pdev = hwif->pci_dev;
> -	int pio = speed;
> -	u8 reg;
>  	int controller = drive->dn > 1 ? 1 : 0;

    Wouldn't hwif->channel be enough?

> +	u8 reg;
>  
> -	switch(speed)
> -	{
> -		case XFER_PIO_4:
> -		case XFER_PIO_3:
> -		case XFER_PIO_2:
> -		case XFER_PIO_1:
> -		case XFER_PIO_0:
> -			pio -= XFER_PIO_0;
> -			break;
> -		default:
> -			pio = 0;
> -			printk(KERN_ERR "cs55x0: bad ide timing.\n");
> -	}
> -	
> -	printk("PIO clocking = %d\n", pio);
> -	
>  	/* FIXME: if DMA = 1 do we need to set the DMA bit here ? */

    Indeed?  Guess not. :-)

>  	/* 8bit CAT/CRT - 8bit command timing for channel */
> @@ -114,12 +97,21 @@ static int cs5520_tune_chipset(ide_drive
>  	reg |= 1<<((drive->dn&1)+5);
>  	outb(reg, hwif->dma_base + 0x02 + 8*controller);

    That should go...

> -	return ide_config_drive_speed(drive, speed);
> +	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
>  }
>  
> -static void cs5520_set_pio_mode(ide_drive_t *drive, const u8 pio)
> +static int cs5520_tune_chipset(ide_drive_t *drive, const u8 speed)
>  {
> -	cs5520_tune_chipset(drive, XFER_PIO_0 + pio);
> +	printk(KERN_ERR "cs55x0: bad ide timing.\n");
> +
> +	cs5520_set_pio_mode(drive, 0);

    Huh?

> +
> +	/*
> +	 * FIXME: this incorrect to return zero here but

    Again, no "is" before "this"...

> +	 * since all users of ide_set_xfer_rate() ignore
> +	 * the return value it is not a problem currently
> +	 */
> +	return 0;
>  }

    The question is why we have to leave the speedproc() handler to be in this 
driver that doesn't support DMA modes per se?

MBR, Sergei
