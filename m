From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 2.6.30-rc2 2/2] palm_bk3710:  UDMA performance fix
Date: Thu, 23 Apr 2009 22:48:26 +0200
Message-ID: <200904232248.26284.bzolnier@gmail.com>
References: <200904201841.10989.david-b@pacbell.net> <200904222305.54820.bzolnier@gmail.com> <200904221529.23427.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51181 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039AbZDWUoZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Apr 2009 16:44:25 -0400
Received: by fxm2 with SMTP id 2so769369fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 23 Apr 2009 13:44:23 -0700 (PDT)
In-Reply-To: <200904221529.23427.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, DaVinci <davinci-linux-open-source@linux.davincidsp.com>

On Thursday 23 April 2009 00:29:23 David Brownell wrote:
> On Wednesday 22 April 2009, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > By the way ... what about the first patch,
> > > which removed accesses to all those non-existent
> > > registers and bitfields?
> > 
> > I didn't see any discussion on it and it looked less urgent / more risky
> > (it is not uncommon for documentation to lack some data) than patch #2.
> 
> It's uncommon for TI's documentation to be that far off,
> for that long, though.  "Lacking" docs for 50% of the
> registers, for several years ... doesn't make sense.
> 
> The current reset handling is clearly broken:  the docs
> are quite explicit that the controller doesn't drive the
> reset signal, it's got to be done through a GPIO.  The
> board designs match that part of the docs.  The code is
> thus contrary to *all* other documentation.
> 
> Early DaVinci drivers sometimes exhibited a flagrant
> disregard for chip documentation.  This driver is from
> about that era.  Maybe it started from prototypes using
> the a different controller design, for example.
> 
> 
> > Should it also go upstream for 2.6.30?
> 
> I can't say either patch would be urgent for 2.6.30,
> but of course it's good that bugfixes merge ASAP.
> 
> Since we're only at RC3, I'd be inclined to push both
> up right now.  If we were at RC6 or so, I'd hold off
> till the next merge window.

Thanks for the detailed explanation.

I applied the patch to ide-2.6.git/for-linus.
