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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E89DC2D0A3
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 14:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A6520665
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 14:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwNhQeXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbgKIOBE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 09:01:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbgKIOBE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Nov 2020 09:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604930462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+UKQzgtuYMyW/SoLBP9eW/fTlDRQd3FvWyc619DNi0=;
        b=MwNhQeXRLnEpC3hXx9Uz/C+9rjLvG136asSQOCUgo5iFPaey8qp/HM0kVvqBSgeKax9AgQ
        QX88OKxxpzlYVAxyU8X9MQJh2duQIbhuWqLHKClfotuOYuCPVVqFZKxXlonNMD7F16H7Zh
        THsHlEqReIVGycV6FuCRKU4ZSTdHUKQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-D4OPjTULN_i-SJUJpffOfQ-1; Mon, 09 Nov 2020 09:01:01 -0500
X-MC-Unique: D4OPjTULN_i-SJUJpffOfQ-1
Received: by mail-ej1-f71.google.com with SMTP id e9so3440670ejb.16
        for <linux-ide@vger.kernel.org>; Mon, 09 Nov 2020 06:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9+UKQzgtuYMyW/SoLBP9eW/fTlDRQd3FvWyc619DNi0=;
        b=ofNld3wzsVDN3c6lsoctANLHPRfGymed8KI1lYClojV0Ru5CllyXgMlHsi0D2zJxpU
         Vqz5f8Jn1KMPXH6Ui1ogoBCBjBJyaa35n6m0o12R/G/OQkk6OIS8ht49qH4DUQ753IFr
         yXnbYsRnZGP9vNP0lC5Soc+xr6NZBqdGg7lzq5HaOQiwomXW52BrVkm1w1oC1lTCxkm2
         b6wcGiwOYSzN8UIZVGw1MDCwi8BgoqJKEqQ7VWV/VIYwugoDEl/RMe++tut22U1oiWe4
         eyDkLqnldWJdy4zd5n+vI370HQNWP31VgF9PmrNjibnxUJJ9fZsELiEuPPZIKmldGVlu
         hmpg==
X-Gm-Message-State: AOAM530cgGZf5EdCWPF6Vp4kNUk/8sE3TaZqeF1JuGYQzKPP/SeL4810
        1OhDWCtZ554mlfpGc87YzyV9BQRs+XH5tnHSA9fP8s7V0XZCwtUkpkCi6ZhxEL+0GMKdE/NMdmy
        4H3sxAztjvt63Wnw1c6Sk
X-Received: by 2002:aa7:d599:: with SMTP id r25mr14877803edq.280.1604930459946;
        Mon, 09 Nov 2020 06:00:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfNo4nDfbngeabQIMVcUapycE4qgM2KZLqawKsUA5teTo9BtvSSvPibXOweDelEQCXirQs/w==
X-Received: by 2002:aa7:d599:: with SMTP id r25mr14877784edq.280.1604930459724;
        Mon, 09 Nov 2020 06:00:59 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id n12sm3949807ejs.19.2020.11.09.06.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 06:00:59 -0800 (PST)
Subject: Re: [PATCH v2 3/9] ata: ahci: custom irq init for host init
To:     sven.auhagen@voleatech.de, axboe@kernel.dk, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <20201104155237.77772-1-sven.auhagen@voleatech.de>
 <20201104155237.77772-4-sven.auhagen@voleatech.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <db4c68b0-d5c3-c410-052a-99a9decef552@redhat.com>
Date:   Mon, 9 Nov 2020 15:00:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104155237.77772-4-sven.auhagen@voleatech.de>
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
> Disable the platform irq init in ahci init platform host
> if it was initiated by a custom function.
> To check for it I am using the AHCI_HFLAG_MULTI_MSI flag.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>

The code is fine here. But I'm not entirely happy with
the commit message how about:

"""
ata: libahci_platform: Do not try to get an IRQ when AHCI_HFLAG_MULTI_MSI is set

When the ahci-host AHCI_HFLAG_MULTI_MSI flag is set then the driver must provide
a get_irq_vector callback and take care of getting the IRQs itself. So in this
case ahci_platform_init_host() should not try to get an IRQ itself.
"""

With the commit message updated to the above (or something similar) you
may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I've also just given you my Reviewed-by for patch 4 and 5, and the
result already has a Reviewed-by.

So if you can sendout a v3 of this series with the commit message for
this patch fixed, then it is ready for merging from my pov.

Regards,

Hans


> ---
>  drivers/ata/libahci_platform.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index de638dafce21..f6f2a111d226 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -581,14 +581,16 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  	struct ata_host *host;
>  	int i, irq, n_ports, rc;
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "no irq\n");
> -		return irq;
> -	}
> +	if (!(hpriv->flags & AHCI_HFLAG_MULTI_MSI)) {
> +		irq = platform_get_irq(pdev, 0);
> +		if (irq <= 0) {
> +			if (irq != -EPROBE_DEFER)
> +				dev_err(dev, "no irq\n");
> +			return irq;
> +		}
>  
> -	hpriv->irq = irq;
> +		hpriv->irq = irq;
> +	}
>  
>  	/* prepare host */
>  	pi.private_data = (void *)(unsigned long)hpriv->flags;
> 

