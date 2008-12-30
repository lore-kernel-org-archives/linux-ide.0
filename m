From: Mark Lord <liml@rtr.ca>
Subject: PIO with SSDs: needs a long DRQ-after-command timeout for WRITEs
Date: Tue, 30 Dec 2008 08:53:39 -0500
Message-ID: <495A27E3.50801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:56362 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbYL3NwK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2008 08:52:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Guys,

I'm still lurking around in the shadows here, but something just
came to light on another project which might affect mainline.

We're using new, cheap 32GB Transcend MLC SSDs with a PATA interface.
Normally, folks would use UDMA with these, and never notice an issue.

But this project has only (very slow) PIO interfaces, and the SSDs
didn't work at first on the old kernel here.

The fix, was to increase the allowed amount of time for the drive
to assert DRQ after s/w issues a PIO WRITE to the drive.

The kernel I was using here had a 50msec timeout (ATA spec requires
at least 20msec), but this was insufficient for these SSDs.

I suspect the SSDs perform an ERASE operation on WRITE,
before asserting DRQ, and this takes a bit of time.

Not sure how much time, but we just bumped the timeout up
to a few seconds and all is working again.  Overkill, yes.

So.. how long does libata and current IDE allow for initial DRQ assertion?
It should probably be at least 500msec or more now.

Cheers
