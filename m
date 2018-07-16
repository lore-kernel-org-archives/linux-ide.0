From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 7/9] dt-bindings: ata: ahci-platform: document
 port-supply
Date: Mon, 16 Jul 2018 09:59:38 -0600
Message-ID: <20180716155938.GA6947@rob-hp-laptop>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-8-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531479786-4911-8-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>
Cc: hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, tj@kernel.org, wens@csie.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, thierry.reding@gmail.com, icenowy@aosc.io
List-Id: linux-ide@vger.kernel.org

On Fri, Jul 13, 2018 at 11:03:04AM +0000, Corentin Labbe wrote:
> This patch document the new optional port-supply
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index 47652521a6ed..40a636b9851e 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -31,6 +31,7 @@ Optional properties:
>  - dma-coherent      : Present if dma operations are coherent
>  - clocks            : a list of phandle + clock specifier pairs
>  - target-supply     : regulator for SATA target power
> +- port-supply       : regulator for SATA port

Humm, I'm pretty sure that's what target-supply was supposed to be. If 
anything, need to clearly define what is what.

How does this work with multiple ports?

>  - phys              : reference to the SATA PHY node
>  - phy-names         : must be "sata-phy"
>  - ahci-supply       : regulator for AHCI controller

Also, please group all the supplies together.

> @@ -51,6 +52,7 @@ Sub-nodes required properties:
>  And at least one of the following properties:
>  - phys		    : reference to the SATA PHY node
>  - target-supply     : regulator for SATA target power
> +- port-supply       : regulator for SATA port
>  
>  Examples:
>          sata@ffe08000 {
> -- 
> 2.16.4
> 
