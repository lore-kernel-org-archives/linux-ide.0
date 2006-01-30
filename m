From: Jens Axboe <axboe@suse.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Mon, 30 Jan 2006 16:08:43 +0100
Message-ID: <20060130150843.GS4209@suse.de>
References: <5840.192.54.193.25.1138269692.squirrel@rousalka.dyndns.org> <1138309495.3968.3.camel@rousalka.dyndns.org> <20060127081319.GU4311@suse.de> <65391.192.54.193.25.1138351983.squirrel@rousalka.dyndns.org> <20060127091002.GX4311@suse.de> <20060127092046.GY4311@suse.de> <58cb370e0601270146n40a5b249v53a736a8021c82f4@mail.gmail.com> <20060127095039.GA4311@suse.de> <1138390636.3017.2.camel@rousalka.dyndns.org> <1138406042.2953.0.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:41328 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932304AbWA3PKU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Jan 2006 10:10:20 -0500
Content-Disposition: inline
In-Reply-To: <1138406042.2953.0.camel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On Sat, Jan 28 2006, Nicolas Mailhot wrote:
> Le vendredi 27 janvier 2006 =E0 20:37 +0100, Nicolas Mailhot a =E9cri=
t :
> > Le vendredi 27 janvier 2006 =E0 10:50 +0100, Jens Axboe a =E9crit :
> >=20
> > > Of course, silly typo! Thanks for catching that. Update patch bel=
ow.
> > =20
> > ...
> >=20
> > a patched kernel reboots before finishing to initialize (Just befor=
e it
> > prints a line starting with SCSI - the rest is too fast for me to c=
atch)
> >=20
> > Now the kernel base is slightly different from yesterday, so the bu=
g may
> > be in the base not the patch. I'll rebuild a new kernel with the sa=
me
> > base and yesterday's patch to check this now
>=20
> I can confirm today's patch is not OK. The same baseline with
> yesterday's patch boot fine.

Is this any better?

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index cfbceb5..07b1e7c 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1700,6 +1700,31 @@ static unsigned int ata_msense_rw_recove
 	return sizeof(def_rw_recovery_mpage);
 }
=20
+/*
+ * We can turn this into a real blacklist if it's needed, for now just
+ * blacklist any Maxtor BANC1G10 revision firmware
+ */
+static int ata_dev_supports_fua(u16 *id)
+{
+	unsigned char model[41], fw[9];
+
+	if (!ata_id_has_fua(id))
+		return 0;
+
+	model[40] =3D '\0';
+	fw[8] =3D '\0';
+
+	ata_dev_id_string(id, model, ATA_ID_PROD_OFS, sizeof(model) - 1);
+	ata_dev_id_string(id, fw, ATA_ID_FW_REV_OFS, sizeof(fw) - 1);
+
+	if (strncmp(model, "Maxtor", 6))
+		return 1;
+	if (strncmp(fw, "BANC1G10", 8))
+		return 1;
+
+	return 0; /* blacklisted */
+}
+
 /**
  *	ata_scsiop_mode_sense - Simulate MODE SENSE 6, 10 commands
  *	@args: device IDENTIFY data / SCSI command of interest.
@@ -1797,7 +1822,7 @@ unsigned int ata_scsiop_mode_sense(struc
 		return 0;
=20
 	dpofua =3D 0;
-	if (ata_id_has_fua(args->id) && dev->flags & ATA_DFLAG_LBA48 &&
+	if (ata_dev_supports_fua(args->id) && dev->flags & ATA_DFLAG_LBA48 &&
 	    (!(dev->flags & ATA_DFLAG_PIO) || dev->multi_count))
 		dpofua =3D 1 << 4;
=20


--=20
Jens Axboe

