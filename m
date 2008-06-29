From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] drivers/ide/ide-tape.c: remove double kfree
Date: Sun, 29 Jun 2008 18:26:44 +0200
Message-ID: <20080629162644.GA10023@gollum.tnic>
References: <1214692474.8254.22.camel@localhost.localdomain>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.225]:13259 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbYF2Q0i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 12:26:38 -0400
Received: by hu-out-0506.google.com with SMTP id 28so2700727hub.21
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 09:26:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1214692474.8254.22.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Jenkins <darrenrjenkins@gmail.com>, bzolnier@gmail.com
Cc: kernel Janitors <kernel-janitors@lists.osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, gadio@netvision.net.il

Hi Bart,

in case you haven't picked that one up already...

On Sun, Jun 29, 2008 at 08:34:34AM +1000, Darren Jenkins" wrote:
> G'day people,
>=20
>=20
> Coverity CID: 2336 USE_AFTER_FREE
>=20
> drivers/ide/ide-tape.c ide_tape_kfree_buffer() double free's a pointe=
r
> (hint freed by an alias in first outer loop).
> This patch simply removes the superfluous kfree().
>=20
>=20
>=20
> Signed-off-by: Darren Jenkins <darrenrjenkins@gmailcom>
Acked-by: Borislav Petkov <petkovbb@gmail.com>
>=20
>=20
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 1e1f263..86164be 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -600,7 +600,6 @@ static void ide_tape_kfree_buffer(idetape_tape_t =
*tape)
>  		bh =3D bh->b_reqnext;
>  		kfree(prev_bh);
>  	}
> -	kfree(tape->merge_bh);
>  }
> =20
>  static int idetape_end_request(ide_drive_t *drive, int uptodate, int=
 nr_sects)
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Regards/Gru=DF,
    Boris.
