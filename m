From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 03/10] ata: ahci_brcmstb: add support 40nm platforms
Date: Thu, 22 Oct 2015 22:01:16 -0700
Message-ID: <CAGVrzcZfJ448Ae64rOMmxxj8wh8w5XoYVmi66VP6y+2h6NpszA@mail.gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34877 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbbJWFB4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 01:01:56 -0400
In-Reply-To: <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Kevin Cernekee <cernekee@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

2015-10-22 18:44 GMT-07:00 Jaedon Shin <jaedon.shin@gmail.com>:
> Add offsets for 40nm BMIPS based set-top box platforms.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/ata/ahci_brcmstb.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index 8cf6f7d4798f..59eb526cf4f6 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -50,7 +50,8 @@
>    #define SATA_TOP_CTRL_2_SW_RST_RX                    BIT(2)
>    #define SATA_TOP_CTRL_2_SW_RST_TX                    BIT(3)
>    #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET             BIT(14)
> - #define SATA_TOP_CTRL_PHY_OFFS                                0x8
> + #define SATA_TOP_CTRL_28NM_PHY_OFFS                   0x8
> + #define SATA_TOP_CTRL_40NM_PHY_OFFS                   0x4
>   #define SATA_TOP_MAX_PHYS                             2
>  #define SATA_TOP_CTRL_SATA_TP_OUT                      0x1c
>  #define SATA_TOP_CTRL_CLIENT_INIT_CTRL                 0x20
> @@ -237,7 +238,13 @@ static int brcm_ahci_resume(struct device *dev)
>
>  static const struct of_device_id ahci_of_match[] = {
>         {.compatible = "brcm,bcm7445-ahci",
> -                       .data = (void *)SATA_TOP_CTRL_PHY_OFFS},
> +                       .data = (void *)SATA_TOP_CTRL_28NM_PHY_OFFS},
> +       {.compatible = "brcm,bcm7346-ahci",
> +                       .data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
> +       {.compatible = "brcm,bcm7360-ahci",
> +                       .data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
> +       {.compatible = "brcm,bcm7362-ahci",
> +                       .data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},

Since you are introducing new compatible strings, you also need to
update the binding document in Documentation/devicetree/bindings/ata/

We could just use the compatible string for the first 40nm chip that
started featuring such a SATA3 AHCI compliant core, which seems to be
7231. Apart from the existing known workarounds (disabling NCQ, tuning
the PHY) it seems to be largely identical across all 40nm chips.

This is fine either way, and more information cannot hurt, these are
all production chips, so we can actually look back at the history to
know everything about them.
-- 
Florian
