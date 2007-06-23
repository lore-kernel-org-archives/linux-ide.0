From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/6] qd65xx: fix PIO mode selection
Date: Sat, 23 Jun 2007 22:13:15 +0400
Message-ID: <467D62BB.2030305@ru.mvista.com>
References: <200706232002.07091.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15155 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752951AbXFWSLd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 14:11:33 -0400
In-Reply-To: <200706232002.07091.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> PIO4 is a maximum PIO mode supported by a driver.  Using "255" as a max_mode
> argument to ide_get_best_pio_mode() could result in wrong timings being used
> by a driver (for "pio" equal to 5) or OOPS (for "pio" values > 5 && < 255).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
>  drivers/ide/legacy/qd65xx.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: b/drivers/ide/legacy/qd65xx.c
> ===================================================================
> --- a/drivers/ide/legacy/qd65xx.c
> +++ b/drivers/ide/legacy/qd65xx.c
> @@ -258,8 +258,7 @@ static void qd6580_tune_drive (ide_drive
>  	int recovery_time = 415; /* worst case values from the dos driver */
>  
>  	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time)) {
> -		pio = ide_get_best_pio_mode(drive, pio, 255, &d);
> -		pio = min_t(u8, pio, 4);
> +		pio = ide_get_best_pio_mode(drive, pio, 4, &d);
>  
>  		switch (pio) {
>  			case 0: break;

MBR, Sergei
