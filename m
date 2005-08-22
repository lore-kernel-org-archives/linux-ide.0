From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs. intr race fix
Date: Mon, 22 Aug 2005 12:57:53 +0900
Message-ID: <20050822035753.GA28721@htj.dyndns.org>
References: <20050820091651.486821E0@htj.dyndns.org> <4308DA57.9000303@pobox.com> <4308E13E.6070104@gmail.com> <4308E2C9.6040605@pobox.com> <4308E6B1.6030001@gmail.com> <4308F114.9020608@pobox.com> <4308F450.4050402@gmail.com> <4308F943.9090706@pobox.com> <20050821235149.GA14097@htj.dyndns.org> <43091BFA.2020101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:12686 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751281AbVHVW4M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:56:12 -0400
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M3x12v023146
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 20:59:02 -0700
Received: by rproxy.gmail.com with SMTP id r35so902140rna
        for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 20:57:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <43091BFA.2020101@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

 Jeff, replies to your comments here and I'll post another reply to
post new patch.

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>>  For example, ATA_PROT_NODATA is processed as follows.
> 
> 
> You mean ATA_PROT_ATAPI_NODATA, I presume.
> 

 Yeap.

>>    Driver                Controller
>>    
>> -------------------------------------------------------------------------
>> 1. issue ATA_CMD_PACKET
>> 2.                    Turns on BSY and sends H2D regs
>> 3. atapi_packet_task poll for BSY
>> 4.                    D2H regs FIS (!BSY, DRQ)
>> 5. packet_task sends CDB
>> 6.                    Turns on BSY and sends DATA FIS
> 
> 
> but first PIO Setup FIS
> 

 Thanks for the correction.

> 
>> 7.                    D2H regs FIS (!BSY, DRDY, INTR)
>> 8. intr handler completes the cmd
>>
>>  In step #3, we're waiting for BSY to clear - command is active and
>> NIEN is clear.  After step #4 but before #5, command is active, BSY
>> clear and DRQ set, if an interrupt from the other port occurs here, it
>> will incorrectly fail this qc causing EH to kick in for sense data.
> 
> 
> Agreed, that is a problem w/ libata's ATAPI HSM.  Two problems actually:
> 
> (a) [what you found] at that point in the HSM, unexpected interrupts can 
> incorrectly complete a command
> (b) [a 'todo' item'] at that point in the HSM, there may actually be an 
> expected interrupt, before which the CDB should not be sent, per 
> ATA/ATAPI-4

 This is deprecated since ATA/ATAPI-4.  Will we see this on SATA ATAPI
devices?  Maybe for PATA ATAPI's?

> 
> 
>>  The problem is that the current interrupt handler is unaware of the
>> HSM state where NIEN and BSY are clear but interrupts are not
>> expected.  So, the problem is that the interrupt handler doesn't know
>> enough about HSM state to be able to determine that the interrupt is
>> not its.
> 
> 
> Agreed.
> 
> 
>> The flag I've mentioned is to tell just that to the
>> interrupt handler.
> 
> 
>>  Otherwise, I think we can implement something like ap->ata_state and
>> fully record where the HSM is, which would also be useful to implement
>> interrupt-driven PIO.  What do you think?
> 
> 
> I tend to prefer ap->ata_state method, since I definitely would like to 
> implement interrupt-driven PIO.  But if the patch is too ugly, maybe a 
> bit flag would be OK.

 I just went the flag way for the following reason.  As the larger
chunk (PIO state machine) is not in place yet, implementing small part
would look out of place and it's gonna need be modified anyway later
when actual state machine is implemented.  I've added a FIXME: comment
after the flag to signify that this should be merged into state
machine.

> 
> Long term, PIO w/ interrupts is probably the best thing to do under 
> SATA.  That prevents problems with PATA->SATA emulation that lead to 
> screaming interrupts.  For SATA, it seems like polling is a bad idea in 
> all cases [save suspend/resume edge cases].
> 
> SATA technology is inherently more suited to an interrupt-driven 
> architecture anyway.  Polling makes less sense, and needlessly increases 
> PCI bus traffic.

 I liked the simplicity of polling and, as PIO is not a very hot path,
thought it would be okay, but I agree that implementing full interrupt
driven HSM is a better thing to do.

 Thanks.

--
tejun
