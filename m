From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs.
 intr race fix
Date: Sun, 21 Aug 2005 20:27:38 -0400
Message-ID: <43091BFA.2020101@pobox.com>
References: <20050820091651.486821E0@htj.dyndns.org> <4308DA57.9000303@pobox.com> <4308E13E.6070104@gmail.com> <4308E2C9.6040605@pobox.com> <4308E6B1.6030001@gmail.com> <4308F114.9020608@pobox.com> <4308F450.4050402@gmail.com> <4308F943.9090706@pobox.com> <20050821235149.GA14097@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:22673 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932341AbVHVXNK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 19:13:10 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M0UqM3009447
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 17:30:53 -0700
In-Reply-To: <20050821235149.GA14097@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  For example, ATA_PROT_NODATA is processed as follows.

You mean ATA_PROT_ATAPI_NODATA, I presume.

>    Driver				Controller
>    -------------------------------------------------------------------------
> 1. issue ATA_CMD_PACKET
> 2.					Turns on BSY and sends H2D regs
> 3. atapi_packet_task poll for BSY
> 4.					D2H regs FIS (!BSY, DRQ)
> 5. packet_task sends CDB
> 6.					Turns on BSY and sends DATA FIS

but first PIO Setup FIS


> 7.					D2H regs FIS (!BSY, DRDY, INTR)
> 8. intr handler completes the cmd
> 
>  In step #3, we're waiting for BSY to clear - command is active and
> NIEN is clear.  After step #4 but before #5, command is active, BSY
> clear and DRQ set, if an interrupt from the other port occurs here, it
> will incorrectly fail this qc causing EH to kick in for sense data.

Agreed, that is a problem w/ libata's ATAPI HSM.  Two problems actually:

(a) [what you found] at that point in the HSM, unexpected interrupts can 
incorrectly complete a command
(b) [a 'todo' item'] at that point in the HSM, there may actually be an 
expected interrupt, before which the CDB should not be sent, per ATA/ATAPI-4


>  The problem is that the current interrupt handler is unaware of the
> HSM state where NIEN and BSY are clear but interrupts are not
> expected.  So, the problem is that the interrupt handler doesn't know
> enough about HSM state to be able to determine that the interrupt is
> not its.

Agreed.


> The flag I've mentioned is to tell just that to the
> interrupt handler.

>  Otherwise, I think we can implement something like ap->ata_state and
> fully record where the HSM is, which would also be useful to implement
> interrupt-driven PIO.  What do you think?

I tend to prefer ap->ata_state method, since I definitely would like to 
implement interrupt-driven PIO.  But if the patch is too ugly, maybe a 
bit flag would be OK.

Long term, PIO w/ interrupts is probably the best thing to do under 
SATA.  That prevents problems with PATA->SATA emulation that lead to 
screaming interrupts.  For SATA, it seems like polling is a bad idea in 
all cases [save suspend/resume edge cases].

SATA technology is inherently more suited to an interrupt-driven 
architecture anyway.  Polling makes less sense, and needlessly increases 
PCI bus traffic.

	Jeff

