From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Sat, 02 Feb 2008 16:13:36 +0900
Message-ID: <47A41820.2070907@gmail.com>
References: <200801272122.21823.gene.heskett@gmail.com>	 <200801281135.14555.gene.heskett@gmail.com>	 <1201580616.12795.2.camel@localhost>	 <200801282349.11696.gene.heskett@gmail.com> <1201582875.12795.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:29173 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276AbYBBHNo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 02:13:44 -0500
Received: by rv-out-0910.google.com with SMTP id k20so984263rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 23:13:43 -0800 (PST)
In-Reply-To: <1201582875.12795.15.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Gene Heskett <gene.heskett@gmail.com>, Mikael Pettersson <mikpe@it.uu.se>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

Kasper Sandberg wrote:
> to put some timeline perspective into this.
> i believe it was in 2005 i assembled the system, and when i realized it
> was faulty, on old ide driver, i stopped using it - that miht have been
> in beginning of 2006. then for almost a year i werent using it, hoping
> to somehow fix it, but in january 2007 i think it was, atleast in the
> very beginning of 2007, i hit upon the idea of trying libata, and ever
> since the system has been running 24/7 - doing these errors around 2
> times a day.
> 
> i have multiple times reported my problems to lkml, but nothing has
> happened, i also tried to aproeach jgarzik direcly, but he was not
> interested.
> 
> i really hope this can be solved now, its a huge problem
> 
> my fileserver has an asus k8v motherboard, with via chipset (k8t880 i
> think it is, or something like it). currently using the promise
> controller again(strangely enough all the timeouts seems to happen here,
> and when the ITE was on, there, not the onboard one), in conjunction
> with the onboard via.

Timeouts are nasty to debug.  It can be caused by whole range of
different problems including transmission errors, bad power, faulty
drive, mishandled media error, IRQ misrouting, dumb hardware bug.  It's
basically 'uh... I told the controller to do something but it never
called me back'.

If you see timeouts on multiple devices connected to different
controllers, the chance is that you have problem somewhere else.  The
most likely culprit is bad power.  Please...

* Post the result of 'lspci -nn' and kernel log including full boot log
and error messages.

* Try to isolate the problem.  ie. Does removing several number of
drives fix the problem?  If the problem is localized to certain device,
what happens if you move it?  Does the problem follow the drive or stay
with the port?  If the failing drives are SATA, it's a good idea to
power some of the failing drives with a separate PSU and see whether
anything is different.

By trying to isolate the hardware problem, more can be learned about the
error condition and even when the problem actually isn't hardware
problem, it gives us much deeper insight of the problem and clues
regarding where to look.

Thanks.

-- 
tejun
