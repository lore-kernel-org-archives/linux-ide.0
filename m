Return-Path: <SRS0=ctpL=EC=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C57C6369E
	for <linux-ide@archiver.kernel.org>; Tue, 27 Oct 2020 18:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FCA22202
	for <linux-ide@archiver.kernel.org>; Tue, 27 Oct 2020 18:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwTDDJEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823012AbgJ0R4r (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409055AbgJ0OWY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2020 10:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603808541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R07k2lE6wZYY3TdpSar7+AvCYtcRqZfj/K/mwBgy/to=;
        b=RwTDDJEbCg2wBRGLEwcKOjMICt3LYX2np1YKms6hxa+ayJmFY8Hp+NeXPeZJrvjLdbBEkc
        SF0cYcys/7QoXG29+/uBbQoYxeZjM285A5fNX3u/bfZFrf7OPLkStsMCo5w8GDUmQ5eu5S
        +VpR4C5Jw9wYwEWh4TNIbRCDGemPe8M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-dp6FrcXRP9u-QW--LRPpTQ-1; Tue, 27 Oct 2020 10:22:18 -0400
X-MC-Unique: dp6FrcXRP9u-QW--LRPpTQ-1
Received: by mail-ed1-f72.google.com with SMTP id n16so728423edw.19
        for <linux-ide@vger.kernel.org>; Tue, 27 Oct 2020 07:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R07k2lE6wZYY3TdpSar7+AvCYtcRqZfj/K/mwBgy/to=;
        b=QMuDRTlAoPtNQHx3WxMNU+LeIboWEgLO6SbxkWbbJT/LTUNQpej+qJ7r4gAUGhjgw9
         sNk0WaVQinfZUAMIaqLSCSKfx7KrV3TXEZ5xLXvN7XisAjReDK0fCc9HkFLIsu/oa9Tn
         PD4Q1uIJS4NV6IRbXAktGafUY2zA/H+TXTMZdAVdHIJvMcwf6sk1k59au+e5MbDCnpam
         4zVS/8EnlnrWApFQRsapmlOgm4Y7KHsWNZ3j2LCTzKYf7GjwF4KYmJ8Zr4VXLiE3fWE7
         RXm2IG/da9QGfAs/vz42dIYG+nKqQ+CIVZMwWRjioQStwZ84rkw2X1e5xM9JxYZpamtC
         3bMA==
X-Gm-Message-State: AOAM533VKEsjqtVk2EXOdPvZgVuMeIr+zCJjtnDpOOx1TxOHGcL9jq/U
        xopPOQOx9wmcNc7qfsiSZ9mS6z7BjRoPUq+YOroL5XDd96lBs9z1ldHqZm4z1otFzUzPXlptr42
        9OYcj6Q20zc9jxM+6085J
X-Received: by 2002:a17:906:eb48:: with SMTP id mc8mr2790719ejb.254.1603808536889;
        Tue, 27 Oct 2020 07:22:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzobc1wMCdxVgiQ4E0tXSnWqyUjdkzw2FXZbaHz8/x12j6ps6ymicQ7buuxmRmrZJE3aQcclA==
X-Received: by 2002:a17:906:eb48:: with SMTP id mc8mr2790679ejb.254.1603808536456;
        Tue, 27 Oct 2020 07:22:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p20sm1168031ejd.78.2020.10.27.07.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 07:22:15 -0700 (PDT)
Subject: Re: [PATCH 3/7] ata: ahci: mvebu: Add support for A8k legacy DT
 bindings
To:     sven.auhagen@voleatech.de, axboe@kernel.dk, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <20201007154554.66650-1-sven.auhagen@voleatech.de>
 <20201007154554.66650-4-sven.auhagen@voleatech.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <64ef8072-b217-275b-be98-c72f52064dff@redhat.com>
Date:   Tue, 27 Oct 2020 15:22:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007154554.66650-4-sven.auhagen@voleatech.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 10/7/20 5:45 PM, sven.auhagen@voleatech.de wrote:
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

See my comments inline.

> ---
>  drivers/ata/ahci.h             |   3 +
>  drivers/ata/ahci_mvebu.c       | 235 ++++++++++++++++++++++++++++++++-
>  drivers/ata/libahci.c          |   3 +-
>  drivers/ata/libahci_platform.c |   3 +
>  include/linux/ahci_platform.h  |   1 +
>  5 files changed, 239 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index d991dd46e89c..8cb256eec86b 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -407,6 +407,9 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
>  int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  		      unsigned long deadline, bool *online);
>  
> +void ahci_handle_port_interrupt(struct ata_port *ap,
> +				       void __iomem *port_mmio, u32 status);
> +
>  unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
>  int ahci_stop_engine(struct ata_port *ap);
>  void ahci_start_fis_rx(struct ata_port *ap);

This bit + the but making the function non static and exporting
it needs to go into its own separate patch.

> diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
> index 1cdc126882eb..62e9b94e2bba 100644
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
> @@ -28,9 +29,14 @@
>  #define AHCI_WINDOW_BASE(win)	(0x64 + ((win) << 4))
>  #define AHCI_WINDOW_SIZE(win)	(0x68 + ((win) << 4))
>  
> +#define ICU_SATA0_ICU_ID 109
> +#define ICU_SATA1_ICU_ID 107
> +
>  struct ahci_mvebu_plat_data {
>  	int (*plat_config)(struct ahci_host_priv *hpriv);
>  	unsigned int host_flags;
> +	unsigned int resource_flags;
> +	unsigned int port_irq[2];
>  };
>  
>  static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
> @@ -96,6 +102,213 @@ static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
>  	return 0;
>  }
>  
> +static int ahci_get_per_port_irq_armada8k(struct ata_host *host, int port)
> +{
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
> +
> +	return pdata->port_irq[port];
> +}
> +
> +static irqreturn_t ahci_multi_irqs_intr_hard_armada8k(int irq, void *dev_instance)
> +{
> +	struct ata_port *ap = dev_instance;
> +	struct ata_host *host = ap->host;
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	void __iomem *mmio = hpriv->mmio;
> +	u32 status;
> +
> +	VPRINTK("ENTER\n");
> +
> +	status = readl(port_mmio + PORT_IRQ_STAT);
> +	writel(status, port_mmio + PORT_IRQ_STAT);
> +
> +	spin_lock(ap->lock);
> +	ahci_handle_port_interrupt(ap, port_mmio, status);
> +	spin_unlock(ap->lock);
> +
> +	writel(BIT(ap->port_no), mmio + HOST_IRQ_STAT);
> +
> +	VPRINTK("EXIT\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ahci_host_activate_multi_irqs_armada8k(struct ata_host *host,
> +					 struct scsi_host_template *sht)
> +{
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	int i, rc;
> +
> +	rc = ata_host_start(host);
> +	if (rc)
> +		return rc;
> +	/*
> +	 * Requests IRQs one per port
> +	 */
> +	for (i = 0; i < host->n_ports; i++) {
> +		struct ahci_port_priv *pp = host->ports[i]->private_data;
> +		int irq = hpriv->get_irq_vector(host, i);
> +
> +		/* Do not receive interrupts sent by dummy ports */
> +		if (!pp) {
> +			disable_irq(irq);
> +			continue;
> +		}
> +
> +		rc = devm_request_irq(host->dev, irq, ahci_multi_irqs_intr_hard_armada8k,
> +				0, pp->irq_desc, host->ports[i]);
> +
> +		if (rc)
> +			return rc;
> +		ata_port_desc(host->ports[i], "irq %d", irq);
> +	}
> +
> +	return ata_host_register(host, sht);
> +}

This is more or less a 1:1 copy of ahci_host_activate_multi_irqs(). Please don't go
around and make copies of functions (also see below).

The only difference seems to be the use of ahci_multi_irqs_intr_hard_armada8k
where as ahci_host_activate_multi_irqs() uses ahci_multi_irqs_intr_hard as IRQ handler.

And ahci_multi_irqs_intr_hard_armada8k itself is a copy of
ahci_multi_irqs_intr_hard() with a small change

No, just no all this function copying is not ok, hard NACK!

Instead I suggest that you add an "multi_irq_host_ack" callback to some
shared data struct, which will then get called by ahci_multi_irqs_intr_hard()
(when defined) in the place where you have added the following line:

	writel(BIT(ap->port_no), mmio + HOST_IRQ_STAT);

To your private copy of ahci_multi_irqs_intr_hard(), then you can drop
both the ahci_multi_irqs_intr_hard() and the ahci_host_activate_multi_irqs()
copies and reduce the size of this patch by a lot of lines, again also see
below for dropping even more lines!

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
> +
> +	if (of_get_child_count(dev->of_node))
> +		return 0;
> +
> +	pdata->port_irq[1] = irq_create_fwspec_mapping(&fwspec);
> +	if (pdata->port_irq[1])
> +		hpriv->mask_port_map = GENMASK(1, 0);
> +
> +	return 0;
> +}
> +


> +static int ahci_platform_init_host_armada8k(struct platform_device *pdev,
> +			    struct ahci_host_priv *hpriv,
> +			    const struct ata_port_info *pi_template,
> +			    struct scsi_host_template *sht)
> +{
> +	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
> +	struct device *dev = &pdev->dev;
> +	struct ata_port_info pi = *pi_template;
> +	const struct ata_port_info *ppi[] = { &pi, NULL };
> +	struct device_node *child;
> +	struct ata_host *host;
> +	int i, port_irq, n_ports, rc, child_nodes, port = 0;
> +
> +	/* Get IRQs per port */
> +	child_nodes = of_get_child_count(dev->of_node);
> +	if (child_nodes) {
> +		for_each_child_of_node(dev->of_node, child) {
> +
> +			port_irq = of_irq_get(child, 0);
> +			if (!port_irq)
> +				port_irq = -EINVAL;
> +			if (port_irq < 0) {
> +				rc = port_irq;
> +				return rc;
> +			}
> +
> +			pdata->port_irq[port] = port_irq;
> +			port++;
> +		}
> +	} else {
> +		/* Backwards Compatibility Check */
> +		port_irq = platform_get_irq(pdev, 0);
> +		if (port_irq > 0) {
> +			pdata->port_irq[0] = port_irq;
> +			ahci_mvebu_armada_8k_irq_backwards(hpriv, dev);
> +		} else {
> +			dev_err(dev, "no irq\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	hpriv->get_irq_vector = ahci_get_per_port_irq_armada8k;
> +
> +	/* prepare host */
> +	pi.private_data = (void *)(unsigned long)hpriv->flags;
> +
> +	ahci_save_initial_config(dev, hpriv);
> +
> +	if (hpriv->cap & HOST_CAP_NCQ)
> +		pi.flags |= ATA_FLAG_NCQ;
> +
> +	if (hpriv->cap & HOST_CAP_PMP)
> +		pi.flags |= ATA_FLAG_PMP;
> +
> +	ahci_set_em_messages(hpriv, &pi);
> +
> +	/* CAP.NP sometimes indicate the index of the last enabled
> +	 * port, at other times, that of the last possible port, so
> +	 * determining the maximum port number requires looking at
> +	 * both CAP.NP and port_map.
> +	 */
> +	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
> +
> +	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
> +	if (!host)
> +		return -ENOMEM;
> +
> +	host->private_data = hpriv;
> +
> +	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
> +		host->flags |= ATA_HOST_PARALLEL_SCAN;
> +	else
> +		dev_info(dev, "SSS flag set, parallel bus scan disabled\n");
> +
> +	if (pi.flags & ATA_FLAG_EM)
> +		ahci_reset_em(host);
> +
> +	for (i = 0; i < host->n_ports; i++) {
> +		struct ata_port *ap = host->ports[i];
> +
> +		ata_port_desc(ap, "mmio %pR",
> +			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
> +
> +		/* set enclosure management message type */
> +		if (ap->flags & ATA_FLAG_EM)
> +			ap->em_message_type = hpriv->em_msg_type;
> +
> +		/* disabled/not-implemented port */
> +		if (!(hpriv->port_map & (1 << i)))
> +			ap->ops = &ata_dummy_port_ops;
> +	}
> +
> +	if (hpriv->cap & HOST_CAP_64) {
> +		rc = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +		if (rc) {
> +			rc = dma_coerce_mask_and_coherent(dev,
> +							  DMA_BIT_MASK(32));
> +			if (rc) {
> +				dev_err(dev, "Failed to enable 64-bit DMA.\n");
> +				return rc;
> +			}
> +			dev_warn(dev, "Enable 32-bit DMA instead of 64-bit.\n");
> +		}
> +	}
> +
> +	rc = ahci_reset_controller(host);
> +	if (rc)
> +		return rc;
> +
> +	ahci_init_controller(host);
> +	ahci_print_info(host, "platform");
> +
> +	return ahci_host_activate_multi_irqs_armada8k(host, sht);
> +}
> +

So this is basically a copy of ahci_platform_init_host() with:

1. This bit:

        irq = platform_get_irq(pdev, 0);
        if (irq <= 0) {
                if (irq != -EPROBE_DEFER)
                        dev_err(dev, "no irq\n");
                return irq;
        }

        hpriv->irq = irq;

Replaced with:

> +	/* Get IRQs per port */
> +	child_nodes = of_get_child_count(dev->of_node);
> +	if (child_nodes) {
> +		for_each_child_of_node(dev->of_node, child) {
> +
> +			port_irq = of_irq_get(child, 0);
> +			if (!port_irq)
> +				port_irq = -EINVAL;
> +			if (port_irq < 0) {
> +				rc = port_irq;
> +				return rc;
> +			}
> +
> +			pdata->port_irq[port] = port_irq;
> +			port++;
> +		}
> +	} else {
> +		/* Backwards Compatibility Check */
> +		port_irq = platform_get_irq(pdev, 0);
> +		if (port_irq > 0) {
> +			pdata->port_irq[0] = port_irq;
> +			ahci_mvebu_armada_8k_irq_backwards(hpriv, dev);
> +		} else {
> +			dev_err(dev, "no irq\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	hpriv->get_irq_vector = ahci_get_per_port_irq_armada8k;

You can just do this new bit, before calling ahci_platform_init_host()
and then disable the bit of ahci_platform_init_host() which you do not
want by adding an if around it like this:

	if (!(hpriv->flags & AHCI_HFLAG_MULTI_MSI)) {
	        irq = platform_get_irq(pdev, 0);
        	if (irq <= 0) {
                	if (irq != -EPROBE_DEFER)
                        	dev_err(dev, "no irq\n");
	                return irq;
        	}
	        hpriv->irq = irq;
	}

Note please add this new if() check in a separate patch.

The only other change to ahci_platform_init_host() here is
the function ending with:

	return ahci_host_activate_multi_irqs_armada8k(host, sht);

Instead of with:

       return ahci_host_activate(host, sht);

As mentioned above you really do NOT need that function, which
is yet another copy. Instead make the changes which I suggested
above and set the AHCI_HFLAG_MULTI_MSI flag to make
ahci_host_activate() do what you want.

After this you can drop all 3 private functions of pre-existing
ahci functions AFAICT.

>  static int ahci_mvebu_armada_8k_config(struct ahci_host_priv *hpriv)
>  {
>  	return 0;
> @@ -189,15 +402,22 @@ static struct scsi_host_template ahci_platform_sht = {
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
> @@ -214,7 +434,11 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto disable_resources;
>  
> -	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
> +	if (pdata->resource_flags & AHCI_PLATFORM_A8K_QUIRK)
> +		rc = ahci_platform_init_host_armada8k(pdev, hpriv, &ahci_mvebu_port_info,
> +				     &ahci_platform_sht);
> +	else
> +		rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
>  				     &ahci_platform_sht);

And this change can go away then too...

>  	if (rc)
>  		goto disable_resources;
> @@ -237,6 +461,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
>  
>  static const struct ahci_mvebu_plat_data ahci_mvebu_armada_8k_plat_data = {
>  	.plat_config = ahci_mvebu_armada_8k_config,
> +	.resource_flags = AHCI_PLATFORM_A8K_QUIRK,
>  };
>  
>  static const struct of_device_id ahci_mvebu_of_match[] = {
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index ea5bf5f4cbed..0e6eaa2e03a9 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1799,7 +1799,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
>  		ata_port_abort(ap);
>  }
>  
> -static void ahci_handle_port_interrupt(struct ata_port *ap,
> +void ahci_handle_port_interrupt(struct ata_port *ap,
>  				       void __iomem *port_mmio, u32 status)
>  {
>  	struct ata_eh_info *ehi = &ap->link.eh_info;
> @@ -1882,6 +1882,7 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
>  		ata_port_freeze(ap);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(ahci_handle_port_interrupt);
>  
>  static void ahci_port_intr(struct ata_port *ap)
>  {

As already mentioned this needs to go to a separate patch.

> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 129556fcf6be..21332a33f766 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -464,6 +464,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	if (!child_nodes)
>  		hpriv->nports = 1;
>  
> +	if (!child_nodes && flags & AHCI_PLATFORM_A8K_QUIRK)
> +		hpriv->nports = 2;
> +
>  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
>  	if (!hpriv->phys) {
>  		rc = -ENOMEM;
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 49e5383d4222..b31972e0bfbf 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -42,5 +42,6 @@ int ahci_platform_suspend(struct device *dev);
>  int ahci_platform_resume(struct device *dev);
>  
>  #define AHCI_PLATFORM_GET_RESETS	0x01
> +#define AHCI_PLATFORM_A8K_QUIRK		0x02
>  
>  #endif /* _AHCI_PLATFORM_H */
> 

These last 2 changes need to go into a separate patch and please rename the quirk to
AHCI_PLATFORM_ARMADA8K_QUIRK to make it clear that it is for armada SoCs.

Regards,

Hans

