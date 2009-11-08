From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] ata: Clean up hard coded array size calculation.
Date: Sun, 8 Nov 2009 17:45:53 -0200
Message-ID: <a4c8a6d00911081145p4765c795tbf873232d86f7c39@mail.gmail.com>
References: <1257708657-1232-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44622 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbZKHTpt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Nov 2009 14:45:49 -0500
In-Reply-To: <1257708657-1232-1-git-send-email-tfransosi@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: mlord@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Thiago Farina <tfransosi@gmail.com>

On Sun, Nov 8, 2009 at 5:30 PM, Thiago Farina <tfransosi@gmail.com> wro=
te:
> Use ARRAY_SIZE macro of kernel api instead.
>
> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> ---
> =C2=A0drivers/ata/sata_mv.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 6f5093b..a8a7be0 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2217,7 +2217,7 @@ static unsigned int mv_qc_issue_fis(struct ata_=
queued_cmd *qc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ata_tf_to_fis(&qc->tf, link->pmp, 1, (void=
 *)fis);
> - =C2=A0 =C2=A0 =C2=A0 err =3D mv_send_fis(ap, fis, sizeof(fis) / siz=
eof(fis[0]));
> + =C2=A0 =C2=A0 =C2=A0 err =3D mv_send_fis(ap, fis, ARRAY_SIZE(fis));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
>
> --
> 1.6.5.2.150.g1b52a
>
>
