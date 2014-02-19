From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6 05/18] ahci-platform: Add support for an optional
 regulator for sata-target power
Date: Wed, 19 Feb 2014 09:53:56 -0500
Message-ID: <20140219145356.GD10134@htj.dyndns.org>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-6-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:34713 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbaBSOyA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 09:54:00 -0500
Content-Disposition: inline
In-Reply-To: <1392811320-3132-6-git-send-email-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

On Wed, Feb 19, 2014 at 01:01:47PM +0100, Hans de Goede wrote:
> @@ -268,6 +281,9 @@ pdata_exit:
>  		pdata->exit(dev);
>  disable_unprepare_clk:
>  	ahci_disable_clks(hpriv);
> +disable_regulator:
> +	if (hpriv->target_pwr)
> +		regulator_disable(hpriv->target_pwr);

The same thing with clks, I'd much prefer to see ahci_platform doing
devres wrapping so that its consumers wouldn't have to worry about
tearing stuff down.

Thanks.

-- 
tejun
