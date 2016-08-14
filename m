From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 12:01:02 +0200
Message-ID: <20160814100102.GA31847@amd>
References: <20160813190340.GA29989@amd>
 <20160814092044.GA20392@amd>
 <CAGnHSEmtgGO5QjfamnN0VPOO2w-4GrZQvPnbkBVdtWBPTnLieA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43442 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbcHNKBF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Aug 2016 06:01:05 -0400
Content-Disposition: inline
In-Reply-To: <CAGnHSEmtgGO5QjfamnN0VPOO2w-4GrZQvPnbkBVdtWBPTnLieA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, jamespharvey20@gmail.com, regressions@leemhuis.info, hdegoede@redhat.com, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, stern@rowland.harvard.edu

On Sun 2016-08-14 17:34:18, Tom Yan wrote:
> Since when it is expected that SATA disks will always be probed before
> USB disks? We can't guarantee that even if we make sure all ata
> drivers are loaded before usb-storage/uas. That's why we need
> consistent namings (e.g. /dev/disk/by-id/*).

Since SATA support was merged, certainly since v2.4, and from way
before /dev/disk/by-id existed.

People may not run udev, and you can't use /dev/disk/by-id on kernel
command line.

								Pavel

> On 14 August 2016 at 17:20, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> It seems that in v4.8-rc0, /dev/sdX got reordered, and now USB devices
> >> are probed before SATA drivers. That is pretty anti-social. It
> >> broke my boot on my primary machine, and unfortunately due to BIOS
> >> problems (keyboard does not work when connected through a hub) it is
> >> less fun than it should be.
> >
> > If you know which commit caused the reordering, that would be helpful.
> >
> > v4.1 seems to be ok: SATA disk is sda, as expected.
> >
> > v4.4 seems to be ok: SATA disk is sda, as expected.
> >
> > I'll test v4.6 next.
> >
> > v4.8-rc1: SATA disk is sde, behind USB card readers. Not helpful.
> >
> > Best regards,
> >                                                                         Pavel
> > --
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
