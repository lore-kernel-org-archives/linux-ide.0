From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH alt4 v2] libata resume fixes
Date: Sat, 27 May 2006 16:56:41 -0400
Message-ID: <4478BD09.5010309@garzik.org>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527201024.GA29015@havoc.gtf.org> <4478B312.5040901@garzik.org> <4478B611.2030201@rtr.ca> <4478B743.2050006@garzik.org> <4478B971.3060409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:6033 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964942AbWE0U4t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:56:49 -0400
In-Reply-To: <4478B971.3060409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
> ..
>> Yay!  I'm familiar with the 0xD0 status on ata_piix, so this is really 
>> good progress.
>>
>>
>>> Other than that, it's still dead -- disk I/O not working.
>>>
>>> Can this patch be combined with Linus's one-liner
>>> and still work on your machine?
>>
>> Does alt4v2 plus Linus's patch work on your machine?  (I'm guessing "no")
> 
> I haven't tried it here yet.
> 
> One other thing:  you patches keep adding a "pata" pci_device_resume 
> handler.
> 
> My disk is SATA, or at least libata thinks it is SATA.
> Just in case that makes any difference here.
> 
> (it really is PATA, but seems to have a SATA bridge
> between it and the ICH6M SATA port).

That's just naming, which indicates it is a PATA-like BMDMA resume 
handler.  Don't worry about it.

As mentioned elsewhere, Linus's patch falls over when we start resuming 
controllers with real SATA phy registers, so that would be a separate 
sata_pci_device_resume() function.

	Jeff



