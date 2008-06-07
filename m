From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.25 -> 2.6.26-rc1: pcmcia flash card changed name from hda
	to hdc
Date: Sat, 7 Jun 2008 23:31:56 +0200
Message-ID: <20080607213156.GB1746@elf.ucw.cz>
References: <20080515132313.GA1558@elf.ucw.cz> <200805162140.49501.bzolnier@gmail.com> <20080605102146.GA1552@elf.ucw.cz> <200806062245.55973.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58448 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbYFGVbE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jun 2008 17:31:04 -0400
Content-Disposition: inline
In-Reply-To: <200806062245.55973.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org

Hi!

...
> I now see the source cause of the hda -> hdc name change - we've fixed
> bast-ide (for arm/bast and arm/vr1000) palm_bk3710 (arm/davinci), ide-cs
> and delkin_cb to use ide_find_port() instead of ide_deprecated_find_port()
> in the commit 4f0eee4d877e3b617b6a22d209d52b3dfca2b2a7.
> 
> This was needed because re-using interfaces already claimed by other host
> drivers was buggy (i.e. if ide-cs was used along with some other host driver
> that can be unloaded, unloading the other driver would result in attempt to
> un-register ide-cs interface => havoc), also the change was necessary for
> proper IDE warm-plug support (devices can be added/removed to ide0).
> 
> We may try to bring the old behavior back with some (major) hackery but:

No, I do not think we should do any hackery here. I should fix my
scripts. Thanks!

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
