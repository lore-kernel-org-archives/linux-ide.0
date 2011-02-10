From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 19:31:24 +0000
Message-ID: <20110210193124.321b7ad6@lxorguk.ukuu.org.uk>
References: <4D51A648.20707@cfl.rr.com>
	<20110209085935.GE6558@htj.dyndns.org>
	<4D52B0B3.40900@cfl.rr.com>
	<20110209153714.558133d7@lxorguk.ukuu.org.uk>
	<4D52ECB6.4010408@cfl.rr.com>
	<20110209214118.GA7196@atj.dyndns.org>
	<4D5332D2.5090701@cfl.rr.com>
	<4D534378.3050304@gmail.com>
	<20110210091325.GK3770@htj.dyndns.org>
	<4D54387F.3030809@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49423 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753883Ab1BJT1o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 14:27:44 -0500
In-Reply-To: <4D54387F.3030809@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Ubuntu has dropped its patch to always unlock in favor of your upstream
> change to unlock when it makes sense.  The net result is that it unlocks
> less, but still sometimes unlocks when it should not with certain raid

If you start the smart stuff then it also sometimes locks when it
shouldn't with devastating results for non technical users. I'd say
Ubuntu made a bad mistake on that one, but its their project so up to
them.

> > Making the condition more intricate won't fix the problem.  It's just
> > gonna make it fail in more weird and convoluted ways.
> 
> If it fails less, then it is an improvement.

No - not if the failure becomes harder to handle. It's like the
difference between debugging an app crash versus trying to work out why
some convuluted pile of Gnome desktop stuff has suddenely decided not to
stick up an authentication box this week. Clear, bounded, predictable and
replicable failure cases are good in the long term.

> > Hotplugging and being able to move hard drives between different
> > machines, and in general behaving consistently across different
> > hardware configurations have way higher priority than trying to avoid
> 
> Your auto unlock change seems to address that issue just fine.

No - because the drive may not even have a partition table on the other
OS.

