From: Pavel Machek <pavel@ucw.cz>
Subject: Re: SATA hdd refuses to reallocate a sector?
Date: Thu, 30 Apr 2015 21:01:54 +0200
Message-ID: <20150430190154.GA20400@amd>
References: <20130623101940.GA4448@amd.pavel.ucw.cz>
 <20130623112133.GA4837@amd.pavel.ucw.cz>
 <CAJBHPoj5hgp97=JH8UKX+Ty8TF9_ySQUYU6AnqcRjuLy5A-PcQ@mail.gmail.com>
 <20130623190003.GA6714@amd.pavel.ucw.cz>
 <51C76858.4060906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48753 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbD3TB5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Apr 2015 15:01:57 -0400
Content-Disposition: inline
In-Reply-To: <51C76858.4060906@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Marcus Overhagen <marcus.overhagen@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, tj@kernel.org

Hi!

> > Thanks for the hint. (Insert rant about hdparm documentation
> > explaining that it is bad idea, but not telling me _why_ is it bad
> > idea. Can I expect cache consistency issues after that, or is it just
> > simple "you are writing to the disk without any checks"? Plus, I guess
> > documentation should mention what sector number is. I guess sectors
> > are 512bytes for the old drives, but is it 512 or 4096 for new
> > drives?)
> 
> For ATA, use the "logical sector size".
> For all existing drives out there, that's a 512 byte unit.
> 
> > ...but it does not do the trick :-(. It behaves strangely as if it was
> > still cached somewhere. Do I need to turn off the write back cache?
> 
> No, it works just fine.  You probably have more than one bad sector.
> After you see a read failure, run "smartctl -a" and look at the error
> logs to see what sector the drive is choking on.
> 
> Or just low-level format it all with "hdparm --security-erase".

Ok, so security erase is not easy operation to do, and it took more
than two hours, and the drive is now full of zeros.. but the bad
sectors are still there.

smartctl -t long stopped working on this one. It is no longer possible
to start a test.

It seems the drive has some firmware problems... But smart still
indicates good health and it still works (except few bad sectors).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
