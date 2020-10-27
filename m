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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A00C388F9
	for <linux-ide@archiver.kernel.org>; Tue, 27 Oct 2020 14:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C5B2072D
	for <linux-ide@archiver.kernel.org>; Tue, 27 Oct 2020 14:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhgUqBIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901580AbgJ0OZB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Oct 2020 10:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S368340AbgJ0OY7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2020 10:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603808698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZIQtSRPpP7bzkDKojGKr85+f7UAm051h+6PAJvhRak=;
        b=NhgUqBIXOokB4C2Yc7JHjvoYnma7hIyVHfgNwRNOadj6Zx9oQkGM7+jvYZ9NTuG7V8nCcJ
        CBxEO9wUjxukalONPwDIzjknhmHckUssi8swQlC7t/OMqwaYiGBke6dJ5qJDNAPacF+3ju
        1GxeWe0aOQo+ohgOeoVgu75cQd45MvQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-jXRIQ8RrOcWLPJUisHhZ9A-1; Tue, 27 Oct 2020 10:24:53 -0400
X-MC-Unique: jXRIQ8RrOcWLPJUisHhZ9A-1
Received: by mail-ej1-f69.google.com with SMTP id c20so926121ejs.12
        for <linux-ide@vger.kernel.org>; Tue, 27 Oct 2020 07:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lZIQtSRPpP7bzkDKojGKr85+f7UAm051h+6PAJvhRak=;
        b=BT1alRRll5gxNwddX1su0g01oDN6oDb5u3+6g5xZiSbXC5GBqqR/F8jS81onFbx83+
         JJUQIX7Npn2iT3cU9hPc7iUWIzAMQPFFzv31vpq7Zokrl3YXh107rtE/w60BXxgbFUUs
         tCyyfatNy31FDXpUMND7MAUF/P+33jwKHNiDov0rclbl7iBT1QAf9HcoFT2deZfiqNDk
         PSLBzPJBcd2y69xc+A1sTqQsUw91nnadFYcA4YZtdjyTumqc6BhRzJPk0/lxnslSOhSH
         Jo/sfrUT1qMhgFAsq+UDSBylfV+Je26QJqCKOS4Q+X+hsXMsroLRM2QgACXKafwdXINB
         dNIA==
X-Gm-Message-State: AOAM532XJhYurSISdQXO9OPAcxPjdi4K55WGGlr6nr6KGrTbPc3O/xe4
        PCxA0TOtihcHv9G9ui9sUwjOgS02t5Sv/6J3WvvwKugUnGYp1XrORPTEKiKk5elNuZ+iH1dYeQF
        mVi5HZaRxdDTQAglCRzqh
X-Received: by 2002:a50:88e5:: with SMTP id d92mr2549989edd.145.1603808692524;
        Tue, 27 Oct 2020 07:24:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzApUcUk9SzoxZFdV+Ugcey7NYFu4EhTJ1o513dIeIc3FxXZD5QyjvKBq96p8qkWB9wFeMMfw==
X-Received: by 2002:a50:88e5:: with SMTP id d92mr2549968edd.145.1603808692276;
        Tue, 27 Oct 2020 07:24:52 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id yw17sm1147190ejb.97.2020.10.27.07.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 07:24:51 -0700 (PDT)
Subject: Re: [PATCH 4/7] irqchip/irq-mvebu-icu: Remove the double SATA ports
 interrupt hack
To:     sven.auhagen@voleatech.de, axboe@kernel.dk, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <20201007154554.66650-1-sven.auhagen@voleatech.de>
 <20201007154554.66650-5-sven.auhagen@voleatech.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fc09e06f-c1a3-d0c7-d906-35a9c6094f5a@redhat.com>
Date:   Tue, 27 Oct 2020 15:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007154554.66650-5-sven.auhagen@voleatech.de>
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
> When writing the driver, a hack was introduced to configure both SATA
> interrupts regardless of the port in use to overcome a limitation in
> the SATA core. Now that this limitation has been addressed and the
> hack moved in the (historically) responsible SATA driver,
> ahci_{platform,mvebu}.c, let's clean this driver section.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/irqchip/irq-mvebu-icu.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> index 91adf771f185..3e29f8d5b33b 100644
> --- a/drivers/irqchip/irq-mvebu-icu.c
> +++ b/drivers/irqchip/irq-mvebu-icu.c
> @@ -38,8 +38,6 @@
>  
>  /* ICU definitions */
>  #define ICU_MAX_IRQS		207
> -#define ICU_SATA0_ICU_ID	109
> -#define ICU_SATA1_ICU_ID	107
>  
>  struct mvebu_icu_subset_data {
>  	unsigned int icu_group;
> @@ -111,22 +109,6 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	}
>  
>  	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
> -
> -	/*
> -	 * The SATA unit has 2 ports, and a dedicated ICU entry per
> -	 * port. The ahci sata driver supports only one irq interrupt
> -	 * per SATA unit. To solve this conflict, we configure the 2
> -	 * SATA wired interrupts in the south bridge into 1 GIC
> -	 * interrupt in the north bridge. Even if only a single port
> -	 * is enabled, if sata node is enabled, both interrupts are
> -	 * configured (regardless of which port is actually in use).
> -	 */
> -	if (d->hwirq == ICU_SATA0_ICU_ID || d->hwirq == ICU_SATA1_ICU_ID) {
> -		writel_relaxed(icu_int,
> -			       icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
> -		writel_relaxed(icu_int,
> -			       icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
> -	}
>  }
>  
>  static struct irq_chip mvebu_icu_nsr_chip = {
> 

