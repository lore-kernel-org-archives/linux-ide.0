From: Pavel Machek <pavel@suse.cz>
Subject: Re: Laptop shock detection and harddisk protection
Date: Sun, 17 Aug 2008 21:51:03 +0200
Message-ID: <20080817195103.GD4043@ucw.cz>
References: <48C7FCEE.8060404@kernel.org> <41840b750809110908o54a61f55w7b1b9793abf55634@mail.gmail.com> <48C948A6.3080404@kernel.org> <877i9ipi56.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3605 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753701AbYIQO0K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Sep 2008 10:26:10 -0400
Content-Disposition: inline
In-Reply-To: <877i9ipi56.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Tejun Heo <tj@kernel.org>, Shem Multinymous <multinymous@gmail.com>, Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi!

> Short of a satisfying proposition regarding the questions raised, I just
> want to add two things that would be nice to solve in the future one way
> or another and should perhaps be taken into consideration from the
> beginning:
> 
> 1. Disable polling completely when it isn't required: once the hd has
>    spun down, there is no need to keep polling the sensors at all. Only
>    when the first request requiring the hd to spin up arrives, the
>    kernel needs to hold back for a short while to gather enough data
>    from the sensors, so shock protection is up and running again.

hdparm can already tell if disk is spinning or not. As userland is
polling, already, that may be enough?

> 2. Make shock protection interact nicely with suspend operations:
>    currently, we are out of luck if anything should happen after
>    processes have been frozen. This is particularly unfortunatel in the
>    case of s2disk.

I'd say that s2disk is similar to early boot... no protection there. 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
