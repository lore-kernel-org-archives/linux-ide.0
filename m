From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: SiI 3112 & Seagate drivers
Date: Sun, 13 Mar 2005 14:57:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0503131430290.22027-100000@coffee.psychology.mcmaster.ca>
References: <200503121937.55673.kanniball@zmail.pt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:52408 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261441AbVCMT5n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Mar 2005 14:57:43 -0500
In-Reply-To: <200503121937.55673.kanniball@zmail.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kanniball <kanniball@zmail.pt>
Cc: linux-ide@vger.kernel.org

> First off all excuse me for bugging you with this, but I can't accept paying 
> for something that I only can use at 20% by the manufacter's fault.

you can't accept that vendors sometime ship broken products?
I admire your idealism.

> For that I would like to have some tecnical details about the faults on both 
> sides, Sata controller and disk drive.

some Seagate drives cannot handle >15 sector IO through some SiI controllers.
you could have found out that much by reading the (very clear) kernel code.
that's what I did.

you also could have spent a few minutes googling:
here's an old patch (which didn't seem to survive to enter Linus's kernel):
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/3481.html
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/3534.html

and something written in Hedrick-ese that seems to say that the 
current mod15 fix is kind of harsh:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/5225.html
but maybe that's a different issue.

this implies that the problem is odd-sized packets:
http://www.thisishull.net/archive/index.php/t-23170.html
which might mean the hint about splitting makes sense.

do you really care, though?  a sata controller costs $20/channel.

