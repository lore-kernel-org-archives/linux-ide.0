From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Sat, 14 Apr 2007 10:52:56 +0000
Message-ID: <20070414105255.GB9157@ucw.cz>
References: <461D4E2C.6000704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1078 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752851AbXDOJhX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Apr 2007 05:37:23 -0400
Content-Disposition: inline
In-Reply-To: <461D4E2C.6000704@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org


Hi!

> When I reboot my notebook, it powers off and powers back on.
> On poweroff a loud snapping noise seems to be coming from the
> hard drive. Today I noticed there is no "shutdown: hda" on
> the console when I reboot. Whne I do a normal poweroff the
> message is displayed and there is no noise. Should the IDE
> code be changed so it always shuts down the drive?

Well... most machines have reboot handling where they do not cut power
to disk drive. That means that shutting down their hdds would
unneccessarily wear their drives.

...while we unneccessarily wear *your* drive :-(.

How common are notebooks that cut power to disks during reboot?
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
