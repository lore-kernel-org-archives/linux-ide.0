From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 17:39:09 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085182749.3122.15.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.edu
	 .	pl><1085162347.4791.24.camel@patibmrh9> <1085170025.3083.91.camel@patibm
	r h9><40AE79E1.9020005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:39362 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264537AbUEUXjR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 19:39:17 -0400
In-Reply-To: <40AE79E1.9020005@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> > > Without auto sense, we read and write ok ...
> > > 
> > > But when I try a no-data op x00 "TEST UNIT READY", I get:
> > 
> > Well, it's a no-op on the ATA side, but not on the ATAPI side.
> > 
> > Thanks for testing though, I'll think about this one a bit.  I'm 
> > surprised the interrupt wasn't handled correctly.
> ...
> I'll roll back to vanilla -bk8, apply my bk8.good.always.patch, and 
> reconfirm ...

Thank you for making the time to question my newbie sanity: I do learn
by having people find time to tell me what sounds reasonable or not.

Here now I can confirm,

In linux-2.6.6-bk8 plus my bk8.good.always.patch ...

One way to hang ata-piix.ko is ...

... to expect to copy zero bytes and have the device agree.

For example:

export PLSCSI='/dev/sg0 -X time 5 0'
plscsi -i x12 -x "03 00:00:00 12 00"
plscsi -x "00 00:00:00 00 00"

I then see "Disabling IRQ #18" happen even without my
bk8.good.always.patch, by way of open /dev/scd0.

With /dev/sg0, the command completes, and `modprobe -r` works, but if I
try modprobe again without reboot, then that hangs after again
broadcasting the complaint: Disabling IRQ #18.

As already you saw in fragments, if I clear out the unit attentions with
unsolicited request sense or with my bk8.good.always.patch, then I can
even die despite having seen no error:

kernel: ata_host_intr: BUS_NODATA (drv_stat 0x50)
kernel: irq 18: nobody cared!

Pat LaVarre


