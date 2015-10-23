From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 04/10] phy: phy_brcmstb_sata: make the driver buildable on BMIPS_GENERIC
Date: Thu, 22 Oct 2015 22:01:35 -0700
Message-ID: <CAGVrzcasH-E124cxEdJV7ejseWfuev+6tPQgtiaAjUHB8gJ=KA@mail.gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445564663-66824-5-git-send-email-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

2015-10-22 18:44 GMT-07:00 Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
> SATA3 PHY.
>
> Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/phy/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 47da573d0bab..c83e48661fd7 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -364,11 +364,11 @@ config PHY_TUSB1210
>
>  config PHY_BRCMSTB_SATA
>         tristate "Broadcom STB SATA PHY driver"
> -       depends on ARCH_BRCMSTB
> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC
>         depends on OF
>         select GENERIC_PHY
>         help
> -         Enable this to support the SATA3 PHY on 28nm Broadcom STB SoCs.
> +         Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB SoCs.
>           Likely useful only with CONFIG_SATA_BRCMSTB enabled.
>
>  endmenu
> --
> 2.6.2
>



-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
