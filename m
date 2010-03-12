From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates for 2.6.34
Date: Thu, 11 Mar 2010 19:16:13 -0500
Message-ID: <4B9987CD.4060907@garzik.org>
References: <20100301202330.GA14977@havoc.gtf.org> <alpine.LFD.2.00.1003091304400.3583@i5.linux-foundation.org> <4B96C7B2.3080008@garzik.org> <4B971F83.4030505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:44352 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab0CLAQQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2010 19:16:16 -0500
In-Reply-To: <4B971F83.4030505@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On 03/09/2010 11:26 PM, Tejun Heo wrote:
> Hello, Linus, Jeff.
>
> On 03/10/2010 07:12 AM, Jeff Garzik wrote:
>> Coincedentally, it looks like someone else just reported the same
>> problem, with 2.6.34-rc1.
>>
>> It definitely sounds like a race.  READ DMA is a DMA command as the name
>> implies, so that eliminates the possibility of polling-related paths in
>> ata_sff_interrupt (libata-sff.c).
>>
>> I'll flip some of my machines to the icky slow boring piix mode, rather
>> than sexy AHCI mode :) to see if I can reproduce.  I have had a feeling
>> that we needed a more sophisticated IRQ handling setup, this may be what
>> was needed.  Lost interrupt recovery should occur faster than 30 seconds
>> in any case, and should not require a hard reset if the hardware
>> functions just fine outside of the lost-interrupt / race that just
>> occurred.
>
> Yeap, there is a race condition with clearing which I don't think we
> can solve completely but with some modification I think we can at
> least cover known failure cases.
>
> For longer term, I don't think we can solve this by diddling with the
> SFF registers.  The interface is just way too ancient and horrid to
> build anything reliable on top of.  I'm planning on implementing
> smarter IRQ storm handling and stepped timeouts for ATA commands.

Another ata_piix report on l-i & lkml indicates that 2.6.33 is fine and 
libata timeouts occur on 2.6.34-rc1.

I was able to reproduce once, during disk stress.  I think I can do so 
again and hopefully verify a fix.

	Jeff



