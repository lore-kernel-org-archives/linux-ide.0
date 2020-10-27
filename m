Return-Path: <SRS0=ctpL=EC=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599D6C388F9
	for <linux-ide@archiver.kernel.org>; Tue, 27 Oct 2020 13:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C052074B
	for <linux-ide@archiver.kernel.org>; Tue, 27 Oct 2020 13:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGBvuAW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503815AbgJ0Nyo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Oct 2020 09:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503725AbgJ0Nyo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2020 09:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603806882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xq9zJB+jTHF1Ao/Vk53ndQQTAJYernihVo37z7lC1Gc=;
        b=cGBvuAW19bwG9SNOF4U2W31771DjzMGp4h0PqXmm7fvc9ufGgwUY0pml2j+xBKccVWjNdV
        N64+KGFmiP1mp9is9l3SUCuePcQF4zn6Edqq1ltxLgzpKBzsYNxSmZh8P8S1tvMQeN8BMv
        rAeCu5IgskBf1EBHTlrY2iuHg7q4Slo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-WxG76qNJPaitR_IXqRuuow-1; Tue, 27 Oct 2020 09:54:41 -0400
X-MC-Unique: WxG76qNJPaitR_IXqRuuow-1
Received: by mail-ed1-f71.google.com with SMTP id a73so695685edf.16
        for <linux-ide@vger.kernel.org>; Tue, 27 Oct 2020 06:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xq9zJB+jTHF1Ao/Vk53ndQQTAJYernihVo37z7lC1Gc=;
        b=E8fx9jbCGGp1e7EWzhhQv1OcbGETevxla8rL6MjeQ26BUcACxKVBtsL2POK/LKBffj
         sQbYt0f665Kpi7qsMLsRuZ7huBTKMPuKU6AFQFOmXnxs/x5scAR59pqkB+3vu+/gg8nr
         XHSHEwy2xDi7dr7LGgZjrhagwL8C3iLvCMaakK+sPFjyhVaTsjtKtO7uC180BbbXJbmz
         VOC9DHIGsl82xKtbacDewqqf/Sn8n2VkUHV9BEz3LYImMeHR3JEqAIbYyoZroKecbp3V
         2XtXQ2rVEK5G9XvT4vE3N0EChPlIb/rlGLAe16IfLuQEl8ULImhHb5AvBE5sbWQ9m67h
         qeAw==
X-Gm-Message-State: AOAM533kgJBeTc3ZFPf2GFQv83R3Nt2rm7jCeOae6Zk7+F/iZsOApd1M
        ubxYZQzxLdQb4XxBJOLZdXlyvFz/l1QTb1wUebyWFzFzWiDtqGBW7/rmBZwSFUN7cUjkiooCdjQ
        oXKXsEOkOI+qKkPmFBDmC
X-Received: by 2002:a05:6402:6d0:: with SMTP id n16mr2376714edy.133.1603806879288;
        Tue, 27 Oct 2020 06:54:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweW4U75R8C6XbhnmHVWmHcpssVe3Ijevw/dLSMoYLh3pGHHtF7QoIJhS0WzbWQfLDmTafXMg==
X-Received: by 2002:a05:6402:6d0:: with SMTP id n16mr2376687edy.133.1603806879095;
        Tue, 27 Oct 2020 06:54:39 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id c3sm1025907edl.60.2020.10.27.06.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 06:54:38 -0700 (PDT)
Subject: Re: [PATCH 1/7] ata: ahci: mvebu: Rename a platform data flag
To:     sven.auhagen@voleatech.de, axboe@kernel.dk, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <20201007154554.66650-1-sven.auhagen@voleatech.de>
 <20201007154554.66650-2-sven.auhagen@voleatech.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6974d0f5-e600-d495-e132-9d3efbd4fd82@redhat.com>
Date:   Tue, 27 Oct 2020 14:54:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007154554.66650-2-sven.auhagen@voleatech.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 10/7/20 5:45 PM, sven.auhagen@voleatech.de wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Before adding more entries in the platform data structure, rename the
> flags entry to be more precise and name it host_flags.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/ata/ahci_mvebu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
> index d4bba3ace45d..43bb2db59698 100644
> --- a/drivers/ata/ahci_mvebu.c
> +++ b/drivers/ata/ahci_mvebu.c
> @@ -30,7 +30,7 @@
>  
>  struct ahci_mvebu_plat_data {
>  	int (*plat_config)(struct ahci_host_priv *hpriv);
> -	unsigned int flags;
> +	unsigned int host_flags;
>  };
>  
>  static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
> @@ -196,7 +196,7 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
>  	if (IS_ERR(hpriv))
>  		return PTR_ERR(hpriv);
>  
> -	hpriv->flags |= pdata->flags;
> +	hpriv->flags |= pdata->host_flags;
>  	hpriv->plat_data = (void *)pdata;
>  
>  	rc = ahci_platform_enable_resources(hpriv);
> @@ -227,7 +227,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_380_plat_data = {
>  
>  static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
>  	.plat_config = ahci_mvebu_armada_3700_config,
> -	.flags = AHCI_HFLAG_SUSPEND_PHYS,
> +	.host_flags = AHCI_HFLAG_SUSPEND_PHYS,
>  };
>  
>  static const struct of_device_id ahci_mvebu_of_match[] = {
> 

