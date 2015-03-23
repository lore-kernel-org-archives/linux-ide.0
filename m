From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 02/10] ARM: at91/pm: move AT91_MEMCTRL_* to pm.h
Date: Mon, 23 Mar 2015 11:15:03 +0100
Message-ID: <550FE7A7.9050900@atmel.com>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com> <1426545886-19162-3-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426545886-19162-3-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Le 16/03/2015 23:44, Alexandre Belloni a =E9crit :
> the AT91_MEMCTRL_* defines are only used by the pm code, move them to=
 pm.h
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/mach-at91/include/mach/at91_ramc.h | 4 ----
>  arch/arm/mach-at91/pm.h                     | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-at91/include/mach/at91_ramc.h b/arch/arm/m=
ach-at91/include/mach/at91_ramc.h
> index e4492b151fee..493bc486e858 100644
> --- a/arch/arm/mach-at91/include/mach/at91_ramc.h
> +++ b/arch/arm/mach-at91/include/mach/at91_ramc.h
> @@ -21,10 +21,6 @@ extern void __iomem *at91_ramc_base[];
>  .extern at91_ramc_base
>  #endif
> =20
> -#define AT91_MEMCTRL_MC		0
> -#define AT91_MEMCTRL_SDRAMC	1
> -#define AT91_MEMCTRL_DDRSDR	2
> -
>  #include <soc/at91/at91rm9200_sdramc.h>
>  #include <soc/at91/at91sam9_ddrsdr.h>
>  #include <soc/at91/at91sam9_sdramc.h>
> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
> index 3223967d3460..ecd875a91d52 100644
> --- a/arch/arm/mach-at91/pm.h
> +++ b/arch/arm/mach-at91/pm.h
> @@ -15,6 +15,10 @@
> =20
>  #include <mach/at91_ramc.h>
> =20
> +#define AT91_MEMCTRL_MC		0
> +#define AT91_MEMCTRL_SDRAMC	1
> +#define AT91_MEMCTRL_DDRSDR	2
> +
>  #define	AT91_PM_MEMTYPE_MASK	0x0f
> =20
>  #define	AT91_PM_MODE_OFFSET	4
>=20


--=20
Nicolas Ferre
