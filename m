From: Alan Cox <alan@redhat.com>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
Date: Mon, 17 May 2004 12:49:47 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040517164947.GC15849@devserv.devel.redhat.com>
References: <200405132116.44201.bzolnier@elka.pw.edu.pl> <40A4B482.3040706@keyaccess.nl> <20040516195811.GH20505@devserv.devel.redhat.com> <200405162220.23971.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:31123 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261551AbUEQQuN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2004 12:50:13 -0400
Content-Disposition: inline
In-Reply-To: <200405162220.23971.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>, Jens Axboe <axboe@suse.de>

On Sun, May 16, 2004 at 10:20:23PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > Have again attached a 'rollup' patch against vanilla 2.6.6, including
> > > this, Andrew's SYSTEM_SHUTDOWN split and the quick "don't switch of
> > > spindle if rebooting" hack. Again, just in case anyone finds it useful.
> >
> > This reintroduces corruption on my thinkpad 600.
> 
> [ this corruption was fixed by kernel 2.6.6 ]
> 
> Please see if reverting changes to ide_device_shutdown() helps.

Something odd going on. I need to look further into this. I'm not sure
now its specifically this patch

