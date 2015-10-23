From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 01/10] ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
Date: Thu, 22 Oct 2015 21:52:21 -0700
Message-ID: <CAGVrzcbzGfuzt_6CV23f+RF4gFjnc_MYO4E-huQ7PTTLyXFihA@mail.gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-2-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34379 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbbJWExB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 00:53:01 -0400
In-Reply-To: <1445564663-66824-2-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Brian Norris <computersforpeace@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

2015-10-22 18:44 GMT-07:00 Jaedon Shin <jaedon.shin@gmail.com>:
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
> SATA3.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 15e40ee62a94..8f535a88a0c7 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -100,7 +100,7 @@ config SATA_AHCI_PLATFORM
>
>  config AHCI_BRCMSTB
>         tristate "Broadcom STB AHCI SATA support"
> -       depends on ARCH_BRCMSTB
> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC
>         help
>           This option enables support for the AHCI SATA3 controller found on
>           STB SoC's.
> --
> 2.6.2
>



-- 
Florian
