From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/4] it8213/piix/slc90e66: don't change DMA settings when programming PIO
Date: Sun, 22 Jul 2007 20:47:08 +0200
Message-ID: <200707222047.08128.bzolnier@gmail.com>
References: <200707201225.02931.bzolnier@gmail.com> <46A0F17B.3080702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:54122 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758388AbXGVS32 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:29:28 -0400
Received: by nf-out-0910.google.com with SMTP id g13so97999nfb
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:29:26 -0700 (PDT)
In-Reply-To: <46A0F17B.3080702@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 20 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added

> > Index: b/drivers/ide/pci/it8213.c
> > ===================================================================
> > --- a/drivers/ide/pci/it8213.c
> > +++ b/drivers/ide/pci/it8213.c
> > @@ -134,6 +134,11 @@ static int it8213_tune_chipset(ide_drive
> >  	u16			reg4042, reg4a;
> >  	u8			reg48, reg54, reg55;
> >  
> > +	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
> > +		it8213_tune_pio(drive, speed - XFER_PIO_0);
> > +		return ide_config_drive_speed(drive, speed);
> > +	}
> > +
> >  	pci_read_config_word(dev, maslave, &reg4042);
> >  	pci_read_config_byte(dev, 0x48, &reg48);
> >  	pci_read_config_word(dev, 0x4a, &reg4a);
> > @@ -153,12 +158,6 @@ static int it8213_tune_chipset(ide_drive
> >  		case XFER_MW_DMA_1:
> >  		case XFER_SW_DMA_2:
> >  			break;
> > -		case XFER_PIO_4:
> > -		case XFER_PIO_3:
> > -		case XFER_PIO_2:
> > -		case XFER_PIO_1:
> > -		case XFER_PIO_0:
> > -			break;
> 
>     Erm, why nmot just change this part, i.e. call it8213_tune_pio() and
> ide_config_drive_speed() here? Would have been simpler...

to get rid of unnecessary PCI reads

> >  		default:
> >  			return -1;
> >  	}
> > @@ -190,10 +189,7 @@ static int it8213_tune_chipset(ide_drive
> >  			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
> >  	}
> >  
> > -	if (speed > XFER_PIO_4)
> > -		it8213_tune_pio(drive, it8213_dma_2_pio(speed));
> > -	else
> > -		it8213_tune_pio(drive, speed - XFER_PIO_0);
> > +	it8213_tune_pio(drive, it8213_dma_2_pio(speed));
> >  
> >  	return ide_config_drive_speed(drive, speed);
> >  }
> [...]
> 
>     The same comment for 2 other drivers...

ditto
