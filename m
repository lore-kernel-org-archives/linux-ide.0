From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 06/21] ide-floppy: remove struct
	idefloppy_flexible_disk_page
Date: Sat, 12 Jan 2008 21:38:48 +0100
Message-ID: <20080112203848.GA31954@gollum.tnic>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-6-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-7-git-send-email-bbpetkov@yahoo.de> <200801120158.57895.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp110.plus.mail.re1.yahoo.com ([69.147.102.73]:45557 "HELO
	smtp110.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751463AbYALUmX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:42:23 -0500
Content-Disposition: inline
In-Reply-To: <200801120158.57895.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


[...]

> This is not an equivalent transformation:
>=20
> header->wp is 0 or 1
> pc.buffer[3] & 0x80 is 0 or 0x80
>=20
> It seems to work fine for ->wp (because it is needlessly defined as '=
int')
> but may seriously confuse set_disk_ro() and thus bdev_read_only() use=
rs.
>=20
> Should be fixed to '(pc.buffer[3] & 0x80) ? 1 : 0' (or something simi=
lar).

upps, sorry, that was silly. I changed it to:

        floppy->wp =3D !!(pc.buffer[3] & 0x80);

> >  	set_disk_ro(floppy->disk, floppy->wp);
> > -	page =3D (idefloppy_flexible_disk_page_t *) (header + 1);
> > -
> > -	page->transfer_rate =3D be16_to_cpu(page->transfer_rate);
> > -	page->sector_size =3D be16_to_cpu(page->sector_size);
> > -	page->cyls =3D be16_to_cpu(page->cyls);
> > -	page->rpm =3D be16_to_cpu(page->rpm);
> > -	capacity =3D page->cyls * page->heads * page->sectors * page->sec=
tor_size;
> > -	if (memcmp (page, &floppy->flexible_disk_page, sizeof (idefloppy_=
flexible_disk_page_t)))
> > +
> > +	transfer_rate =3D be16_to_cpu(*(u16 *)&pc.buffer[8 + 2]);
> > +	sector_size   =3D be16_to_cpu(*(u16 *)&pc.buffer[8 + 6]);
> > +	cyls          =3D be16_to_cpu(*(u16 *)&pc.buffer[8 + 8]);
> > +	rpm           =3D be16_to_cpu(*(u16 *)&pc.buffer[8 + 28]);
> > +	heads         =3D pc.buffer[8 + 4];
> > +	sectors       =3D pc.buffer[8 + 5];
> > +
> > +	capacity =3D cyls * heads * sectors * sector_size;
> > +
> > +	if ((1UL << IDEFLOPPY_MEDIA_CHANGED) & floppy->flags)
>=20
> IDEFLOPPY_MEDIA_CHANGED is set when block device is opened for the fi=
rst
> time (please check idefloppy_open() for details) so I don't think it =
is
> the right change.  'Flexible Disk Page' is only 32 bytes so we are be=
tter
> off with leaving 'u8 flexible_disk_page[32]' in idefloppy_floppy_t an=
d
> doing things the old way.
>=20
> Besides please do not intermix real changes like the above one with p=
urely
> cleanup ones like idefloppy_flexible_disk_page_t removal.  This is ba=
d from
> maintainability point of view.  If some patch causes problems it is e=
asier
> to narrow it down by heaving purely cleanup changes separated out + i=
f we
> would need to revert the real change we would have to make a separate=
 patch
> doing it instead of just reverting the guilty commit (given that we d=
on't
> want cleanup changes to be reverted as well).

How about we get rid of that chunk altogether? floppy->flexible_disk_pa=
ge is
used only here for the purpose of printk-ing to the syslog and has no "=
real"
purpose otherwise. Do we need that info spewed into the syslog at all?

--=20
Regards/Gru=DF,
    Boris.
