From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Sat, 22 Nov 2008 02:05:18 +0900
Message-ID: <4926EA4E.1070605@kernel.org>
References: <49263552.8090602@kernel.org> <4926E907.20706@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42770 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbYKURFK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Nov 2008 12:05:10 -0500
In-Reply-To: <4926E907.20706@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Sergei Shtylyov wrote:
> Hello.
> 
> Tejun Heo wrote:
> 
>> The DMA_IRQ bit in the bmdma status register is always set when IDEIRQ
>> is asserted allowing spurious IRQ detection.  Detect spurious IRQs and
>> clear them.  This protects ata_piix against nobody-cared which gets
>> reported not so rarely.
> 
>    This should be more generic, as several IDE controllers have the
> separate IDE interrupt status bits.

Well, this was workaround for ata_piix.  I'll prep a more generic one
with callback.

>> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
>> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
>> index 8e37be1..b438edc 100644
>> --- a/drivers/ata/ata_piix.c
>> +++ b/drivers/ata/ata_piix.c
>> @@ -922,6 +922,58 @@ static int piix_sidpr_scr_read(struct ata_link
>> *link,
>>      return 0;
>>  }
>>  
>> +static irqreturn_t piix_interrupt(int irq, void *dev_instance)
>> +{
> [...]
>> +        /*
>> +         * Control reaches here if HSM is not expecting IRQ.
>> +         * If the controller is actually asserting IRQ line,
>> +         * this will lead to nobody cared.  Fortuantely,
>> +         * DMA_INTR of PIIX is set whenever IDEIRQ is set so
> 
>    Frankly speaking, I'm not sure about the PIIX chips themselves... Is
> that documented by Intel?

Yeap, it is.

-- 
tejun
