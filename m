From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide: another possible ide panic fix for blk-end-request
Date: Tue, 5 Feb 2008 07:01:57 +0100
Message-ID: <20080205060157.GB29807@gollum.tnic>
References: <20080204.145312.39152078.k-ueda@ct.jp.nec.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:33372 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbYBEHm3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 02:42:29 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1932220wra.23
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 23:42:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080204.145312.39152078.k-ueda@ct.jp.nec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, j-nomura@ce.jp.nec.com

On Mon, Feb 04, 2008 at 02:53:12PM -0500, Kiyoshi Ueda wrote:
> Hi Jens, Bart, Boris,
>=20
> I have reviewed all blk-end-request patches again to confirm whether
> there are any similar problems with the last week's ide-cd panic:
>     http://lkml.org/lkml/2008/1/29/140
>=20
> And I found a possible similar bug in ide-io change:
> ide_end_drive_cmd() could be called for blk_pc_request() which could
> have bios.

You mean ide_abort() and ide_error(), right? Because ide{-tape,-floppy,=
-scsi}
do call already ide_end_request() for non-special rq's
(!blk_special_request()), except ide-scsi filters also on !blk_sense_re=
quest().

> To complete such requests correctly, we need to pass
> the actual size of the request.
> Otherwise, __blk_end_request() returns 1 because the request still ha=
s
> bios, and the system will BUG() unnecessarily.
>=20
> The following patch fixes the bug and should be applied on top of
> Linus' git.
> Please review and apply.
>=20
>=20
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Cc: Borislav Petkov <petkovbb@googlemail.com>
> Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> ---
>  drivers/ide/ide-io.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> --- a/drivers/ide/ide-io.c	2008-02-01 18:20:02.000000000 -0500
> +++ b/drivers/ide/ide-io.c	2008-02-01 18:21:50.000000000 -0500
> @@ -388,7 +388,8 @@ void ide_end_drive_cmd (ide_drive_t *dri
>  	spin_lock_irqsave(&ide_lock, flags);
>  	HWGROUP(drive)->rq =3D NULL;
>  	rq->errors =3D err;
> -	if (__blk_end_request(rq, (rq->errors ? -EIO : 0), 0))
> +	if (unlikely(__blk_end_request(rq, (rq->errors ? -EIO : 0),
> +				       blk_rq_bytes(rq))))
>  		BUG();
>  	spin_unlock_irqrestore(&ide_lock, flags);
>  }
>=20
> Thanks,
> Kiyoshi Ueda

--=20
Regards/Gru=DF,
    Boris.
