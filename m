From: Joe Harvell <jharvell@dogpad.net>
Subject: Re: [SATA] status reports updated
Date: Fri, 15 Apr 2005 17:30:08 -0500
Message-ID: <1113604208.1341.81.camel@wrc2y0me.us.nortel.com>
References: <Pine.LNX.4.44.0504151711440.13960-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:26071 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261990AbVDOWaL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Apr 2005 18:30:11 -0400
Received: from zrtpd0jn.us.nortel.com (zrtpd0jn.us.nortel.com [47.140.202.35])
	by zcars04e.ca.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id j3FMU2k03972
	for <linux-ide@vger.kernel.org>; Fri, 15 Apr 2005 18:30:02 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.44.0504151711440.13960-100000@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I can understand the reluctance to put out a warning before verifying
the problem.

I would be willing to reproduce the problem if you have some debugging
data you want me to collect.

If you are concerned about the data corruption coming from the technique
I used (copying the OS installation from a utility boot environment),
then it may help you to know the following:

1. that I reproduced the problem 3 or 4 times with the 2.6 sata_promise
driver before deciding to try Promise's 2.4 driver; and 
2. that I used the same procedure of copying the same source OS from a
utility boot environment after switching to the 2.4 kernel and the
Promise driver, which resolved the problem.

On Fri, 2005-04-15 at 16:20, Mark Hahn wrote:
> On Fri, 15 Apr 2005, Joe Harvell wrote:
> 
> > http://marc.theaimsgroup.com/?l=linux-ide&m=111029414823303&w=2
> > http://marc.theaimsgroup.com/?l=linux-ide&m=111054989026053&w=2
> > http://marc.theaimsgroup.com/?l=linux-ide&m=111230129320297&w=2
> 
> all pretty much the same report (by Joe).
> 
> > http://marc.theaimsgroup.com/?l=linux-ide&m=111214149529209&w=2
> 
> leads to 
> http://forums.gentoo.org/viewtopic-p-2247734.html
> 
> which is somewhat more interesting, though rather fuzzy.  there's something 
> about the driver deciding not to handle an interrupt (nobody cared), after 
> which the driver is toast.  some claim that this might be dependent on which
> disk is attached.
> 
> fundamentally, the problem is to isolate whether the (few) reported problems
> are due to peculiarities of the reporting machines or not.
> 
> 
> > > > You need to add a comment about the SATAII TX2/TX4 boards indicating
> > > > users have experienced data corruption with the sata_promise driver and
> > > > the SATAII TX4 board.
> 
> personally, I don't think this kind of warning is warranted.  it's like
> saying that "rm" should have a warning because users have experienced 
> data deletion when mistyping it...
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Joe Harvell
jharvell@dogpad.net

