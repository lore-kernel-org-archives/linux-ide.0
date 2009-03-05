From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide_timer_expiry() - shouldn't 'wait' be int?
Date: Thu, 5 Mar 2009 13:59:24 +0100
Message-ID: <200903051359.24851.bzolnier@gmail.com>
References: <49ABEAC0.40407@gmail.com> <49ABF892.1060300@gmail.com> <200903021629.13651.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:41808 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765AbZCEOtu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 09:49:50 -0500
Received: by fxm24 with SMTP id 24so3384049fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2009 06:49:46 -0800 (PST)
In-Reply-To: <200903021629.13651.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Monday 02 March 2009, Bartlomiej Zolnierkiewicz wrote:
> On Monday 02 March 2009, Roel Kluin wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > On Monday 02 March 2009, Sergei Shtylyov wrote:
> > >> Roel Kluin wrote:
> > >>
> > >>> vi drivers/ide/ide-io.c +906 and note:
> > >>> void ide_timer_expiry (unsigned long data)
> > >>> {
> > >>> 	ide_expiry_t *expiry = hwif->expiry;
> > >>> 	...
> > >>> 	unsigned long   wait = -1;
> > >>     Hm, haven't nothiced that this is *unsigned*.
> > >>
> > >>> 		...
> > >>> 		if (expiry) {
> > >>> 			...
> > >>> 			wait = expiry(drive);
> > >>> 			if (wait > 0) { /* continue */
> > >>> also note that in include/linux/ide.h:883:
> > >>> typedef int (ide_expiry_t)(ide_drive_t *);
> > >>> doesn't this mean that expiry returns int, and wait therefore should
> > >>> be int as well?
> > >>     It rather means that ide_expiry_t() should return unsigned.
> > > 
> > > Seconded.  Roel, could you also handle it?
> > > 
> > > [ However since this is 2.6.30 stuff and there has been much work in
> > >   this area recently please base in top of linux-next or pata-2.6 tree. ]
> > > 
> > >>     However, you're right as ide_dma_timeout_retry() takes *int* as a 2nd 
> > >> argument.
> > > 
> > > Though it works fine (by a luck :) we should also fix it while we're at it.
> > > 
> > > Thanks,
> > > Bart
> > 
> > I'm a little confused, do you want wait to be int, as my patch does below,
> > or do you want the typedef to be:
> > 
> > typedef unsigned long (ide_expiry_t)(ide_drive_t *);
> 
> Both. ;)
> 
> > If the latter, I think the functions that expiry points to have to be adapted as
> > well, right?
> > 
> > this is against tip-latest, feel free to modify the changelog.
> 
> Thanks!  This is exactly what I meant for 2.6.29 (one-line bugfix),
> for 2.6.30 we should also do s/int/unsigned long/ cleanup (on top of
> the current linux-next/pata-2.6 tree).
> 
> > ------------------------------>8-------------8<---------------------------------
> > expiry() returns int, negative expiry() return values won't be noticed.
> > 
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > ---
> > diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> > index cc35d6d..0715692 100644
> > --- a/drivers/ide/ide-io.c
> > +++ b/drivers/ide/ide-io.c
> > @@ -1190,7 +1190,7 @@ void ide_timer_expiry (unsigned long data)
> >  	ide_handler_t	*handler;
> >  	ide_expiry_t	*expiry;
> >  	unsigned long	flags;
> > -	unsigned long	wait = -1;
> > +	int		wait = -1;
> >  
> >  	spin_lock_irqsave(&ide_lock, flags);

I failed to notice it before but the patch was against some old kernel
(we don't have ide_lock anymore) so it won't apply to Linus' tree...

Anyway I ended up with the following version:

From: Roel Kluin <roel.kluin@gmail.com>
Subject: ide: expiry() returns int, negative expiry() return values won't be noticed

bart:
It seems like the bug could cause insanely long timeouts for:
- ATA_DMA_ERR error in dma_timer_expiry()
- commands without ->expiry in tc86c001_timer_expiry()
  (TC86C001 IDE controller only)

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
[bart: port it to the current tree]
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -908,7 +908,7 @@ void ide_timer_expiry (unsigned long dat
 	ide_drive_t	*uninitialized_var(drive);
 	ide_handler_t	*handler;
 	unsigned long	flags;
-	unsigned long	wait = -1;
+	int		wait = -1;
 	int		plug_device = 0;
 
 	spin_lock_irqsave(&hwif->lock, flags);
