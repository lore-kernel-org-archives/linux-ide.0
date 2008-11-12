From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata-rb532-cf: fix signature of the xfer function
Date: Wed, 12 Nov 2008 13:54:05 +0300
Message-ID: <491AB5CD.3070504@ru.mvista.com>
References: <1226448821-10933-1-git-send-email-n0-1@freewrt.org> <1226448849-11460-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52922 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751375AbYKLKyM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 05:54:12 -0500
In-Reply-To: <1226448849-11460-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Florian Fainelli <florian@openwrt.org>

Hello.

Phil Sutter wrote:

> Per definition, this function should return the number of bytes
> consumed. Also take care of the unlikely case when buflen is not a
> multiple of four; while transferring, the division cuts the remaining
> bytes, so alter the return value accordingly.
>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
>   

Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>

   Except it should've been the first patch in the series.

> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index b919012..95a0d66 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -75,7 +75,7 @@ static void rb532_pata_exec_command(struct ata_port *ap,
>  	rb532_pata_finish_io(ap);
>  }
>  
> -static void rb532_pata_data_xfer(struct ata_device *adev,
> +static unsigned int rb532_pata_data_xfer(struct ata_device *adev,
>  		unsigned char *buf, unsigned int buflen, int write_data)
>  {
>  	struct ata_port *ap = adev->link->ap;
> @@ -87,6 +87,7 @@ static void rb532_pata_data_xfer(struct ata_device *adev,
>  		readsl(ioaddr, buf, buflen / sizeof(u32));
>  
>  	rb532_pata_finish_io(adev->link->ap);
> +	return buflen - (buflen % sizeof(u32));
>   

   Unneeded parens -- multiplication/division/modulo has natural 
priority over addition/subtraction.

WBR, Sergei


