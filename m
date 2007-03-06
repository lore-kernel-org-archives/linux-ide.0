From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH, RFT, v2] sata_mv: convert to new EH
Date: Tue, 06 Mar 2007 00:26:53 -0500
Message-ID: <45ECFB9D.3040207@garzik.org>
References: <20070225233454.GA31282@havoc.gtf.org> <1173158201.3416.8.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50570 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbXCFF04 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 00:26:56 -0500
In-Reply-To: <1173158201.3416.8.camel@obelisk.thedillows.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Dillow <dave@thedillows.org>
Cc: linux-ide@vger.kernel.org

Dave Dillow wrote:
> On Sun, 2007-02-25 at 18:34 -0500, Jeff Garzik wrote:
>> Just got sata_mv working under the new EH, on my 6041.
>>
>> It probes and talks to disks just fine (chip doesn't support ATAPI),
>> and hotplug actually has a chance of working.
>>
>> The 'mv-eh' branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git mv-eh
> 
> Testing on my Adaptec 1420SA (604x, not sure which) gave several BUG()s,
> and seemed to mount the drive. I immediately unmounted it, as I got
> spooked by the bug reports in dmesg, and I fat fingered ro as rw :(
> 
> sata_mv, and libata built as modules, full .config available on request 

> BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> BUG: at drivers/ata/sata_mv.c:1291 mv_get_crpb_status()


Thanks much for the testing.  This looks quite similar to the BUG()s 
that someone emailed me in private (so far the only other tester besides 
me and you).

I'll give this a think, and see what I come up with.


> I'd love to get this controller running, as I could use the space. I'll
> test just about anything you want, but my turnaround is likely to be on
> the order of 24 hours or so...

Does the stock upstream driver work for you?  It should already be 
running, just with prehistoric error handling :)

	Jeff



