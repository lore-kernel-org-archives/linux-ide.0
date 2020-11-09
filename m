Return-Path: <SRS0=+6aJ=EP=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27B5C2D0A3
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 13:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272992076E
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 13:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxQilh5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgKIN74 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 08:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730294AbgKIN74 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Nov 2020 08:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604930393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Q0/WKC9ygaVRT70WbAMfpAiA9Io/Zwg/bd3hxZJLXw=;
        b=VxQilh5+FOMwu4dwBO4ploZs1PwXeNv6fTzXZoNaHTvFvb62Ws3UBhDZn1APQePJTTvzds
        UoH8Q3cmgsCXFkvR0SetTzg0qm7fF9MkN+cMuHDTlU0SF+Edo1HJuiCxcoiXI8HllCDSxd
        r+9JSjAoLOwlyw/pgtV1jsP68JvyG7A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-cmwOtCXeMj2dGXE9zIBxbg-1; Mon, 09 Nov 2020 08:59:51 -0500
X-MC-Unique: cmwOtCXeMj2dGXE9zIBxbg-1
Received: by mail-ed1-f71.google.com with SMTP id n16so2746798edw.19
        for <linux-ide@vger.kernel.org>; Mon, 09 Nov 2020 05:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Q0/WKC9ygaVRT70WbAMfpAiA9Io/Zwg/bd3hxZJLXw=;
        b=MD/RFflLUqDqmzVcKU/z2J5GDmzn5HV7Pz4dBFRNkn8AxT1FYDWhKmgVqkIHJGUa/g
         YnVyIrsc4dIZ/3IvWJ6Ky/zfB8WfWfsHOeth3+RguzbalJKIGivhCiOAdWVAhv3eGuBI
         NNiT67ahRajmOkBU4riJRDNJ0RED4cBlGO5bxOOdiSuZGG3rTjU9C5gO0EHzhOrBupDa
         fS3cX8+1IdxAZGz9bLyezFToCAVrhQao6Pi5OGYTgcDbw6VXQsj4/+LMaJnCxnwAd3CV
         lUTqWnObCmls+6gRh/I5bCNmnb1bk7IwGBPkzx1D3o+g/NLGUwfrIFYDnAZwDWB+51EN
         W/Mw==
X-Gm-Message-State: AOAM532xBQ8NmeCT/xdAo+ZNWrnthUM5QLPjcStoiEUMlTefR7p8a48O
        win0Ilo43XaSDHzamjeJHfUYqKU2gkh/oL1pUU94hTFX3qFfkjlpWTFZuBjTrzeaK/awJrWUPwW
        ppWxuARU4IJatOwjBtN6e
X-Received: by 2002:a50:f104:: with SMTP id w4mr15001643edl.381.1604930390134;
        Mon, 09 Nov 2020 05:59:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzE7Gi5mtM0lM74RcphRhzF9k+bg2uK0RboIYO0WxUMpofYFcAPhZ7brr7fcePLG7T9NpCKGw==
X-Received: by 2002:a50:f104:: with SMTP id w4mr15001617edl.381.1604930389916;
        Mon, 09 Nov 2020 05:59:49 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id h23sm8797344ejf.120.2020.11.09.05.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 05:59:49 -0800 (PST)
Subject: Re: [PATCH v2 5/9] ata: ahci: mvebu: Add support for A8k legacy DT
 bindings
To:     sven.auhagen@voleatech.de, axboe@kernel.dk, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <20201104155237.77772-1-sven.auhagen@voleatech.de>
 <20201104155237.77772-6-sven.auhagen@voleatech.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <75818019-d578-95cc-5ae0-bf022305e068@redhat.com>
Date:   Mon, 9 Nov 2020 14:59:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104155237.77772-6-sven.auhagen@voleatech.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 11/4/20 4:52 PM, sven.auhagen@voleatech.de wrote:
> From: Sven Auhagen <sven.auhagen@voleatech.de>
> 
> The CP110 SATA unit has 2 ports, and a dedicated ICU entry per
> port. In the past, the AHCI SATA driver only supported one interrupt
> per SATA unit. To solve this conflict, the 2 SATA wired interrupts in
> the South-Bridge got configured as 1 GIC interrupt in the
> North-Bridge, regardless of the number of SATA ports actually
> enabled/in use, and the DT bindings only referenced the interrupt of
> one port.
> 
> Since then, this limitation has been addressed and this patch ensures
> backward compatibility with old DTs not describing SATA ports
> correctly directly from the AHCI MVEBU driver. This way, we will be
> able to drop the hack from the ICU driver. IOW, when the A8k
> compatible string is used and there is no sub-nodes in the DT, we
> fake the creation and mapping of the second (missing) interrupt.
> 
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Much better, thank you.

The patch looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/ata/ahci_mvebu.c       | 126 ++++++++++++++++++++++++++++++---
>  drivers/ata/libahci_platform.c |   3 +
>  include/linux/ahci_platform.h  |   1 +
>  3 files changed, 120 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
> index ed82381dc4a7..22447b1bb23f 100644
> --- a/drivers/ata/ahci_mvebu.c
> +++ b/drivers/ata/ahci_mvebu.c
> @@ -16,6 +16,7 @@
>  #include <linux/mbus.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include "ahci.h"
>  
> @@ -28,9 +29,15 @@
>  #define AHCI_WINDOW_BASE(win)	(0x64 + ((win) << 4))
>  #define AHCI_WINDOW_SIZE(win)	(0x68 + ((win) << 4))
>  
> +#define ICU_SATA0_ICU_ID 109
> +#define ICU_SATA1_ICU_ID 107
> +
>  struct ahci_mvebu_plat_data {
> -	int (*plat_config)(struct ahci_host_priv *hpriv);
> +	int (*plat_config)(struct platform_device *pdev,
> +				   struct ahci_host_priv *hpriv);
>  	unsigned int host_flags;
> +	unsigned int resource_flags;
> +	unsigned int port_irq[2];
>  };
>  
>  static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
> @@ -67,7 +74,8 @@ static void ahci_mvebu_regret_option(struct ahci_host_priv *hpriv)
>  	writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
>  }
>  
> -static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv)
> +static int ahci_mvebu_armada_380_config(struct platform_device *pdev,
> +				   struct ahci_host_priv *hpriv)
>  {
>  	const struct mbus_dram_target_info *dram;
>  	int rc = 0;
> @@ -83,7 +91,8 @@ static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv)
>  	return rc;
>  }
>  
> -static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
> +static int ahci_mvebu_armada_3700_config(struct platform_device *pdev,
> +				   struct ahci_host_priv *hpriv)
>  {
>  	u32 reg;
>  
> @@ -96,8 +105,94 @@ static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
>  	return 0;
>  }
>  
> -static int ahci_mvebu_armada_8k_config(struct ahci_host_priv *hpriv)
> +static int multi_irq_host_ack_armada8k(int irq, struct ata_port *ap)
>  {
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	void __iomem *mmio = hpriv->mmio;
> +
> +	writel(BIT(ap->port_no), mmio + HOST_IRQ_STAT);
> +
> +	return 0;
> +}
> +
> +static int ahci_get_per_port_irq_armada8k(struct ata_host *host, int port)
> +{
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
> +
> +	return pdata->port_irq[port];
> +}
> +
> +static int ahci_mvebu_armada_8k_irq_backwards(struct ahci_host_priv *hpriv,
> +				       struct device *dev)
> +{
> +	struct device_node *np = of_irq_find_parent(dev->of_node);
> +	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
> +	struct irq_data *irqd = irq_get_irq_data(pdata->port_irq[0]);
> +	int host_irq = irqd ? irqd_to_hwirq(irqd) : 0;
> +	int missing_irq = (host_irq == ICU_SATA1_ICU_ID) ?
> +		ICU_SATA0_ICU_ID : ICU_SATA1_ICU_ID;
> +	struct irq_fwspec fwspec = {
> +		.fwnode = of_node_to_fwnode(np),
> +		.param_count = 2,
> +		.param = {missing_irq, IRQ_TYPE_LEVEL_HIGH},
> +	};
> +	int irq;
> +
> +	pdata->port_irq[1] = irq_create_fwspec_mapping(&fwspec);
> +	hpriv->mask_port_map = GENMASK(1, 0);
> +
> +	if (missing_irq == ICU_SATA0_ICU_ID) {
> +		irq = pdata->port_irq[0];
> +		pdata->port_irq[0] = pdata->port_irq[1];
> +		pdata->port_irq[1] = irq;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ahci_mvebu_armada_8k_config(struct platform_device *pdev,
> +				   struct ahci_host_priv *hpriv)
> +{
> +	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *child;
> +	int port_irq, child_nodes, port = 0;
> +
> +	/* Get IRQs per port */
> +	child_nodes = of_get_child_count(dev->of_node);
> +	if (child_nodes) {
> +		for_each_child_of_node(dev->of_node, child) {
> +
> +			port_irq = of_irq_get(child, 0);
> +			if (!port_irq)
> +				port_irq = -EINVAL;
> +
> +			if (port_irq < 0)
> +				goto compat;
> +
> +			pdata->port_irq[port] = port_irq;
> +			port++;
> +		}
> +
> +		goto out;
> +	}
> +
> +compat:
> +	/* Backwards Compatibility Check */
> +	port_irq = platform_get_irq(pdev, 0);
> +	if (port_irq > 0) {
> +		pdata->port_irq[0] = port_irq;
> +		ahci_mvebu_armada_8k_irq_backwards(hpriv, dev);
> +	} else {
> +		dev_err(dev, "no irq\n");
> +		return port_irq;
> +	}
> +
> +out:
> +	hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
> +	hpriv->get_irq_vector = ahci_get_per_port_irq_armada8k;
> +
>  	return 0;
>  }
>  
> @@ -167,7 +262,7 @@ static int ahci_mvebu_resume(struct platform_device *pdev)
>  	struct ahci_host_priv *hpriv = host->private_data;
>  	const struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
>  
> -	pdata->plat_config(hpriv);
> +	pdata->plat_config(pdev, hpriv);
>  
>  	return ahci_platform_resume_host(&pdev->dev);
>  }
> @@ -189,15 +284,22 @@ static struct scsi_host_template ahci_platform_sht = {
>  
>  static int ahci_mvebu_probe(struct platform_device *pdev)
>  {
> -	const struct ahci_mvebu_plat_data *pdata;
> +	const struct ahci_mvebu_plat_data *pdata_plat;
> +	struct ahci_mvebu_plat_data *pdata;
>  	struct ahci_host_priv *hpriv;
>  	int rc;
>  
> -	pdata = of_device_get_match_data(&pdev->dev);
> -	if (!pdata)
> +	pdata_plat = of_device_get_match_data(&pdev->dev);
> +	if (!pdata_plat)
>  		return -EINVAL;
>  
> -	hpriv = ahci_platform_get_resources(pdev, 0);
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	memcpy(pdata, pdata_plat, sizeof(*pdata));
> +
> +	hpriv = ahci_platform_get_resources(pdev, pdata->resource_flags);
>  	if (IS_ERR(hpriv))
>  		return PTR_ERR(hpriv);
>  
> @@ -210,10 +312,13 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
>  
>  	hpriv->stop_engine = ahci_mvebu_stop_engine;
>  
> -	rc = pdata->plat_config(hpriv);
> +	rc = pdata->plat_config(pdev, hpriv);
>  	if (rc)
>  		goto disable_resources;
>  
> +	if (pdata->resource_flags & AHCI_PLATFORM_ARMADA8K_QUIRK)
> +		hpriv->multi_irq_host_ack = multi_irq_host_ack_armada8k;
> +
>  	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
>  				     &ahci_platform_sht);
>  	if (rc)
> @@ -237,6 +342,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
>  
>  static const struct ahci_mvebu_plat_data ahci_mvebu_armada_8k_plat_data = {
>  	.plat_config = ahci_mvebu_armada_8k_config,
> +	.resource_flags = AHCI_PLATFORM_ARMADA8K_QUIRK,
>  };
>  
>  static const struct of_device_id ahci_mvebu_of_match[] = {
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index f6f2a111d226..a5d06565a5c7 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -464,6 +464,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	if (!child_nodes)
>  		hpriv->nports = 1;
>  
> +	if (!child_nodes && flags & AHCI_PLATFORM_ARMADA8K_QUIRK)
> +		hpriv->nports = 2;
> +
>  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
>  	if (!hpriv->phys) {
>  		rc = -ENOMEM;
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 49e5383d4222..99ff30b6c37c 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -42,5 +42,6 @@ int ahci_platform_suspend(struct device *dev);
>  int ahci_platform_resume(struct device *dev);
>  
>  #define AHCI_PLATFORM_GET_RESETS	0x01
> +#define AHCI_PLATFORM_ARMADA8K_QUIRK	0x02
>  
>  #endif /* _AHCI_PLATFORM_H */
> 

