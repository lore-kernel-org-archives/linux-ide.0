From: Jens Axboe <axboe@suse.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Fri, 27 Jan 2006 10:50:40 +0100
Message-ID: <20060127095039.GA4311@suse.de>
References: <43D8637F.5030207@gmail.com> <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org> <20060126092120.GP4212@suse.de> <5840.192.54.193.25.1138269692.squirrel@rousalka.dyndns.org> <1138309495.3968.3.camel@rousalka.dyndns.org> <20060127081319.GU4311@suse.de> <65391.192.54.193.25.1138351983.squirrel@rousalka.dyndns.org> <20060127091002.GX4311@suse.de> <20060127092046.GY4311@suse.de> <58cb370e0601270146n40a5b249v53a736a8021c82f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:46099 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932450AbWA0Jvj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jan 2006 04:51:39 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e0601270146n40a5b249v53a736a8021c82f4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On Fri, Jan 27 2006, Bartlomiej Zolnierkiewicz wrote:
> On 1/27/06, Jens Axboe <axboe@suse.de> wrote:
> > On Fri, Jan 27 2006, Jens Axboe wrote:
> > > On Fri, Jan 27 2006, Nicolas Mailhot wrote:
> > > >
> > > > Le Ven 27 janvier 2006 09:13, Jens Axboe a =E9crit :
> > > > > On Thu, Jan 26 2006, Nicolas Mailhot wrote:
> > > > >> Le jeudi 26 janvier 2006 =E0 11:01 +0100, Nicolas Mailhot a =
=E9crit :
> > > > >> > Le Jeu 26 janvier 2006 10:21, Jens Axboe a =E9crit :
> > > > >> > > On Thu, Jan 26 2006, Nicolas Mailhot wrote:
> > > > >> >
> > > > >> > >> What parts can be done one a pre-breakage kernel and wh=
at parts on
> > > > >> a
> > > > >> > >> problem kernel (I ask this because a problem kernel wil=
l corrupt
> > > > >> > >> basically
> > > > >> > >> any file it writes to, even in single login mode the da=
mage is
> > > > >> > >> significant
> > > > >> > >> so I need to limit the corruption window to minimum).
> > > > >> > >
> > > > >> > > You need a new kernel (after the barrier rework), so 2.6=
=2E16-rc1 for
> > > > >> > > instance.
> > > > >> >
> > > > >> > Ok, I'll do the test this evening (CET) with the rawhide/d=
avej
> > > > >> kernel-of
> > > > >> > the day.
> > > > >>
> > > > >> I applied the fua backout patch and the kernel booted beauti=
fully.
> > > > >> Now I guess I need to see if Maxtor released a fixed firmwar=
e right ?
> > > > >> (is it possible to change the firmware on a running system ?=
)
> > > > >
> > > > > If you can get an update firmware, it is usually done by boot=
ing from
> > > > > DOS floppy and running a special flash utility from there. Ca=
n you send
> > > > > me the hdparm -I /dev/sdX output of the problem drive? I thin=
k we should
> > > > > just blacklist it for FUA. This bug is so obscure I think it'=
s a better
> > > > > solution than adding a FUA disable module parameter at this p=
oint.
> > > >
> > > > There is already fairly complete smart info available in
> > > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D177951
> > > > (https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=3D12360=
4
> > > > https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=3D123605=
)
> > >
> > > I didn't notice the smart info, yes that holds enough information=
=2E
> > > Thanks!
> >
> > Can you try and boot a kernel with this patch applied (needs to be =
one
> > of the newer ones, of course) and see if you still see the "w/ FUA"
> > string next to your Maxtor drive(s)?
> >
> > diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.=
c
> > index cfbceb5..3feda07 100644
> > --- a/drivers/scsi/libata-scsi.c
> > +++ b/drivers/scsi/libata-scsi.c
> > @@ -1700,6 +1700,28 @@ static unsigned int ata_msense_rw_recove
> >         return sizeof(def_rw_recovery_mpage);
> >  }
> >
> > +/*
> > + * We can turn this into a real blacklist if it's needed, for now =
just
> > + * blacklist any Maxtor BANC1G10 revision firmware
> > + */
> > +static int ata_dev_supports_fua(u16 *id)
> > +{
> > +       unsigned char model[41], fw[9];
> > +
> > +       if (!ata_id_has_fua(id))
> > +               return 0;
> > +
> > +       ata_dev_id_string(id, model, ATA_ID_PROD_OFS, sizeof(model)=
);
> > +       ata_dev_id_string(id, fw, ATA_ID_FW_REV_OFS, sizeof(fw));
> > +
> > +       if (strncmp(model, "Maxtor", 6))
> > +               return 1;
> > +       if (strncmp(model, "BANC1G10", 8))
> > +               return 1;
>=20
> s/model/fw/

Of course, silly typo! Thanks for catching that. Update patch below.

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index cfbceb5..3feda07 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1700,6 +1700,28 @@ static unsigned int ata_msense_rw_recove
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
+	ata_dev_id_string(id, model, ATA_ID_PROD_OFS, sizeof(model));
+	ata_dev_id_string(id, fw, ATA_ID_FW_REV_OFS, sizeof(fw));
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
@@ -1797,7 +1819,7 @@ unsigned int ata_scsiop_mode_sense(struc
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

