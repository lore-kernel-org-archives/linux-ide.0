Return-Path: <SRS0=ewW1=7C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8398DC433DF
	for <linux-ide@archiver.kernel.org>; Wed, 20 May 2020 07:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66918206BE
	for <linux-ide@archiver.kernel.org>; Wed, 20 May 2020 07:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgETHOY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 20 May 2020 03:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETHOX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2020 03:14:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B675C061A0E
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2020 00:14:23 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1jbIvl-0004Kb-KV; Wed, 20 May 2020 09:14:21 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1jbIvj-0001XJ-8J; Wed, 20 May 2020 09:14:19 +0200
Date:   Wed, 20 May 2020 09:14:19 +0200
From:   Philipp Zabel <pza@pengutronix.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/15] ahci_brcm: fix use of BCM7216 reset controller
Message-ID: <20200520071419.GA5213@pengutronix.de>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-3-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519203419.12369-3-james.quinlan@broadcom.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:10:42 up 90 days, 14:41, 103 users,  load average: 0.85, 0.58,
 0.33
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ide@vger.kernel.org
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Jim,

On Tue, May 19, 2020 at 04:34:00PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> A reset controller "rescal" is shared between the AHCI driver
> and the PCIe driver for the BrcmSTB 7216 chip.  The code is
> modified to allow this sharing and to deassert() properly.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  drivers/ata/ahci_brcm.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 6853dbb4131d..a3c32fc29e9c 100644
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
> @@ -452,11 +451,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  
>  	/* Reset is optional depending on platform and named differently */
>  	if (priv->version == BRCM_SATA_BCM7216)
> -		reset_name = "rescal";
> +		priv->rcdev = devm_reset_control_get_shared(&pdev->dev,
> +							    "rescal");

With this change the "rescal" reset control is not optional anymore.
Please use devm_reset_control_get_optional_shared() or change the
comment.

>  	else
> -		reset_name = "ahci";
> -
> -	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
> +		priv->rcdev = devm_reset_control_get_optional(&pdev->dev,
> +							      "ahci");

You can use devm_reset_control_get_optional_exclusive() here to make it
clear this requests an exclusive control.

regards
Philipp
