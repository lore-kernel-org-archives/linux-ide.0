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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185DFC388F9
	for <linux-ide@archiver.kernel.org>; Tue, 27 Oct 2020 13:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AF02074B
	for <linux-ide@archiver.kernel.org>; Tue, 27 Oct 2020 13:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVNO1js2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900850AbgJ0NzD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Oct 2020 09:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2900849AbgJ0NzA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2020 09:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603806899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngy9t9+mZDVeXCahPtqT6RsIxpk8fj+GjpvS3FzPgDo=;
        b=QVNO1js2AGPl71Gb51EybzUSCWkMfF3FcEHgFjGsXXemF7QzC097zcRMEWW8PztHIzkYdc
        ZcBasi8QPKxN/j9fYq5CCxolk5IA8cYd15gdSUJiAo/+4d4uWhVh26qsuQOtRq6IWFmXsb
        ibmouXHnQ0Wc85aUTQmFWp7Af3kXoeU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-efN-ADJEO1CSJ9IQJ8YLJA-1; Tue, 27 Oct 2020 09:54:55 -0400
X-MC-Unique: efN-ADJEO1CSJ9IQJ8YLJA-1
Received: by mail-ej1-f70.google.com with SMTP id b17so873708ejb.20
        for <linux-ide@vger.kernel.org>; Tue, 27 Oct 2020 06:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ngy9t9+mZDVeXCahPtqT6RsIxpk8fj+GjpvS3FzPgDo=;
        b=W6y6JfoZ7rF2/rd5PDdH3jsDPdq8c55reOzdzdG0lj+b1WjoC+nF7JtBYLeN5k7PVk
         9ZZY8vsb6VKl4XpGAp4Tq4klf/4dNP00OCKcPwMULqa3KspFWK2KfI4PgpMPlRV1Tomn
         JWrhytomwyDz5JxuKBmd/lv4x2lQ0LskJPDVCpw4HrXJCsfA+zI4/vkRImx/Lvh9d9VR
         zHE9is0Yyo4E+TqUMidvcLoiidvypaZyX1ED7kpsmuFPEmUyRUjwwVYHB0j3rJ4RYTmT
         gxsbUXXENTyrv2bX8M6bK+R/XKzC7o798I/YA/duKdLGLsA0nXNmJ0Tl3+eFLSvAPrbf
         GY/g==
X-Gm-Message-State: AOAM533ODCrIE5w9+d1EmprSjfMv4VyHn7dK+tzXtZp+kylnMmiAM9Z8
        5ot2pmE17EFNe3aCRr8z2x7+1Sei1kAVnF7cpxBMGdH4uX5AunUUK28mdYCPWXcTgo8sEcykFSK
        E6VSkp0VMeC48NLaKxhVI
X-Received: by 2002:aa7:db07:: with SMTP id t7mr2433223eds.161.1603806894611;
        Tue, 27 Oct 2020 06:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOWMHIOJb9ZQeE/rAhdam2sVdYl3IBDyDW1OMzfCBuJWAVzpMjkn8z+c+E6aL/ohN3DVq4Ew==
X-Received: by 2002:aa7:db07:: with SMTP id t7mr2433197eds.161.1603806894417;
        Tue, 27 Oct 2020 06:54:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v14sm1082691ejh.6.2020.10.27.06.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 06:54:53 -0700 (PDT)
Subject: Re: [PATCH 2/7] ata: ahci: mvebu: Support A8k compatible
To:     sven.auhagen@voleatech.de, axboe@kernel.dk, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <20201007154554.66650-1-sven.auhagen@voleatech.de>
 <20201007154554.66650-3-sven.auhagen@voleatech.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fe603fd8-80e4-ac76-ae16-a00c2c9494e0@redhat.com>
Date:   Tue, 27 Oct 2020 14:54:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007154554.66650-3-sven.auhagen@voleatech.de>
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
> The ahci_platform.c driver was historically the one bound to the A8k
> AHCI compatible string, but before adding a quirk for this compatible,
> it is probably cleaner to put all Marvell EBU code in one place: the
> ahci_mvebu.c driver.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/ata/ahci_mvebu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
> index 43bb2db59698..1cdc126882eb 100644
> --- a/drivers/ata/ahci_mvebu.c
> +++ b/drivers/ata/ahci_mvebu.c
> @@ -96,6 +96,11 @@ static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
>  	return 0;
>  }
>  
> +static int ahci_mvebu_armada_8k_config(struct ahci_host_priv *hpriv)
> +{
> +	return 0;
> +}
> +
>  /**
>   * ahci_mvebu_stop_engine
>   *
> @@ -230,6 +235,10 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
>  	.host_flags = AHCI_HFLAG_SUSPEND_PHYS,
>  };
>  
> +static const struct ahci_mvebu_plat_data ahci_mvebu_armada_8k_plat_data = {
> +	.plat_config = ahci_mvebu_armada_8k_config,
> +};
> +
>  static const struct of_device_id ahci_mvebu_of_match[] = {
>  	{
>  		.compatible = "marvell,armada-380-ahci",
> @@ -239,6 +248,10 @@ static const struct of_device_id ahci_mvebu_of_match[] = {
>  		.compatible = "marvell,armada-3700-ahci",
>  		.data = &ahci_mvebu_armada_3700_plat_data,
>  	},
> +	{
> +		.compatible = "marvell,armada-8k-ahci",
> +		.data = &ahci_mvebu_armada_8k_plat_data,
> +	},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
> 

