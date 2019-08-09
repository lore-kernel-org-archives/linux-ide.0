Return-Path: <SRS0=yb+g=WF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682CCC31E40
	for <linux-ide@archiver.kernel.org>; Fri,  9 Aug 2019 03:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BDC2173E
	for <linux-ide@archiver.kernel.org>; Fri,  9 Aug 2019 03:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bjQlBWig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbfHIDqJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:46:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45943 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfHIDqJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Aug 2019 23:46:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so2288752plr.12
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2019 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sBIKQXIXKWp+Zjgwd6msZBJ52uKa+ld5yJbKwfV5h4I=;
        b=bjQlBWigP4K5lgayTQypHC706lxWKPtL8vHp1fqDYj27SubbZwEyl9D6hvI0i1H2mq
         XaJuEnV8HtiNlcyfCnZ1FPewHmIYgI3UtuZfaPuJ09mHBEv0wua479K+ztrjOdq/RQ9U
         ZaaQTb36DLXYNUTQlG58+zQY+BGrjS6zhZYK2vw1Gv6b94dqJ76lCxZKydhmHRZB55B7
         O4FaysqKf/E1HNKLGnc1xVCl42uis5Z906TLxVkADY+7Fi3s86dUdh1MurqVQlqNaKJr
         Qk13c/A2Y/PoWY4YOKFUhksIq1ELFt99LdjL80pp27/377B65hDM/y5csAFwRPFIvO8W
         a4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sBIKQXIXKWp+Zjgwd6msZBJ52uKa+ld5yJbKwfV5h4I=;
        b=EJ/sU+gJS+WC+rfCDcosUk2lIyzZmYwUsQDKto8k/vTRv3Rh/ZC615I7TTcHlEJfo+
         ASx8tcxrQcIiUEMytOcJVy8cGsitXfcZezGvb83hz+8Hc0X6iWgeIxUcfeE60PazHaXF
         oajnWKq5FuO1eJGYhdJVL+wp6aVqn3b7KuRoJuubs7AemKWE/swNPVqr/GM9yEKFkZ+s
         caSlBcv3EcvTO1vcB2JJA6VpdvJZ16CDdFqMR47OOhUBPw0HHM2BueyDYoGDAW5Nsmq/
         oW71vveyF0hmzZ5j2CC3QsbgoXa3q8VGFBrovqLSeORPzV3Mhy6FJv5FF6uFR/pRIS/n
         iOog==
X-Gm-Message-State: APjAAAWhdbVxVH4NjfDp2CeEoye+9ZT0QrE9sYP27cw+1W1xzCAHCEj8
        EDgdqttAaZ4Rr0kKUDGBJFw0vQ==
X-Google-Smtp-Source: APXvYqxI+RKnidAtOJ/bKsv4NjNBqz4XEdw3DDJ1+yV3o43pfqKZAroBH9TjPA1VNSG0ZFVBmqv84w==
X-Received: by 2002:a17:902:567:: with SMTP id 94mr7654280plf.228.1565322368499;
        Thu, 08 Aug 2019 20:46:08 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:3965:6e7a:8c2:c21b? ([2605:e000:100e:83a1:3965:6e7a:8c2:c21b])
        by smtp.gmail.com with ESMTPSA id s66sm101040116pfs.8.2019.08.08.20.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 20:46:07 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device
 ID
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20be9bbb-5f09-c048-d98d-7398657c0c8f@kernel.dk>
Date:   Thu, 8 Aug 2019 20:46:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808202415.25166-1-stephend@silicom-usa.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/8/19 1:24 PM, Stephen Douthit wrote:
> Intel moved the PCS register from 0x92 to 0x94 on Denverton for some
> reason, so now we get to check the device ID before poking it on reset.
> 
> Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
> ---
>   drivers/ata/ahci.c | 42 +++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index f7652baa6337..7090c7754fc2 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -623,6 +623,41 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>   	ahci_save_initial_config(&pdev->dev, hpriv);
>   }
>   
> +/*
> + * Intel moved the PCS register on the Denverton AHCI controller, see which
> + * offset this controller is using
> + */
> +static int ahci_pcs_offset(struct ata_host *host)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host->dev);
> +
> +	switch (pdev->device) {
> +	case 0x19b0:
> +	case 0x19b1:
> +	case 0x19b2:
> +	case 0x19b3:
> +	case 0x19b4:
> +	case 0x19b5:
> +	case 0x19b6:
> +	case 0x19b7:
> +	case 0x19bE:
> +	case 0x19bF:
> +	case 0x19c0:
> +	case 0x19c1:
> +	case 0x19c2:
> +	case 0x19c3:
> +	case 0x19c4:
> +	case 0x19c5:
> +	case 0x19c6:
> +	case 0x19c7:
> +	case 0x19cE:
> +	case 0x19cF:

Any particular reason why you made some of hex alphas upper case?

-- 
Jens Axboe

