Return-Path: <SRS0=hcVH=V4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62827C32751
	for <linux-ide@archiver.kernel.org>; Wed, 31 Jul 2019 12:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4012120693
	for <linux-ide@archiver.kernel.org>; Wed, 31 Jul 2019 12:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGaM3l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:29:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40474 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfGaM3l (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jul 2019 08:29:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so65514752eds.7
        for <linux-ide@vger.kernel.org>; Wed, 31 Jul 2019 05:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cWhYbpDrUuUf9tzgnGr7N/5jeQPjNFxyJaniFBQ/ZdE=;
        b=XE+BtHOGwQfYX76uJ7Iqkayen7blqYW9yhZANePqNDs5tG7j4/lFbz1ujNold9VQfw
         WRKjOzq6WWPksrkx59iEXEVDcFWwZT/2AH9OtwmUNoH012bbcCsVfvKp6z0bw4jTHN4c
         mmxgVmBIgAqvI6Vk3DzkKSmYRbsrA13W8VGp0o0af9/I1U5pqSP1jESRzRj962vv9/Cn
         BLFPWcIW0LdJcyzwqXr37RLkZXUzAvCVBi8NzkpqdVSuQjISh/20COJ7wR6KIGLB4IOT
         W7kWOjhizyzBxbtMdMPZXsTOJkfRQl8l8P5ss7Y+nCB8uvlRicDZAoMjv46k9XIHeLqC
         V/lA==
X-Gm-Message-State: APjAAAUOzFOg9jCaGdoO2KOCOMUkNOIQSpszLiSQCAm54qRIbMcqaPZ6
        SjFQiBvm3LCSjaMmGGGRxwEtUUqiK8s=
X-Google-Smtp-Source: APXvYqz5L9AtSUiSDZDSU3Ec4l1DdhhnlyLpT1WuuySh8zNip8KXA6PeFuGGBVGC/6qMt+KdqwF4Yw==
X-Received: by 2002:a50:95a1:: with SMTP id w30mr107329357eda.177.1564576179723;
        Wed, 31 Jul 2019 05:29:39 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h10sm17334351eda.85.2019.07.31.05.29.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 05:29:39 -0700 (PDT)
Subject: Re: [PATCH] ata: libahci: do not complain in case of deferred probe
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org
References: <20190731122651.3378-1-miquel.raynal@bootlin.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <defc93ba-5a7f-d568-5a2a-f2b7c4e3690f@redhat.com>
Date:   Wed, 31 Jul 2019 14:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731122651.3378-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 31-07-19 14:26, Miquel Raynal wrote:
> Retrieving PHYs can deffer the probe, do not spawn an error when
> -EPROBE_DEFER is returned, it is normal behavior.
> 
> Fixes: b1a9edbda040 ("ata: libahci: allow to use multiple PHYs")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/ata/libahci_platform.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 72312ad2e142..c25cdbf817f1 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -338,6 +338,9 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
>   		hpriv->phys[port] = NULL;
>   		rc = 0;
>   		break;
> +	case -EPROBE_DEFER:
> +		/* Do not complain yet */
> +		break;
>   
>   	default:
>   		dev_err(dev,
> 
