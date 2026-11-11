Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416598;
	b=pL8vVbjHEWdeupmvu20HH9F5QeGuJg/Ud9Lan10HrnvuL3P4fBUAEKNo36ML14anaOq4
	 I9XY7bZVmP8ab37OizsJtn3T7WWXW18gSjEp3aaG3rJgAfSjtgb/gnHK/+FoSjiQTvtNL
	 wJENUxzz263+0X6tAc/OalS2CymXLDda7A2QOIr8BbCG7PjNtR3OUjcIVcG2T+8Gua/+j
	 uztqGSZWIKtWwIumAQ9ULaVFQsWJuQpchWkOtqjseYCay8FCdkQoxzb92Lm0nUhvXwlvH
	 XXuH3Xpgk/2qEHioVacxIAzIxAoeiZKuiu5aG9J3H2GR+Cf5J0w/V208IcanMdpcmhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wxpngDtFwloG1/2zX5m8zdGdfK4MWKJaRlU75TSUFfU=;
	b=1TEcoqVbjehy4fqwj2RJk/TIFe+4HJhE8ZJRmR/WZxauSptrDjGUrgvvsVzvZEyHeRt+
	 jv6KNMfs2MrGfDPopfYueZIrQk5/cKUP9zjrBAyOnunhK4c/lEFLeSfu4sx/6lVX5TLkA
	 5ezvYO01yfzoOJd3HnYKHM5d5GRJ3IAaskYtU08PstDD9850PN9nU+kCwKgSbXNmRfSBT
	 LKrWkfYhehjYR9gR0/Q+5BjNRZ8UaOWoJ4XJrSPsXmhbPSF7ZpVYjvQuivcLq6jfDQZJt
	 +nG/VsraNOjVHgESUBzlkZiML4nBnDK9+D1AnCydcCepPj95fnE0LPCWJ2Dv+EzmzFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHXD58o2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A0606A31C;
	Wed, 11 Nov 2026 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHXD58o2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5411F00A05;
	Wed, 11 Nov 2026 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416598;
	bh=wxpngDtFwloG1/2zX5m8zdGdfK4MWKJaRlU75TSUFfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HHXD58o2qvuTrs5W/O/UNCs6giVeocABZph7jh6J42f+0dej1v6+k3FynyDcAcYPo
	 NNgZ9LZt5N0KCuepapGrMpaI9T+JxJ0tGAuq+ZoKjT41CnwhCxiPmxxOnZbBf39xw2
	 aEwHQPoDQ2U9jVXWP5SC+fr6zxzWLI92X8TyNYfaR5d/7ECx6VCp7J5/2XxvPiTeyb
	 CqfCmTAYziy+KNC8rT/LfzrcTK5eDIt155p1V+U7jdZ7xrvXbF6tWR7YfmTbRJXfv4
	 MkHJeC/H6fVFNmQPJPPfwZv+gGqHwMh8w9WrUb+22dSC8zknc7Zfw1waYAe5GTPXST
	 L16DlJRKchZYg==
Message-ID: <sashiko-outbox-209365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/7] zorro: warp mfd: add the CS-Lab Warp
 multifunction parent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: linux-ide@vger.kernel.org, mfd@lists.linux.dev, dlemoal@kernel.org, cassel@kernel.org, lee@kernel.org
In-Reply-To: <20261111163735.227286-2-p.pisati@gmail.com>
References: <20261111163735.227286-1-p.pisati@gmail.com>
 <20261111163735.227286-2-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:03:17 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Low] mfd: warp_mfd_probe() places new MFD core driver in
  drivers/zorro/
- [Low] mfd: warp_mfd_driver hard-codes mfd in names and uses wrong
  subject prefix
- [Low] mfd: warp_mfd_cells registers only a single child cell and
  Kconfig mismatches code
- [Low] mfd: warp_mfd_probe() passes z->dev.id instead of
  PLATFORM_DEVID_AUTO
--

commit 9af1a8469b32d3686430ab985b8dd9f3f752e76e
Author: Paolo Pisati <p.pisati@gmail.com>

zorro: warp mfd: add the CS-Lab Warp multifunction parent

This commit adds a Zorro parent driver for the CS-Lab Warp 1260 board that
registers the on-board IDE window as an mfd cell for pata_cswarp.

> diff --git a/drivers/zorro/Kconfig b/drivers/zorro/Kconfig
> index 41475ad46e45f..c9ab9fb4b9ee7 100644
> --- a/drivers/zorro/Kconfig
> +++ b/drivers/zorro/Kconfig
> @@ -17,3 +17,33 @@ config ZORRO_NAMES
> =20
>  	  When in doubt, say Y.
> =20
> +# Zorro multifunction drivers
> +
> +config WARP_MFD
> +	tristate "CS-Lab Warp multifunction driver"
> +	depends on ZORRO
> +	select MFD_CORE
[ ... ]
> +	  This driver hands the IDE window to pata_cswarp - which needs
> +	  idemode=3Dnative set in Warp Configuration to be of any use - and
> +	  exposes the configuration and telemetry reachable over the dual-port
> +	  RAM in sysfs: voltages, temperatures, fan, firmware version and
> +	  Kickstart slot. Nothing else on the list has a driver yet.
[ ... ]
> diff --git a/drivers/zorro/Makefile b/drivers/zorro/Makefile
> index 91ba82e633e76..6fe7cc1822dc1 100644
> --- a/drivers/zorro/Makefile
> +++ b/drivers/zorro/Makefile
> @@ -7,6 +7,8 @@ obj-$(CONFIG_ZORRO)	+=3D zorro.o zorro-driver.o zorro-sys=
fs.o
>  obj-$(CONFIG_PROC_FS)	+=3D proc.o
>  obj-$(CONFIG_ZORRO_NAMES) +=3D  names.o
> =20
> +obj-$(CONFIG_WARP_MFD) +=3D warp-mfd.o

[Severity: Low]
Should this driver and its local header live under drivers/mfd/ instead of
drivers/zorro/?  Per the mfd subsystem guidelines, new core mfd drivers
that call mfd_add_devices() or devm_mfd_add_devices(), along with headers
shared only between the parent and its children, belong in drivers/mfd/.

> diff --git a/drivers/zorro/warp-mfd.c b/drivers/zorro/warp-mfd.c
> new file mode 100644
> index 0000000000000..94af7c9d0ea5e
> --- /dev/null
> +++ b/drivers/zorro/warp-mfd.c
[ ... ]
> +static const struct mfd_cell warp_mfd_cells[] =3D {
> +	{
> +		.name		=3D "warp-pata",
> +		.num_resources  =3D 1,
> +		.resources	=3D (const struct resource []) {
> +			DEFINE_RES_MEM_NAMED(WARP_OFFSET_ATA, WARP_ATA_SIZE,
> +					     "pata"),
> +		}
> +	}
> +};

[Severity: Low]
Is an mfd driver appropriate when warp_mfd_cells[] only registers a single
child device?  The mfd subsystem guidelines require mfd to be used only for
devices registering multiple children across different subsystems.

In addition, the Kconfig help text states that this driver exposes
dual-port RAM configuration and telemetry in sysfs (voltages, temperatures,
fan, firmware version, and Kickstart slot), none of which is present in
this commit, and drivers/zorro/warp-mfd.h defines dual-port RAM offsets and
sizes that have no users here.  Even later in the series, telemetry is
added as custom sysfs attributes on the parent Zorro device rather than as
a child device in the appropriate subsystem such as hwmon.

> +static int warp_mfd_probe(struct zorro_dev *z,
> +			  const struct zorro_device_id *ent)
> +{
> +	int error;
> +
> +	dev_info(&z->dev, "Warp at %pR\n", &z->resource);
> +
> +	error =3D mfd_add_devices(&z->dev, z->dev.id, warp_mfd_cells,
> +				ARRAY_SIZE(warp_mfd_cells), &z->resource,
> +				0, NULL);
> +	if (error) {
> +		dev_err(&z->dev, "mfd_add_devices() failed %d\n", error);
> +		return error;
> +	}
> +	return 0;
> +}
> +
> +static void warp_mfd_remove(struct zorro_dev *z)
> +{
> +	mfd_remove_devices(&z->dev);
> +}

[Severity: Low]
This isn't a bug, but mfd guidelines prefer automatic platform device IDs
over passing z->dev.id to mfd_add_devices() when subdevices do not require
explicit numbering.  Using devm_mfd_add_devices() would also drop
warp_mfd_remove() and keep child teardown ordered with devres resources
added later in the series.

Similarly, warp_mfd_cells[] could use the standard mfd cell resource helper
macro instead of open-coding .num_resources and a compound literal, and
warp_mfd_init() / warp_mfd_exit() could use module_driver().

[ ... ]

> +static struct zorro_driver warp_mfd_driver =3D {
> +	.name		=3D "warp-mfd",
> +	.id_table	=3D warp_mfd_ids,
> +	.probe		=3D warp_mfd_probe,
> +	.remove		=3D warp_mfd_remove
> +};

[Severity: Low]
This isn't a bug, but mfd subsystem conventions avoid hard-coding "mfd" in
driver, symbol, Kconfig, and file names (such as "warp-mfd",
warp_mfd_driver, and warp-mfd.c), and expect commit subjects in the form
"mfd: <driver>: <Capitalized description>".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111163735.2272=
86-1-p.pisati@gmail.com?part=3D1
