From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
Date: Fri, 20 Mar 2015 15:58:48 -0700
Message-ID: <550CA628.3020704@gmail.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com> <1426728222-8197-3-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32900 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbbCTW7c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Mar 2015 18:59:32 -0400
In-Reply-To: <1426728222-8197-3-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 18/03/15 18:23, Brian Norris wrote:
> Pretty straightforward driver, using the nice library-ization of the
> generic ahci_platform driver.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> ---
>  drivers/ata/Kconfig        |   9 +++
>  drivers/ata/Makefile       |   1 +
>  drivers/ata/sata_brcmstb.c | 148 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 drivers/ata/sata_brcmstb.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 5f601553b9b0..33d4b3031705 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -98,6 +98,15 @@ config SATA_AHCI_PLATFORM
>  
>  	  If unsure, say N.
>  
> +config SATA_BRCMSTB
> +	tristate "Broadcom STB AHCI SATA support"
> +	depends on ARCH_BRCMSTB

We would probably want a select PHY_BRCMSTB_SATA here?

[snip]

> +
> +static void brcm_sata3_init_config(struct brcm_ahci_priv *priv)
> +{
> +	/* Configure endianness */
> +	writel((DATA_ENDIAN << 4) | (DATA_ENDIAN << 2) | (MMIO_ENDIAN << 0),
> +		priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);

AFAIR, this portion of the initialization must be done in the host-CPU
native endianness, so __raw_writel() would be more appropriate, or we
could use Kevin's conditional I/O accessors and do either ioread32() or
ioread32be() based on the absence/presence of the "big-endian" property?


[snip]

> +
> +static const struct of_device_id ahci_of_match[] = {
> +	{.compatible = "brcm,sata3-ahci"},

The binding specifies brcm,bcm7445-ahci as a valid compatible string,
such that we would probably want to match it here for consistency.
-- 
Florian
