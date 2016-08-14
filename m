From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 18:06:53 +0200
Message-ID: <20160814160653.GA3802@amd>
References: <20160813190340.GA29989@amd>
 <20160814092044.GA20392@amd>
 <20160814101438.GA27772@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50333 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbcHNQG6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Aug 2016 12:06:58 -0400
Content-Disposition: inline
In-Reply-To: <20160814101438.GA27772@amd>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, jamespharvey20@gmail.com, regressions@leemhuis.info
Cc: hdegoede@redhat.com, tj@kernel.org, linux-ide@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, stern@rowland.harvard.edu

On Sun 2016-08-14 12:14:38, Pavel Machek wrote:
> On Sun 2016-08-14 11:20:44, Pavel Machek wrote:
> > Hi!
> > 
> > > It seems that in v4.8-rc0, /dev/sdX got reordered, and now USB devices
> > > are probed before SATA drivers. That is pretty anti-social. It
> > > broke my boot on my primary machine, and unfortunately due to BIOS
> > > problems (keyboard does not work when connected through a hub) it is
> > > less fun than it should be.
> > 
> > If you know which commit caused	the reordering, that would be helpful.
> > 
> > v4.1 seems to be ok: SATA disk is sda, as expected.
> > 
> > v4.4 seems to be ok: SATA disk is sda, as expected.
> 
> v4.6 seems to be ok.

v4.7-rc1 seems to be ok?! 9956d572
v4.7-rc3 seems still to be ok.
v4.7-rc4: still ok.
v4.7-rc5: ok.
v4.7-rc6: problem

Bisecting now, 8 steps to go. As it was introduced between -rc5 and
-rc6, bisect should not be too scary.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
