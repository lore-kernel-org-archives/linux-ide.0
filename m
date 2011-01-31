From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: Re: sata_via bus errors fixed?
Date: Mon, 31 Jan 2011 12:19:31 +0000
Message-ID: <4D46A8D3.3000807@mrc-lmb.cam.ac.uk>
References: <4D3DA387.8080301@mrc-lmb.cam.ac.uk> <20110124170432.GH27510@htj.dyndns.org> <4D3EA771.3070206@mrc-lmb.cam.ac.uk> <20110125105049.GQ27510@htj.dyndns.org> <4D3FF0D9.5040006@mrc-lmb.cam.ac.uk> <20110126101119.GE12520@htj.dyndns.org> <4D4693DB.4070009@mrc-lmb.cam.ac.uk> <20110131105322.GE7459@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:53275 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab1AaMTt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jan 2011 07:19:49 -0500
In-Reply-To: <20110131105322.GE7459@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
>> One thing I still need to investigate is why Ubuntu 10.04 was showing
>> the problem, but perhaps I never got as far as updating the kernel after
>> installing it. (AFAIK as installed it is 2.6.31, whilst the current
>> update is 2.6.32-28 which I think should have the patch)
> 
> Most likely.

I've just been googling and peeking and it seems there may be another
possibility but I'm much less familiar with Ubuntu so I could easily be
misinterpreting something.

I have an Ubuntu box at work and I just installed the
linux-source-2.6.32-28.55 package on it. When I look at sata_via.c I see
that there's a different (earlier?) version of the patch there than what
is in 2.6.37 (the test is pdev->device == 0x3249 versus one based on
board_id)

So it's conceivable that I did update my lucid installation at home but
that this version of the patch doesn't fix the problem. I'll check
exactly what's what tonight.

> So, that leaves the problem sil was seeing.  Are you
> interested in digging that down too?

Well I don't mind testing that card with the kernels I've now got,
assuming I can borrow the card again. I'm a lot less enthusiastic about
compiling more new versions though.

Firstly, I've got to finish sorting out my machine - my backup system
has stopped working for example and I've still got a bunch of data to
migrate/integrate from the old disk. And I need to upgrade SUSE to 11.3
to see if that fixes this problem without introducing any new ones.

Secondly, kernel compilation in my limited experience has been a big
hassle. Every time I change anything in sata_via.c it seems to want to
recompile absolutely everything and that takes over two hours. I thought
make was supposed to do minimal recompilation? That plus a bug in the
script, the unexpectedly large amount of space required and some finger
trouble made it a less than smooth process.

Since we don't yet know whether a recent kernel fixes my sil problem and
if it does we don't have any idea of a particular patch, that suggests
the strategy would be bisection, which probably involves more compiles
than I'm up for.

But first steps first. I'll see if I can test it with my existing kernels.

Cheers, Dave
