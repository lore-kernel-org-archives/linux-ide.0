From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 00/10] ARM: at91 cleanups for 4.1 #2
Date: Mon, 23 Mar 2015 11:14:35 +0100
Message-ID: <550FE78B.6090900@atmel.com>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:11538 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbbCWKOh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Mar 2015 06:14:37 -0400
In-Reply-To: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Lee Jones <lee.jones@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Le 16/03/2015 23:44, Alexandre Belloni a =E9crit :
> Hi,
>=20
> This patch set finishes the clean up of the mach-at91 directory.
>=20
> It fixed the remaining two drivers (at91_cf and pata_at91) so that th=
ey compile
> in a multiplatform configuration.
>=20
> Then it removes the uneeded headers.
>=20
>=20
> Alexandre Belloni (9):
>   ARM: at91/pm: move the standby functions to pm.c
>   ARM: at91/pm: move AT91_MEMCTRL_* to pm.h

Ok, I only take the first 2 patches of this series for now.

The rest looks good as well, but I need more insight and the review fro=
m
Lee to go forward.

Thanks, bye.


>   ata: at91: use syscon to configure the smc
>   ARM: at91: drop sam9_smc.c
>   ARM: at91: declare the at91rm9200 memory controller as a syscon
>   pcmcia: at91_cf: Use syscon to configure the MC/smc
>   ARM: at91/pm: use the atmel-mc syscon defines
>   ARM: at91: remove mach/at91_ramc.h and mach/at91rm9200_mc.h
>   ARM: at91: remove at91rm9200_sdramc.h
>=20
> Boris Brezillon (1):
>   mfd: syscon: Add Atmel MC (Memory Controller) registers definition
>=20
>  .../devicetree/bindings/arm/atmel-at91.txt         |   2 +-
>  arch/arm/boot/dts/at91rm9200.dtsi                  |   2 +-
>  arch/arm/mach-at91/Makefile                        |   5 -
>  arch/arm/mach-at91/include/mach/at91_ramc.h        |  32 -----
>  arch/arm/mach-at91/include/mach/at91rm9200_mc.h    | 116 -----------=
------
>  arch/arm/mach-at91/include/mach/at91sam9_smc.h     |  98 -----------=
---
>  arch/arm/mach-at91/pm.c                            |  91 +++++++++++=
+-
>  arch/arm/mach-at91/pm.h                            | 110 +++--------=
-----
>  arch/arm/mach-at91/pm_suspend.S                    |   3 +-
>  arch/arm/mach-at91/sam9_smc.c                      | 136 -----------=
--------
>  arch/arm/mach-at91/sam9_smc.h                      |  11 --
>  drivers/ata/Kconfig                                |   1 -
>  drivers/ata/pata_at91.c                            |  92 ++++++++++-=
--
>  drivers/pcmcia/Kconfig                             |   1 -
>  drivers/pcmcia/at91_cf.c                           |  25 ++--
>  include/linux/mfd/syscon/atmel-mc.h                | 144 +++++++++++=
++++++++++
>  include/soc/at91/at91rm9200_sdramc.h               |  63 ---------
>  17 files changed, 339 insertions(+), 593 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91_ramc.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200_mc.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9_smc.h
>  delete mode 100644 arch/arm/mach-at91/sam9_smc.c
>  delete mode 100644 arch/arm/mach-at91/sam9_smc.h
>  create mode 100644 include/linux/mfd/syscon/atmel-mc.h
>  delete mode 100644 include/soc/at91/at91rm9200_sdramc.h
>=20


--=20
Nicolas Ferre
