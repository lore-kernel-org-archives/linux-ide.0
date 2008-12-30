From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PIO with SSDs: needs a long DRQ-after-command timeout for WRITEs
Date: Tue, 30 Dec 2008 12:14:43 -0600
Message-ID: <495A6513.9070609@shaw.ca>
References: <495A27E3.50801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:40216 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbYL3SO5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2008 13:14:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHj7E-000508-Uu
	for linux-ide@vger.kernel.org; Tue, 30 Dec 2008 18:14:52 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2008 18:14:52 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2008 18:14:52 +0000
In-Reply-To: <495A27E3.50801@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Mark Lord wrote:
> Guys,
> 
> I'm still lurking around in the shadows here, but something just
> came to light on another project which might affect mainline.
> 
> We're using new, cheap 32GB Transcend MLC SSDs with a PATA interface.
> Normally, folks would use UDMA with these, and never notice an issue.
> 
> But this project has only (very slow) PIO interfaces, and the SSDs
> didn't work at first on the old kernel here.
> 
> The fix, was to increase the allowed amount of time for the drive
> to assert DRQ after s/w issues a PIO WRITE to the drive.
> 
> The kernel I was using here had a 50msec timeout (ATA spec requires
> at least 20msec), but this was insufficient for these SSDs.
> 
> I suspect the SSDs perform an ERASE operation on WRITE,
> before asserting DRQ, and this takes a bit of time.
> 
> Not sure how much time, but we just bumped the timeout up
> to a few seconds and all is working again.  Overkill, yes.
> 
> So.. how long does libata and current IDE allow for initial DRQ assertion?
> It should probably be at least 500msec or more now.

No idea about IDE, but libata does not wait at all for DRQ assertion 
specifically, after issuing the PIO command it waits for BSY to be 
deasserted and then expects either DRQ, DF or ERR to be set, else it's a 
host state machine violation and triggers error handling. According to 
the ATA spec, the device is specifically not allowed to set DRQ to one 
while BSY is not asserted.

