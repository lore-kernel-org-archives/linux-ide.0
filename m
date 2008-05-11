From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_promise.c:pdc_irq_clear() buglet?
Date: Sun, 11 May 2008 17:31:12 -0400
Message-ID: <482765A0.8020002@pobox.com>
References: <18471.25405.877617.621279@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46147 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441AbYEKVbO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 May 2008 17:31:14 -0400
In-Reply-To: <18471.25405.877617.621279@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Jeff,
> 
> In the 2.6.8 kernel you added sata_promise.c:pdc_irq_clear()
> which looks as follows:
> 
>> static void pdc_irq_clear(struct ata_port *ap)
>> {
>>        struct ata_host *host = ap->host;
>>        void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
>>
>>        readl(mmio + PDC_INT_SEQMASK);
>> }
> 
> I have two issues with this code:
> 1. It reads from the SEQMASK register, which is global for
>    all ports. Hence, calling pdc_irq_clear() on one port
>    potentially affects all ports.
> 2. Promise's drivers (both 1st and 2nd generation chip drivers)
>    instead read the port's ATA Command/Status register when
>    they want to clear any pending IRQs.
> 
> Did you write the code this way on purpose, or did you just
> accidentally use the wrong mechanism?
> 
> If you have no objections, I intend to change this to read
> Command/Status instead.

For sata_promise, at the time it was written, irq_clear was largely a 
sledgehammer for SFF situations that didn't automatically resolve 
themselves through normal operation.  Given the amount of SFF code that 
is _not_ enabled when using sata_promise is in use, ->irq_clear() is 
largely a relic for PIO data xfer situations.

Feel free to replace if you think is appropriate...

	Jeff



