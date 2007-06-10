From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] [2.6.22] libata: fix probe time irq printouts
Date: Sat, 09 Jun 2007 22:42:04 -0400
Message-ID: <466B64FC.1090509@garzik.org>
References: <20070603233510.GA25750@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35831 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666AbXFJCmH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jun 2007 22:42:07 -0400
In-Reply-To: <20070603233510.GA25750@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Olof Johansson wrote:
> Most drivers don't seem to fill out the host->irq field, resulting in the
> wrong (no) irq being reported at probe time. For example, sil24 on my system:
> 
> ata1: SATA max UDMA/100 cmd 0xd00008009001f000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
> ata2: SATA max UDMA/100 cmd 0xd000080090021000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
> 
> Since they're allocated and set up in ata_host_activate(), just save
> them away there.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index af62514..7491b11 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6438,6 +6438,9 @@ int ata_host_activate(struct ata_host *host, int irq,
>  	if (rc)
>  		devm_free_irq(host->dev, irq, host);
>  
> +	/* Used to print device info at probe */
> +	host->irq = irq;
> +

applied, thanks for fixing that


