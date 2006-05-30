From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git patch] libata resume fix
Date: Tue, 30 May 2006 11:26:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605301122340.5623@g5.osdl.org>
References: <20060528203419.GA15087@havoc.gtf.org> <1148938482.5959.27.camel@localhost.localdomain>
 <447C4718.6090802@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:28631 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932373AbWE3S1E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 14:27:04 -0400
In-Reply-To: <447C4718.6090802@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org



On Tue, 30 May 2006, Mark Lord wrote:
> 
> Not in a suspend/resume capable notebook, though.
> 
> I don't know of *any* notebook drives that take longer
> than perhaps five seconds to spin-up and accept commands.
> Such a slow drive wouldn't really be tolerated by end-users,
> which is why they don't exist.

Indeed. In fact, I'd be surprised to see it in a desktop too.

At least at one point, in order to get a M$ hw qualification (whatever 
it's called - but every single hw manufacturer wants it, because some 
vendors won't use your hardware if you don't have it), a laptop needed to 
boot up in less than 30 seconds or something.

And that wasn't the disk spin-up time. That was the time until the Windows 
desktop was visible.

Desktops could do a bit longer, and I think servers didn't have any time 
limits, but the point is that selling a disk that takes a long time to 
start working is actually not that easy. 

The market that has accepted slow bootup times is historically the server 
market (don't ask me why - you'd think that with five-nines uptime 
guarantees you'd want fast bootup), and so you'll find large SCSI disks in 
particular with long spin-up times. In the laptop and desktop space I'd be 
very surprised to see anythign longer than a few seconds.

		Linus
