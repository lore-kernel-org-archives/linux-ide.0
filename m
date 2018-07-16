From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 5/9] dt-bindings: ata: ahci-platform: fix
 indentation of target-supply
Date: Mon, 16 Jul 2018 09:55:39 -0600
Message-ID: <20180716155539.GA5354@rob-hp-laptop>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-6-git-send-email-clabbe@baylibre.com>
Reply-To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDJIP47K7MERB7P7WLNAKGQEQUMYC7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1531479786-4911-6-git-send-email-clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, icenowy-h8G6r0blFSE@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Fri, Jul 13, 2018 at 11:03:02AM +0000, Corentin Labbe wrote:
> This patch fix the indentation of target-supply's ':'.
> 
> Signed-off-by: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This one should come before the others. Fixes/restructuring before 
features.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index a5281d7557e3..47652521a6ed 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -50,7 +50,7 @@ Sub-nodes required properties:
>  - reg		    : the port number
>  And at least one of the following properties:
>  - phys		    : reference to the SATA PHY node
> -- target-supply    : regulator for SATA target power
> +- target-supply     : regulator for SATA target power
>  
>  Examples:
>          sata@ffe08000 {
> -- 
> 2.16.4
> 
