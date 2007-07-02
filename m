From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/15] ide: drop "PIO data" argument from ide_get_best_pio_mode()
Date: Mon, 02 Jul 2007 21:41:34 +0400
Message-ID: <468938CE.8010202@ru.mvista.com>
References: <200706302105.20596.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:16630 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752727AbXGBRjw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 13:39:52 -0400
In-Reply-To: <200706302105.20596.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Drop no longer needed "PIO data" argument from ide_get_best_pio_mode()
>   and convert all users accordingly.

> * Remove no longer needed ide_pio_data_t.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/pci/tc86c001.c
> ===================================================================
> --- a/drivers/ide/pci/tc86c001.c
> +++ b/drivers/ide/pci/tc86c001.c
> @@ -47,7 +47,7 @@ static int tc86c001_tune_chipset(ide_dri
>  
>  static void tc86c001_tune_drive(ide_drive_t *drive, u8 pio)
>  {
> -	pio =  ide_get_best_pio_mode(drive, pio, 4, NULL);
> +	pio = ide_get_best_pio_mode(drive, pio, 4);

    Oh, you've ruined my formatting... :'-[

>  	(void) tc86c001_tune_chipset(drive, XFER_PIO_0 + pio);
>  }
>  

MBR, Sergei
