From: Timothy Thelin <timothy.thelin@wdc.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Fri, 17 Feb 2006 10:27:12 -0800
Message-ID: <1140200833.7509.101.camel@localhost>
References: <20060215143439.GA17850@harddisk-recovery.com>
	 <43F37A5E.1090301@rtr.ca> <20060216005643.GA28396@harddisk-recovery.com>
	 <43F3E17E.1090701@pobox.com> <43F4461C.1080501@gmail.com>
	 <43F58B7E.4000401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe01.sc.wdc.com ([129.253.170.53]:32903 "EHLO
	wdscexfe01.sc.wdc.com") by vger.kernel.org with ESMTP
	id S1750821AbWBQS3m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Feb 2006 13:29:42 -0500
In-Reply-To: <43F58B7E.4000401@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Erik Mouw <erik@harddisk-recovery.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Fri, 2006-02-17 at 03:38 -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> > Just a side note.  Taskfile has finer granuality regarding which 
> > registers are written and read back than current libata does and IDE 
> > taskfile implementation is somewhat broken/weird in a few delicate fun 
> > ways, so... be careful.  Whoever tries it.
> 
> Yes -- it opens the question about whether we care enough to fully 
> support flagged taskfiles, and if not, how to best emulate that support 
> under libata.
> 
> I'm told that flagging individual ATA shadow registers for modification 
> (or not) is required for issuing certain specialized PATA 
> vendor-specific commands.  SATA, OTOH, transmits all ATA shadow 
> registers in a FIS, so flagged taskfiles are useless.
> 
> So, I'm now thinking the best route is to leave the code as it is ;-) 
> Rather than imperfectly implementing the flagged taskfile ioctl, punt 
> the remaining userland users to SG_IO.
> 
> I don't see lack of full flagged taskfile support as a big stumbling 
> block to libata use.
> 
> 	Jeff

FYI, Western Digital doesn't need flagged taskfile access to use its
vendor specific commands; SAT passthru works fine (although we'd
appreciate more of the protocols implemented, or at least a way to
discover at runtime which ones are implemented before trying to use
them).

- Tim Thelin
