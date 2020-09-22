Return-Path: <SRS0=jz0E=C7=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE7AC4727E
	for <linux-ide@archiver.kernel.org>; Tue, 22 Sep 2020 12:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB162388B
	for <linux-ide@archiver.kernel.org>; Tue, 22 Sep 2020 12:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIVMFv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Sep 2020 08:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgIVMFv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Sep 2020 08:05:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA2CC061755
        for <linux-ide@vger.kernel.org>; Tue, 22 Sep 2020 05:05:51 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kKh3N-0006tH-G1; Tue, 22 Sep 2020 14:05:49 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kKh3M-0008Fc-IZ; Tue, 22 Sep 2020 14:05:48 +0200
Message-ID: <cf79a03117f4886dd91a624fd0081222ae87fea0.camel@pengutronix.de>
Subject: Re: [PATCH V2 2/2] ata: ahci: ceva: Update the driver to support
 xilinx GT phy
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Piyush Mehta <piyush.mehta@xilinx.com>, axboe@kernel.dk,
        robh+dt@kernel.org
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com, sgoud@xilinx.com,
        michal.simek@xilinx.com
Date:   Tue, 22 Sep 2020 14:05:48 +0200
In-Reply-To: <1600769713-944-3-git-send-email-piyush.mehta@xilinx.com>
References: <1600769713-944-1-git-send-email-piyush.mehta@xilinx.com>
         <1600769713-944-3-git-send-email-piyush.mehta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, 2020-09-22 at 15:45 +0530, Piyush Mehta wrote:
> SATA controller used in Xilinx ZynqMP platform uses xilinx GT phy
> which has 4 GT lanes and can used by 4 peripherals at a time.
> SATA controller uses 1 GT phy lane among the 4 GT lanes. To configure
> the GT lane for SATA controller, the below sequence is expected.
> 
> 1. Assert the SATA controller reset.
> 2. Configure the xilinx GT phy lane for SATA controller (phy_init).
> 3. De-assert the SATA controller reset.
> 4. Wait for PLL of the GT lane used by SATA to be locked (phy_power_on).
> 
> The ahci_platform_enable_resources() by default does the phy_init()
> and phy_power_on() but the default sequence doesn't work with Xilinx
> platforms. Because of this reason, updated the driver to support the
> new sequence.
> 
> Added is_rst_ctrl flag, for backward compatibility with the older
> sequence. If the reset controller is not available, then the SATA
> controller will configure with the older sequences.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
>  drivers/ata/ahci_ceva.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index b10fd4c..c704906 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include "ahci.h"
>  
>  /* Vendor Specific Register Offsets */
> @@ -87,6 +88,7 @@ struct ceva_ahci_priv {
>  	u32 axicc;
>  	bool is_cci_enabled;
>  	int flags;
> +	struct reset_control *rst;
>  };
>  
>  static unsigned int ceva_ahci_read_id(struct ata_device *dev,
> @@ -194,7 +196,7 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  	struct ahci_host_priv *hpriv;
>  	struct ceva_ahci_priv *cevapriv;
>  	enum dev_dma_attr attr;
> -	int rc;
> +	int rc, i, is_rst_ctrl = 1;
>  
>  	cevapriv = devm_kzalloc(dev, sizeof(*cevapriv), GFP_KERNEL);
>  	if (!cevapriv)
> @@ -202,14 +204,47 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  
>  	cevapriv->ahci_pdev = pdev;
>  
> +	cevapriv->rst = devm_reset_control_get(&pdev->dev, NULL);

Please use devm_reset_control_get_optional_exclusive()

> +	if (IS_ERR(cevapriv->rst)) {
> +		if (PTR_ERR(cevapriv->rst) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get reset: %ld\n",
> +				PTR_ERR(cevapriv->rst));
> +		is_rst_ctrl = 0;

is_rst_ctrl will not be required then.

> +	}
> +
>  	hpriv = ahci_platform_get_resources(pdev, 0);
>  	if (IS_ERR(hpriv))
>  		return PTR_ERR(hpriv);
> +	if (is_rst_ctrl)
> +		rc = ahci_platform_enable_clks(hpriv);
> +	else
> +		rc = ahci_platform_enable_resources(hpriv);
>  
> -	rc = ahci_platform_enable_resources(hpriv);
>  	if (rc)
>  		return rc;
>  
> +	if (is_rst_ctrl) {

This can just be "if (cevapriv->rst)"

> +		/* Assert the controller reset */
> +		reset_control_assert(cevapriv->rst);
> +
> +		for (i = 0; i < hpriv->nports; i++) {
> +			rc = phy_init(hpriv->phys[i]);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		/* De-assert the controller reset */
> +		reset_control_deassert(cevapriv->rst);
> +
> +		for (i = 0; i < hpriv->nports; i++) {
> +			rc = phy_power_on(hpriv->phys[i]);
> +			if (rc) {
> +				phy_exit(hpriv->phys[i]);
> +				return rc;
> +			}
> +		}
> +	}
> +
>  	if (of_property_read_bool(np, "ceva,broken-gen2"))
>  		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
>  

regards
Philipp
