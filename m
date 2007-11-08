From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA Target mode & libata
Date: Thu, 8 Nov 2007 16:05:08 -0500
Message-ID: <20071108210508.GA12845@havoc.gtf.org>
References: <20071107221355.GB15784@havoc.gtf.org> <001f01c821b0$20b6c9f0$6200a8c0@jameshsu> <02d301c821e2$25dc01c0$d400a8c0@laurence> <005e01c821fb$502be120$6200a8c0@jameshsu> <20071108162229.GB31492@havoc.gtf.org> <473368FA.4030603@rtr.ca> <20071108200920.GB4895@havoc.gtf.org> <47336F68.2080601@rtr.ca> <20071108203127.GC4895@havoc.gtf.org> <4733764D.80203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:42546 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758686AbXKHVFJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 16:05:09 -0500
Content-Disposition: inline
In-Reply-To: <4733764D.80203@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

On Thu, Nov 08, 2007 at 03:49:17PM -0500, Mark Lord wrote:
> Jeff Garzik wrote:
> >On Thu, Nov 08, 2007 at 03:19:52PM -0500, Mark Lord wrote:
> ..
> >>MMmm..  I wonder what the most common use case is for target mode?
> >>
> >>Everybody I've dealt with thus far uses it as a high-speed local comms 
> >>interface,
> >>which would suggest that it might be done as a network interface 
> >>(ethernet emulation).
> >>
> >>But that would confusingly go across driver subsystems,
> >>despite that this is how it actually is used.
> >
> >The low-level driver itself will just be a dumb DMA send/receive engine,
> >with submit/completion APIs highly similar to the existing ones.  Then
> >you can easily provide a network interface interface (not a typo) on top
> >of that.
> ..
> 
> The obvious BIG difference is that in host mode, *we* initiate 
> communcations,
> whereas in target mode, it has to just sit there waiting for a host to say 
> something.
> 
> That's a pretty big change from how libata operates today,
> in just about every respect.

Not at all -- both initiator and target modes have the exact same tasks:  
1) send stuff to hardware, 2) receive hardware responses.

On modern SAS/SATA hardware, you have both command and response queues.

On modern SATA hardware, you have command queue and a received FIS list,
which provides essentially the same services.

Thus SATA target mode will simply need a "here is data I just received
from the wire" hook, and the rest of the infrastructure already exists.

Target mode will re-use ->qc_issue, and need a new ata_receive_fis()
function for asynchronously received FIS's (H2D FIS, etc.)

	Jeff



