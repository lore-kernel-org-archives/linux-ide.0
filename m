Return-Path: <SRS0=KxJU=CD=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534DEC433E1
	for <linux-ide@archiver.kernel.org>; Tue, 25 Aug 2020 08:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D85B205CB
	for <linux-ide@archiver.kernel.org>; Tue, 25 Aug 2020 08:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHYIQn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:16:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49199 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgHYIQm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Aug 2020 04:16:42 -0400
Received: from [2001:67c:670:100:3ad5:47ff:feaf:1a17] (helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kAU8B-0000Us-1j; Tue, 25 Aug 2020 10:16:35 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kAU89-0002cv-D2; Tue, 25 Aug 2020 10:16:33 +0200
Message-ID: <32b000b801202c3d6318da6c5bc52d47ab6947e0.camel@pengutronix.de>
Subject: Re: [PATCH v1] ata: ahci_brcm: Fix use of BCM7216 reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Aug 2020 10:16:33 +0200
In-Reply-To: <20200824204002.45500-1-james.quinlan@broadcom.com>
References: <20200824204002.45500-1-james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ide@vger.kernel.org
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 2020-08-24 at 16:40 -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> A reset controller "rescal" is shared between the AHCI driver and the PCIe
> driver for the BrcmSTB 7216 chip.  Use
> devm_reset_control_get_optional_shared() to handle this sharing.
> 
> Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
> Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  drivers/ata/ahci_brcm.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 6853dbb4131d..d6115bc04b09 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -428,7 +428,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *of_id;
>  	struct device *dev = &pdev->dev;
> -	const char *reset_name = NULL;
>  	struct brcm_ahci_priv *priv;
>  	struct ahci_host_priv *hpriv;
>  	struct resource *res;
> @@ -452,11 +451,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  
>  	/* Reset is optional depending on platform and named differently */
>  	if (priv->version == BRCM_SATA_BCM7216)
> -		reset_name = "rescal";
> +		priv->rcdev = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
>  	else
> -		reset_name = "ahci";
> +		priv->rcdev = devm_reset_control_get_optional(&pdev->dev, "ahci");

I think it would be cleaner to use two separate reset control handles
here. It is hard to reason about what the code does when the reset
control is shared on one platform and exclusive on the other.

> -	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
>  	if (IS_ERR(priv->rcdev))
>  		return PTR_ERR(priv->rcdev);
>  
> @@ -479,10 +477,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> -	if (priv->version == BRCM_SATA_BCM7216)
> -		ret = reset_control_reset(priv->rcdev);

I think we might have a similar issue currently with
"usb: dwc3: meson-g12a: fix shared reset control use", where two IP
cores try to share a pulsed reset line.

> -	else
> -		ret = reset_control_deassert(priv->rcdev);
> +	ret = reset_control_deassert(priv->rcdev);

Isn't the shared 'rescal' reset a triggered reset pulse? Looking at the
reset-brcmstb-rescal reset controller driver, without reset line level
control implemented, this will turn into a no-op for BCM7216. Yes, the
reset line will be deasserted after this call, but there is no guarantee
that the reset line was ever pulsed.

regards
Philipp
