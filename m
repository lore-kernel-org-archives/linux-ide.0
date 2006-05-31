From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [git patch] libata resume fix
Date: Wed, 31 May 2006 18:01:18 -0400
Message-ID: <447E122E.3000105@tmr.com>
References: <20060528203419.GA15087@havoc.gtf.org> <1148938482.5959.27.camel@localhost.localdomain> <447C4718.6090802@rtr.ca> <Pine.LNX.4.64.0605301122340.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:43698 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S965192AbWEaV7k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 May 2006 17:59:40 -0400
In-Reply-To: <Pine.LNX.4.64.0605301122340.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 30 May 2006, Mark Lord wrote:
>> Not in a suspend/resume capable notebook, though.
>>
>> I don't know of *any* notebook drives that take longer
>> than perhaps five seconds to spin-up and accept commands.
>> Such a slow drive wouldn't really be tolerated by end-users,
>> which is why they don't exist.
> 
> Indeed. In fact, I'd be surprised to see it in a desktop too.
> 
> At least at one point, in order to get a M$ hw qualification (whatever 
> it's called - but every single hw manufacturer wants it, because some 
> vendors won't use your hardware if you don't have it), a laptop needed to 
> boot up in less than 30 seconds or something.
> 
> And that wasn't the disk spin-up time. That was the time until the Windows 
> desktop was visible.
> 
> Desktops could do a bit longer, and I think servers didn't have any time 
> limits, but the point is that selling a disk that takes a long time to 
> start working is actually not that easy. 
> 
> The market that has accepted slow bootup times is historically the server 
> market (don't ask me why - you'd think that with five-nines uptime 
> guarantees you'd want fast bootup), and so you'll find large SCSI disks in 
> particular with long spin-up times. In the laptop and desktop space I'd be 
> very surprised to see anythign longer than a few seconds.

The trade-off is that if I have a 15k rpm SCSI drive, it would take a 
lot of design changes to make it spin up quickly, and improve a function 
which is usually done on a server once every MTBF when replacing the 
failed unit.

I think the majority of very large or very fast drives are in systems 
which don't (deliberately) power cycles often, in rooms where heat is an 
issue. And to spin up quickly take a larger power supply... 30 sec is 
fine with most users.

Couldn't find a spin-up time for the new Seagate 750GB drive, but the 
seek sure is fast!

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

