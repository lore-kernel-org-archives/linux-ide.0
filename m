From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] libata: [PATCHSET] libata: new reset mechanism, take#3
Date: Thu, 09 Feb 2006 01:51:41 -0500
Message-ID: <43EAE67D.6010304@pobox.com>
References: <11388720003793-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:34201 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422830AbWBIGvv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 01:51:51 -0500
In-Reply-To: <11388720003793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Jeff, after patches upto #04 are applied, the following differences
> remain between the new reset mechanism and the original one.
> 
> 1. For softreset
> 
> In the original code, ata_busy_sleep() is done after waking up the PHY
> whether SATA_RESET is used or not.  For SRST case, it looks like the
> following.
> 
> 	Original			New
> -----------------------------------------------------------------
> a1. Wake up PHY using SControl	b1. Wake up PHY using SControl
> 
> a2. ata_busy_sleep(),
>     if sata_dev_present()
> 
> a3. dev_select(ap, 0)		b2. dev_select(ap, 0)
> 
> a4. do softreset		b3. do softreset
> 
> a5. ata_busy_sleep() for	b4. ata_busy_sleep() for
>     present devices in		    present devices in
>     ata_bus_post_reset()	    ata_bus_post_reset()
> 
> 
> I thought the ata_busy_sleep() in #a2 was for SATA_RESET case and left
> it out.  Do you think it's necessary for SRST too?

Yes.  You want to check status before dev_select() to ensure that we are 
at bus-idle in the HSM.

Follow the register I/O operations in Hale Landis's ATADRDR 
(http://www.ata-atapi.com/atadrvr.htm).  For PATA probing, I consider 
his code darn near canonical.


> 2. For hardreset
> 
> Unlike in the original code, the new reset mechanism first wake up the
> PHY before invoking sata_std_hardreset() even when
> sata_std_hardreset() is the only reset method.  And dev_select(ap, 0)
> is not performed for hardreset.
> 
> So, the diffrence looks like the following.
> 
> 	Original			New
> -----------------------------------------------------------------
> 				b1. Wake up PHY using SControl
> 
> a1. Reset PHY using SControl	b2. Reset PHY using SControl
> 
> a2. Wake up PHY using SControl	b3. Wakeup PHY using SControl
> 
> a3. ata_busy_sleep(),		b4. ata_busy_sleep(),
>     if sata_dev_present()	    if sata_dev_present()
> 
> a4. dev_select(ap, 0)
> 
> 
> #b1 is there as probeinit operation and as most controllers implement
> softreset, there will be softreset operations between #b1 and #b2 in
> most cases.  The dev_select(ap, 0) in #a4 is actually for SRST and
> EDD.  For SATA_RESET, double dev_select()'s are soon done later in
> ata_bus_reset() with only ata_irq_on() inbetween.

I agree RE double select.

However, I don't want to mess with the reset/wake phy sequence at all. 
It works now, and changing it is really unnecessary churn.


> 3. During postreset
> 
> The original code does ata_irq_on() if ctl_addr is non-NULL, double
> select and ctl setup.  The new code does double select and
> ata_irq_on() if ctl_addr is non-NULL.
> 
> 	Original			New
> -----------------------------------------------------------------
> a1. ata_irq_on() if ctl_addr
> 
> a2. double select		b1. double select
> 
> a3. ctl setup
> 				b2. ata_irq_on() if ctl_addr
> 
> 
> ata_irq_on() actually implies ctl setup.  Also, in the original code,
> 'if ctl_addr' test in #a1 is bogus because in #a3, ctl_addr is used
> unchecked.  New code just does ata_irq_on() at the end.

This (though probably not double select) was largely based on ATADRVR, 
so I would rather not change the ata_irq_on() order without a good reason.


> IMHO, the remaining differences seem harmless and mainly due to the
> fact that new code splits soft and hard resets explicitly whereas the
> original code shared a lot of code path.  If any of above changes
> seems suspicious, please let me know.

Life is FAR easier in the long run if you don't change the hardware 
register read/write order at all, when switching libata to your new 
reset mechanism.  You are welcome to experiment with that -- but in 
separate patches, at the end of the patch series.  The ATA host state 
machine, with added SATA complexities, is way too fragile to mess with 
without lots of testing.

Your software will be more robust if you don't change the register I/O 
order at all.  Doing so means you leverage all the existing field 
testing done with the original probe/reset code.

Thanks for your continued work and patience on this...  we're getting there.

	Jeff



