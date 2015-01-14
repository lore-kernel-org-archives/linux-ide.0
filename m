From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] ata: pata_at91: depend on !ARCH_MULTIPLATFORM
Date: Wed, 14 Jan 2015 10:21:47 +0100
Message-ID: <54B6352B.8050508@atmel.com>
References: <1421173517-21246-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421173517-21246-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Le 13/01/2015 19:25, Alexandre Belloni a =E9crit :
> Until the driver is corrected to stop using mach/at91isam9_smc.h, it =
won't
> compile in a ARCH_MULTIPLATFORM configuration.
>=20
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/ata/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index a3a13605a9c4..5f601553b9b0 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -835,6 +835,7 @@ config PATA_AT32
>  config PATA_AT91
>  	tristate "PATA support for AT91SAM9260"
>  	depends on ARM && SOC_AT91SAM9
> +	depends on !ARCH_MULTIPLATFORM
>  	help
>  	  This option enables support for IDE devices on the Atmel AT91SAM9=
260 SoC.
> =20
>=20


--=20
Nicolas Ferre
