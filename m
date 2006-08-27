From: Jens Axboe <axboe@kernel.dk>
Subject: Re: HPA Resume patch
Date: Sun, 27 Aug 2006 19:05:01 +0200
Message-ID: <20060827170501.GD30609@kernel.dk>
References: <44F15ADB.5040609@PicturesInMotion.net> <20060827150608.GA4534@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:39693 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932182AbWH0RCZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Aug 2006 13:02:25 -0400
Content-Disposition: inline
In-Reply-To: <20060827150608.GA4534@ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Lee Trager <Lee@PicturesInMotion.net>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, seife@suse.de

On Sun, Aug 27 2006, Pavel Machek wrote:
> Hi!
> 
> > This patch fixes a problem with computers that have HPA on their hard
> > drive and not being able to come out of resume from RAM or disk. I've
> > tested this patch on 2.6.17.x and 2.6.18-rc4 and it works great on both
> > of these. This patch also fixes the bug #6840. This is my first patch to
> > the kernel and I was told to e-mail the above people to get my patch
> > into the kernel.
> 
> Congratulations for a first patch.
> 
> > If I made a mistake please be gentle and correct me ;)
> 
> We'll need signed-off-by: line next time.
> 
> Stefan, can we get this some testing? Or anyone else with thinkpad
> with host-protected area still enabled?

It has design issues, at someone else already noticed. hpa restore needs
to be a driver private step, included in the resume state machine. The
current patch is a gross layering violation.

But thanks to Lee for taking a stab at this, I hope he'll continue and
get it polished :-)

-- 
Jens Axboe

