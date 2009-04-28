From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/3] mg_disk: fix CONFIG_LBD=y warning
Date: Tue, 28 Apr 2009 11:19:34 -0400
Message-ID: <49F71E86.7040300@rtr.ca>
References: <1240890740-3462-1-git-send-email-tj@kernel.org> <1240890740-3462-3-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:37195 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758723AbZD1PTg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Apr 2009 11:19:36 -0400
In-Reply-To: <1240890740-3462-3-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, donari75@gmail.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>=20
> drivers/block/mg_disk.c: In function =E2=80=98mg_dump_status=E2=80=99=
:
> drivers/block/mg_disk.c:265: warning: format =E2=80=98%ld=E2=80=99 ex=
pects type =E2=80=98long int=E2=80=99, but
> argument 2 has type =E2=80=98sector_t=E2=80=99
>=20
> [ Impact: kill build warning ]
>=20
> Cc: unsik Kim <donari75@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/block/mg_disk.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
> index d3e72ad..f389835 100644
> --- a/drivers/block/mg_disk.c
> +++ b/drivers/block/mg_disk.c
> @@ -79,7 +79,7 @@ static void mg_dump_status(const char *msg, unsigne=
d int stat,
>  			if (host->breq) {
>  				req =3D elv_next_request(host->breq);
>  				if (req)
> -					printk(", sector=3D%ld", req->sector);
> +					printk(", sector=3D%u", (u32)req->sector);
=2E.

Eh?  Shouldn't that be fixed the other way around, like this:

  +					printk(", sector=3D%llu", (u64)req->sector);

This way, it will still give correct data when sector_t is a u64.

???
