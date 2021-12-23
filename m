Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B8C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 23 Dec 2021 00:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhLWAon (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Dec 2021 19:44:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:12454 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbhLWAon (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Dec 2021 19:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640220281; x=1671756281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A8CRIoe5sRDp9RHnUg7XpgF/2koGCEaw4oVfdXymJwg=;
  b=E/blVLUhOasNnKo5+Fjap1f9Ts7axN+nQiBsx/TwcyGKZoFhc0DvrTgR
   /yMhyWXImBmavrDIs3QZFeAIwdNWdwp+yvb5yCl7qK6lzvaIg7gmB9VBT
   3moUB7jnWRTqufyRcWVJ/4LVmJdERaxDeVUi0myC2rI5O5fgvrBNAkViY
   pytbE9eOR8Z4G0Cb8FVF2UxOAO483KdlBgXDGa5zEd0LCQlRf2PikVvQh
   XZOKw7tEEZYlCRSnR3fe8kJHmljRjngsosxQb8Ty3cMnopyEw9C5vRzBg
   55Rfbtnp9NyW2aM/EI5T36T696p9yrROhYIthU9wReKRws2O3l1IvUByq
   A==;
X-IronPort-AV: E=Sophos;i="5.88,228,1635177600"; 
   d="scan'208";a="193703517"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Dec 2021 08:44:41 +0800
IronPort-SDR: R8GfQEtEdv8kZd84apb/NHXu+WBhlR7NVvsIkSFJslSJcWWHhOr/661LSMrEmuKWvJjmmm5Q8i
 VIrB/tNOh1RXC7Jg5rANxGnD21QR68cfGE0KEIKkwejYjhmKyDoyyIdQuzLP823Dkkd7H5ra7o
 XOVnEsF9CMjuQY1Vd0SlIka5V+oo3BXxPIKCzmY6922a6xyIQsCbQB/9N+vwC6Q5aFpQHTsU19
 3Nf2V3AStJ8DE6tZ/5I/LVnc3ToWVY1QBKS2T2oJ9qgeVkpYpA/1uEOCSQeR3TNAb0kGKjCWHK
 poJmSAGp/cunCQZ3C4zQZj/D
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:18:55 -0800
IronPort-SDR: uBeqeyOfJ5MEpJk1AiBFBtMMNun5I0XiqiyhvTtX3LMv5MqGkWoGKV3KUMEelSE4oxo8gImH4a
 d1bc3ejCuBmhYUQHaZEQJ/0+ah3jjT9TLzaq6EwIe07kDc57QYKS6qH5kUVEoo+rnfIhJVFXSO
 /bkSQ+TdT76ktdFocmhYX5J3JbWkTunqQAMDPzAjZoyCpqI8Nw66iF6sBigE1mY/qIVOv+veR1
 23HuaDZ+iFvrTbTQa5PnIP5KqSWfWXlFWyNE6bElTxYFfL6fa35LtX4Qx4kDd3micDXQ0FUUJk
 VSc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:44:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JKBKk4Mx7z1RwFN
        for <linux-ide@vger.kernel.org>; Wed, 22 Dec 2021 16:44:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640220282; x=1642812283; bh=A8CRIoe5sRDp9RHnUg7XpgF/2koGCEaw4oV
        fdXymJwg=; b=KXDvzmQ6b2GgWc7mGXI6teW8lRE4cPdb4/2OLvcJzPtrcUE4LAl
        mAtNHp1FChyfsM+td5CrgvDvvzmVRI1WWWiEwuDRqVIq7Bvruwj28mF1oR5tSxKW
        2+DqIuG1M5rdo7gsNfl+CrElOQsXQH8UmSEePuuxXUXpQh0PhbJsDdmuulFNdHrt
        /aCzBvZIdB70//XuPKVZWHhZBR9FZF6q065a9aL/U9Qtro9xGbPqIVqvEBI2JHzE
        kGy1EwrrCtCQZZFIkLS99YCBmFQbS/KTQzGsls1d+0eJWGptx/Yd2EpxDSmncvTB
        N9OHc/rZS/4WuHZ7m7rm/htbiovXSFcZlCg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xE19pAi71Hh9 for <linux-ide@vger.kernel.org>;
        Wed, 22 Dec 2021 16:44:42 -0800 (PST)
Received: from [10.225.163.35] (unknown [10.225.163.35])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JKBKj1d4pz1RtVG;
        Wed, 22 Dec 2021 16:44:41 -0800 (PST)
Message-ID: <c31cd71c-901b-27b5-8054-fcf576533590@opensource.wdc.com>
Date:   Thu, 23 Dec 2021 09:44:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ata: libahci_platform: Remove abundant check
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, hdegoede@redhat.com,
        axboe@kernel.dk, p.zabel@pengutronix.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211222072446.1096168-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211222072446.1096168-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/22/21 16:24, Jiasheng Jiang wrote:
> It can be found that platform_get_irq() returns nagative code but not
> null when fails.
> The comment of the platform_get_irq clearly shows that.
> Therefore it should be better to remove the useless check.
> 
> Fixes: fd990556f0fa ("ata: move library code from ahci_platform.c to libahci_platform.c")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Another note: please use scripts/get_maintainer.pl to see to whom you
should address patches. This one was not addressed to me.

> ---
>  drivers/ata/libahci_platform.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index b2f552088291..5ec68f138c28 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -587,8 +587,6 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  			dev_err(dev, "no irq\n");
>  		return irq;
>  	}
> -	if (!irq)
> -		return -EINVAL;
>  
>  	hpriv->irq = irq;
>  


-- 
Damien Le Moal
Western Digital Research
