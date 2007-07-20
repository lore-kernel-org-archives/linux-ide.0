From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/4] it8213/piix/slc90e66: don't change DMA settings when
 programming PIO
Date: Fri, 20 Jul 2007 21:31:39 +0400
Message-ID: <46A0F17B.3080702@ru.mvista.com>
References: <200707201225.02931.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:48468 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1765844AbXGTR3h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 13:29:37 -0400
In-Reply-To: <200707201225.02931.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/pci/it8213.c
> ===================================================================
> --- a/drivers/ide/pci/it8213.c
> +++ b/drivers/ide/pci/it8213.c
> @@ -134,6 +134,11 @@ static int it8213_tune_chipset(ide_drive
>  	u16			reg4042, reg4a;
>  	u8			reg48, reg54, reg55;
>  
> +	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
> +		it8213_tune_pio(drive, speed - XFER_PIO_0);
> +		return ide_config_drive_speed(drive, speed);
> +	}
> +
>  	pci_read_config_word(dev, maslave, &reg4042);
>  	pci_read_config_byte(dev, 0x48, &reg48);
>  	pci_read_config_word(dev, 0x4a, &reg4a);
> @@ -153,12 +158,6 @@ static int it8213_tune_chipset(ide_drive
>  		case XFER_MW_DMA_1:
>  		case XFER_SW_DMA_2:
>  			break;
> -		case XFER_PIO_4:
> -		case XFER_PIO_3:
> -		case XFER_PIO_2:
> -		case XFER_PIO_1:
> -		case XFER_PIO_0:
> -			break;

    Erm, why nmot just change this part, i.e. call it8213_tune_pio() and
ide_config_drive_speed() here? Would have been simpler...

>  		default:
>  			return -1;
>  	}
> @@ -190,10 +189,7 @@ static int it8213_tune_chipset(ide_drive
>  			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
>  	}
>  
> -	if (speed > XFER_PIO_4)
> -		it8213_tune_pio(drive, it8213_dma_2_pio(speed));
> -	else
> -		it8213_tune_pio(drive, speed - XFER_PIO_0);
> +	it8213_tune_pio(drive, it8213_dma_2_pio(speed));
>  
>  	return ide_config_drive_speed(drive, speed);
>  }
[...]

    The same comment for 2 other drivers...

MBR, Sergei
