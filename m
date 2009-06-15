From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ata: add ata_id_pio_need_iordy() helper
Date: Mon, 15 Jun 2009 18:32:02 +0200
Message-ID: <200906151832.03501.bzolnier@gmail.com>
References: <200906131821.07018.bzolnier@gmail.com> <4A3410D6.9060400@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:11862 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762977AbZFOQt2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jun 2009 12:49:28 -0400
Received: by ey-out-2122.google.com with SMTP id 25so354793eya.37
        for <linux-ide@vger.kernel.org>; Mon, 15 Jun 2009 09:49:29 -0700 (PDT)
In-Reply-To: <4A3410D6.9060400@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Saturday 13 June 2009 22:49:26 Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Cc: Jeff Garzik <jgarzik@pobox.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> > against Linus' tree
> >
> >  include/linux/ata.h |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > Index: b/include/linux/ata.h
> > ===================================================================
> > --- a/include/linux/ata.h
> > +++ b/include/linux/ata.h
> > @@ -800,6 +800,17 @@ static inline int ata_id_is_ssd(const u1
> >  	return id[ATA_ID_ROT_SPEED] == 0x01;
> >  }
> >  
> > +static inline int ata_id_pio_need_iordy(const u16 *id, const u8 pio)
> > +{
> > +	/* CF spec. r4.1 Table 22 says no IORDY on PIO5 and PIO6.  */
> > +	if (ata_id_is_cfa(id) && pio > 4)
> >   
> 
>    It actually makes sense to put the cheap 'pio' check first. We 
> shouldn't call ata_id_is_cfa() for all modes.

It is a micro-optimization but why not... revised version follows.

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ata: add ata_id_pio_need_iordy() helper (v2)

v2:
Minor fixes per Sergei's review.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
against Linus' tree

 include/linux/ata.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: b/include/linux/ata.h
===================================================================
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -800,6 +800,20 @@ static inline int ata_id_is_ssd(const u1
 	return id[ATA_ID_ROT_SPEED] == 0x01;
 }
 
+static inline int ata_id_pio_need_iordy(const u16 *id, const u8 pio)
+{
+	/* CF spec. r4.1 Table 22 says no IORDY on PIO5 and PIO6. */
+	if (pio > 4 && ata_id_is_cfa(id))
+		return 0;
+	/* For PIO3 and higher it is mandatory. */
+	if (pio > 2)
+		return 1;
+	/* Turn it on when possible. */
+	if (ata_id_has_iordy(id))
+		return 1;
+	return 0;
+}
+
 static inline int ata_drive_40wire(const u16 *dev_id)
 {
 	if (ata_id_is_sata(dev_id))
