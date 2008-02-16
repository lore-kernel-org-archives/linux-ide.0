From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: Optiarc DVD RW AD-5200A audio playing
Date: Sat, 16 Feb 2008 19:41:08 +0100
Message-ID: <20080216184108.GT13446@gollum.tnic>
References: <47B5EDB7.5050709@canonical.com> <200802161848.24475.bzolnier@gmail.com> <20080216180406.GR13446@gollum.tnic> <200802161923.58313.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:8178 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402AbYBPSlX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 13:41:23 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1155023fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 10:41:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802161923.58313.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stefan Bader <stefan.bader@canonical.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Sat, Feb 16, 2008 at 07:23:58PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Saturday 16 February 2008, Borislav Petkov wrote:
> > On Sat, Feb 16, 2008 at 06:48:24PM +0100, Bartlomiej Zolnierkiewicz=
 wrote:
> > > On Saturday 16 February 2008, Borislav Petkov wrote:
> > > > On Sat, Feb 16, 2008 at 04:24:01PM +0100, Bartlomiej Zolnierkie=
wicz wrote:
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > On Saturday 16 February 2008, Borislav Petkov wrote:
> > > > > > On Fri, Feb 15, 2008 at 02:53:27PM -0500, Stefan Bader wrot=
e:
> > > > > > > Hello Borislav,
> > > > > > >=20
> > > > > > > I worked on a problem with an DVD driver (model=3DOptiarc=
 DVD RW AD-5200A)
> > > > > > > which obviously has the same problem as some Matshita dri=
ves. The
> > > > > > > following patch was reported to enabled audio playing on =
this drive.
> > > > > > > Would this approach be suitable for upstream or are there=
 other
> > > > > > > solutions to this problem?
> > > > > > >=20
> > > > > > > Regards,
> > > > > > > Stefan
> > > > > > >=20
> > > > > > > --- a/drivers/ide/ide-cd.c
> > > > > > > +++ b/drivers/ide/ide-cd.c
> > > > > > > @@ -2988,7 +2988,8 @@ int ide_cdrom_probe_capabilities (i=
de_drive_t *drive)
> > > > > > >  	if (strcmp(drive->id->model, "MATSHITADVD-ROM SR-8187")=
 =3D=3D 0 ||
> > > > > > >  	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8186")=
 =3D=3D 0 ||
> > > > > > >  	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8176")=
 =3D=3D 0 ||
> > > > > > > -	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8174")=
 =3D=3D 0)
> > > > > > > +	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8174")=
 =3D=3D 0 ||
> > > > > > > +	    strcmp(drive->id->model, "Optiarc DVD RW AD-5200A")=
 =3D=3D 0)
> > > > > > >  		CDROM_CONFIG_FLAGS(drive)->audio_play =3D 1;
> > > > > > >=20
> > > > > > >  #if ! STANDARD_ATAPI
> > > > > >=20
> > > > > > Hi Stefan,
> > > > > >=20
> > > > > > just to make sure that the audioplay bit is not set in the =
capabilities page,
> > > > > > can you please try the following patch applied against 2.6.=
25-rc2 and send me
> > > > > > the output. Thanks!
> > > > > >=20
> > > > > > @Bart: by the way, this cdi->mask thingy is kinda unintuiti=
ve doing double
> > > > > > negation to check whether a feature is supported or not. Ye=
ah, this comes from
> > > > > > "above," i.e. uniform cdrom layer. But still, shouldn't we =
use a cdi->caps_flags
> > > > > > or something similar instead, which mirrors the caps page b=
its setting?
> > > > >=20
> > > > > It seems so (at least having negative flags is very unintuiti=
ve) but they
> > > > > might be some reason for this ugliness, Jens?
> > > > >=20
> > > > > [ Please also remember that since cdrom layer is _uniform_ it=
 may be not
> > > > >   possible and/or desirable to have 1-1 mapping between caps =
page bits
> > > > >   and the future cdi->caps_flags. ]
> > > > >=20
> > > > > > commit 435f0f4496a1b32af2d542f43b2370a890fe2f83
> > > > > > Author: Borislav Petkov <petkovbb@gmail.com>
> > > > > > Date:   Sat Feb 16 09:56:36 2008 +0100
> > > > > >=20
> > > > > >     ide-cd: Enable audio play quirk for Optiarc DVD RW AD-5=
200A drive
> > > > > >    =20
> > > > > >     Reported-by: Stefan Bader <stefan.bader@canonical.com>
> > > > > >     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > > > > >=20
> > > > > > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > > > > > index f77db6b..2c9d06e 100644
> > > > > > --- a/drivers/ide/ide-cd.c
> > > > > > +++ b/drivers/ide/ide-cd.c
> > > > > > @@ -1750,6 +1750,10 @@ int ide_cdrom_probe_capabilities (id=
e_drive_t *drive)
> > > > > >  		cdi->mask &=3D ~(CDC_DVD_RAM | CDC_RAM);
> > > > > >  	if (buf[8 + 3] & 0x10)
> > > > > >  		cdi->mask &=3D ~CDC_DVD_R;
> > > > > > +	if (!(buf[8 + 4] & 0x01)) {
> > > > >=20
> > > > > Hmm, shouldn't there be '&& (cd->cd_flags & IDE_CD_FLAG_PLAY_=
AUDIO_OK)'
> > > > > to prevent false positives?
> > > >=20
> > > > I wanted to see whether the caps page reports the audioplay bit=
 off...
> > >=20
> > > we still need IDE_CD_FLAG_PLAY_AUDIO_OK flag to be _set_ to enabl=
e the quirk
> > >=20
> > > > >=20
> > > > > > +		printk(KERN_INFO "ide-cd: audio play not advertised in c=
aps page,"
> > > > >=20
> > > > > Would be nice to also printk() the device name.
> > > >=20
> > > > ... but printing the device model is actually a good idea and t=
his will rule out
> > > > false positives, so Stefan, please drop the previous patch and =
test the updated
> > > > one below. Thanks.
> > > >=20
> > > >=20
> > > > commit 6cc44b0ce5c9270b15d456eb9ffa91b855e4e0d0
> > > > Author: Borislav Petkov <petkovbb@gmail.com>
> > > > Date:   Sat Feb 16 09:56:36 2008 +0100
> > > >=20
> > > >     ide-cd: Enable audio play quirk for Optiarc DVD RW AD-5200A=
 drive
> > > >    =20
> > > >     Reported-by: Stefan Bader <stefan.bader@canonical.com>
> > > >     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > > >=20
> > > > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > > > index f77db6b..4c9984f 100644
> > > > --- a/drivers/ide/ide-cd.c
> > > > +++ b/drivers/ide/ide-cd.c
> > > > @@ -1750,6 +1750,11 @@ int ide_cdrom_probe_capabilities (ide_dr=
ive_t *drive)
> > > >  		cdi->mask &=3D ~(CDC_DVD_RAM | CDC_RAM);
> > > >  	if (buf[8 + 3] & 0x10)
> > > >  		cdi->mask &=3D ~CDC_DVD_R;
> > > > +	if (!(buf[8 + 4] & 0x01)) {
> > > > +		printk(KERN_INFO "ide-cd: audio play not advertised in caps =
"
> > > > +				"page for drive model [%s], enabling quirk.\n",
> > > > +				drive->id->model);
> > >=20
> > > if IDE_CD_FLAG_PLAY_AUDIO_OK flag is not set the above message is=
 _bogus_
> > > (because the quirk won't be enabled)
> > >=20
> > > [ how's about just deleting the whole printk() to preserve simpli=
city? ]
> > >=20
> > > > +	}
> > > >  	if ((buf[8 + 4] & 0x01) || (cd->cd_flags & IDE_CD_FLAG_PLAY_A=
UDIO_OK))
> > > >  		cdi->mask &=3D ~CDC_PLAY_AUDIO;
> > > > =20
> > > > @@ -1929,6 +1934,7 @@ static const struct cd_list_entry ide_cd_=
quirks_list[] =3D {
> > > >  	{ "MATSHITADVD-ROM SR-8186", NULL,   IDE_CD_FLAG_PLAY_AUDIO_O=
K	    },
> > > >  	{ "MATSHITADVD-ROM SR-8176", NULL,   IDE_CD_FLAG_PLAY_AUDIO_O=
K	    },
> > > >  	{ "MATSHITADVD-ROM SR-8174", NULL,   IDE_CD_FLAG_PLAY_AUDIO_O=
K	    },
> > > > +	{ "Optiarc DVD RW AD-5200A", NULL,   IDE_CD_FLAG_PLAY_AUDIO_O=
K      },
> >=20
> > But the flag _is_ set because the drive is added to the quirk list =
(line above	^) and
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> (fortunately) majority of ATAPI drives are not in the quirk list ;-)
>=20
> [ and they may have (buf[8 + 4] & 0x01) =3D=3D 0 ]

Bart,

i think i probably didn't express myself clear enough before. The patch
serves the sole purpose to show exactly whether buf[8 + 4] & 0x01) =3D=3D=
 0 and
is in no way the final solution. I just wanted to make sure the caps pa=
ge
doesn't set the audioplay bit. The final solution would be to add the d=
rive
to the quirks list only, i guess, in case you don't have a better idea.

Sorry for the misunderstanding :=3D).

>=20
> > ide_cdrom_setup() calls ide_cd_flags() to set the proper flags for =
cd->cd_flags and later on
> > ide_cdrom_probe_capabilities() works on the same cd->cd_flags for t=
esting
> > IDE_CD_FLAG_PLAY_AUDIO_OK, or have i gone blind completely...?
> >=20
> > > >  	{ NULL, NULL, 0 }
> > > >  };

--=20
Regards/Gru=DF,
    Boris.
