From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] ide: don't enable IORDY at a probe time
Date: Sun, 14 Jun 2009 00:58:44 +0400
Message-ID: <4A341304.4040304@ru.mvista.com>
References: <200906131823.15906.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57576 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756089AbZFMU6v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jun 2009 16:58:51 -0400
In-Reply-To: <200906131823.15906.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add 'unsigned long port_flags' field to ide_hwif_t.
>
> * Add IDE_PFLAG_PROBING port flag and keep it set during probing.
>
> * Fix ide_pio_need_iordy() to not enable IORDY at a probe time
>   (IORDY may lead to controller lock up on certain controllers
>    if the port is not occupied).
>
> Loosely based on the recent libata's fix by Tejun, thanks to Alan
> for the hint that IDE may also need it.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
[...]

> Index: b/drivers/ide/ide-xfer-mode.c
> ===================================================================
> --- a/drivers/ide/ide-xfer-mode.c
> +++ b/drivers/ide/ide-xfer-mode.c
> @@ -109,6 +109,12 @@ EXPORT_SYMBOL_GPL(ide_get_best_pio_mode)
>  
>  int ide_pio_need_iordy(ide_drive_t *drive, const u8 pio)
>  {
> +	/*
> +	 * IORDY may lead to controller lock up on certain controllers
> +	 * if the port is not occupied.
>   

   This is really strange -- shouldn't it be floating in this case, and 
so most sampled as 1? Who can pull it down on an empty port?..

> +	 */
> +	if (pio == 0 && (drive->hwif->port_flags & IDE_PFLAG_PROBING))
> +		return 0;
>   

   Now I'm seeing why there was a need to introduce the wrapper. :-)

MBR, Sergei


