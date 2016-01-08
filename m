From: Danesh Petigara <dpetigara@broadcom.com>
Subject: Re: [PATCH 3/4] drivers: ata: wake port before DMA stop for ALPM
Date: Fri, 8 Jan 2016 15:20:44 -0800
Message-ID: <5690444C.2090200@broadcom.com>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com> <1452211413-1350-4-git-send-email-f.fainelli@gmail.com> <20160108163610.GS1898@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:10582 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbcAHXUq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jan 2016 18:20:46 -0500
In-Reply-To: <20160108163610.GS1898@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com

Hi Tejun,

On 1/8/2016 8:36 AM, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jan 07, 2016 at 04:03:32PM -0800, Florian Fainelli wrote:
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index d61740e78d6d..b6664c579f9a 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -595,6 +595,58 @@ int ahci_stop_engine(struct ata_port *ap)
>>  	void __iomem *port_mmio = ahci_port_base(ap);
>>  	u32 tmp;
>>  
>> +	/*
>> +	 * On some controllers, stopping a port's DMA engine
>> +	 * while the port is in ALPM state (partial or slumber)
>> +	 * results in failures on subsequent DMA engine starts.
>> +	 * For those controllers, put the port back in active
>> +	 * state before stopping it's DMA engine.
>> +	 */
>> +	if (ap->flags2 & ATA_FLAG2_WAKE_BEFORE_STOP) {
> ...
> 
> So, I'm not too comfortable with open coding ALPM switching in
> ahci_stop_engine().  Shouldn't it be possible to update and/or
> refactor and reuse ahci_set_lpm()?
>
ahci_set_lpm in it's current form cannot be used here as it also
modifies the ALPE/ASP bits. The idea is to wake the link before DMA stop
without changing the ALPM bits so the link can return to it's configured
low power state when it's idle.

We could however update that function by introducing a new hints flag
that allows us to skip unneeded logic for this scenario. ahci_set_lpm
can then be called from ahci_stop_engine.

>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -236,6 +236,8 @@ enum {
>>  
>>  	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
>>  
>> +	/* struct ata_port flags2 */
>> +	ATA_FLAG2_WAKE_BEFORE_STOP = (1 << 0), /* wake link before DMA stop */
> 
> What's wrong with bits 2-5 in ATA_FLAG_* space?  Also, should this be
> a ahci priv flag?

I wasn't sure whether those bits were left unused on purpose, so I did
not use them. The point to make this a AHCI_HFLAG_ flag makes perfect sense.

> 
> Thanks.
> 

Thanks for the feedback.

Danesh
