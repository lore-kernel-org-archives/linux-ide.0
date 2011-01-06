From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: 2.6.35.9 bug shown in dmesg (fwd)
Date: Thu, 6 Jan 2011 17:19:18 +0100
Message-ID: <20110106161918.GA3008@r2bh72.net.upc.cz>
References: <alpine.LNX.2.00.1012301233380.3394@bigred.russwhit.org>
 <20110103230028.GA1456@localhost.localdomain>
 <alpine.LNX.2.00.1101052112010.1625@bigred.russwhit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.7]:46668 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157Ab1AFQMv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2011 11:12:51 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1101052112010.1625@bigred.russwhit.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell Whitaker <russ@ashlandhome.net>
Cc: linux-ide@vger.kernel.org

On Wed, Jan 05, 2011 at 10:21:21PM -0800, Russell Whitaker wrote:
> >For some unknown reason resources needed by amd76xrom driver can not be
> >available. Instead of return error, driver crash the kernel with
> >messages like below. Patch fix that.
> >
> >amd76xrom" amd76xrom_init_one(): Unable to register resource 0x00000000ffc00000-0x00000000ffffffff - kernel bug?
> 
> Sorry, in my case that's the wrong bug. First found the bug using
> Slackware-current. So I stripped down his config file by removing
> most of what I can't use, recompiled, and the bug was still there.
> 
> I'm not using amd76xrom so went into a MTD submenu and changed it to
> not set, etc, and found the bug is still there.

I do not see any other problems except that one:

	BUG: unable to handle kernel paging request at f862aaa0
	IP: [<f8120282>] simple_map_write+0x82/0xbb [map_funcs]

in dmesg's you provided in the first email. That BUG is from amd75xrom
driver. Does dmesg without MTD compiled show something different?
And this is also not clear for me from your first email, crash happened
every time with pata or randomly?

Stanislaw
