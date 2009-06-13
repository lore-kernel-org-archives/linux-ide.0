From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] ata: add ata_id_pio_need_iordy() helper
Date: Sun, 14 Jun 2009 00:49:26 +0400
Message-ID: <4A3410D6.9060400@ru.mvista.com>
References: <200906131821.07018.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57399 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753017AbZFMUtc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jun 2009 16:49:32 -0400
In-Reply-To: <200906131821.07018.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Cc: Jeff Garzik <jgarzik@pobox.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> against Linus' tree
>
>  include/linux/ata.h |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> Index: b/include/linux/ata.h
> ===================================================================
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -800,6 +800,17 @@ static inline int ata_id_is_ssd(const u1
>  	return id[ATA_ID_ROT_SPEED] == 0x01;
>  }
>  
> +static inline int ata_id_pio_need_iordy(const u16 *id, const u8 pio)
> +{
> +	/* CF spec. r4.1 Table 22 says no IORDY on PIO5 and PIO6.  */
> +	if (ata_id_is_cfa(id) && pio > 4)
>   

   It actually makes sense to put the cheap 'pio' check first. We 
shouldn't call ata_id_is_cfa() for all modes.

> +		return 0;
> +	/* PIO3 and higher it is mandatory. */
> +	if (pio > 2 || ata_id_has_iordy(id))
> +		return 1;
> +	return 0;
> +}
> +

MBR, Sergei


