From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: dma problems with via82cxxx after suspend
Date: Fri, 18 Mar 2005 17:27:30 +0100
Message-ID: <58cb370e05031808273d396562@mail.gmail.com>
References: <1110822850.11750.0.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1130_27294916.1111163250398"
Received: from wproxy.gmail.com ([64.233.184.205]:27787 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261690AbVCRQ1b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2005 11:27:31 -0500
Received: by wproxy.gmail.com with SMTP id 69so141251wri
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2005 08:27:30 -0800 (PST)
In-Reply-To: <1110822850.11750.0.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Meier <droebbel.melta@gmx.de>
Cc: linux-ide@vger.kernel.org

------=_Part_1130_27294916.1111163250398
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 14 Mar 2005 18:54:10 +0100, David Meier <droebbel.melta@gmx.de> wrote:
> I get DMA errors after resuming from suspend (S3).
> 
> I had switched DMA off before suspending.

...

This should be fixed in ide-dev-2.6 tree and in -mm series.
Alternatively you can try attached patch.

Bartlomiej

------=_Part_1130_27294916.1111163250398
Content-Type: text/x-patch; name="via.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="via.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/03 21:47:18+01:00 bzolnier@trik.(none)=20
#   [ide] fix via82cxxx resume failure
#  =20
#   With David Woodhouse <dwmw2@infradead.org>.
#  =20
#   On resume from sleep, via_set_speed() doesn't reinstate the correct
#   mode, because it thinks the drive is already configured correctly.
#  =20
#   Also kill redundant printk, ide_config_drive_speed() warns about errors=
.
#=20
# drivers/ide/pci/via82cxxx.c
#   2005/02/03 21:47:05+01:00 bzolnier@trik.(none) +2 -5
#   [ide] fix via82cxxx resume failure
#=20
diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c=092005-03-18 17:26:38 +01:00
+++ b/drivers/ide/pci/via82cxxx.c=092005-03-18 17:26:38 +01:00
@@ -332,11 +332,8 @@
 =09struct ide_timing t, p;
 =09unsigned int T, UT;
=20
-=09if (speed !=3D XFER_PIO_SLOW && speed !=3D drive->current_speed)
-=09=09if (ide_config_drive_speed(drive, speed))
-=09=09=09printk(KERN_WARNING "ide%d: Drive %d didn't "
-=09=09=09=09"accept speed setting. Oh, well.\n",
-=09=09=09=09drive->dn >> 1, drive->dn & 1);
+=09if (speed !=3D XFER_PIO_SLOW)
+=09=09ide_config_drive_speed(drive, speed);
=20
 =09T =3D 1000000000 / via_clock;
=20

------=_Part_1130_27294916.1111163250398--
