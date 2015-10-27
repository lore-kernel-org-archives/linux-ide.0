From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [v2 02/10] ata: ahci_brcmstb: add support MIPS-based platforms
Date: Tue, 27 Oct 2015 09:35:03 -0700
Message-ID: <20151027163503.GR13239@google.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
 <1445928491-7320-3-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445928491-7320-3-git-send-email-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dragan Stancevic <dragan.stancevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Tue, Oct 27, 2015 at 03:48:03PM +0900, Jaedon Shin wrote:
> The BCM7xxx ARM-based and MIPS-based platforms share a similar hardware
> block for AHCI SATA3.
> 
> The BCM7425 is flagship chipset of 40nm class. Other MIPS-based 40nm
> chipsets has same hardware block. so the compatible string may be use
> brcm,bcm7425-ahci.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt | 4 ++--
>  drivers/ata/Kconfig                                         | 2 +-
>  drivers/ata/ahci_brcmstb.c                                  | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> index 4650c0aff6b3..488a383ce202 100644
> --- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> +++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> @@ -4,8 +4,8 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
>  Each SATA controller should have its own node.
>  
>  Required properties:
> -- compatible         : compatible list, may contain "brcm,bcm7445-ahci" and/or
> -                       "brcm,sata3-ahci"
> +- compatible         : compatible list, may contain "brcm,bcm7445-ahci" or
> +                       "brcm,bcm7425-ahci" or "brcm,sata3-ahci"

If you're going to spin this series anyway, you might as well turn this
into a list, with one compatible string per line. That way it's easier
to expand if needed.

Brian

>  - reg                : register mappings for AHCI and SATA_TOP_CTRL
>  - reg-names          : "ahci" and "top-ctrl"
>  - interrupts         : interrupt mapping for SATA IRQ
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 15e40ee62a94..8f535a88a0c7 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -100,7 +100,7 @@ config SATA_AHCI_PLATFORM
>  
>  config AHCI_BRCMSTB
>  	tristate "Broadcom STB AHCI SATA support"
> -	depends on ARCH_BRCMSTB
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC
>  	help
>  	  This option enables support for the AHCI SATA3 controller found on
>  	  STB SoC's.
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index a2df76698adb..e53962cb48ee 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -343,6 +343,7 @@ static int brcm_ahci_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id ahci_of_match[] = {
>  	{.compatible = "brcm,bcm7445-ahci"},
> +	{.compatible = "brcm,bcm7425-ahci"},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
> -- 
> 2.6.2
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
