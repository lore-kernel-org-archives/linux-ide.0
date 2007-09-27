From: robert@robos.org (Robert)
Subject: Re: Improper disk shutdown with 2.6.22.6?
Date: Thu, 27 Sep 2007 10:58:18 +0200
Message-ID: <20070927085818.GA31158@robos.org>
References: <20070919093306.GA2359@robos.org> <46FAFBDA.4080509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proxy3.bredband.net ([195.54.101.73]:63475 "EHLO
	proxy3.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbXI0I63 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 04:58:29 -0400
Content-Disposition: inline
In-Reply-To: <46FAFBDA.4080509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jeff Garzik <jeff@garzik.org>

On Thu, Sep 27, 2007 at 09:39:54AM +0900, Tejun Heo wrote:
> [cc'ing Henrique and Jeff]
> 
> Robert wrote:
> > Hello,
> > 
> > When shutting down this system running Linux 2.6.22.6, I get a warning about
> > the possibility that the disks are not properly shut down. When the power is
> > turned off, it sounds like the disks aren't spun down (but I may be mistaken
> > on that point).
> > 
> > http://linux-ata.org/shutdown.html claims that kernels newer than 2.6.21 will
> > always spin down the disks, but is this really the case?
> > The manage_start_stop files exist.
> > 
> > Tell me if you'd like more detailed information about configuration and
> > hardware.
> 
> You're on debian, right?  You need to update your shutdown utilities.

Thanks for your help.

I'm on Debian, yes, and now I applied the change to /etc/init.d/halt in
http://lists.alioth.debian.org/pipermail/pkg-sysvinit-commits/2007-June.txt
and I'm using HDDOWN=NEVER in /etc/default/halt, which seems to work.

Robert

> Henrique, what information should we put into the faq page to properly
> direct debian users to needed updates?
> 
> Thanks.
> 
> -- 
> tejun
> 
