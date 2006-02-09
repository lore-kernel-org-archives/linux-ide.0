From: Tejun <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: [PATCHSET] libata: new reset mechanism, take#3
Date: Thu, 09 Feb 2006 18:20:18 +0900
Message-ID: <43EB0952.6090409@gmail.com>
References: <11388720003793-git-send-email-htejun@gmail.com> <43EAE67D.6010304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:1138 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030622AbWBIJUY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 04:20:24 -0500
Received: by wproxy.gmail.com with SMTP id i11so262847wra
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2006 01:20:23 -0800 (PST)
In-Reply-To: <43EAE67D.6010304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> 1. For softreset
>>
[--snip--]
>> I thought the ata_busy_sleep() in #a2 was for SATA_RESET case and left
>> it out.  Do you think it's necessary for SRST too?
> 
> Yes.  You want to check status before dev_select() to ensure that we are 
> at bus-idle in the HSM.

Yes, I'll add that back.

> Follow the register I/O operations in Hale Landis's ATADRDR 
> (http://www.ata-atapi.com/atadrvr.htm).  For PATA probing, I consider 
> his code darn near canonical.

Will do.

> 
>> 2. For hardreset
[--snip--]
>> #b1 is there as probeinit operation and as most controllers implement
>> softreset, there will be softreset operations between #b1 and #b2 in
>> most cases.  The dev_select(ap, 0) in #a4 is actually for SRST and
>> EDD.  For SATA_RESET, double dev_select()'s are soon done later in
>> ata_bus_reset() with only ata_irq_on() inbetween.
> 
> I agree RE double select.
> 
> However, I don't want to mess with the reset/wake phy sequence at all. 
> It works now, and changing it is really unnecessary churn.
> 

I'll add double select back.  But removing additional PHY wakup before 
hardreset would require changes to reset_drive function.  Currently 
->probe_init is called to prep ports for probing (in this case, waking 
up PHY) for both hard and soft reset cases and that's why there's PHY 
wake up before hardreset.  I'd really like to waking up PHY out of reset 
component operations.  I'll figure something out.

> 
>> 3. During postreset
>>
>> The original code does ata_irq_on() if ctl_addr is non-NULL, double
>> select and ctl setup.  The new code does double select and
>> ata_irq_on() if ctl_addr is non-NULL.
>>
>>     Original            New
>> -----------------------------------------------------------------
>> a1. ata_irq_on() if ctl_addr
>>
>> a2. double select        b1. double select
>>
>> a3. ctl setup
>>                 b2. ata_irq_on() if ctl_addr
>>
>>
>> ata_irq_on() actually implies ctl setup.  Also, in the original code,
>> 'if ctl_addr' test in #a1 is bogus because in #a3, ctl_addr is used
>> unchecked.  New code just does ata_irq_on() at the end.
> 
> 
> This (though probably not double select) was largely based on ATADRVR, 
> so I would rather not change the ata_irq_on() order without a good reason.
> 
> 
>> IMHO, the remaining differences seem harmless and mainly due to the
>> fact that new code splits soft and hard resets explicitly whereas the
>> original code shared a lot of code path.  If any of above changes
>> seems suspicious, please let me know.
> 
> 
> Life is FAR easier in the long run if you don't change the hardware 
> register read/write order at all, when switching libata to your new 
> reset mechanism.  You are welcome to experiment with that -- but in 
> separate patches, at the end of the patch series.  The ATA host state 
> machine, with added SATA complexities, is way too fragile to mess with 
> without lots of testing.
 >
> Your software will be more robust if you don't change the register I/O 
> order at all.  Doing so means you leverage all the existing field 
> testing done with the original probe/reset code.

I see your point.  I'll submit another patch to make probing sequence 
register-wise identical to before.

> Thanks for your continued work and patience on this...  we're getting 
> there.

Thanks for reviewing.

-- 
tejun
