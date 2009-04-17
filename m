From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE
	detection
Date: Fri, 17 Apr 2009 12:23:13 +0200
Message-ID: <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
	 <1239960802-31978-3-git-send-email-tj@kernel.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f164.google.com ([209.85.220.164]:49248 "EHLO
	mail-fx0-f164.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759021AbZDQKXP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2009 06:23:15 -0400
Received: by fxm8 with SMTP id 8so479467fxm.13
        for <linux-ide@vger.kernel.org>; Fri, 17 Apr 2009 03:23:14 -0700 (PDT)
In-Reply-To: <1239960802-31978-3-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi,

On Fri, Apr 17, 2009 at 11:33 AM, Tejun Heo <tj@kernel.org> wrote:
> Impact: fix an oops which always triggers
>
> ide_tape_issue_pc() assumed drive->pc isn't NULL on invocation when
> checking for back-to-back request sense issues but drive->pc can be
> NULL and even when it's not NULL, it's not safe to dereference it onc=
e
> the previous command is complete because pc could have been freed or
> was on stack. =A0Kill back-to-back REQUEST_SENSE detection.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> =A0drivers/ide/ide-tape.c | =A0 =A06 ------
> =A01 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index cb942a9..3a53e08 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -614,12 +614,6 @@ static ide_startstop_t ide_tape_issue_pc(ide_dri=
ve_t *drive,
> =A0{
> =A0 =A0 =A0 =A0idetape_tape_t *tape =3D drive->driver_data;
>
> - =A0 =A0 =A0 if (drive->pc->c[0] =3D=3D REQUEST_SENSE &&
> - =A0 =A0 =A0 =A0 =A0 pc->c[0] =3D=3D REQUEST_SENSE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "ide-tape: possible ide=
-tape.c bug - "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Two request sense in s=
erial were issued\n");
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0if (drive->failed_pc =3D=3D NULL && pc->c[0] !=3D REQU=
EST_SENSE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0drive->failed_pc =3D pc;
>

I hit that too when debugging an ide-tape problem a user has
(http://bugzilla.kernel.org/show_bug.cgi?id=3D12874). However, this is =
not the
proper solution since, currently, ide-tape stuffs all packet commands i=
n
rq->buffer or rq->special now after your changes. It has to get them ou=
t of
there in the ->do_request callback and set drive->pc to point to the cu=
rrent
packet command in flight through the IRQ handler. And since ide_tape_is=
sue_pc()
is called by the ->do_request callback we should have the drive->pc alw=
ays
valid.

How about something like that instead:

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 4e6181c..171dbcd 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -792,6 +792,9 @@ static ide_startstop_t
idetape_do_request(ide_drive_t *drive,
 	struct request *postponed_rq =3D tape->postponed_rq;
 	u8 stat;

+	if (rq->cmd_type =3D=3D REQ_TYPE_SPECIAL)
+		drive->pc =3D (struct ide_atapi_pc *) rq->buffer;
+
 	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %lu,"
 			" current_nr_sectors: %u\n",
 			(unsigned long long)rq->sector, rq->nr_sectors,


--=20
Regards/Gruss,
Boris
