From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 11/14] sata: ahci-da850: un-hardcode the MPY bits
Date: Tue, 31 Jan 2017 20:43:11 +0530
Message-ID: <3bcc927a-f074-7f18-cdeb-e40655c39118@ti.com>
References: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
 <1485770531-6772-12-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485770531-6772-12-git-send-email-bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Monday 30 January 2017 03:32 PM, Bartosz Golaszewski wrote:

> +	/*
> +	 * The second clock used by ahci-da850 is the external REFCLK. If we
> +	 * didn't get it from ahci_platform_get_resources(), let's try to
> +	 * specify the con_id in clk_get().
> +	 */
> +	if (!hpriv->clks[1]) {
> +		clk = clk_get(dev, "refclk");
> +		if (IS_ERR(clk)) {
> +			dev_err(dev, "unable to obtain the reference clock");
> +			return -ENODEV;
> +		} else {
> +			hpriv->clks[1] = clk;
> +		}

This results in a checkpatch warning about the unneeded else. I fixed 
this locally to look like:

+        */
+       if (!hpriv->clks[1]) {
+               clk = clk_get(dev, "refclk");
+               if (IS_ERR(clk)) {
+                       dev_err(dev, "unable to obtain the reference clock");
+                       return -ENODEV;
+               }
+
+               hpriv->clks[1] = clk;
+       }

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
