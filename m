From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs.
 intr race fix
Date: Sun, 21 Aug 2005 17:59:31 -0400
Message-ID: <4308F943.9090706@pobox.com>
References: <20050820091651.486821E0@htj.dyndns.org> <4308DA57.9000303@pobox.com> <4308E13E.6070104@gmail.com> <4308E2C9.6040605@pobox.com> <4308E6B1.6030001@gmail.com> <4308F114.9020608@pobox.com> <4308F450.4050402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:9704 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751146AbVHUV7h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:59:37 -0400
In-Reply-To: <4308F450.4050402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Now I see what you're saying.  We should be able to know/clear 
> interrupt by reading ATA_STATUS.  So, not having explicit interrupt 
> pending bit can be compensated by following changes in ATA_STATUS (so 
> the state machine), right?  Thanks a lot for putting up with my ignorance.

Correct.  Just never forget there is a side effect to reading the Status 
register -- it clears any interrupt event it also signals.


>  So, how about a port status bit to tell interrupt handler whether or 
> not we are expecting an interrupt currently?  That would solve the race 
> from I tried to fix in the first patchset.  If that's okay with you, 
> I'll redo all four patches accordingly.

I'm a bit skeptical, TBH.  I would prefer some sort of approach whereby 
the code knows where the port is, inside the host state machine, and may 
deduce from that "location" whether or not an interrupt is expected. 
That's precisely how the code functions now with ATA DMA and non-data, 
at least (or should...).

If we find out where the bug in the "I know when I expect an interrupt" 
logic is, then your race should be easy to fix.  Currently, I can see 
that (a) ATAPI interrupt can race with called-immediately EH, and (b) 
ATAPI may throw an interrupt to indicate CDB is ready to be sent [see 
ATA-4], and libata doesn't yet support such a state in its host state 
machine (HSM) implementation.

That said, if you still wish to send such a patch, I will give it an 
open and honest review.

Maybe your bit flag approach plugs the hole in the existing HSM -- I 
would just like to know _where_ this hole is.  So far I don't see it, 
except for (a) and (b) ATAPI examples above.

	Jeff


