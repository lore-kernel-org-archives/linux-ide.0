From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Sun, 3 Jun 2007 19:24:46 +0200
Message-ID: <200706031924.46238.bzolnier@gmail.com>
References: <46598350.6030403@gmail.com> <4662E5B3.4020205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:2110 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbXFCRLJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jun 2007 13:11:09 -0400
Received: by ug-out-1314.google.com with SMTP id j3so565570ugf
        for <linux-ide@vger.kernel.org>; Sun, 03 Jun 2007 10:11:08 -0700 (PDT)
In-Reply-To: <4662E5B3.4020205@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>


Hi,

On Sunday 03 June 2007, Jeff Garzik wrote:
> Tejun Heo wrote:
> > Several people have reported LITE-ON LTR-48246S detection failed
> > because SETXFER fails.  It seems the device raises IRQ too early after
> > SETXFER.  This is controller independent.  The same problem has been
> > reported for different controllers.
> > 
> > So, now we have pata_via where the controller raises IRQ before it's
> > ready after SETXFER and a device which does similar thing.  This patch
> > makes libata always execute SETXFER via polling.  As this only happens
> > during EH, performance impact is nil.  Setting ATA_TFLAG_POLLING is
> > also moved from issue hot path to ata_dev_set_xfermode() - the only
> > place where SETXFER can be issued.
> > 
> > Note that ATA_TFLAG_POLLING applies only to drivers which implement
> > SFF TF interface and use libata HSM.  More advanced controllers ignore
> > the flag.  This doesn't matter for this fix as SFF TF controllers are
> > the problematic ones.
> > 
> > Signed-off-by: Tejun Heo <htejun@gmail.com>
> > ---
> >  drivers/ata/libata-core.c |   13 ++++---------
> >  drivers/ata/pata_via.c    |   12 ++++++------
> >  include/linux/libata.h    |    1 -
> >  3 files changed, 10 insertions(+), 16 deletions(-)
> 
> To Linus and Andrew:
> 
> After discussion and a minor revision (mostly to the description), I am 
> OK with this patch.
> 
> At this point, I am only reluctant to push it for 2.6.22 since it is so 
> late in the -rc series.
> 
> If we have another -rc, I would probably be OK with pushing it for 
> 2.6.22, otherwise I would prefer to wait for 2.6.23.
> 
> Comments solicited, from all involved...

I have a feeling that we are needlessly wasting time on this.

The patch should be safe (drivers/ide has been doing SETXFER this way for
ages) and fixes real user problems (which becomes even more important now as
distros are converting to libata PATA).

So.. can we get this almost 3 months old patch merged finally?

http://thread.gmane.org/gmane.linux.ide/17096/focus=17116

Thanks,
Bart
