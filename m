From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/4] ide: generic packet command representation
Date: Tue, 12 Feb 2008 06:59:19 +0100
Message-ID: <20080212055919.GD2879@gollum.tnic>
References: <1202718880-1793-1-git-send-email-petkovbb@gmail.com> <200802120109.24152.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:54940 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbYBLGAO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 01:00:14 -0500
Received: by fg-out-1718.google.com with SMTP id e21so4009501fga.17
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 22:00:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802120109.24152.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Feb 12, 2008 at 01:09:24AM +0100, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> On Monday 11 February 2008, Borislav Petkov wrote:
> > Hi Bart,
> >=20
> > here's the ide_atapi_pc unification series. It all went pretty smoo=
thly along
> > the search & replace line. Using driver-specific members in ide_ata=
pi_pc like
> > idefloppy_callback and idetape_callback is kinda dumb but this appr=
oach seemed
> > the fastest versus unnecessary callback function signature change t=
hat will
> > touch stuff all over the place. Besides, ide-tape might be gone soo=
n so that
> > would alleviate the problem.
>=20
> applied all four patches, thanks!
>=20
> > On a different note, i noticed ide-scsi might also need a cleanup s=
imilar to the
> > other drivers. It is next on my TODO list in case you don't have an=
ything with a
> > higher prio.
>=20
> I was actually hoping that you'll continue unifying ATAPI handling...

yeah, sure. ide-scsi simply will wander down the prio stack pushed by t=
he other
stuff :)

> [ ide-scsi is orphaned and has (probably) unfixable problems (because=
 of having

does this mean it might have a similar to idetape's destiny...?

--=20
Regards/Gru=DF,
    Boris.
