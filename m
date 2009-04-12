From: "Leslie Rhorer" <lrhorer@satx.rr.com>
Subject: RE: Implementing NVMHCI...
Date: Sun, 12 Apr 2009 00:08:21 -0500
Message-ID: <20090412050829.SANX2520.cdptpa-omta04.mail.rr.com@Leslie>
References: <alpine.LFD.2.00.0904111524000.4583@localhost.localdomain>
Reply-To: <lrhorer@satx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:43188 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbZDLFIb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Apr 2009 01:08:31 -0400
Received: from Leslie ([68.203.168.150]) by cdptpa-omta04.mail.rr.com
          with ESMTP
          id <20090412050829.SANX2520.cdptpa-omta04.mail.rr.com@Leslie>
          for <linux-ide@vger.kernel.org>; Sun, 12 Apr 2009 05:08:29 +0000
In-Reply-To: <alpine.LFD.2.00.0904111524000.4583@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> So if you're involved with any such hardware or know people who are, you
> might give people strong hints that sector sizes >4kB will not be taken
> seriously by a huge number of people. Maybe it's not too late to head the
> crap off at the pass.
> 
> Btw, this is not a new issue. Sandisk and some other totally clueless SSD
> manufacturers tried to convince people that 64kB access sizes were the
> RightThing(tm) to do. The reason? Their SSD's were crap, and couldn't do
> anything better, so they tried to blame software.
> 
> Then Intel came out with their controller, and now the same people who
> tried to sell their sh*t-for-brain SSD's are finally admittign that
> it was crap hardware.
> 
> Do you really want to go through that one more time?

So with drive sizes soon to be at 10TB, and arrays soon to exceed 250 and
perhaps even 1000TB, what's the long term solution?  I'm far from being an
expert, and you most certainly are an expert, so do you really feel a 4KB
sector is the way to go for the indeterminate future?  My mind reels at the
thought of dealing with perhaps more than a trillion sectors on a drive
system.  Clearly it's possible a 64 bit file system may be a simpler
proposition than a 64K sector, but still...

