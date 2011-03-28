From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] ata: pata_at91.c bugfix for initial_timing
 initialisation
Date: Mon, 28 Mar 2011 14:09:30 +0200
Message-ID: <1301314170.3182.15.camel@edumazet-laptop>
References: <1301313545-22730-1-git-send-email-plyatov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34565 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1C1MJf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2011 08:09:35 -0400
In-Reply-To: <1301313545-22730-1-git-send-email-plyatov@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Igor Plyatov <plyatov@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Le lundi 28 mars 2011 =C3=A0 15:59 +0400, Igor Plyatov a =C3=A9crit :
> The "struct ata_timing" must contain 10 members, but ".dmack_hold" me=
mber was
> forgotten for "initial_timing" initialisation. This patch fixes such =
a problem.
>=20
> Signed-off-by: Igor Plyatov <plyatov@gmail.com>
> ---
>  drivers/ata/pata_at91.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> index 0da0dcc..d1aaeb5 100644
> --- a/drivers/ata/pata_at91.c
> +++ b/drivers/ata/pata_at91.c
> @@ -49,8 +49,9 @@ struct at91_ide_info {
>  	void __iomem *alt_addr;
>  };
> =20
> -static const struct ata_timing initial_timing =3D
> -	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
> +static const struct ata_timing initial_timing =3D {
> +	XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0

Oh well.

	XFER_PIO_0, 70, 290, 240, 600, 165, 150, 0, 600, 0

Or even better, use C99 initializer ?


