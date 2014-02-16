From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [REGRESSION] 3.14-rc2 boot failure on Kirkwood (qnap ts-119p+)
Date: Sun, 16 Feb 2014 11:45:20 -0300
Message-ID: <20140216143735.GA8680@localhost>
References: <21248.39509.418884.931848@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34823 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752280AbaBPOpZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Feb 2014 09:45:25 -0500
Content-Disposition: inline
In-Reply-To: <21248.39509.418884.931848@gargle.gargle.HOWL>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org

Hi Mikael,

On Sun, Feb 16, 2014 at 12:00:37PM +0100, Mikael Pettersson wrote:
> My Kirkwood box worked fine with the 3.13 kernel, but with 3.14-rc2
> boot always fails due to a kernel NULL dereference in __clk_put.
>=20
> This is a non-DT kernel, with:
>=20
> CONFIG_ARCH_KIRKWOOD=3Dy
> CONFIG_KIRKWOOD_LEGACY=3Dy
> CONFIG_MACH_TS219=3Dy
> # CONFIG_ARCH_KIRKWOOD_DT is not set
>=20

Thanks for the report. I thought this issue was already fixed, but I
cannot find it on either the mailing lists or linux-next.

So, in case it hasn't been fixed here's an untested fix for you to test=
=2E
Please try this patch and let us know.

Your SATA won't work but if the patch is OK the kernel wont't blow away=
=2E

Andrew? Do we support the new phy requirement in non-DT platforms?

=46rom 5d4010ba3c485e7e22887408663fb260f628b9b2 Mon Sep 17 00:00:00 200=
1
=46rom: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date: Sun, 16 Feb 2014 11:21:50 -0300
Subject: [PATCH] ata: sata_mv: Cleanup only the initialized ports

When an error occurs in the port initialization loop, currently the
driver tries to cleanup all the ports. This results in a NULL pointer
dereference if the ports were only partially initialized.

=46ix this by updating only the number of initialized ports (either
with failure or successfully), before jumping to the error path
and looping over that number in the cleanup loop.

Cc: Andrew Lunn <andrew@lunn.ch>
Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/ata/sata_mv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 20a7517..9c1a11d 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4104,7 +4104,6 @@ static int mv_platform_probe(struct platform_devi=
ce *pdev)
 	if (!hpriv->port_phys)
 		return -ENOMEM;
 	host->private_data =3D hpriv;
-	hpriv->n_ports =3D n_ports;
 	hpriv->board_idx =3D chip_soc;
=20
 	host->iomap =3D NULL;
@@ -4132,11 +4131,17 @@ static int mv_platform_probe(struct platform_de=
vice *pdev)
 			hpriv->port_phys[port] =3D NULL;
 			if ((rc !=3D -EPROBE_DEFER) && (rc !=3D -ENODEV))
 				dev_warn(&pdev->dev, "error getting phy");
+
+			/* Cleanup only the initialized ports */
+			hpriv->n_ports =3D port;
 			goto err;
 		} else
 			phy_power_on(hpriv->port_phys[port]);
 	}
=20
+	/* All the ports have been initialized */
+	hpriv->n_ports =3D n_ports;
+
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
@@ -4174,7 +4179,7 @@ err:
 		clk_disable_unprepare(hpriv->clk);
 		clk_put(hpriv->clk);
 	}
-	for (port =3D 0; port < n_ports; port++) {
+	for (port =3D 0; port < hpriv->n_ports; port++) {
 		if (!IS_ERR(hpriv->port_clks[port])) {
 			clk_disable_unprepare(hpriv->port_clks[port]);
 			clk_put(hpriv->port_clks[port]);
--=20
1.8.1.5


--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
