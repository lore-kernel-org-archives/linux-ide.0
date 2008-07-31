From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 05:17:27 +0200
Message-ID: <200807310517.27978.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop> <200807310248.29214.bzolnier@gmail.com> <1217466559.11188.378.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:63852 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbYGaDUq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 23:20:46 -0400
Received: by fk-out-0910.google.com with SMTP id 18so267955fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 20:20:45 -0700 (PDT)
In-Reply-To: <1217466559.11188.378.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Thursday 31 July 2008, Benjamin Herrenschmidt wrote:
> On Thu, 2008-07-31 at 02:48 +0200, Bartlomiej Zolnierkiewicz wrote:
> > There seems to be some confusion between warm-plugging of IDE devices
> > and hot-plugging of IDE devices.
> > 
> > > not a single piece of HW to exercise those code path ? I don't ask you
> > > to get a powermac with a media-bay, but ide_cs seems to be a pretty
> > > important one that's part of what the ide maintainer should take care
> > > of... And I suspect it's going to exercise the same code path as
> > > mediabay.
> > 
> > I'm open for offers of co-maintaince of the code (which includes taking
> > over particular host drivers) and since you seem to have pretty good
> > insight into what ide maintainer should be doing I presume that you want
> > to be added to MAINTAINERS?
> 
> Should I laugh ?
> 
> Seriously here. Those things used to work, you broke them.

That's jumping to conlusions as you haven't yet proven that it was
really me. :)

Which would be great because than I can finally start fixing the damage.

> It may be worthwile cleanup / improvements, but at the end of the day,
> if you are the maintainer for drivers/ide, and things as fundamental as
> supporting proper ide_cs seems to be totally part of your job. I'm not

Maybe I'm really completely unsuited for the job.  I even didn't know
that proper supporting of _one_ particular host driver is a _fundamental_
part of the _subsystem_ maintainer's job...

> saying ide_cs is broken today (though I suspect it -may- be suffering
> from similar breakage to media-bay), however, I'm reacting to your
> apparent lack of interest in making sure these things work.

If only all people showed so much interest as *IDE*PMAC* Maintainer in
making sure that things work (instead of i.e. telling people what should
they be doing in their _limited_ _private_ time) we would have nothing
to worry about! ;)

Can we now go back to fixing ide-pmac breakage?  Pretty please.

It is not unlikely that it in the time it took for the last four
mails it would have been fixed already.
