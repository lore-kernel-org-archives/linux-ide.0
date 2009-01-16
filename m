From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] tx4939ide: Do not use zero count PRD entry
Date: Fri, 16 Jan 2009 15:51:29 +0300
Message-ID: <497082D1.5030504@ru.mvista.com>
References: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:48243 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933949AbZAPMve (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2009 07:51:34 -0500
In-Reply-To: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-mips@linux-mips.org, stable <stable@kernel.org>

Hello.

Atsushi Nemoto wrote:

> This fixes data corruption on some heavy load.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
> index bafb7d1..30d0d25 100644
> --- a/drivers/ide/tx4939ide.c
> +++ b/drivers/ide/tx4939ide.c
> @@ -259,6 +259,12 @@ static int tx4939ide_build_dmatable(ide_drive_t *drive, struct request *rq)
>  			bcount = 0x10000 - (cur_addr & 0xffff);
>  			if (bcount > cur_len)
>  				bcount = cur_len;
> +			/*
> +			 * This workaround for zero count seems required.
> +			 * (standard ide_build_dmatable do it too)
>   

    s/do/does/

> +			 */
> +			if ((bcount & 0xffff) == 0x0000)
>   

   Why not just bcount == 0x10000?

MBR, Sergei


