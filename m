From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Acard ATP8620 2SATA / 1 IDE  driver - AHCI.C Nov082007
Date: Thu, 8 Nov 2007 15:09:20 -0500
Message-ID: <20071108200920.GB4895@havoc.gtf.org>
References: <47270656.7080205@garzik.org> <003701c81c63$cee89c30$6200a8c0@jameshsu> <025c01c82016$fbcf3810$d400a8c0@laurence> <025001c82067$d76c04c0$6200a8c0@jameshsu> <20071107221355.GB15784@havoc.gtf.org> <001f01c821b0$20b6c9f0$6200a8c0@jameshsu> <02d301c821e2$25dc01c0$d400a8c0@laurence> <005e01c821fb$502be120$6200a8c0@jameshsu> <20071108162229.GB31492@havoc.gtf.org> <473368FA.4030603@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:54809 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318AbXKHUJX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 15:09:23 -0500
Content-Disposition: inline
In-Reply-To: <473368FA.4030603@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

On Thu, Nov 08, 2007 at 02:52:26PM -0500, Mark Lord wrote:
> Jeff Garzik wrote:
> >..
> >2) This chip includes target mode support.  Very nice, well done!
> >I hope that standard AHCI eventually supports this nice feature!
> ..
> 
> Speaking of which.  Do we have a strategy as to how to implement/support
> the target side of target mode on controllers which can do it?
> 
> The Marvell chips also have a target mode feature, and I'd like to add
> support for it soon-ish, but it's now clear how you would like it plumbed
> into libata.
> 
> It's almost like a separate driver/subsystem, except that would be very 
> silly.

I'm letting the SCSI folks do the heavy lifting, implementing SCSI
target mode -- an effort already quite well along.

We should be able to piggyback off of that work.

	Jeff


