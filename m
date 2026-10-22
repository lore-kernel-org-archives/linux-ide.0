Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651839;
	b=cFUxH26OHgSF57QFbZHQ3mUFFOPX18YSQ6S/wPWq7l2Pvv4LI3YlDE5zlkE1n1pg4hwm
	 TSRSD7p+dfryQsaJ8zLNBfNI1k6p2GWhExFVocxnUxnwZYrkp2CAGtbfIbOnRyrKWrK24
	 HUUoLgl6ILhKZ6Ks7i0Cla54h++K0muYwdSEsI53+geA/lPXQD8M8PRzgKwzA2rIyEVRb
	 PWDC+/cN/2wF5UENWqSyhAV37I0KuzzDHcOqLf73mgZHBm31omi3kBWSld6hHnmtvItW/
	 DvdxG7iP89/jZV5MfnDWfbshQIg4vg86w0dsLADrISJcLKrY7zqEHsvTrUkXco4XV3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651839;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VMJJtOaPJzI81KalVBBOZcnAoFG/9Ue++7vqjKuxbS4=;
	b=IEv1FtT7IcKHbmzYiWwVlhYy23MJFzAk1M9hUEOHpsTuYeqHTu9DwnakdqvXb1UCP4c3
	 fJ1+j69idSyjIe/a9CaLG6EkvBGabyWWv1rgmp8sl8fM6j7hkLlx9JXYwXBQm5pw7fXYC
	 UTf5sJHQsxl3OTAYncxb2CJGi6JMJmcI/vZtk57wO81hxvPyZMRpUIbG22Nev1hJnORQC
	 /hLbnXd0e0yS8WwS43Ss3zGDJmuX2Xg8rb/fCrTwI3sJBdi+gZ8W6SX9iPUxa5Yx7R102
	 H5PqBIbvpoDBR7NBcq9Ec/g7Ys1Dy5DeBNK0EwGJ+i5UUG3ak6gT1/CGd0+mi4Sq1fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLn7iabQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5369606A31B;
	Thu, 22 Oct 2026 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLn7iabQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7021F000C4;
	Thu, 22 Oct 2026 06:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792651838;
	bh=VMJJtOaPJzI81KalVBBOZcnAoFG/9Ue++7vqjKuxbS4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nLn7iabQcVBxR41nchJsSeKLe50j7FRih7F73CPOfFsH8JkLpmXAv5Z5YmvrWPT2O
	 X8gmEYBo+etLwTgfB/gX4hWPCJISLVJ1o08ddVC5t1dDmwOpNiUeQjA8M9tN2dCz1c
	 7xTjNmNztG9zlLhst/cUbacFaJ/WgoF/U+0HwNNxQ00oaOs9NnV12BVTH89Z/67C1O
	 CBaCtXQz6zVcw0acBIpgXxFlw4WyaYWy+C3WU/cQ+vzM+pu4F17F5lVpyPxgCZcX4q
	 Jj21bl6bVa6YiQpB4Uv8A++R6RfTXJq41IMP5TC9ti4VKQLNs+XaArlPLmCPPTx4la
	 Nb+iPMIZDN2xA==
Message-ID: <79a81f1d-2964-4b2a-80d1-64e01c202468@kernel.org>
Date: Thu, 22 Oct 2026 08:50:33 +0200
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ata: ahci_brcm: Initialize the NSP interface clock
 and reset
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
References: <20261021165555.652102-1-florian.fainelli@broadcom.com>
 <20261021165555.652102-4-florian.fainelli@broadcom.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261021165555.652102-4-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/21 18:55, Florian Fainelli wrote:
> The NSP probe path assumes firmware has enabled the SATA IDM interface
> clock and released the core reset. The downstream iProc config_AHCI()
> sequence explicitly performs both operations before accessing AHCI.
> Without that setup, a cold boot can access an inactive controller.
> 
> Map the optional NSP IDM register region and enable the interface clock
> before releasing reset, retaining the downstream settling intervals.
> Perform the sequence at probe and resume before reconfiguring SATA.
> 
> Keep the resource optional so older device trees continue to rely on
> firmware initialization.
> 
> Fixes: 3ee2e6dcaa35 ("ata: ahci_brcm: Add support for Broadcom NSP SoC")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/ata/ahci_brcm.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 29be74fedcf0..2ed60806b671 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -6,7 +6,9 @@
>   */
>  
>  #include <linux/ahci_platform.h>
> +#include <linux/bcma/bcma_regs.h>
>  #include <linux/compiler.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -83,6 +85,7 @@ enum brcm_ahci_quirks {
>  struct brcm_ahci_priv {
>  	struct device *dev;
>  	void __iomem *top_ctrl;
> +	void __iomem *idm;
>  	u32 port_mask;
>  	u32 quirks;
>  	enum brcm_ahci_version version;
> @@ -230,6 +233,25 @@ static u32 brcm_ahci_get_portmask(struct ahci_host_priv *hpriv,
>  	return impl;
>  }
>  
> +static void brcm_sata_init_idm(struct brcm_ahci_priv *priv)
> +{
> +	u32 data;
> +
> +	if (!priv->idm)
> +		return;
> +
> +	/* Enable the interface clock before taking the SATA core out of reset. */

Long line. Please split before 80 chars.

> +	data = readl(priv->idm + BCMA_IOCTL);
> +	writel(data | BCMA_IOCTL_CLK, priv->idm + BCMA_IOCTL);
> +	readl(priv->idm + BCMA_IOCTL);
> +	usleep_range(1000, 2000);
> +
> +	data = readl(priv->idm + BCMA_RESET_CTL);
> +	writel(data & ~BCMA_RESET_CTL_RESET, priv->idm + BCMA_RESET_CTL);
> +	readl(priv->idm + BCMA_RESET_CTL);
> +	usleep_range(1000, 2000);
> +}
> +
>  static void brcm_sata_init(struct brcm_ahci_priv *priv)
>  {
>  	void __iomem *ctrl = priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL;
> @@ -369,6 +391,8 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
>  	struct brcm_ahci_priv *priv = hpriv->plat_data;
>  	int ret = 0;
>  
> +	brcm_sata_init_idm(priv);
> +
>  	ret = reset_control_deassert(priv->rcdev_ahci);
>  	if (ret)
>  		return ret;
> @@ -453,6 +477,14 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	priv->version = (unsigned long)of_id->data;
>  	priv->dev = dev;
>  
> +	/* Older NSP device trees rely on firmware to initialize the IDM. */
> +	if (priv->version == BRCM_SATA_NSP &&
> +	    platform_get_resource_byname(pdev, IORESOURCE_MEM, "idm")) {
> +		priv->idm = devm_platform_ioremap_resource_byname(pdev, "idm");
> +		if (IS_ERR(priv->idm))
> +			return PTR_ERR(priv->idm);
> +	}
> +
>  	priv->top_ctrl = devm_platform_ioremap_resource_byname(pdev, "top-ctrl");
>  	if (IS_ERR(priv->top_ctrl))
>  		return PTR_ERR(priv->top_ctrl);
> @@ -493,6 +525,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	brcm_sata_init_idm(priv);

Here, this is called *before* the clocks are enabled, but in brcm_ahci_resume(),
brcm_sata_init() -> brcm_sata_init_idm(() is called *after* the clocks are
enabled. Does this matter?

> +
>  	ret = ahci_platform_enable_clks(hpriv);
>  	if (ret)
>  		goto out_reset;


-- 
Damien Le Moal
Western Digital Research
