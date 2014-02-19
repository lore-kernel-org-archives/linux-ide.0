From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 06/18] ahci-platform: Add enable_ /
 disable_resources helper functions
Date: Wed, 19 Feb 2014 09:55:41 -0500
Message-ID: <20140219145541.GE10134@htj.dyndns.org>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-7-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDQ2FCEAWYLRB4ELSOMAKGQEWB5ZWMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1392811320-3132-7-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Wed, Feb 19, 2014 at 01:01:48PM +0100, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/ata/ahci_platform.c   | 83 ++++++++++++++++++++++++-------------------
>  include/linux/ahci_platform.h |  2 ++
>  2 files changed, 48 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 2f319e9..1cce7a2 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -117,6 +117,39 @@ void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
>  EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
>  
>  
> +int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
> +{
> +	int rc;
> +
> +	if (hpriv->target_pwr) {
> +		rc = regulator_enable(hpriv->target_pwr);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = ahci_platform_enable_clks(hpriv);
> +	if (rc)
> +		goto disable_regulator;
> +
> +	return 0;
> +
> +disable_regulator:
> +	if (hpriv->target_pwr)
> +		regulator_disable(hpriv->target_pwr);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
> +
> +void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
> +{
> +	ahci_platform_disable_clks(hpriv);
> +
> +	if (hpriv->target_pwr)
> +		regulator_disable(hpriv->target_pwr);
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_disable_resources);
> +
> +

Ditto with comments, double blank lines and devres wrapping.

Thanks.

-- 
tejun
