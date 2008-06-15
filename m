From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 02/18] ide-cd: remove ide_cd_drain_data and
	ide_cd_pad_transfer
Date: Sun, 15 Jun 2008 11:28:08 +0200
Message-ID: <20080615092808.GA7622@gollum.tnic>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com> <1213252870-20474-3-git-send-email-petkovbb@gmail.com> <200806141929.05834.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:12556 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690AbYFOJ2Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jun 2008 05:28:16 -0400
Received: by ug-out-1314.google.com with SMTP id h2so258331ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 15 Jun 2008 02:28:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200806141929.05834.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Jun 14, 2008 at 07:29:05PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
> On Thursday 12 June 2008, Borislav Petkov wrote:
> > Use the generic ide_pad_transfer() helper instead
> >=20
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
>=20
> applied w/ ide_cd_drain_data() -> ide_pad_transfer() conversion fixup
>=20
> [...]
>=20
> > @@ -1006,7 +981,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_dr=
ive_t *drive)
> >  					   - bio_cur_sectors(rq->bio),
> >  					   thislen >> 9);
> >  			if (nskip > 0) {
> > -				ide_cd_drain_data(drive, nskip);
> > +				ide_pad_transfer(drive, write, nskip);
> >  				rq->current_nr_sectors -=3D nskip;
> >  				thislen -=3D (nskip << 9);
> >  			}
>=20
> ide_cd_drain_data() took number for _sectors_ as an argument
> while ide_pad_transfer() wants to be given number of _bytes_

/me crawls ashamed back into the black place behind the wall cardboard =
=2E.. :)
>=20
> > @@ -1043,7 +1018,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_d=
rive_t *drive)
> >  				 * If the buffers are full, pipe the rest into
> >  				 * oblivion.
> >  				 */
> > -				ide_cd_drain_data(drive, thislen >> 9);
> > +				ide_pad_transfer(drive, 0, thislen >> 9);
>=20
> ditto

--=20
Regards/Gru=DF,
    Boris.
