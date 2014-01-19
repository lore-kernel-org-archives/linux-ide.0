From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [RFC v3 06/13] ahci-platform: Add support for
 devices with more then 1 clock
Date: Sun, 19 Jan 2014 12:38:55 +0000
Message-ID: <20140119123854.GP15937@n2100.arm.linux.org.uk>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-7-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCUYRNXYZECRB2EO56LAKGQEBWKD3BI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390088935-7193-7-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Sun, Jan 19, 2014 at 12:48:48AM +0100, Hans de Goede wrote:
> +static int ahci_enable_clks(struct device *dev, struct ahci_host_priv *hpriv)
> +{
> +	int c, rc;
> +
> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {

	for (c = 0; c < AHCI_MAX_CLKS && !IS_ERR(hpriv->clks[c]); c++) {

> +		rc = clk_prepare_enable(hpriv->clks[c]);
> +		if (rc) {
> +			dev_err(dev, "clock prepare enable failed");
> +			goto disable_unprepare_clk;
> +		}
> +	}
> +	return 0;
> +
> +disable_unprepare_clk:
> +	while (--c >= 0)
> +		clk_disable_unprepare(hpriv->clks[c]);
> +	return rc;
> +}
> +
> +static void ahci_disable_clks(struct ahci_host_priv *hpriv)
> +{
> +	int c;
> +
> +	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
> +		if (hpriv->clks[c])

		if (!IS_ERR(hpriv->clks[c]))

> +			clk_disable_unprepare(hpriv->clks[c]);
> +}
> +
> +static void ahci_put_clks(struct ahci_host_priv *hpriv)
> +{
> +	int c;
> +
> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)

	for (c = 0; c < AHCI_MAX_CLKS && !IS_ERR(hpriv->clks[c]); c++)

> +		clk_put(hpriv->clks[c]);
> +}

Better still for this one, consider using devm_clk_get() - in which case
the above is even more important to get right.  We really should have
a devm_of_clk_get() too.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
