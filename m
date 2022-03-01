Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E93C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  1 Mar 2022 10:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiCAKnS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiCAKnR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2022 05:43:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F42C21AC
        for <linux-ide@vger.kernel.org>; Tue,  1 Mar 2022 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646131355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8A5OtxkczfYcacviZFl/lBLkt8cByyhfx0j2HTJtBH4=;
        b=JTxuTCRBirc55ao4DS38ydzrVGTw/SDiMRHaKGzwH/kGW6FM1UzRfSjNrlpnWuq178em3Y
        aUM9L4AXIDETmIHvkYqfkYF/LZdMPiMoz7RsanGt7JdyGD3Fw0MrLdKLQw8+P0WNOhigKv
        jk8GCV1O9aFayTle447p566c2Gyo0Pc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-4an4-BXoPgKXE_0aZTsX1g-1; Tue, 01 Mar 2022 05:42:34 -0500
X-MC-Unique: 4an4-BXoPgKXE_0aZTsX1g-1
Received: by mail-ej1-f71.google.com with SMTP id oy15-20020a170907104f00b006d6a18ab439so2720081ejb.12
        for <linux-ide@vger.kernel.org>; Tue, 01 Mar 2022 02:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8A5OtxkczfYcacviZFl/lBLkt8cByyhfx0j2HTJtBH4=;
        b=gGxjilXmfLNYD8eg5eckd9VtVxPiWI2mVdeXEnyyW8VBdLgT9CUrtnrzLYwvlthAqw
         Ak23uPXEQN1OmctTr0v3r0GEvt4IKeF/KFCp++zgnEcAApHtnhpG2YG8CZM1swf/BUqC
         CJqyqa94SLDqUtX5x6fdOIwqq5l8ni7DvZKDE+OM9FHIU1Isv4JScd+355Og8mQdrG7o
         tXHzEEiRJc/lJ/6o39b5h3jXgOFVaTn3AXNz8e5urHV/FYFGNpgIRDw8nDLlONpFwZRx
         VjP9tSSfeXnrB0+5/N8ONHM4tfVyqKsXVfNpbZPE6Ge5gdaqjhmsIQ3XkpuMfRQXGqI+
         Fsrw==
X-Gm-Message-State: AOAM531eMn14aKnZpuYUd3jRLmwb1J4kObv/WsAHDBEf6+1dacfRxm72
        ZsAmHESahX3ypUKX+JWPettaXvLFAsGJcL6ThYKExX7lM+DMpBM8UVuj6JK6JnqY1vYKElzHB7g
        YCS7zBcSt0dC6x3VxGCDt
X-Received: by 2002:a05:6402:845:b0:412:ad14:863e with SMTP id b5-20020a056402084500b00412ad14863emr23959721edz.380.1646131353417;
        Tue, 01 Mar 2022 02:42:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzogE2u6NQu+4q0ZdJGdPrDMHERcNJvQyX44NVgti8SbKFON5h23iuLW6O8K96++Z4QvZPumQ==
X-Received: by 2002:a05:6402:845:b0:412:ad14:863e with SMTP id b5-20020a056402084500b00412ad14863emr23959702edz.380.1646131353059;
        Tue, 01 Mar 2022 02:42:33 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id g21-20020a056402115500b00413c824e422sm1788061edw.72.2022.03.01.02.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 02:42:32 -0800 (PST)
Message-ID: <5bb89e60-91ab-3d20-4ea8-86fd50925b9e@redhat.com>
Date:   Tue, 1 Mar 2022 11:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] ata: ahci: Protect users from setting policies their
 drives don't support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220228213302.2915071-1-mario.limonciello@amd.com>
 <20220228213302.2915071-2-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220228213302.2915071-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 2/28/22 22:33, Mario Limonciello wrote:
> As the default low power policy applies to more chipsets and drives, it's
> important to make sure that drives actually support the policy that a user
> selected in their kernel configuration.
> 
> If the drive doesn't support slumber, don't let the default policies
> dependent upon slumber (`min_power` or `min_power_with_partial`) affect the
> disk.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Changes from RFC v1 -> PATCH v1:
> * Move the warning and protection from drives that don't support slumber further
>   into the calling path.
>  drivers/ata/libahci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 0ed484e04fd6..9dee721ed1fe 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -785,7 +785,15 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  		pp->intr_mask &= ~PORT_IRQ_PHYRDY;
>  		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
>  
> -		sata_link_scr_lpm(link, policy, false);
> +		if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
> +		   !(hpriv->cap & HOST_CAP_SSC)) {
> +			struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +
> +			dev_warn(&pdev->dev,
> +				 "This drive doesn't support slumber; ignoring SATA policy\n");

Not sure if completely ignoring the policy here is a good idea. IMHO it would
be better to fallback to MED_POWER_WITH_DIPM at least for the haswell - skylake(++++)
generations having MED_POWER_WITH_DIPM is important to allow the package to
go the higher PC states.

> +		} else {
> +			sata_link_scr_lpm(link, policy, false);
> +		}
>  	}
>  
>  	if (hpriv->cap & HOST_CAP_ALPM) {

Regards,

Hans

