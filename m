From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: SATA "target mode" (or "Channel-to-Channel" comm mode)
Date: Tue, 03 Mar 2009 16:16:12 +0000
Message-ID: <1236096972.3263.12.camel@localhost.localdomain>
References: <49AD34F4.8090008@rtr.ca> <49AD3BA5.3080603@pobox.com>
	 <49AD409F.6040102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:34506 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750985AbZCCQQS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Mar 2009 11:16:18 -0500
In-Reply-To: <49AD409F.6040102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, 2009-03-03 at 09:37 -0500, Mark Lord wrote:
> Jeff Garzik wrote:
> > Mark Lord wrote:
> >> Time is short, so I'd like to spend it on something that Jeff would
> >> actually accept.  Thus this email.
> > 
> > It depends on the task.
> > 
> > The miscdev (i.e. chrdev) interface found in drivers/scsi/scsi_tgt_if.c 
> > of repo [1] seems pretty generic, simple, small and applicable to 
> > portions of the problem presented here...  The basic task in 
> > scsi_tgt_if's case is just shoveling packets to/from userspace.
> ..
> 
> Except it's rather SCSI specific, and the userspace frontend even more so.
> The code expects a SCSI command block, LUN, TAG, and other fields that
> a SATA FIS won't have.  Seems clumsy, particularly when we (in theory)
> are trying to decouple libata from SCSI.   But if that's the way,
> then I can clumsily wrap each FIS in a fake ATA_16 header or something.

Yes, but SG_IO began life as being entirely SCSI specific, but it's now
the block packet infrastructure.  I don't think anyone has an objection
to the SCSI target infrastructure becoming block target
infrastructure ... the fields can be made optional or more generic to
further this.  Probably it should speak a generic packet with a protocol
identifier and let the user space sort out the details.

James


