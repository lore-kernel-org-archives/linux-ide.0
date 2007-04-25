From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.21-rc7-mm1 BUG at kernel/sched-clock.c:175 init_sched_clock()
Date: Wed, 25 Apr 2007 19:25:10 +0900
Message-ID: <462F2C86.7030009@gmail.com>
References: <462E4C4D.9020806@gmail.com>	<20070425011654.222a2b4b.akpm@linux-foundation.org>	<462F1481.8010807@gmail.com>	<20070425085432.GD17130@htj.dyndns.org> <20070425112533.19d4a1aa@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:20272 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161522AbXDYKZQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 06:25:16 -0400
Received: by py-out-1112.google.com with SMTP id a29so148962pyi
        for <linux-ide@vger.kernel.org>; Wed, 25 Apr 2007 03:25:15 -0700 (PDT)
In-Reply-To: <20070425112533.19d4a1aa@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Berck E. Nash" <flyboy@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 72c286e..a128717 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1369,10 +1369,14 @@ static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
>>  
>>  static void ahci_freeze(struct ata_port *ap)
>>  {
>> +	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
>>  	void __iomem *port_mmio = ahci_port_base(ap);
>>  
>>  	/* turn IRQ off */
>>  	writel(0, port_mmio + PORT_IRQ_MASK);
>> +
>> +	/* clear IRQ pending bit */
>> +	writel(1 << ap->port_no, mmio + HOST_IRQ_STAT);
>>  }
>>  
> 
> Actually now I think about it the problem is even worse. On older systems
> IRQ delivery for SMP machines is asynchronous. So the following can occur
> 
> 
> 		device raises IRQ line
> 		IRQ request hits APIC bus
> 
> 		We write IRQ off
> 		We clear IRQ pending
> 
> 		We read back to ensure the write took
> 	
> 
> 		IRQ arrives on CPU APIC
> 
> (and yes this happens on dual P3 boxes - NE2K has some fantastic bugs at
> one point due to this)

I think the second patch should work regardless of IRQ posting.  No?

-- 
tejun
