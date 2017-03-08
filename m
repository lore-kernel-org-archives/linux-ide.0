From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFT PATCH] mips: workpad_defconfig: convert to use libata PATA
 drivers
Date: Wed, 08 Mar 2017 17:04:35 +0100
Message-ID: <1693758.UBeBuiPSKd@amdc3058>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
 <1442245918-27631-17-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170308160437epcas5p40c3197b4fde85ccf984a362917a7c5a7@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43988 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbdCHQEm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Mar 2017 11:04:42 -0500
In-reply-to: <1442245918-27631-17-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Ralf,

When patches converting MIPS defconfigs to libata PATA were
applied this one got lost somehow. Please consider merging
(it applies fine to v4.11-rc1).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

On Monday, September 14, 2015 05:51:58 PM Bartlomiej Zolnierkiewicz wrote:
> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
> 
> * testing efforts are divided between two subsystems
> 
> * having duplicate drivers for same hardware confuses users
> 
> This patch converts workpad_defconfig to use libata PATA
> drivers.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Build tested only.
> If you have affected hardware please test.  Thank you.
> 
>  arch/mips/configs/workpad_defconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
> index ee4b2be..1b556cd 100644
> --- a/arch/mips/configs/workpad_defconfig
> +++ b/arch/mips/configs/workpad_defconfig
> @@ -28,10 +28,10 @@ CONFIG_IP_MULTICAST=y
>  # CONFIG_IPV6 is not set
>  CONFIG_NETWORK_SECMARK=y
>  CONFIG_BLK_DEV_RAM=m
> -# CONFIG_MISC_DEVICES is not set
> -CONFIG_IDE=y
> -CONFIG_BLK_DEV_IDECS=m
> -CONFIG_IDE_GENERIC=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_ATA=y
> +CONFIG_PATA_PCMCIA=m
> +CONFIG_PATA_LEGACY=y
>  CONFIG_NETDEVICES=y
>  # CONFIG_NETDEV_1000 is not set
>  # CONFIG_NETDEV_10000 is not set

