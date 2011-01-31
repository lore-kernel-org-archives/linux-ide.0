From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_via bus errors fixed?
Date: Mon, 31 Jan 2011 14:24:30 +0100
Message-ID: <20110131132430.GH7459@htj.dyndns.org>
References: <4D3DA387.8080301@mrc-lmb.cam.ac.uk>
 <20110124170432.GH27510@htj.dyndns.org>
 <4D3EA771.3070206@mrc-lmb.cam.ac.uk>
 <20110125105049.GQ27510@htj.dyndns.org>
 <4D3FF0D9.5040006@mrc-lmb.cam.ac.uk>
 <20110126101119.GE12520@htj.dyndns.org>
 <4D4693DB.4070009@mrc-lmb.cam.ac.uk>
 <20110131105322.GE7459@htj.dyndns.org>
 <4D46A8D3.3000807@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46833 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755508Ab1AaNYk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jan 2011 08:24:40 -0500
Received: by fxm20 with SMTP id 20so5589894fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 31 Jan 2011 05:24:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D46A8D3.3000807@mrc-lmb.cam.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Cc: linux-ide@vger.kernel.org

Hello,

On Mon, Jan 31, 2011 at 12:19:31PM +0000, Dave Howorth wrote:
> I have an Ubuntu box at work and I just installed the
> linux-source-2.6.32-28.55 package on it. When I look at sata_via.c I see
> that there's a different (earlier?) version of the patch there than what
> is in 2.6.37 (the test is pdev->device == 0x3249 versus one based on
> board_id)

Yes, originally the FIFO fix was applied more narrowly.  Later it got
discovered that the fix was necessary for all 6421's and updated.

> So it's conceivable that I did update my lucid installation at home but
> that this version of the patch doesn't fix the problem. I'll check
> exactly what's what tonight.

Yeah, if that's the case and if it's still not updated in ubuntu,
opening a bug report against ubuntu would be a good idea.

> > So, that leaves the problem sil was seeing.  Are you
> > interested in digging that down too?
> 
> Well I don't mind testing that card with the kernels I've now got,
> assuming I can borrow the card again. I'm a lot less enthusiastic about
> compiling more new versions though.
> 
> Firstly, I've got to finish sorting out my machine - my backup system
> has stopped working for example and I've still got a bunch of data to
> migrate/integrate from the old disk. And I need to upgrade SUSE to 11.3
> to see if that fixes this problem without introducing any new ones.

Okay.

> Secondly, kernel compilation in my limited experience has been a big
> hassle. Every time I change anything in sata_via.c it seems to want to
> recompile absolutely everything and that takes over two hours. I thought
> make was supposed to do minimal recompilation? That plus a bug in the
> script, the unexpectedly large amount of space required and some finger
> trouble made it a less than smooth process.

It really shouldn't be like that.  If you're using distro build
scripts, it might behave like that but if you're building directly
from vanilla tarball and if you just modify sata_via, it will just
recompile sata_via and relink the kernel which will probably take
something like a couple minutes.

> Since we don't yet know whether a recent kernel fixes my sil problem and
> if it does we don't have any idea of a particular patch, that suggests
> the strategy would be bisection, which probably involves more compiles
> than I'm up for.

If sil shows the problem, I'll provide debug patches so that you'll
only need to build libata and sata_via.

Thanks.

-- 
tejun
