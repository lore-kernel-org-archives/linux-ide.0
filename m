From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Fri, 22 Oct 2004 19:07:15 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041022190715.B3459@flint.arm.linux.org.uk>
References: <58cb370e04102210385ca8b554@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30724 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267839AbUJVSHW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Oct 2004 14:07:22 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e04102210385ca8b554@mail.gmail.com>; from bzolnier@gmail.com on Fri, Oct 22, 2004 at 07:38:44PM +0200
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 07:38:44PM +0200, Bartlomiej Zolnierkiewicz wrote:
> @@ -498,14 +483,6 @@
>  			ICS_ARCIN_V6_INTRSTAT_1)) & 1;
>  }
>  
> -static int icside_dma_verbose(ide_drive_t *drive)
> -{
> -	printk(", %s (peak %dMB/s)",
> -		ide_xfer_verbose(drive->current_speed),
> -		2000 / drive->drive_data);
> -	return 1;
> -}
> -
>  static int icside_dma_timeout(ide_drive_t *drive)
>  {
>  	printk(KERN_ERR "%s: DMA timeout occurred: ", drive->name);
> @@ -554,7 +531,6 @@
>  	hwif->dma_start		= icside_dma_start;
>  	hwif->ide_dma_end	= icside_dma_end;
>  	hwif->ide_dma_test_irq	= icside_dma_test_irq;
> -	hwif->ide_dma_verbose	= icside_dma_verbose;
>  	hwif->ide_dma_timeout	= icside_dma_timeout;
>  	hwif->ide_dma_lostirq	= icside_dma_lostirq;

Why are you denying me the ability to report detailed drive transfer
speed information?  Would you prefer me to printk a separate line
and further clutter up the message log instead?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
