From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] mg_disk: fix CONFIG_LBD=y warning
Date: Tue, 28 Apr 2009 17:28:57 +0200
Message-ID: <200904281728.58209.bzolnier@gmail.com>
References: <1240890740-3462-1-git-send-email-tj@kernel.org> <1240890740-3462-3-git-send-email-tj@kernel.org> <49F71E86.7040300@rtr.ca>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762323AbZD1R0Z@vger.kernel.org>
In-Reply-To: <49F71E86.7040300@rtr.ca>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, axboe@kernel.dk, linux-kernel@vger.kernel.org, donari75@gmail.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-Id: linux-ide@vger.kernel.org

On Tuesday 28 April 2009 17:19:34 Mark Lord wrote:
> Tejun Heo wrote:
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >=20
> > drivers/block/mg_disk.c: In function =E2=80=98mg_dump_status=E2=80=99=
:
> > drivers/block/mg_disk.c:265: warning: format =E2=80=98%ld=E2=80=99 =
expects type =E2=80=98long int=E2=80=99, but
> > argument 2 has type =E2=80=98sector_t=E2=80=99
> >=20
> > [ Impact: kill build warning ]
> >=20
> > Cc: unsik Kim <donari75@gmail.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  drivers/block/mg_disk.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
> > index d3e72ad..f389835 100644
> > --- a/drivers/block/mg_disk.c
> > +++ b/drivers/block/mg_disk.c
> > @@ -79,7 +79,7 @@ static void mg_dump_status(const char *msg, unsig=
ned int stat,
> >  			if (host->breq) {
> >  				req =3D elv_next_request(host->breq);
> >  				if (req)
> > -					printk(", sector=3D%ld", req->sector);
> > +					printk(", sector=3D%u", (u32)req->sector);
> ..
>=20
> Eh?  Shouldn't that be fixed the other way around, like this:
>=20
>   +					printk(", sector=3D%llu", (u64)req->sector);
>=20
> This way, it will still give correct data when sector_t is a u64.

shouldn't matter, req->sector is never > u32 for mg_disk
