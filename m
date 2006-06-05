From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] swsusp: allow drivers to determine between write-resume and actual wakeup
Date: Mon, 5 Jun 2006 15:15:16 +0200
Message-ID: <20060605131516.GD2132@elf.ucw.cz>
References: <20060605091131.GE8106@htj.dyndns.org> <20060605092342.GI5540@elf.ucw.cz> <44841AA0.4060404@gmail.com> <448426FE.8090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12161 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750782AbWFENQB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jun 2006 09:16:01 -0400
Content-Disposition: inline
In-Reply-To: <448426FE.8090801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Po 05-06-06 21:43:42, Tejun Heo wrote:
> Tejun Heo wrote:
> >Pavel Machek wrote:
> >>If you want to know if you RESUME was after normal FREEZE or if it is
> >>after reboot, there's better patch floating around to do that.
> >
> >Yeap, this is what I'm interested in.  Care to give me a pointer?
> 
> And, one more things.  As written in the first mail, for libata, it 
> would be nice to know if a device suspend is due to runtime PM event 
> (per-device) or system wide suspend.  What do you think about this?  If 
> you agree, what method do you recommend to determine that?

Currently, runtime pm is unsupported/broken; so any request can be
thought as system pm.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
