From: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 11:33:26 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040817153326.GA31746@devserv.devel.redhat.com>
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171630.07979.bzolnier@elka.pw.edu.pl> <20040817144604.GA30778@devserv.devel.redhat.com> <200408171705.43974.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:25264 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268301AbUHQPe1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2004 11:34:27 -0400
Content-Disposition: inline
In-Reply-To: <200408171705.43974.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Tue, Aug 17, 2004 at 05:05:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > You can't unload them in 2.4.
> Really?  That would simplify a lot of considerations...

I wanted to make that work but it proved too interesting in handing the
drive back to legacy

> > We can do it the 2.4-ac way - that works with the locking I think. What
> if you are talking about abusing HDIO_SCAN_HWIF then HELL NO

No I'm talking about the 2.4-ac way - using the bus state stuff which is
currently useless.

> > might be nicer if it works out is to follow the shutdown/suspend code
> > approach so that we actually queue the "unplug" into the command stream.
> 
> and we are back to lack of sysfs integration

Not really. We don't need sysfs to queue a series of command phases and then
drop the drive.

Alan

