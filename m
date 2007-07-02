From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/15] ide: ide_find_best_pio_mode() fixes
Date: Mon, 2 Jul 2007 20:05:01 +0200
Message-ID: <200707022005.01655.bzolnier@gmail.com>
References: <200706302104.42299.bzolnier@gmail.com> <468917D2.6010907@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:63829 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbXGBRuo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 13:50:44 -0400
Received: by nf-out-0910.google.com with SMTP id g13so61480nfb
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 10:50:43 -0700 (PDT)
In-Reply-To: <468917D2.6010907@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 02 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > * Check IORDY bit for PIO modes > 2.
> 
> > * Some devices claim maximum PIO mode > 2 in id->tPIO, they were punished too
> >   severly for this by being limited to PIO_SLOW.  Limit them to PIO2 instead.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>     NAK. :-)
> 
> > Index: b/drivers/ide/ide-timing.h
> > ===================================================================
> > --- a/drivers/ide/ide-timing.h
> > +++ b/drivers/ide/ide-timing.h
> > @@ -111,16 +111,14 @@ static short ide_find_best_pio_mode(ide_
> >  	struct hd_driveid *id = drive->id;
> >  	short best = 0;
> >  
> > -	if (id->field_valid & 2) {	/* EIDE PIO modes */
> > -
> > +	/* EIDE PIO modes */
> > +	if ((id->field_valid & 2) && (id->capability & 8)) {
> >  		if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
> >  			    (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
> >  			    (drive->id->eide_pio_modes & 1) ? XFER_PIO_3 : 0)) return best;
> >  	}
> > -	
> > -	return  (drive->id->tPIO == 2) ? XFER_PIO_2 :
> > -		(drive->id->tPIO == 1) ? XFER_PIO_1 :
> > -		(drive->id->tPIO == 0) ? XFER_PIO_0 : XFER_PIO_SLOW;
> > +
> > +	return min_t(u8, id->tPIO, 2);
> 
>     XFER_PIO_[012] != [012], and otherwise you're returning XFER_PIO_* constants.

Oh, crap, there should be "+ XFER_PIO_0" in the return line - fixed.

Thanks for spotting this bug, revised patch included.

[PATCH] ide: ide_find_best_pio_mode() fixes (take 2)

* Check IORDY bit for PIO modes > 2.

* Some devices claim maximum PIO mode > 2 in id->tPIO, they were punished too
  severly for this by being limited to PIO_SLOW.  Limit them to PIO2 instead.

v2:
* Fix PIO number being returned incorrectly instead of PIO mode
  (Noticed by Sergei).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reviewed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
 drivers/ide/ide-timing.h |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-timing.h
===================================================================
--- a/drivers/ide/ide-timing.h
+++ b/drivers/ide/ide-timing.h
@@ -111,16 +111,14 @@ static short ide_find_best_pio_mode(ide_
 	struct hd_driveid *id = drive->id;
 	short best = 0;
 
-	if (id->field_valid & 2) {	/* EIDE PIO modes */
-
+	/* EIDE PIO modes */
+	if ((id->field_valid & 2) && (id->capability & 8)) {
 		if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
 			    (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
 			    (drive->id->eide_pio_modes & 1) ? XFER_PIO_3 : 0)) return best;
 	}
-	
-	return  (drive->id->tPIO == 2) ? XFER_PIO_2 :
-		(drive->id->tPIO == 1) ? XFER_PIO_1 :
-		(drive->id->tPIO == 0) ? XFER_PIO_0 : XFER_PIO_SLOW;
+
+	return XFER_PIO_0 + min_t(u8, id->tPIO, 2);
 }
 
 static void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT)
