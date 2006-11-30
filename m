From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: blacklist for early irq problem
Date: Thu, 30 Nov 2006 15:45:30 -0500
Message-ID: <456F42EA.1020806@rtr.ca>
References: <200611180759.34622.t.powa@gmx.de> <20061118002357.564dbb9d.akpm@osdl.org> <455F790C.2030509@garzik.org> <456BDCAC.4060609@tw.ibm.com> <456C4514.9090107@tw.ibm.com> <456C4ACC.1050806@rtr.ca> <456C8A51.3000605@garzik.org> <456EA7D6.2050101@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:35082 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S967865AbWK3Upd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Nov 2006 15:45:33 -0500
In-Reply-To: <456EA7D6.2050101@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

Albert Lee wrote:
>...
>  
> +	/* some drives raise INTRQ early before clearing BSY */
> +	if (unlikely(qc->dev->horkage & ATA_HORKAGE_EARLY_IRQ))
> +		/* wait up to 10 microseconds for BSY to clear */
> +		ata_busy_wait_alt(ap, ATA_BUSY, ATA_EARLY_IRQ_WAIT);
> +
>  	/* check altstatus */
>  	status = ata_altstatus(ap);
>  	if (status & ATA_BUSY)
...

I dunno.

I think a much simpler patch could address the same situation,
with *no blacklist* to maintain, and no added overhead required:

	/* check altstatus */
+	retries = 10;
+	while (((status = ata_altstatus(ap)) & ATA_BUSY) && --retries) {
+		udelay(1);
+	}
-	status = ata_altstatus(ap);
	if (status & ATA_BUSY)

This still just does a single access in the hot path, but without any
real added complexity otherwise.

????
