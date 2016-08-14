From: Pavel Machek <pavel@ucw.cz>
Subject: Regression - SATA disks behind USB ones on v4.8-rc1, breaking boot.
 [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 11:20:44 +0200
Message-ID: <20160814092044.GA20392@amd>
References: <20160813190340.GA29989@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42673 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbcHNJUr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Aug 2016 05:20:47 -0400
Content-Disposition: inline
In-Reply-To: <20160813190340.GA29989@amd>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, jamespharvey20@gmail.com, regressions@leemhuis.info
Cc: hdegoede@redhat.com, tj@kernel.org, linux-ide@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, stern@rowland.harvard.edu

Hi!

> It seems that in v4.8-rc0, /dev/sdX got reordered, and now USB devices
> are probed before SATA drivers. That is pretty anti-social. It
> broke my boot on my primary machine, and unfortunately due to BIOS
> problems (keyboard does not work when connected through a hub) it is
> less fun than it should be.

If you know which commit caused	the reordering, that would be helpful.

v4.1 seems to be ok: SATA disk is sda, as expected.

v4.4 seems to be ok: SATA disk is sda, as expected.

I'll test v4.6 next.

v4.8-rc1: SATA disk is sde, behind USB card readers. Not helpful.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
