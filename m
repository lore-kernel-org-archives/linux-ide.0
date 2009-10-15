From: Tejun Heo <tj@kernel.org>
Subject: Re: [Patch 1/1] sata_via.c: Remove redundant device ID for VT8261
Date: Thu, 15 Oct 2009 16:19:13 +0900
Message-ID: <4AD6CCF1.4030501@kernel.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB80A1D1498@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55018 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbZJOHUS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Oct 2009 03:20:18 -0400
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB80A1D1498@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, jeff@garzik.org

JosephChan@via.com.tw wrote:
> Just remove redundant device ID for VT8261.
>=20
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>

Looks okay to me.

> --- a/drivers/ata/sata_via.c	2009-10-15 21:38:14.000000000 +0800
> +++ b/drivers/ata/sata_via.c	2009-10-15 21:38:28.000000000 +0800
> @@ -93,7 +93,6 @@
>  	{ PCI_VDEVICE(VIA, 0x7372), vt6420 },
>  	{ PCI_VDEVICE(VIA, 0x5287), vt8251 }, /* 2 sata chnls (Master/Slave=
) */
>  	{ PCI_VDEVICE(VIA, 0x9000), vt8251 },
> -	{ PCI_VDEVICE(VIA, 0x9040), vt8251 },
> =20
>  	{ }	/* terminate list */
>  };
>=20
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
=EF=BF=BD=D7=A2=EF=BF=BD=EF=BF=BD^n=EF=BF=BDr=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
=1A=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD=EF=
=BF=BD=1E=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=03(=EF=BF=BD=E9=
=9A=8E=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD=1A=EF=BF=BD=1Bm=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=DE=96=EF=BF=BD=EF=BF=BD=EF=BF=BD=
f=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BDmml=3D=
=3D

But, what's the above garbled line?

--=20
tejun
