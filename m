From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 3/7] dt-bindings: phy: Add documentation for NSP SATA PHY
Date: Fri, 17 Jun 2016 18:12:06 +0530
Message-ID: <5763F01E.60305@ti.com>
References: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
 <1466085215-10246-4-git-send-email-yendapally.reddy@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466085215-10246-4-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>, Anup Patel <anup.patel@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org



On Thursday 16 June 2016 07:23 PM, Yendapally Reddy Dhananjaya Reddy wrote:
> Add documentation for SATA PHY available in Broadcom's
> NSP SoC.
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/brcm-sata-phy.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
> index d023120..6ccce09 100644
> --- a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
> @@ -5,6 +5,7 @@ Required properties:
>       "brcm,bcm7425-sata-phy"
>       "brcm,bcm7445-sata-phy"
>       "brcm,iproc-ns2-sata-phy"
> +     "brcm,iproc-nsp-sata-phy"
>       "brcm,phy-sata3"
>  - address-cells: should be 1
>  - size-cells: should be 0
> @@ -22,7 +23,8 @@ Sub-nodes required properties:
>  
>  Sub-nodes optional properties:
>  - brcm,enable-ssc: use spread spectrum clocking (SSC) on this port
> -     This property is not applicable for "brcm,iproc-ns2-sata-phy".
> +     This property is not applicable for "brcm,iproc-ns2-sata-phy" and
> +     "brcm,iproc-nsp-sata-phy".
>  
>  Example:
>  	sata-phy@f0458100 {
> 
