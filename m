From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/7] ide: locking improvements
Date: Sat, 11 Oct 2008 20:34:36 +0200
Message-ID: <20081011183436.GA10948@gollum.tnic>
References: <fa.Ke90oacfRjgiI4x5LejzjssRBEg@ifi.uio.no> <200810111645.27847.bzolnier@gmail.com> <20081011150532.GU19428@kernel.dk> <200810111756.37278.bzolnier@gmail.com> <20081011175617.GX19428@kernel.dk>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762430AbYJKSey@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081011175617.GX19428@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> > The actual users' feedback about amount of IDE changes have been mostly
> > positive (some ask for even more changes :) so I don't think that it
> > should be a reason of a great worries.  I hope that all other concerns
> > have been also cleared now.
> 
> Heck that's good, I do hope that I'm mostly over-concerned! I'm not
> trying to create a problem where there isn't one, mainly looking for
> clarity into the situation.
> 
> I noticed one ide-tape tested complaining something broke, and it seems
> like he was the only one out there actually using current kernels and
> testing it. I worry mostly about the changes breaking somebodys distro 3
> years down the line, by which point people may have moved on (and the
> old code would have worked).

We try to fix those as fast as possible and they become
highest priority. If we're talking about the same thing, aka
801bd32e205ca6ef78dcaf80121f1eccb89b8c1e, this is obviously already fixed.

It's not like everything is fine with the older code either. For example, I'm
staring at traces w.r.t. bug 11581 which somehow broke ide-cd around the 2.6.19
timeframe and this has been broken for that particular user since then. So I
think that what we do now, generally that anyone is doing something about that
code, replying to bug reports and working with users to solve problems is, IMO,
a lot bigger advantage than doing nothing at all. But your concern is also valid
and we're doing our best to avoid such regressions.

-- 
Regards/Gruss,
    Boris.
