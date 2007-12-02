From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH RFC] sata_promise: make pdc_atapi_pkt() use values from qc->tf
Date: Sun, 2 Dec 2007 18:06:16 +0100 (MET)
Message-ID: <200712021706.lB2H6GJd025895@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:51838 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756596AbXLBRG3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 12:06:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, jeff@garzik.org
Cc: linux-ide@vger.kernel.org, mikpe@it.uu.se

On Sat, 01 Dec 2007 18:23:44 -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> > Make pdc_atapi_pkt() use values from qc->tf instead of creating its
> > own.  This is to ease future ATAPI handling changes.
> > 
> > DONT APPLY YET
> > ---
> > Mikael, would this work?  Values other than lbam and lbah remain the
> > same.  Does sata_promise have strict requirements for lbam and lbah?
> > 
> > Thanks.
> > 
> >  drivers/ata/sata_promise.c |   34 +++++++++++++---------------------
> >  1 file changed, 13 insertions(+), 21 deletions(-)
> 
> what was the outcome of this discussion?
> 
> I haven't looked over the Promise datasheet nor checked my brain for 
> details, hoping Mikael would do that for me ;-)

I've now tested this on top of 2.6.24-rc3, with no observable
regressions. Blanking, writing, and mounting/reading CD-RWs
on both SATAPI and PATAPI works (tested on a 300 TX2plus card).

I can't find anything in Promise's public docs or reference driver
about non-standard requirements on lbam/lbah in ATAPI packets.

/Mikael
