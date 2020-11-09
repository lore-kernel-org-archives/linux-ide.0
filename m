Return-Path: <SRS0=+6aJ=EP=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93A0C4741F
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 13:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D74020731
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 13:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtWil2hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgKIN7J (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 08:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729697AbgKIN7I (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Nov 2020 08:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604930347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xwyMRgx6zwOoi8ggqAXxORMWSzC0EyKow3sz49WwHo=;
        b=YtWil2huR+GpHdxBkzTckNpvG6yWFffoK6vsbJwVRvVgOCdYye434xxAnCUv1H87rLAJ3A
        7BAVZoYE088haL5HLw12be72pg7Ago7uH2xVPaWRMnmg0XB/y/zgEU+Y2kz5qljHbREW/f
        0N1lsrSgBh4k3pEHQ1NB/AEsc/Kygd8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-aqHMUbrVPceZGsgbmEkV-w-1; Mon, 09 Nov 2020 08:59:04 -0500
X-MC-Unique: aqHMUbrVPceZGsgbmEkV-w-1
Received: by mail-ed1-f70.google.com with SMTP id c24so2768994edx.2
        for <linux-ide@vger.kernel.org>; Mon, 09 Nov 2020 05:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xwyMRgx6zwOoi8ggqAXxORMWSzC0EyKow3sz49WwHo=;
        b=aiD3uzbDiBl7k/JPkJ6ZyJpdHdkXRBEENKL+NY9XUjB8urwp5lLi0JVgmrvhPnEghy
         ixOMdmIK9b2/w1mYMc7fZkmdRurMxzYRGLf4iLQIcklPE/iCSgRD0Dx59pGymOb37MRM
         XmQ/Bis5Y4S6D5ZcAYV6qztKS3WCh7+1saovkY0IWRjqsRCx0AH/sRds86T3lYX6pJRV
         YjvyvkZ08XtEXKTVcbVrWTXMYuisdTLGCHzyCKrhD6pBNne2F0pEzvpVchjAnRdm4xYr
         QbO4TO8SKXDjurgn7rDvh/FSkU9nOT+w8PEo1MobJDr334T2wSqn8346fuNeHxQjAYBV
         L8Sg==
X-Gm-Message-State: AOAM5313BGxe9kDjPY8mQrZvzrf5HD1mcIpzSvmrhL47k9a2a1/OPbwb
        t3wY9vsNJp3AtwEhMs71D0Q2gKqBK5y1UFyPKhWOPQ4iIFERsCczGU+Cc9eo6qFuMsIYgTf8nZ1
        WxxxxFdbjciX9V6b/f/N2
X-Received: by 2002:a17:906:6d13:: with SMTP id m19mr15065932ejr.345.1604930342786;
        Mon, 09 Nov 2020 05:59:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtdM3M+0YFSVIeiw2vPzebtoaAaXJrH7HsStEJdONxGf7Fpp63aS0CZ48GpVImlcZ1NZAehw==
X-Received: by 2002:a17:906:6d13:: with SMTP id m19mr15065916ejr.345.1604930342620;
        Mon, 09 Nov 2020 05:59:02 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id c4sm8714607ejx.9.2020.11.09.05.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 05:59:02 -0800 (PST)
Subject: Re: [PATCH v2 4/9] ata: ahci: add ack callback to multi irq handler
To:     sven.auhagen@voleatech.de, axboe@kernel.dk, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <20201104155237.77772-1-sven.auhagen@voleatech.de>
 <20201104155237.77772-5-sven.auhagen@voleatech.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b27902a6-f7cb-cea4-2023-2cc6875a4f42@redhat.com>
Date:   Mon, 9 Nov 2020 14:59:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104155237.77772-5-sven.auhagen@voleatech.de>
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
> In order to support custom actions at the end of the irq handler
> a multi_irq_host_ack callback is added to the struct ahci_host_priv.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/ata/ahci.h    | 2 ++
>  drivers/ata/libahci.c | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 98b8baa47dc5..d8109e06794c 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -371,6 +371,8 @@ struct ahci_host_priv {
>  	/* only required for per-port MSI(-X) support */
>  	int			(*get_irq_vector)(struct ata_host *host,
>  						  int port);
> +
> +	int			(*multi_irq_host_ack)(int irq, struct ata_port *ap);
>  };
>  
>  extern int ahci_ignore_sss;
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index ea5bf5f4cbed..cf9839135a57 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1897,6 +1897,7 @@ static void ahci_port_intr(struct ata_port *ap)
>  static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
>  {
>  	struct ata_port *ap = dev_instance;
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  	u32 status;
>  
> @@ -1909,6 +1910,9 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
>  	ahci_handle_port_interrupt(ap, port_mmio, status);
>  	spin_unlock(ap->lock);
>  
> +	if (hpriv->multi_irq_host_ack)
> +		hpriv->multi_irq_host_ack(irq, ap);
> +
>  	VPRINTK("EXIT\n");
>  
>  	return IRQ_HANDLED;
> 

