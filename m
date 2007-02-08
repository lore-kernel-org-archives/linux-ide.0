From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_promise: fix missing PATA cable detection
Date: Thu, 08 Feb 2007 10:07:09 -0500
Message-ID: <45CB3C9D.8060702@garzik.org>
References: <200702081439.l18EdqfI010278@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45836 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423197AbXBHPHM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Feb 2007 10:07:12 -0500
In-Reply-To: <200702081439.l18EdqfI010278@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> On Thu, 08 Feb 2007 08:50:09 -0500, Jeff Garzik wrote:
>> Mikael Pettersson wrote:
>>> This patch fixes an oversight which caused sata_promise to
>>> not perform cable detection on the TX2plus chips' PATA ports.
>>>
>>> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
>>>
>>> ---
>>>
>>> This patch adds yet another is-PATA-or-SATA? check, but it's in a
>>> cold path so shouldn't matter much. This will be cleaned up if/when
>>> PATA ports and SATA ports start using different ops structures.
>>>
>>> --- linux-2.6.20/drivers/ata/sata_promise.c.~1~	2007-02-07 20:30:20.000000000 +0100
>>> +++ linux-2.6.20/drivers/ata/sata_promise.c	2007-02-07 20:57:34.000000000 +0100
>>> @@ -601,6 +601,13 @@ static void pdc_thaw(struct ata_port *ap
>>>  	readl(mmio + PDC_CTLSTAT); /* flush */
>>>  }
>>>  
>>> +static int pdc_pre_reset(struct ata_port *ap)
>>> +{
>>> +	if (!sata_scr_valid(ap))
>>> +		pdc_pata_cbl_detect(ap);
>>> +	return ata_std_prereset(ap);
>>> +}
>>> +
>> Since it was a bug in the original patch, I just dropped it, waiting for 
>> you to resend the whole thing.  That keeps the git history much more clean.
> 
> I hope you dropped the 20619 new EH patch but applied this one.
> 
> Maybe the patch description was too terse given the broken 20619 patch:
> This patch corrects TX2plus PATA in current #upstream. It's currently
> unrelated to 20619 (since 20619 has its own ops and a ->phy_reset which
> calls pdc_pata_cbl_detect()), but later when 20619 is converted to new EH,
> it ensures that 20619 continues to do PATA cable detection.
> 
> The bug originated in the #promise-sata-pata branch, which added
> TX2plus PATA support but didn't hook in any cable detection.
> I failed to observe that omission when reworking #promise-sata-pata
> into the form that got merged.

Ah, I misunderstood.  I thought it was an incremental patch to your 
new-EH patch, at first glance.

It is now in my queue.

	Jeff



