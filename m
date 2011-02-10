From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 12:46:44 +0000
Message-ID: <20110210124644.0cec1287@lxorguk.ukuu.org.uk>
References: <4D51A648.20707@cfl.rr.com>
	<20110209085935.GE6558@htj.dyndns.org>
	<4D52B0B3.40900@cfl.rr.com>
	<20110209153714.558133d7@lxorguk.ukuu.org.uk>
	<4D52ECB6.4010408@cfl.rr.com>
	<20110209211351.3d7eff85@lxorguk.ukuu.org.uk>
	<4D5306F8.6050106@cfl.rr.com>
	<20110209213904.4aff945d@lxorguk.ukuu.org.uk>
	<4D532FFC.2020503@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41828 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751123Ab1BJMnH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 07:43:07 -0500
In-Reply-To: <4D532FFC.2020503@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> What experience?  The only reason that I have heard for unlocking it is 

About ten years of distributions, drive hiding magic for old BIOSes and
other pain.

> to maintain compatibility with the old ide driver which did so.  What 
> reason does Linux have to access an area of the disk that the system has 
> made clear it should not?

It's unfortunate you won't listen but continue to spout stuff from a
standard no vendor, no OS and no product ever followed. ATA is not built
on strict adherance to formal standards, nor is the PC.

> What part to you disagree with?  That the compromise in place can have 
> the benefits of both, but the drawbacks of neither?

That there is any point doing anything but always unlocking.

> I understand that dmraid could work around the problem, but there should 
> not be a problem in the first place.  The system has asked that we not 
> touch that part of the disk

I see no point continuing this discussion if all you want to do is wave a
'standard' that isn't followed by anyone and breaks stuff and demand we
follow it. Always unlock in the kernel, make both sets of geometry
available via sysfs and then fix dmraid. It's an easy problem to solve
and because dmraid knows a lot about fakeraid stuff it also knows enough
to peer in various locations and figure out which to use - something that
the kernel quite intentionally does not.

Alan
