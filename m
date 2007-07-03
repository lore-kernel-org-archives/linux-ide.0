From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 9/15] ide: add PIO masks
Date: Tue, 03 Jul 2007 23:28:17 +0400
Message-ID: <468AA351.4090509@ru.mvista.com>
References: <200706302107.42458.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:25648 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755966AbXGCT0g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 15:26:36 -0400
In-Reply-To: <200706302107.42458.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Bartlomiej Zolnierkiewicz wrote:

> * Add ATA_PIO[0-6] defines to <linux/ata.h>.

> * Add ->pio_mask field to ide_pci_device_t and ide_hwif_t.

> * Add PIO masks to host drivers.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

   Not sure if my ACK applies now...

> Index: b/drivers/ide/pci/jmicron.c
> ===================================================================
> --- a/drivers/ide/pci/jmicron.c
> +++ b/drivers/ide/pci/jmicron.c
> @@ -180,6 +180,7 @@ fallback:
>  		.autodma	= AUTODMA,		\
>  		.bootable	= ON_BOARD,		\
>  		.enablebits	= { {0x40, 1, 1}, {0x40, 0x10, 0x10} }, \
> +		.pio_mask	= ATA_PIO5,		\
>  	}

    Just noticed that this driver does nothing in its tuneproc() method. So, 
this mask is unrealistic. The method needs to be dropped for now along with 
config-jmicron_chipset_for_pio() -- ptobably, with FIXME added.

MBR, Sergei
