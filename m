From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
Date: Sun, 03 Dec 2006 08:03:39 -0500
Message-ID: <4572CB2B.8050406@garzik.org>
References: <200612010958.kB19wGbg002454@alkaid.it.uu.se> <4572CA7A.6010103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:17869 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1758606AbWLCNDm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Dec 2006 08:03:42 -0500
In-Reply-To: <4572CA7A.6010103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Hello, Mikael.
> 
> Thanks for doing this.
> 
> Mikael Pettersson wrote:
> [--snip--]
>> +static void pdc_freeze(struct ata_port *ap)
>> +{
>> +	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
>> +	u32 tmp;
>> +
>> +	tmp = readl(mmio + PDC_CTLSTAT);
>> +	tmp |= PDC_IRQ_DISABLE;
>> +	tmp &= ~PDC_DMA_ENABLE;
>> +	writel(tmp, mmio + PDC_CTLSTAT);
>> +	readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? sata_sil does this */
> 
> Just drop the above line.
> 
>> +}
>> +
>> +static void pdc_thaw(struct ata_port *ap)
>> +{
>> +	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
>> +	u32 tmp;
>> +
>> +	/* clear IRQ */
>> +	readl(mmio + PDC_INT_SEQMASK);
>> +
>> +	/* turn IRQ back on */
>> +	tmp = readl(mmio + PDC_CTLSTAT);
>> +	tmp &= ~PDC_IRQ_DISABLE;
>> +	writel(tmp, mmio + PDC_CTLSTAT);
>> +	readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? */
> 
> Ditto.

Why do you think these flushes are not needed?

	Jeff



