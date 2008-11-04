From: Pavel Machek <pavel@suse.cz>
Subject: Re: [git patches] libata hibernation fixes
Date: Tue, 4 Nov 2008 21:30:37 +0100
Message-ID: <20081104203036.GE5862@ucw.cz>
References: <20081104062734.GA4420@havoc.gtf.org> <alpine.LFD.2.00.0811040823350.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53212 "EHLO UNKNOWN"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753469AbYKDUl6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 15:41:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811040823350.3419@nehalem.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi!

>  - quite possibly: we just should not spin down disks at all, and just 
>    flush them and do the "park" command thing. If we're _really_ powering 
>    off, the disks will spin down on their own when power goes away. Maybe 
>    that's what Windows does?

I believe that 'emergency' spindown (on power fail) is different from
regular spindown, and that emergency spindown damages the disk more.

But perhaps park + power fail is similar to regular spindown?

(Is park command normally supported on modern disks? IIRC hdaps people
had issues with not all disks supporting it?)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
