From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC][PATCH] ata: sata_sil.c check sil_scr_read for failure
Date: Mon, 14 Sep 2009 18:24:44 +0900
Message-ID: <4AAE0BDC.4040403@kernel.org>
References: <1252780626.3687.20.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39110 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbZINJYv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Sep 2009 05:24:51 -0400
In-Reply-To: <1252780626.3687.20.camel@ht.satnam>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Jaswinder Singh Rajput wrote:
> [This is untested]
>=20
> By checking sil_scr_read, we can get rid of this compilation warning:
>=20
>   CC [M]  drivers/ata/sata_sil.o
> drivers/ata/sata_sil.c: In function =E2=80=98sil_host_intr=E2=80=99:
> drivers/ata/sata_sil.c:442: warning: =E2=80=98serror=E2=80=99 may be =
used uninitialized in this function
>=20
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> ---
>  drivers/ata/sata_sil.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
> index 3cb69d5..a908031 100644
> --- a/drivers/ata/sata_sil.c
> +++ b/drivers/ata/sata_sil.c
> @@ -445,7 +445,8 @@ static void sil_host_intr(struct ata_port *ap, u3=
2 bmdma2)
>  		 * controllers continue to assert IRQ as long as
>  		 * SError bits are pending.  Clear SError immediately.
>  		 */
> -		sil_scr_read(&ap->link, SCR_ERROR, &serror);
> +		if (sil_scr_read(&ap->link, SCR_ERROR, &serror))
> +			return;
>  		sil_scr_write(&ap->link, SCR_ERROR, serror);

Eh.... the driver knows the call wouldn't fail.  I think
uninitialized_var() would be more appropriate here.

Thanks.

--=20
tejun
