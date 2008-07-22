From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: use proper printk() KERN_* levels in ide-probe.c
Date: Tue, 22 Jul 2008 22:44:38 +0200
Message-ID: <200807222244.38752.bzolnier@gmail.com>
References: <200807212108.15505.bzolnier@gmail.com> <20080721214535.6de8c6a0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:62038 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbYGVUuY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 16:50:24 -0400
Received: by nf-out-0910.google.com with SMTP id d3so756571nfc.21
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 13:50:23 -0700 (PDT)
In-Reply-To: <20080721214535.6de8c6a0@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 21 July 2008, Alan Cox wrote:
> On Mon, 21 Jul 2008 21:08:15 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > While at it:
> > 
> > - fixup printk() messages in save_match() and hwif_init().
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-probe.c |   54 ++++++++++++++++++++++++++----------------------
> >  1 file changed, 30 insertions(+), 24 deletions(-)
> > 
> > Index: b/drivers/ide/ide-probe.c
> > ===================================================================
> > --- a/drivers/ide/ide-probe.c
> > +++ b/drivers/ide/ide-probe.c
> > @@ -141,7 +141,8 @@ static inline void do_identify (ide_driv
> >  	 */
> >  	if ((id->model[0] == 'P' && id->model[1] == 'M') ||
> >  	    (id->model[0] == 'S' && id->model[1] == 'K')) {
> > -		printk("%s: EATA SCSI HBA %.10s\n", drive->name, id->model);
> > +		printk(KERN_ERR "%s: EATA SCSI HBA %.10s\n",
> > +			drive->name, id->model);
> 
> That isn't an error. It occurs normally using legacy IDE with an EATA HBA
> present in ATA emulating mode.

Thanks for noticing, fix below.

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix for EATA SCSI HBA in ATA emulating mode

IDE probing code used to skip devices attached to EATA SCSI HBA
in ATA emulating mode but because of warm-plug support port I/O
resources are no longer freed if no devices are detected on a port
and the decision about the driver to use is left up to the user.

Remove no longer valid EATA SCSI HBA quirk from do_identify().

Noticed-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
goes before "ide: use proper printk() KERN_* levels in ide-probe.c"
patch in pata tree

 drivers/ide/ide-probe.c |   12 ------------
 1 file changed, 12 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -134,18 +134,6 @@ static inline void do_identify (ide_driv
 #endif
 	ide_fix_driveid(id);
 
-#if defined (CONFIG_SCSI_EATA_PIO) || defined (CONFIG_SCSI_EATA)
-	/*
-	 * EATA SCSI controllers do a hardware ATA emulation:
-	 * Ignore them if there is a driver for them available.
-	 */
-	if ((id->model[0] == 'P' && id->model[1] == 'M') ||
-	    (id->model[0] == 'S' && id->model[1] == 'K')) {
-		printk("%s: EATA SCSI HBA %.10s\n", drive->name, id->model);
-		goto err_misc;
-	}
-#endif /* CONFIG_SCSI_EATA || CONFIG_SCSI_EATA_PIO */
-
 	/*
 	 *  WIN_IDENTIFY returns little-endian info,
 	 *  WIN_PIDENTIFY *usually* returns little-endian info.
