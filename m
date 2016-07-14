From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] ide: missing break statement in set_timings_mdma()
Date: Thu, 14 Jul 2016 06:40:02 -0500
Message-ID: <1468496402.20552.107.camel@kernel.crashing.org>
References: <20160714104802.GI18175@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20160714104802.GI18175@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, "David S. Miller" <davem@davemloft.net>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 2016-07-14 at 13:48 +0300, Dan Carpenter wrote:
> There was clearly supposed to be a break statement here.=C2=A0=C2=A0C=
urrently we
> use the k2 ata timings instead of sh ata ones we intended.=C2=A0=C2=A0=
Probably no
> one has this hardware anymore so it likely doesn't make a difference
> beyond the static checker warning.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Should probably also:

CC: stable@vger.kernel.org

> diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
> index 7f0434f..0c5d3a9 100644
> --- a/drivers/ide/pmac.c
> +++ b/drivers/ide/pmac.c
> @@ -707,6 +707,7 @@ set_timings_mdma(ide_drive_t *drive, int intf_typ=
e, u32 *timings, u32 *timings2,
> =C2=A0		*timings =3D ((*timings) & ~TR_133_PIOREG_MDMA_MASK) | tr;
> =C2=A0		*timings2 =3D (*timings2) & ~TR_133_UDMAREG_UDMA_EN;
> =C2=A0		}
> +		break;
> =C2=A0	case controller_un_ata6:
> =C2=A0	case controller_k2_ata6: {
> =C2=A0		/* 100Mhz cell */
--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
