From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 03/10] ata: ahci_brcmstb: add support 40nm platforms
Date: Fri, 23 Oct 2015 14:25:58 -0700
Message-ID: <20151023212558.GS13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34504 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbJWV0C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 17:26:02 -0400
Content-Disposition: inline
In-Reply-To: <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, devicetree@vger.kernel.org

Hi Jadeon,

Hmm, my suspicions about the PHY driver are probably meant to be applied
here. I don't think this change is sufficient.

On Fri, Oct 23, 2015 at 10:44:16AM +0900, Jaedon Shin wrote:
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
>    #define SATA_TOP_CTRL_2_SW_RST_RX			BIT(2)
>    #define SATA_TOP_CTRL_2_SW_RST_TX			BIT(3)
>    #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET		BIT(14)
> - #define SATA_TOP_CTRL_PHY_OFFS				0x8
> + #define SATA_TOP_CTRL_28NM_PHY_OFFS			0x8
> + #define SATA_TOP_CTRL_40NM_PHY_OFFS			0x4

I don't remember the exact 40nm vs. 28nm map that well, but judging by
the code-is-the-documentation, the 28nm layout is like this:

base + 0x0C = port 0, phy control 1
base + 0x10 = port 0, phy control 2
base + 0x14 = port 1, phy control 1
base + 0x18 = port 1, phy control 2

but the 40nm layout is differnt, where the ports are interleaved:

base + 0x0C = port 0, phy control 1
base + 0x10 = port 1, phy control 1
base + 0x14 = port 0, phy control 2
base + 0x18 = port 1, phy control 2

So, your patch gets phy control 1 correct for both ports, but it doesn't
get phy control 2 correct. (Or at least, even if my guess at the 40nm
layout is wrong, your patch makes "port 0, phy control 2" collide with
"port 1, phy control 1", which is most certainly a bug.)

Are you sure you're testing this properly? Did you try using both ports
at the same time? And please, apply the same scrutiny to the PHY driver.
(e.g., did you test SSC? did you test both ports?)

Brian

>   #define SATA_TOP_MAX_PHYS				2
>  #define SATA_TOP_CTRL_SATA_TP_OUT			0x1c
>  #define SATA_TOP_CTRL_CLIENT_INIT_CTRL			0x20
> @@ -237,7 +238,13 @@ static int brcm_ahci_resume(struct device *dev)
>  
>  static const struct of_device_id ahci_of_match[] = {
>  	{.compatible = "brcm,bcm7445-ahci",
> -			.data = (void *)SATA_TOP_CTRL_PHY_OFFS},
> +			.data = (void *)SATA_TOP_CTRL_28NM_PHY_OFFS},
> +	{.compatible = "brcm,bcm7346-ahci",
> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
> +	{.compatible = "brcm,bcm7360-ahci",
> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
> +	{.compatible = "brcm,bcm7362-ahci",
> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
