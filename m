From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 11/11] ide-pmac: remove pmac_ide_do_setfeature() (take
	2)
Date: Fri, 27 Jul 2007 07:33:42 +1000
Message-ID: <1185485622.5495.125.camel@localhost.localdomain>
References: <200707240029.02584.bzolnier@gmail.com>
	 <1185230714.5439.150.camel@localhost.localdomain>
	 <200707262004.15566.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38079 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761595AbXGZVdk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 17:33:40 -0400
In-Reply-To: <200707262004.15566.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, 2007-07-26 at 20:04 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 24 July 2007, Benjamin Herrenschmidt wrote:
> > On Tue, 2007-07-24 at 00:29 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > Use ide_config_drive_speed() instead of pmac_ide_do_setfeature() and remove
> > > the latter, also  ide-iops.c::__ide_wait_stat() could be static again.
> > > 
> > > Since for IDE PMAC host driver IDE_CONTROL_REG is always true, device's
> > > ->quirk_list is always zero and ->ide_dma_host_{on,off} are nops than
> > > the only changes in behavior are:
> > > 
> > > * if PIO mode is set then ->dma_off_queitly is called to disable DMA
> > > 
> > > * if setting transfer mode fails ide_dump_status() is called to dump status
> > 
> > I'll test that today.
> 
> ping?

Oops, sorry, got delayed by urgent work things among others. I'll get
back to that today or next week, not sure yet.

BTW. It might make my life easier if you could email me a tarball of
your full current quilt serie :-)

Cheers,
Ben.

