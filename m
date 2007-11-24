From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce pata node, make use pata_of_platform driver
Date: Sat, 24 Nov 2007 21:57:46 +0100
Message-ID: <200711242157.47303.arnd@arndb.de>
References: <20071123175229.GA27143@localhost.localdomain> <20071123175356.GC27338@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:64324 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbXKXU6J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Nov 2007 15:58:09 -0500
In-Reply-To: <20071123175356.GC27338@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linux-ide@vger.kernel.org

On Friday 23 November 2007, Anton Vorontsov wrote:
>=20
> +static struct of_device_id mpc834x_ids[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{ .compatible =3D "pata-platform", },
> +=A0=A0=A0=A0=A0=A0=A0{},
> +};
> +
> +static int __init mpc834x_declare_of_platform_devices(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0if (!machine_is(mpc834x_itx))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> +
> +=A0=A0=A0=A0=A0=A0=A0of_platform_bus_probe(NULL, mpc834x_ids, NULL);
> +
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}
> +device_initcall(mpc834x_declare_of_platform_devices);

This is not really how of_platform_bus_probe was meant to be used.
Instead of listing the device you want to probe, you should list
all buses that potentially contain a device that you are probing.

Normally, an ata controller is not a top-level device but instead
the child of an SOC bus device, and then you just probe all
SOC devices, which means their children get added to the device
tree.

In your case, that would probably mean that you have to another
entry in the "ranges" of the soc8349 node, or add a second socXXXX
node that has the 0xf0000000 ranges, depending on the actual layout
of the SOC.

	Arnd <><
