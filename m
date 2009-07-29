From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pcmcia: add CNF-CDROM-ID for ide/pata
Date: Tue, 28 Jul 2009 21:10:57 -0400
Message-ID: <4A6FA1A1.4070604@garzik.org>
References: <1248625649-7193-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59209 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753775AbZG2BLB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 21:11:01 -0400
In-Reply-To: <1248625649-7193-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, David Miller <davem@davemloft.net>

Wolfram Sang wrote:
> Fixes this report:
> http://article.gmane.org/gmane.linux.kernel.pcmcia.devel/2228/
> 
> Reported-by: John McGrath <john@john-mcgrath.com>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/ata/pata_pcmcia.c |    1 +
>  drivers/ide/ide-cs.c      |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
> index f4d009e..dc99e26 100644
> --- a/drivers/ata/pata_pcmcia.c
> +++ b/drivers/ata/pata_pcmcia.c
> @@ -411,6 +411,7 @@ static struct pcmcia_device_id pcmcia_devices[] = {
>  	PCMCIA_DEVICE_PROD_ID123("PCMCIA", "IDE CARD", "F1", 0x281f1c5d, 0x1907960c, 0xf7fde8b9),
>  	PCMCIA_DEVICE_PROD_ID12("ARGOSY", "CD-ROM", 0x78f308dc, 0x66536591),
>  	PCMCIA_DEVICE_PROD_ID12("ARGOSY", "PnPIDE", 0x78f308dc, 0x0c694728),
> +	PCMCIA_DEVICE_PROD_ID12("CNF   ", "CD-ROM", 0x46d7db81, 0x66536591),
>  	PCMCIA_DEVICE_PROD_ID12("CNF CD-M", "CD-ROM", 0x7d93b852, 0x66536591),
>  	PCMCIA_DEVICE_PROD_ID12("Creative Technology Ltd.", "PCMCIA CD-ROM Interface Card", 0xff8c8a45, 0xfe8020c4),
>  	PCMCIA_DEVICE_PROD_ID12("Digital Equipment Corporation.", "Digital Mobile Media CD-ROM", 0x17692a66, 0xef1dcbde),

applied the pata_pcmcia portion of this

