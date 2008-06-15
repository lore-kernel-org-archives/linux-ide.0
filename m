From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 00/18] misc generic ide stuff
Date: Sun, 15 Jun 2008 12:27:13 +0200
Message-ID: <20080615102713.GC7622@gollum.tnic>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com> <200806141929.00459.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:46027 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997AbYFOK1T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jun 2008 06:27:19 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2825526fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 15 Jun 2008 03:27:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200806141929.00459.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Jun 14, 2008 at 07:29:00PM +0200, Bartlomiej Zolnierkiewicz wro=
te:

Hi,

>=20
> Hi,
>=20
> On Thursday 12 June 2008, Borislav Petkov wrote:
> > Hi Bart,
> >=20
> > here are some generic ide conversion patches. The first 12 are what=
 i thought
> > you suggested :) concerning prepping the ide-cd code for the generi=
c layer. The
> > remaining 6 are what i've done so far wrt removing ide_atapi_pc fro=
m the ide
> > drivers. It is obvious that this is not trivial and I basically tip=
toe around the
>=20
> Thanks.
>=20
> I applied patches #1-2, #5-12 and #14-15.
>=20
> I skipped patches #3-4, #13 and #16-18 for now
> (more details in replies to corresponding mails).
>=20
> > landmines in the IRQ handler and request issue paths :). This raise=
s also
> > several questions:
> >=20
> > 1. ide-cd uses the cdrom_info struct for e.g. dma status notificati=
on, the other
> > ide drivers use it per packet command in pc->flags. Well the last a=
re kinda too
> > much to carry for _each_ command and i'm thinking maybe put all tha=
t in the
> > ide_drive_t and make it generic enough to fit all drivers. This way
> > pc->callback() can also be harboured there. One concern might be wh=
en a flag is
> > strictly per packet command which could be put somewhere else (mayb=
e in the
> > struct request since it already has members when it is used as a pa=
cket
> > command).
>=20
> Some pc->flags describe device's properties and thus should be moved =
to
> ide_drive_t (->dev_flags) while some other correspond to the queued c=
ommand
> and moving them to ide_drive_t would be a bad idea IMO.

With "the last" i meant pc->flags and not "per packet" so i completely =
agree:
per-packet commands go somewhere in rq and the others land in ide_drive=
_t.

> For ATA commands I was planning to put taskfile flags into rq->specia=
l field
> (well, I actually implemented it in draft patch and it looks OK) so m=
aybe we
> can do something similar for packet commands.

Yep, i was looking for a field to put all those per-command flags into =
so
rq->special sounds good. Will prepare some patches for that later.

> > 2. Can all that pc->xferred, pc->b_count, pc->errors and pc->cur_po=
s accounting
> > be safely mapped to a rq? I see some discrepancies like is pc->buf_=
size =3D=3D
> > rq->data_len, what about pc->req_xfer? I'll have a more detailed lo=
ok at those
> > when i have more spare time later.
>=20
> If you ask if they can be mapped 'directly' then the answer is: "prob=
ably no"
> but if the question is whether it is possible to do it after some cha=
nges then
> the answer is: "probably yes". :)
>=20
> [ However it may be necessary to convert ATAPI drivers to use scatter=
lists
>   instead of open-coded ->bio walking for PIO transfers first. ]

Looking into it right now...

Thanks.

--=20
Regards/Gru=DF,
    Boris.
