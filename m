From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/13] ide: add IDE_HFLAG_ERROR_STOPS_FIFO host flag
Date: Sat, 8 Sep 2007 16:17:55 +0100
Message-ID: <20070908161755.10902b54@the-village.bc.nu>
References: <200709052352.57848.bzolnier@gmail.com>
	<20070906081356.GA20007@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56681 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752857AbXIHPJq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 11:09:46 -0400
In-Reply-To: <20070906081356.GA20007@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Thu, 6 Sep 2007 04:13:56 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> On Wed, Sep 05, 2007 at 11:52:57PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Add IDE_HFLAG_ERROR_STOPS_FIFO host flag and use it instead
> > of hwif->err_stops_fifo.  As a side-effect this change fixes
> > hwif->err_stops_fifo not being restored by ide_hwif_restore().
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-io.c           |    3 ++-
> >  drivers/ide/pci/pdc202xx_new.c |    3 +--
> >  drivers/ide/pci/pdc202xx_old.c |    8 ++++----
> >  include/linux/ide.h            |    3 ++-
> >  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> Hum, I wonder if libata needs something like this.

You'd have to add the drain data on error hack first, right now we will
reset in that case (which for one or two devices has another problem in
that it won't clear a stuck FIFO)

Alan
