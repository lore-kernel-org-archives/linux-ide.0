From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/15] ide: ide_find_best_pio_mode() fixes
Date: Mon, 02 Jul 2007 19:20:50 +0400
Message-ID: <468917D2.6010907@ru.mvista.com>
References: <200706302104.42299.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:15386 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751486AbXGBPTJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 11:19:09 -0400
In-Reply-To: <200706302104.42299.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> * Check IORDY bit for PIO modes > 2.

> * Some devices claim maximum PIO mode > 2 in id->tPIO, they were punished too
>   severly for this by being limited to PIO_SLOW.  Limit them to PIO2 instead.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    NAK. :-)

> Index: b/drivers/ide/ide-timing.h
> ===================================================================
> --- a/drivers/ide/ide-timing.h
> +++ b/drivers/ide/ide-timing.h
> @@ -111,16 +111,14 @@ static short ide_find_best_pio_mode(ide_
>  	struct hd_driveid *id = drive->id;
>  	short best = 0;
>  
> -	if (id->field_valid & 2) {	/* EIDE PIO modes */
> -
> +	/* EIDE PIO modes */
> +	if ((id->field_valid & 2) && (id->capability & 8)) {
>  		if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
>  			    (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
>  			    (drive->id->eide_pio_modes & 1) ? XFER_PIO_3 : 0)) return best;
>  	}
> -	
> -	return  (drive->id->tPIO == 2) ? XFER_PIO_2 :
> -		(drive->id->tPIO == 1) ? XFER_PIO_1 :
> -		(drive->id->tPIO == 0) ? XFER_PIO_0 : XFER_PIO_SLOW;
> +
> +	return min_t(u8, id->tPIO, 2);

    XFER_PIO_[012] != [012], and otherwise you're returning XFER_PIO_* constants.

MBR, Sergei
