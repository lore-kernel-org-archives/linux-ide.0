From: "Benjamin S." <sbenni@gmx.de>
Subject: Re: ahci sometimes fails to suspend controller
Date: Fri, 7 Aug 2009 10:50:07 +0200
Message-ID: <20090807105007.693b700a@pluto-lenny.milky.way>
References: <20090719220423.54e8c75d@uranus>
	<20090803103016.4305e098@pluto-lenny.milky.way>
	<4A77DD1C.9010505@kernel.org>
	<200908041733.09707.rjw@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757176AbZHGIrA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Aug 2009 04:47:00 -0400
In-Reply-To: <200908041733.09707.rjw@suse.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@suse.com>
Cc: Tejun Heo <tj@kernel.org>, "Huang, Shane" <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org



On Tue, 4 Aug 2009 17:33:09 +0200
"Rafael J. Wysocki" <rjw@suse.com> wrote:

> On Tuesday 04 August 2009, Tejun Heo wrote:
> > 
> > Does irqpoll help?

You asked me to count how many suspends the system is able to do until 
the error happens. With 2.6.30 (without irqpoll) the system was able to 
suspend 200 times consecutively (tested with a script) without any error. 
Therefore I was not able to reproduce the error this way. After 
upgrading to 2.6.30.4 I let it suspend many times distributed over
the last three days. After about 270 suspends it happened again. I am
going to start trying it with irqpoll today. 



> I'd recomment trying 2.6.30.y (from kernel org) to see if the issue is still
> there.

The kernel I was using before your comment was 2.6.30. After it I 
have upgraded the kernel to 2.6.30.4 but the problem persists.


Regards, Benjamin
