From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [patch][2/3] ide: add ide_hwif_t->dma_exec_cmd()
Date: Mon, 13 Sep 2004 15:31:37 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040913223137.GB95391@sgi.com>
References: <200409130133.55663.bzolnier@elka.pw.edu.pl> <20040913213552.GA95513@sgi.com> <200409140011.22047.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.20]:2462 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269024AbUIMWb5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Sep 2004 18:31:57 -0400
Content-Disposition: inline
In-Reply-To: <200409140011.22047.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mikael Starvik <mikael.starvik@axis.com>, Erik Jacobson <erikj@subway.americas.sgi.com>

On Tue, Sep 14, 2004 at 12:11:21AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday 13 September 2004 23:35, Jeremy Higdon wrote:
> > > Some real bugs are also fixed:
> > > - in Etrax ide.c driver REQ_DRIVE_TASKFILE requests weren't
> > >   handled properly for drive->addressing == 0
> > > - in trm290.c read and write commands were interchanged
> > > - in sgiioc4.c commands weren't sent to disk devices
> 
> DMA commands, PIO ones were sent out
> 
> > Sgiioc4 only is used with multimedia devices.  I don't think disks will
> > work with it, even if you do send commands.
> 
> It is hard to believe but if this is true it should be documented somewhere.
> 
> Anyway my changes don't make it worse. :-)

Okay.  I just wanted to be sure you knew.  It would be a challenge
just to connect a disk to it, so it probably doesn't matter too much.
Even if you did and it worked, Multimode 2 DMA speeds would not be
too exciting . . . .   :-)
