From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 05/10] phy: phy_brcmstb_sata: remove unused definitions
Date: Thu, 22 Oct 2015 22:02:02 -0700
Message-ID: <CAGVrzcb3gbtBS8TvsJjQbRxQ=shVXgKAaTNV3p3spgEbWRgRQg@mail.gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-6-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37155 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbbJWFCm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 01:02:42 -0400
In-Reply-To: <1445564663-66824-6-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Kevin Cernekee <cernekee@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

2015-10-22 18:44 GMT-07:00 Jaedon Shin <jaedon.shin@gmail.com>:
> Remove unused definitions.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/phy/phy-brcmstb-sata.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
> index 8a2cb16a1937..0be55dafe9ea 100644
> --- a/drivers/phy/phy-brcmstb-sata.c
> +++ b/drivers/phy/phy-brcmstb-sata.c
> @@ -26,8 +26,6 @@
>
>  #define SATA_MDIO_BANK_OFFSET                          0x23c
>  #define SATA_MDIO_REG_OFFSET(ofs)                      ((ofs) * 4)
> -#define SATA_MDIO_REG_SPACE_SIZE                       0x1000
> -#define SATA_MDIO_REG_LENGTH                           0x1f00
>
>  #define MAX_PORTS                                      2
>
> --
> 2.6.2
>



-- 
Florian
