From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Fri, 17 Feb 2006 03:38:22 -0500
Message-ID: <43F58B7E.4000401@pobox.com>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca> <20060216005643.GA28396@harddisk-recovery.com> <43F3E17E.1090701@pobox.com> <43F4461C.1080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:52177 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964822AbWBQIia (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 03:38:30 -0500
In-Reply-To: <43F4461C.1080501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Just a side note.  Taskfile has finer granuality regarding which 
> registers are written and read back than current libata does and IDE 
> taskfile implementation is somewhat broken/weird in a few delicate fun 
> ways, so... be careful.  Whoever tries it.

Yes -- it opens the question about whether we care enough to fully 
support flagged taskfiles, and if not, how to best emulate that support 
under libata.

I'm told that flagging individual ATA shadow registers for modification 
(or not) is required for issuing certain specialized PATA 
vendor-specific commands.  SATA, OTOH, transmits all ATA shadow 
registers in a FIS, so flagged taskfiles are useless.

So, I'm now thinking the best route is to leave the code as it is ;-) 
Rather than imperfectly implementing the flagged taskfile ioctl, punt 
the remaining userland users to SG_IO.

I don't see lack of full flagged taskfile support as a big stumbling 
block to libata use.

	Jeff


