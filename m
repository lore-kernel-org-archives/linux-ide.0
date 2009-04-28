From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] mg_disk: fix CONFIG_LBD=y warning
Date: Tue, 28 Apr 2009 20:28:11 +0200
Message-ID: <200904282028.12047.bzolnier@gmail.com>
References: <1240890740-3462-1-git-send-email-tj@kernel.org> <200904281728.58209.bzolnier@gmail.com> <49F74672.2090407@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:37177 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbZD1SXj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Apr 2009 14:23:39 -0400
In-Reply-To: <49F74672.2090407@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <tj@kernel.org>, axboe@kernel.dk, linux-kernel@vger.kernel.org, donari75@gmail.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On Tuesday 28 April 2009 20:09:54 Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 28 April 2009 17:19:34 Mark Lord wrote:
> >> Tejun Heo wrote:
> >>> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >>>
> >>> drivers/block/mg_disk.c: In function =E2=80=98mg_dump_status=E2=80=
=99:
> >>> drivers/block/mg_disk.c:265: warning: format =E2=80=98%ld=E2=80=99=
 expects type =E2=80=98long int=E2=80=99, but
> >>> argument 2 has type =E2=80=98sector_t=E2=80=99
> >>>
> >>> [ Impact: kill build warning ]
> >>>
> >>> Cc: unsik Kim <donari75@gmail.com>
> >>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >>> Signed-off-by: Tejun Heo <tj@kernel.org>
> >>> ---
> >>>  drivers/block/mg_disk.c |    2 +-
> >>>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
> >>> index d3e72ad..f389835 100644
> >>> --- a/drivers/block/mg_disk.c
> >>> +++ b/drivers/block/mg_disk.c
> >>> @@ -79,7 +79,7 @@ static void mg_dump_status(const char *msg, uns=
igned int stat,
> >>>  			if (host->breq) {
> >>>  				req =3D elv_next_request(host->breq);
> >>>  				if (req)
> >>> -					printk(", sector=3D%ld", req->sector);
> >>> +					printk(", sector=3D%u", (u32)req->sector);
> >> ..
> >>
> >> Eh?  Shouldn't that be fixed the other way around, like this:
> >>
> >>   +					printk(", sector=3D%llu", (u64)req->sector);
> >>
> >> This way, it will still give correct data when sector_t is a u64.
> >=20
> > shouldn't matter, req->sector is never > u32 for mg_disk
>=20
> It never matters... until the code gets copied elsewhere.  IMO wrong=20
> code should never be kept -- "impossible to hit" just means it is low=
=20
> priority :)

Well, if you feel strongly about it feel free to replace my patch with
your improved version.  You may also fix hd.c (from which the above cod=
e
has been copied) while at it.
