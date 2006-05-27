From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH alt4 v2] libata resume fixes
Date: Sat, 27 May 2006 17:06:58 -0400
Message-ID: <4478BF72.5010708@garzik.org>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527201024.GA29015@havoc.gtf.org> <4478B312.5040901@garzik.org> <4478B611.2030201@rtr.ca> <4478B743.2050006@garzik.org> <4478B971.3060409@rtr.ca> <4478BD09.5010309@garzik.org> <4478BDFD.60209@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:22417 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964968AbWE0VHE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:07:04 -0400
In-Reply-To: <4478BDFD.60209@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>>
>> As mentioned elsewhere, Linus's patch falls over when we start 
>> resuming controllers with real SATA phy registers, so that would be a 
>> separate sata_pci_device_resume() function.
> 
> But does it fall over any worse than we already do with the stock kernel?

Are you talking about my x86-64 box + Linus's patch, or the future 
implications?

For the former, the previous behavior was EH spew like what you are 
seeing.  After apply Linus's patch, it hardlocks.  But I don't want that 
to hold up the patch...  libata suspend/resume is one part luck, and one 
part "it's only ata_piix so far."  It has a looooong way to go before it 
is usable outside of that domain.

For the latter, it doesn't make sense to poll BSY on modern SATA 
controllers, particularly (a) FIS-based ones and more importantly (b) 
devices attached behind a Port Multiplier.

	Jeff



