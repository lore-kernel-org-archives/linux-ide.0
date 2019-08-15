Return-Path: <SRS0=tRDq=WL=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609B5C433FF
	for <linux-ide@archiver.kernel.org>; Thu, 15 Aug 2019 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E85F2064A
	for <linux-ide@archiver.kernel.org>; Thu, 15 Aug 2019 08:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfHOIzf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:55:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37214 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfHOIzf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 15 Aug 2019 04:55:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id f22so1548142edt.4
        for <linux-ide@vger.kernel.org>; Thu, 15 Aug 2019 01:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w12IhXmASUdChiniQIcmTiLoQtyHTC3MdMv6IJNT4MA=;
        b=WKKU/yhyWTr5P239YIvVa3oguutlv+dbMXMk3FQUVWaU3V2Pc+CA65MWzGkpiVuTns
         B8+t+5vNH/2HI7PAdyCj1X+PJlWuvVRrotAJ/+SikpQDB8QGaNUoJ6Vd1u/XA/2sjzGS
         F3y/K/UM1oU+GNk3N3oBTumR9G4Pox5sZpWHoEOBRrNxfTA7ocvHgsvGIP2RTVHVRgPq
         chNfOiqImOVXBjMZfSvnToNcinE+hzURY2Ll51HVxXBm7kb8TCYDOnh20rptQz3LCiGO
         UxI1o3SS8SX1QyKnwEgpNm20eb4IzJajcr1pzkfoCmyndSHAqMAS9d+Rxbuq9dk0W/QY
         tPyA==
X-Gm-Message-State: APjAAAWXrMazLV4D8NUeSDcjKFa0rlXqCXWJ5LfSoo5qdGTZC37Q9CcC
        lbXZ/qnskUwxuSBVeELjAWno/A==
X-Google-Smtp-Source: APXvYqzl3yjd2kRjc5l321gkj1B2VEL0uJrhSqt1nABxYa2F5oWs1PuPlbN+GvxvMFZAAkkS4RBhxA==
X-Received: by 2002:a17:906:7c4d:: with SMTP id g13mr2153637ejp.188.1565859334032;
        Thu, 15 Aug 2019 01:55:34 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id fk15sm294773ejb.42.2019.08.15.01.55.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 01:55:33 -0700 (PDT)
Subject: Re: [PATCH] ata: libahci_platform: Add of_node_put() before loop exit
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>, axboe@kernel.dk,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190815060014.2191-1-nishkadg.linux@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <159af6e4-90cb-bf10-8186-18f95f6a6f80@redhat.com>
Date:   Thu, 15 Aug 2019 10:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815060014.2191-1-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 15-08-19 08:00, Nishka Dasgupta wrote:
> Each iteration of for_each_child_of_node puts the previous node, but
> in the case of a goto from the middle of the loop, there is no put,
> thus causing a memory leak. Add an of_node_put before three such goto
> statements.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>

I really believe the for_each_child_of_node semantics are broken, see my
other reply. But that is no reason not to fix this, so this is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/ata/libahci_platform.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 9e9583a6bba9..e742780950de 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -497,6 +497,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   
>   			if (of_property_read_u32(child, "reg", &port)) {
>   				rc = -EINVAL;
> +				of_node_put(child);
>   				goto err_out;
>   			}
>   
> @@ -514,14 +515,18 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   			if (port_dev) {
>   				rc = ahci_platform_get_regulator(hpriv, port,
>   								&port_dev->dev);
> -				if (rc == -EPROBE_DEFER)
> +				if (rc == -EPROBE_DEFER) {
> +					of_node_put(child);
>   					goto err_out;
> +				}
>   			}
>   #endif
>   
>   			rc = ahci_platform_get_phy(hpriv, port, dev, child);
> -			if (rc)
> +			if (rc) {
> +				of_node_put(child);
>   				goto err_out;
> +			}
>   
>   			enabled_ports++;
>   		}
> 
