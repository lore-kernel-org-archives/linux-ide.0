From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] pata_artop: fix "& (1 >>" typo
Date: Fri, 10 Nov 2006 11:25:35 -0500
Message-ID: <20061110162535.GA7338@devserv.devel.redhat.com>
References: <20061110195246.GC5872@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:2215 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946765AbWKJQZj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Nov 2006 11:25:39 -0500
Content-Disposition: inline
In-Reply-To: <20061110195246.GC5872@localhost.sw.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, devel@openvz.org

On Fri, Nov 10, 2006 at 10:52:46PM +0300, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>

Acked-by: Alan Cox <alan@redhat.com>

> ---
>=20
>  drivers/ata/pata_artop.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -92,7 +92,7 @@ static int artop6260_pre_reset(struct at
>  		return -ENOENT;
> =20
>  	pci_read_config_byte(pdev, 0x49, &tmp);
> -	if (tmp & (1 >> ap->port_no))
> +	if (tmp & (1 << ap->port_no))
>  		ap->cbl =3D ATA_CBL_PATA40;
>  	else
>  		ap->cbl =3D ATA_CBL_PATA80;

--=20
    "People who choose variable names like htlbpagek SHOULD be sent to
             produce a street map of R'Lyeh.=A0 On site."
			-- Al Viro
