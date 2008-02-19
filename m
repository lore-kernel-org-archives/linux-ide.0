From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: Optiarc DVD RW AD-5200A audio playing
Date: Tue, 19 Feb 2008 06:52:33 +0100
Message-ID: <20080219055233.GA4901@gollum.tnic>
References: <47B5EDB7.5050709@canonical.com> <20080216164302.GP13446@gollum.tnic> <47B99384.2080900@canonical.com> <200802190018.48850.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:4121 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYBSFwp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 00:52:45 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1747873fga.17
        for <linux-ide@vger.kernel.org>; Mon, 18 Feb 2008 21:52:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802190018.48850.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stefan Bader <stefan.bader@canonical.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Tue, Feb 19, 2008 at 12:18:48AM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Monday 18 February 2008, Stefan Bader wrote:
> > Borislav Petkov wrote:
> > > On Sat, Feb 16, 2008 at 04:24:01PM +0100, Bartlomiej Zolnierkiewi=
cz wrote:
> > >> Hi,
> > >>
> > >> On Saturday 16 February 2008, Borislav Petkov wrote:
> > >>> On Fri, Feb 15, 2008 at 02:53:27PM -0500, Stefan Bader wrote:
> > >>>> Hello Borislav,
> > >>>>
> > >>>> I worked on a problem with an DVD driver (model=3DOptiarc DVD =
RW AD-5200A)
> > >>>> which obviously has the same problem as some Matshita drives. =
The
> > >>>> following patch was reported to enabled audio playing on this =
drive.
> > >>>> Would this approach be suitable for upstream or are there othe=
r
> > >>>> solutions to this problem?
> > >>>>
> > >>>> Regards,
> > >>>> Stefan
> > >>>>
> > >>>> --- a/drivers/ide/ide-cd.c
> > >>>> +++ b/drivers/ide/ide-cd.c
> > >>>> @@ -2988,7 +2988,8 @@ int ide_cdrom_probe_capabilities (ide_dr=
ive_t *drive)
> > >>>>  	if (strcmp(drive->id->model, "MATSHITADVD-ROM SR-8187") =3D=3D=
 0 ||
> > >>>>  	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8186") =3D=3D=
 0 ||
> > >>>>  	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8176") =3D=3D=
 0 ||
> > >>>> -	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8174") =3D=3D=
 0)
> > >>>> +	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8174") =3D=3D=
 0 ||
> > >>>> +	    strcmp(drive->id->model, "Optiarc DVD RW AD-5200A") =3D=3D=
 0)
> > >>>>  		CDROM_CONFIG_FLAGS(drive)->audio_play =3D 1;
> > >>>>
> > >>>>  #if ! STANDARD_ATAPI
> > >>> Hi Stefan,
> > >>>
> > >>> just to make sure that the audioplay bit is not set in the capa=
bilities page,
> > >>> can you please try the following patch applied against 2.6.25-r=
c2 and send me
> > >>> the output. Thanks!
> > >>>
> > >>> @Bart: by the way, this cdi->mask thingy is kinda unintuitive d=
oing double
> > >>> negation to check whether a feature is supported or not. Yeah, =
this comes from
> > >>> "above," i.e. uniform cdrom layer. But still, shouldn't we use =
a cdi->caps_flags
> > >>> or something similar instead, which mirrors the caps page bits =
setting?
> > >> It seems so (at least having negative flags is very unintuitive)=
 but they
> > >> might be some reason for this ugliness, Jens?
> > >>
> > >> [ Please also remember that since cdrom layer is _uniform_ it ma=
y be not
> > >>   possible and/or desirable to have 1-1 mapping between caps pag=
e bits
> > >>   and the future cdi->caps_flags. ]
> > >>
> > >>> commit 435f0f4496a1b32af2d542f43b2370a890fe2f83
> > >>> Author: Borislav Petkov <petkovbb@gmail.com>
> > >>> Date:   Sat Feb 16 09:56:36 2008 +0100
> > >>>
> > >>>     ide-cd: Enable audio play quirk for Optiarc DVD RW AD-5200A=
 drive
> > >>>    =20
> > >>>     Reported-by: Stefan Bader <stefan.bader@canonical.com>
> > >>>     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > >>>
> > >>> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > >>> index f77db6b..2c9d06e 100644
> > >>> --- a/drivers/ide/ide-cd.c
> > >>> +++ b/drivers/ide/ide-cd.c
> > >>> @@ -1750,6 +1750,10 @@ int ide_cdrom_probe_capabilities (ide_dr=
ive_t *drive)
> > >>>  		cdi->mask &=3D ~(CDC_DVD_RAM | CDC_RAM);
> > >>>  	if (buf[8 + 3] & 0x10)
> > >>>  		cdi->mask &=3D ~CDC_DVD_R;
> > >>> +	if (!(buf[8 + 4] & 0x01)) {
> > >> Hmm, shouldn't there be '&& (cd->cd_flags & IDE_CD_FLAG_PLAY_AUD=
IO_OK)'
> > >> to prevent false positives?
> > >=20
> > > I wanted to see whether the caps page reports the audioplay bit o=
ff...
> > >=20
> > >>> +		printk(KERN_INFO "ide-cd: audio play not advertised in caps =
page,"
> > >> Would be nice to also printk() the device name.
> > >=20
> > > ... but printing the device model is actually a good idea and thi=
s will rule out
> > > false positives, so Stefan, please drop the previous patch and te=
st the updated
> > > one below. Thanks.
> > >=20
> > >=20
> >=20
> > Hi Borislav,
> >=20
> > the problem is that I don't own this drive myself and the owner is
> > running a 2.6.22 kernel and is normally not doing any kernel compil=
es.
> > But I could provide him a modified patch.
> > Though, if you just want to know whether the cap bit was really uns=
et, I
> > think we know this already. When I got the problem report we checke=
d
> > /proc/sys/dev/cdrom/info and that showed the "Can play audio" bit a=
s 0.
> > Which is the reason I gave the owner the patch for adding the model=
 to
> > the excemption list. And from his feedback I take that the drive pl=
ays
> > audio tracks with the patch in use.
>=20
> Borislav, I guess that this is good enough proof that audioplay bit i=
s off.

indeed.

> Could you please send me the final version of the patch?

commit fa4af2fab0804bead4da6ecbf468118f05111229
Author: Borislav Petkov <petkovbb@gmail.com>
Date:   Sat Feb 16 09:56:36 2008 +0100

    ide-cd: Enable audio play quirk for Optiarc DVD RW AD-5200A drive
   =20
    Reported-by: Stefan Bader <stefan.bader@canonical.com>
    Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index f77db6b..9e63c34 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1929,6 +1929,7 @@ static const struct cd_list_entry ide_cd_quirks_l=
ist[] =3D {
 	{ "MATSHITADVD-ROM SR-8186", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
 	{ "MATSHITADVD-ROM SR-8176", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
 	{ "MATSHITADVD-ROM SR-8174", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
+	{ "Optiarc DVD RW AD-5200A", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK      }=
,
 	{ NULL, NULL, 0 }
 };
=20

--=20
Regards/Gru=DF,
    Boris.
