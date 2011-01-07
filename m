From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: 2.6.35.9 bug shown in dmesg (fwd)
Date: Fri, 7 Jan 2011 21:32:10 +0100
Message-ID: <20110107203209.GA1908@r2bh72.net.upc.cz>
References: <alpine.LNX.2.00.1012301233380.3394@bigred.russwhit.org>
 <20110103230028.GA1456@localhost.localdomain>
 <alpine.LNX.2.00.1101052112010.1625@bigred.russwhit.org>
 <20110106161918.GA3008@r2bh72.net.upc.cz>
 <alpine.LNX.2.00.1101061034080.1611@bigred.russwhit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx4.wp.pl ([212.77.101.8]:60734 "EHLO mx4.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755399Ab1AGUZf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Jan 2011 15:25:35 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1101061034080.1611@bigred.russwhit.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell Whitaker <russ@ashlandhome.net>
Cc: linux-ide@vger.kernel.org

On Thu, Jan 06, 2011 at 11:09:21AM -0800, Russell Whitaker wrote:
> >>Sorry, in my case that's the wrong bug. First found the bug using
> >>Slackware-current. So I stripped down his config file by removing
> >>most of what I can't use, recompiled, and the bug was still there.
> >>
> >>I'm not using amd76xrom so went into a MTD submenu and changed it to
> >>not set, etc, and found the bug is still there.
> >
> >I do not see any other problems except that one:
> >
> >	BUG: unable to handle kernel paging request at f862aaa0
> >	IP: [<f8120282>] simple_map_write+0x82/0xbb [map_funcs]
> >
> >in dmesg's you provided in the first email. That BUG is from amd75xrom
> >driver. Does dmesg without MTD compiled show something different?
> 
> The " - kernel bug?" line is gone.
???

> >And this is also not clear for me from your first email, crash happened
> >every time with pata or randomly?
> 
> There are two bugs. In order to reduce the problem to only one bug I
> complied 2.6.35.10-smp without MTD's 4 drivers where the name starts
> with "bios" and also compiled with pata.
> 
> Result, first four attempts at booting: oops 3, success 1.

Ok, but on all dmesgs in your first email there was no oops
other than MTD one. If you want to have pata bug fixed, you need
to show where the problem is.

Stanislaw
