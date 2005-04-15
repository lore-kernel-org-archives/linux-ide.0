From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [SATA] status reports updated
Date: Fri, 15 Apr 2005 17:20:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44.0504151711440.13960-100000@coffee.psychology.mcmaster.ca>
References: <1113591701.1341.5.camel@wrc2y0me.us.nortel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:2298 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261978AbVDOVVI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Apr 2005 17:21:08 -0400
Received: from coffee.psychology.mcmaster.ca (coffee.Psychology.McMaster.CA [130.113.218.59])
	by sigma957.cis.mcmaster.ca (8.12.11/8.12.11) with ESMTP id j3FLL3v5013235
	for <linux-ide@vger.kernel.org>; Fri, 15 Apr 2005 17:21:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by coffee.psychology.mcmaster.ca (Postfix) with ESMTP id 009478807
	for <linux-ide@vger.kernel.org>; Fri, 15 Apr 2005 17:20:38 -0400 (EDT)
In-Reply-To: <1113591701.1341.5.camel@wrc2y0me.us.nortel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Fri, 15 Apr 2005, Joe Harvell wrote:

> http://marc.theaimsgroup.com/?l=linux-ide&m=111029414823303&w=2
> http://marc.theaimsgroup.com/?l=linux-ide&m=111054989026053&w=2
> http://marc.theaimsgroup.com/?l=linux-ide&m=111230129320297&w=2

all pretty much the same report (by Joe).

> http://marc.theaimsgroup.com/?l=linux-ide&m=111214149529209&w=2

leads to 
http://forums.gentoo.org/viewtopic-p-2247734.html

which is somewhat more interesting, though rather fuzzy.  there's something 
about the driver deciding not to handle an interrupt (nobody cared), after 
which the driver is toast.  some claim that this might be dependent on which
disk is attached.

fundamentally, the problem is to isolate whether the (few) reported problems
are due to peculiarities of the reporting machines or not.


> > > You need to add a comment about the SATAII TX2/TX4 boards indicating
> > > users have experienced data corruption with the sata_promise driver and
> > > the SATAII TX4 board.

personally, I don't think this kind of warning is warranted.  it's like
saying that "rm" should have a warning because users have experienced 
data deletion when mistyping it...

