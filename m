From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] libata: Convert LED disk trigger from IDE to libata
Date: Thu, 06 Oct 2011 14:53:19 +0400
Message-ID: <4E8D889F.7010401@mvista.com>
References: <38bd3a0590c6b069e2e6ff63d2bc4d039a703f02.1317657893.git.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51918 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286Ab1JFKyM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 06:54:12 -0400
In-Reply-To: <38bd3a0590c6b069e2e6ff63d2bc4d039a703f02.1317657893.git.joerg@alea.gnuu.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, "David S. Miller" <davem@davemloft.net>, Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>

Hello.

On 03-10-2011 20:07, J=F6rg Sommer wrote:

> This patch converts the trigger for the LED at the front of Apple's
> iBooks to libata. It's merely a replacement of the string ide by disk=
=2E

> The patch is taken from http://dev.gentoo.org/~josejx/ata.patch. I've
> asked Joseph Jezak if he intends to send this patch upstream, but as =
he
> did not reply I'll do so.

    The patch needs to be signed off, it cannot be applied otherwise.

> ---
>   arch/powerpc/configs/pmac32_defconfig |    2 +-
>   arch/powerpc/configs/ppc6xx_defconfig |    2 +-
>   drivers/ata/libata-core.c             |    4 ++
>   drivers/ide/ide-disk.c                |    2 +-
>   drivers/leds/Kconfig                  |   10 +++---
>   drivers/leds/Makefile                 |    2 +-
>   drivers/leds/ledtrig-disk.c           |   64 ++++++++++++++++++++++=
+++++++++++
>   drivers/leds/ledtrig-ide-disk.c       |   64 ----------------------=
-----------
>   drivers/macintosh/Kconfig             |   11 +++---
>   drivers/macintosh/via-pmu-led.c       |    4 +-
>   include/linux/leds.h                  |    6 ++--
>   11 files changed, 87 insertions(+), 84 deletions(-)
>   create mode 100644 drivers/leds/ledtrig-disk.c
>   delete mode 100644 drivers/leds/ledtrig-ide-disk.c

    You should use -C/-M git options to detect file renames.

> diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/con=
figs/pmac32_defconfig
> index f8b394a..cff5d4e 100644
> --- a/arch/powerpc/configs/pmac32_defconfig
> +++ b/arch/powerpc/configs/pmac32_defconfig
> @@ -180,7 +180,7 @@ CONFIG_ADB=3Dy
>   CONFIG_ADB_CUDA=3Dy
>   CONFIG_ADB_PMU=3Dy
>   CONFIG_ADB_PMU_LED=3Dy
> -CONFIG_ADB_PMU_LED_IDE=3Dy
> +CONFIG_ADB_PMU_LED_DISK=3Dy
>   CONFIG_PMAC_APM_EMU=3Dm
>   CONFIG_PMAC_MEDIABAY=3Dy
>   CONFIG_PMAC_BACKLIGHT=3Dy
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/con=
figs/ppc6xx_defconfig
> index 04360f9..c56464d 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -471,7 +471,7 @@ CONFIG_ADB=3Dy
>   CONFIG_ADB_CUDA=3Dy
>   CONFIG_ADB_PMU=3Dy
>   CONFIG_ADB_PMU_LED=3Dy
> -CONFIG_ADB_PMU_LED_IDE=3Dy
> +CONFIG_ADB_PMU_LED_DISK=3Dy
>   CONFIG_PMAC_APM_EMU=3Dy
>   CONFIG_PMAC_MEDIABAY=3Dy
>   CONFIG_PMAC_BACKLIGHT=3Dy

    Defconfigs should be changed by a separate patch.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4a3a5ae..d37e3a2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -66,6 +66,7 @@
>   #include<asm/byteorder.h>
>   #include<linux/cdrom.h>
>   #include<linux/ratelimit.h>
> +#include<linux/leds.h>
>
>   #include "libata.h"
>   #include "libata-transport.h"
> @@ -4823,6 +4824,9 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>   {
>   	struct ata_port *ap =3D qc->ap;
>
> +	/* Trigger the LED (if available) */
> +	ledtrig_disk_activity();
> +
>   	/* XXX: New EH and old EH use different mechanisms to
>   	 * synchronize EH with regular execution path.
>   	 *

    This also seems a material for the separate patch. You should first=
 do a=20
file/function rename and then add support for libata, I think.

> diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> index 2747980..cb25bd6 100644
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -186,7 +186,7 @@ static ide_startstop_t ide_do_rw_disk(ide_drive_t=
 *drive, struct request *rq,
>   	BUG_ON(drive->dev_flags&  IDE_DFLAG_BLOCKED);
>   	BUG_ON(rq->cmd_type !=3D REQ_TYPE_FS);
>
> -	ledtrig_ide_activity();
> +	ledtrig_disk_activity();

    Hm, the trigger point seems asymmetric to that one you added to lib=
ata.=20
Here you trigger before executing a request, and in libata after a comm=
and=20
completes; also, in libata you also trigger on ATAPI devices, while her=
e only=20
on ATA devices...

WBR, Sergei
