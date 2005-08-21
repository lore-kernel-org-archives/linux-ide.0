From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs. intr race fix
Date: Mon, 22 Aug 2005 08:51:49 +0900
Message-ID: <20050821235149.GA14097@htj.dyndns.org>
References: <20050820091651.486821E0@htj.dyndns.org> <4308DA57.9000303@pobox.com> <4308E13E.6070104@gmail.com> <4308E2C9.6040605@pobox.com> <4308E6B1.6030001@gmail.com> <4308F114.9020608@pobox.com> <4308F450.4050402@gmail.com> <4308F943.9090706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:13346 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751172AbVHUXv7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 19:51:59 -0400
Received: by zproxy.gmail.com with SMTP id i11so600891nzh
        for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 16:51:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4308F943.9090706@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sun, Aug 21, 2005 at 05:59:31PM -0400, Jeff Garzik wrote:
> Tejun Heo wrote:
> > Now I see what you're saying.  We should be able to know/clear 
> >interrupt by reading ATA_STATUS.  So, not having explicit interrupt 
> >pending bit can be compensated by following changes in ATA_STATUS (so 
> >the state machine), right?  Thanks a lot for putting up with my ignorance.
> 
> Correct.  Just never forget there is a side effect to reading the Status 
> register -- it clears any interrupt event it also signals.
> 
> 
> > So, how about a port status bit to tell interrupt handler whether or 
> >not we are expecting an interrupt currently?  That would solve the race 
> >from I tried to fix in the first patchset.  If that's okay with you, 
> >I'll redo all four patches accordingly.
> 
> I'm a bit skeptical, TBH.  I would prefer some sort of approach whereby 
> the code knows where the port is, inside the host state machine, and may 
> deduce from that "location" whether or not an interrupt is expected. 
> That's precisely how the code functions now with ATA DMA and non-data, 
> at least (or should...).
> 
> If we find out where the bug in the "I know when I expect an interrupt" 
> logic is, then your race should be easy to fix.  Currently, I can see 
> that (a) ATAPI interrupt can race with called-immediately EH, and (b) 
> ATAPI may throw an interrupt to indicate CDB is ready to be sent [see 
> ATA-4], and libata doesn't yet support such a state in its host state 
> machine (HSM) implementation.
> 
> That said, if you still wish to send such a patch, I will give it an 
> open and honest review.
> 
> Maybe your bit flag approach plugs the hole in the existing HSM -- I 
> would just like to know _where_ this hole is.  So far I don't see it, 
> except for (a) and (b) ATAPI examples above.

 For example, ATA_PROT_NODATA is processed as follows.

   Driver				Controller
   -------------------------------------------------------------------------
1. issue ATA_CMD_PACKET
2.					Turns on BSY and sends H2D regs
3. atapi_packet_task poll for BSY
4.					D2H regs FIS (!BSY, DRQ)
5. packet_task sends CDB
6.					Turns on BSY and sends DATA FIS
7.					D2H regs FIS (!BSY, DRDY, INTR)
8. intr handler completes the cmd

 In step #3, we're waiting for BSY to clear - command is active and
NIEN is clear.  After step #4 but before #5, command is active, BSY
clear and DRQ set, if an interrupt from the other port occurs here, it
will incorrectly fail this qc causing EH to kick in for sense data.

 The problem is that the current interrupt handler is unaware of the
HSM state where NIEN and BSY are clear but interrupts are not
expected.  So, the problem is that the interrupt handler doesn't know
enough about HSM state to be able to determine that the interrupt is
not its.  The flag I've mentioned is to tell just that to the
interrupt handler.

 Otherwise, I think we can implement something like ap->ata_state and
fully record where the HSM is, which would also be useful to implement
interrupt-driven PIO.  What do you think?

 Thanks.  :-)

-- 
tejun
