From: Jeff Garzik <jeff@garzik.org>
Subject: jgarzik and max-sectors: out of memory
Date: Sat, 27 May 2006 15:37:16 -0400
Message-ID: <4478AA6C.5070305@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:64398 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751082AbWE0ThV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:37:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>, Hannes Reinecke <hare@suse.de>

ATA_MAX_SECTORS is 200, rather than than 256 like it should be.  I seem 
to recall that this was due to libata being incomplete in some area, but 
I've tried in vain for a year to remember where the alleged 
incompleteness was, to no avail.  So, my brain is out of memory :)

Further -- someone with a long ATA memory correct me -- I think that we 
can increase ATA_MAX_PRD beyond 256.  Most DMA engines should just keep 
chugging along, provided that we continue to respect the 64k IDE DMA 
boundaries.

So, I propose that we rename ATA_MAX_SECTORS to ATA_LBA28_SECTORS, and 
change its value to 256, and see what happens.  People have reported 
that that worked for them, so let's subject it to a wide test.  If 
people are extremely paranoid, we could increase it to 255, and then in 
the next kernel version, bump it from 255 to 256.

Then we can look at increasing ATA_MAX_PRD, if that's feasible for PATA 
hardware.

	Jeff


