From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/02] sata_mv: warn on PIO with multiple DRQs
Date: Wed, 18 Jun 2008 20:29:58 -0400
Message-ID: <4859A886.8000509@pobox.com>
References: <485933A4.3010409@rtr.ca> <4859340E.60203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58755 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757094AbYFSAaC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 20:30:02 -0400
In-Reply-To: <4859340E.60203@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> Chip errata sometimes prevents reliable use of PIO commands which involve
> more than a single DRQ (data request).  In normal operation, libata should
> not generate such PIO commands (uses DMA instead), but they could be sent
> in via SG_IO from userspace.
> 
> A full workaround might be to break up such commands into sequences
> of single DRQ ones, but that's just way too complex for something
> that doesn't normally happen in real life.
> 
> So, allow the attempt (it often works, despite the errata),
> but log the event for reference when somebody screams.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>


applied patches 1-2



> Tejun/Alan/Jeff:
> 
> We may also want a patch to prevent libata-eh from downshifting
> all the way to PIO on these chipsets, but I am not sure how to
> accomplish that from inside sata_mv.  Any suggestions?

Do we really want that?  Seems to me we need that for older bridged PATA 
devices attached to a SATA bridge.

	Jeff


