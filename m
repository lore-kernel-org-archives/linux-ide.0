From: Mikael Pettersson <mikpelinux@gmail.com>
Subject: Re: [REGRESSION] 3.14-rc2 boot failure on Kirkwood (qnap ts-119p+)
Date: Sun, 16 Feb 2014 16:10:02 +0100
Message-ID: <21248.54474.414445.790516@gargle.gargle.HOWL>
References: <21248.39509.418884.931848@gargle.gargle.HOWL>
	<20140216143735.GA8680@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:55593 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbaBPPKH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Feb 2014 10:10:07 -0500
Received: by mail-la0-f43.google.com with SMTP id pv20so10500740lab.16
        for <linux-ide@vger.kernel.org>; Sun, 16 Feb 2014 07:10:05 -0800 (PST)
In-Reply-To: <20140216143735.GA8680@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Mikael Pettersson <mikpelinux@gmail.com>, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org

Ezequiel Garcia writes:
 > Hi Mikael,
 >=20
 > On Sun, Feb 16, 2014 at 12:00:37PM +0100, Mikael Pettersson wrote:
 > > My Kirkwood box worked fine with the 3.13 kernel, but with 3.14-rc=
2
 > > boot always fails due to a kernel NULL dereference in __clk_put.
 > >=20
 > > This is a non-DT kernel, with:
 > >=20
 > > CONFIG_ARCH_KIRKWOOD=3Dy
 > > CONFIG_KIRKWOOD_LEGACY=3Dy
 > > CONFIG_MACH_TS219=3Dy
 > > # CONFIG_ARCH_KIRKWOOD_DT is not set
 > >=20
 >=20
 > Thanks for the report. I thought this issue was already fixed, but I
 > cannot find it on either the mailing lists or linux-next.
 >=20
 > So, in case it hasn't been fixed here's an untested fix for you to t=
est.
 > Please try this patch and let us know.
 >=20
 > Your SATA won't work but if the patch is OK the kernel wont't blow a=
way.

Thanks, this fixes the oops but does leave sata_mv non-functional,
which is still a major regression from 3.13.

sata_mv sata_mv.0: cannot get optional clkdev
sata_mv sata_mv.0: error getting phy
sata_mv: probe of sata_mv.0 failed with error -38
=2E..
VFS: Cannot open root device "sda1" or unknown-block(0,0): error -6
Please append a correct "root=3D" boot option; here are the available p=
artitions:
1f00             512 mtdblock0  (driver?)
1f01            2048 mtdblock1  (driver?)
1f02            9216 mtdblock2  (driver?)
1f03            3072 mtdblock3  (driver?)
1f04             256 mtdblock4  (driver?)
1f05            1280 mtdblock5  (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-blo=
ck(0,0)

/Mikael

 > Andrew? Do we support the new phy requirement in non-DT platforms?
 >=20
 > >From 5d4010ba3c485e7e22887408663fb260f628b9b2 Mon Sep 17 00:00:00 2=
001
 > From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
 > Date: Sun, 16 Feb 2014 11:21:50 -0300
 > Subject: [PATCH] ata: sata_mv: Cleanup only the initialized ports
 >=20
 > When an error occurs in the port initialization loop, currently the
 > driver tries to cleanup all the ports. This results in a NULL pointe=
r
 > dereference if the ports were only partially initialized.
 >=20
 > Fix this by updating only the number of initialized ports (either
 > with failure or successfully), before jumping to the error path
 > and looping over that number in the cleanup loop.
 >=20
 > Cc: Andrew Lunn <andrew@lunn.ch>
 > Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
 > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
 > ---
 >  drivers/ata/sata_mv.c | 9 +++++++--
 >  1 file changed, 7 insertions(+), 2 deletions(-)
 >=20
 > diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
 > index 20a7517..9c1a11d 100644
 > --- a/drivers/ata/sata_mv.c
 > +++ b/drivers/ata/sata_mv.c
 > @@ -4104,7 +4104,6 @@ static int mv_platform_probe(struct platform_d=
evice *pdev)
 >  	if (!hpriv->port_phys)
 >  		return -ENOMEM;
 >  	host->private_data =3D hpriv;
 > -	hpriv->n_ports =3D n_ports;
 >  	hpriv->board_idx =3D chip_soc;
 > =20
 >  	host->iomap =3D NULL;
 > @@ -4132,11 +4131,17 @@ static int mv_platform_probe(struct platform=
_device *pdev)
 >  			hpriv->port_phys[port] =3D NULL;
 >  			if ((rc !=3D -EPROBE_DEFER) && (rc !=3D -ENODEV))
 >  				dev_warn(&pdev->dev, "error getting phy");
 > +
 > +			/* Cleanup only the initialized ports */
 > +			hpriv->n_ports =3D port;
 >  			goto err;
 >  		} else
 >  			phy_power_on(hpriv->port_phys[port]);
 >  	}
 > =20
 > +	/* All the ports have been initialized */
 > +	hpriv->n_ports =3D n_ports;
 > +
 >  	/*
 >  	 * (Re-)program MBUS remapping windows if we are asked to.
 >  	 */
 > @@ -4174,7 +4179,7 @@ err:
 >  		clk_disable_unprepare(hpriv->clk);
 >  		clk_put(hpriv->clk);
 >  	}
 > -	for (port =3D 0; port < n_ports; port++) {
 > +	for (port =3D 0; port < hpriv->n_ports; port++) {
 >  		if (!IS_ERR(hpriv->port_clks[port])) {
 >  			clk_disable_unprepare(hpriv->port_clks[port]);
 >  			clk_put(hpriv->port_clks[port]);
 > --=20
 > 1.8.1.5
 >=20
 >=20
 > --=20
 > Ezequiel Garc=EDa, Free Electrons
 > Embedded Linux, Kernel and Android Engineering
 > http://free-electrons.com

--=20
