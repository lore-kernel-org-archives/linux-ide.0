From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 13:58:58 -0500
Message-ID: <4D543572.4010807@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com>	<20110209085935.GE6558@htj.dyndns.org>	<4D52B0B3.40900@cfl.rr.com>	<20110209153714.558133d7@lxorguk.ukuu.org.uk>	<4D52ECB6.4010408@cfl.rr.com>	<20110209211351.3d7eff85@lxorguk.ukuu.org.uk>	<4D5306F8.6050106@cfl.rr.com>	<20110209213904.4aff945d@lxorguk.ukuu.org.uk>	<4D532FFC.2020503@cfl.rr.com> <20110210124644.0cec1287@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.123]:45124 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1BJS6x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 13:58:53 -0500
In-Reply-To: <20110210124644.0cec1287@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/10/2011 7:46 AM, Alan Cox wrote:
> About ten years of distributions, drive hiding magic for old BIOSes and
> other pain.

So a few systems made over a decade ago used the HPA to hide the true
size of the drive from a broken bios, and it was a good idea for the OS
to unlock it?  How did Windows run on such systems?  That seems like a
radically obscure case for always unlocking.  Tejun's change already
fixes such a system anyhow.

Is there any other pain that makes unlocking a good idea?  Would any of
it still fail with Tejun's change?

> It's unfortunate you won't listen but continue to spout stuff from a
> standard no vendor, no OS and no product ever followed. ATA is not built
> on strict adherance to formal standards, nor is the PC.

Microsoft's OS follows it.

> I see no point continuing this discussion if all you want to do is wave a
> 'standard' that isn't followed by anyone and breaks stuff and demand we
> follow it. Always unlock in the kernel, make both sets of geometry
> available via sysfs and then fix dmraid. It's an easy problem to solve
> and because dmraid knows a lot about fakeraid stuff it also knows enough
> to peer in various locations and figure out which to use - something that
> the kernel quite intentionally does not.

Even if dmraid works around it, you are still left with:

1)  Possibly trashing data the bios put on the hd and told you not to touch

2)  Rebooting after running Linux leaves the drive unlocked, which
causes the fakeraid bios to complain that your raid is broken.  People
don't like that.
