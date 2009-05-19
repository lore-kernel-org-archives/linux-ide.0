From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATA DMA problem leading to kernel panic on reading movie DVDs
Date: Tue, 19 May 2009 23:31:59 +0200
Message-ID: <200905192332.00707.bzolnier@gmail.com>
References: <20090517091224.GA8280@wanza.invalid> <200905192131.00168.bzolnier@gmail.com> <20090519211221.GA6977@wanza.invalid>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:51814 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbZESVbc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 17:31:32 -0400
In-Reply-To: <20090519211221.GA6977@wanza.invalid>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Lottermoser <Martin.Lottermoser@t-online.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 19 May 2009 23:12:21 Martin Lottermoser wrote:
> Hi,
> 
> On Tue, May 19, 2009 at 09:30:59PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Incremental patch fixing it:
> > 
> > diff -u b/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> > --- b/drivers/ide/ide-iops.c
> > +++ b/drivers/ide/ide-iops.c
> > @@ -255,7 +255,7 @@
> >  	if (ivb) {
> >  		const char *model = (char *)&id[ATA_ID_PROD];
> >  
> > -		if (strcmp("TSSTcorp CDDVDW SH-S202", model) == 0) {
> > +		if (strstr("TSSTcorp CDDVDW SH-S202", model)) {
> >  			/*
> >  			 * These ATAPI devices always report 80c cable
> >  			 * so we have to depend on the host in this case.
> > 
> 
> I applied that, recompiled, installed, rebooted, and checked the syslog.
> The message was still
> 
>   hdc: UDMA/66 mode selected
> 
> and hdparm also showed "udma4" as being selected. I therefore didn't test
> with a DVD.
> 
> However, after twice reading the POSIX definition of strstr() I reversed
> the order of the arguments to
> 
>                 if (strstr(model, "TSSTcorp CDDVDW SH-S202")) {

/me hides

> and that did it. Syslog now contained:
> 
>   hdc: host side 80-wire cable detection failed, limiting max speed to UDMA33
>   hdc: UDMA/33 mode selected
> 
> hdparm showed "udma2", and playing movie DVDs worked without DMA being
> disabled. :-)

:)

The final patch version:

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix 40-wire cable detection for TSST SH-S202* ATAPI devices (v2)

Since 2.6.26 we support UDMA66 on ATAPI devices requiring IVB quirk:

  commit 8588a2b732928b343233af9b1855705b8286bed4
  ("ide: add SH-S202J to ivb_list[]")

We also later added support for more such devices in:

  commit e97564f362a93f8c248246c19828895950341252
  ("ide: More TSST drives with broken cable detection")

and in:

  commit 3ced5c49bd2d1f2c7f769e3a54385883de63a652
  ("ide: add TSSTcorp CDDVDW SH-S202H to ivb_list[]")

It turns out that such devices lack cable detection altogether
(which in turn results in incorrect detection of 40-wire cables
by our current cable detection strategy) so always handle them
by trusting host-side cable detection only.

v2:
Model detection fixup from Martin.

Reported-and-tested-by: Martin Lottermoser <Martin.Lottermoser@t-online.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -206,8 +206,6 @@ EXPORT_SYMBOL_GPL(ide_in_drive_list);
 
 /*
  * Early UDMA66 devices don't set bit14 to 1, only bit13 is valid.
- * We list them here and depend on the device side cable detection for them.
- *
  * Some optical devices with the buggy firmwares have the same problem.
  */
 static const struct drive_list_entry ivb_list[] = {
@@ -251,10 +249,25 @@ u8 eighty_ninty_three(ide_drive_t *drive
 	 * - force bit13 (80c cable present) check also for !ivb devices
 	 *   (unless the slave device is pre-ATA3)
 	 */
-	if ((id[ATA_ID_HW_CONFIG] & 0x4000) ||
-	    (ivb && (id[ATA_ID_HW_CONFIG] & 0x2000)))
+	if (id[ATA_ID_HW_CONFIG] & 0x4000)
 		return 1;
 
+	if (ivb) {
+		const char *model = (char *)&id[ATA_ID_PROD];
+
+		if (strstr(model, "TSSTcorp CDDVDW SH-S202")) {
+			/*
+			 * These ATAPI devices always report 80c cable
+			 * so we have to depend on the host in this case.
+			 */
+			if (hwif->cbl == ATA_CBL_PATA80)
+				return 1;
+		} else {
+			/* Depend on the device side cable detection. */
+			if (id[ATA_ID_HW_CONFIG] & 0x2000)
+				return 1;
+		}
+	}
 no_80w:
 	if (drive->dev_flags & IDE_DFLAG_UDMA33_WARNED)
 		return 0;
