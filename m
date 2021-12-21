Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535E9C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 02:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhLUCMB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Dec 2021 21:12:01 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22430 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhLUCMB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Dec 2021 21:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640052721; x=1671588721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1mYZHjSDCP8vzdBYhvhCE1szrN/8Vt0SAmcm/UORrb8=;
  b=Jj097gVyrUnXNjZu4p7WzupDOKrcz6ZRWMYIR8U4vKQJsWJr1mIZSuaZ
   /puUe3HQejkP4C76J9xNxUXs3VA9m4yeQeeqUZjeLoeQFXMOc6m4z4Lf5
   OBGsqdM0XPrGnWh3eh4hAinjVV/MQk/R9AzxFy8oheRQF3uZqFycFW/YM
   5pwc7G8Yi4h3s6i6v+P/C9y7o8sRMsolSfx9Rh77rG7LyxAWPeauzkvAX
   Itk7Je0jzXbcSP6UvNm4TMFbT2j76oDANWzllJqRzLD9ox8wKgxuHNIsO
   w0lfcS5L7mA5n8rLn3pUEj1GeulFIhwmCAmunpNwCaMqi2Sx1bbaQSMBt
   A==;
X-IronPort-AV: E=Sophos;i="5.88,222,1635177600"; 
   d="scan'208";a="292742808"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2021 10:12:00 +0800
IronPort-SDR: IIbhsECzSAfydi5FDKEA7gf/pldfqarhD1hOiQzKoXU2unNiltR141iQ1Au3wy+ymYIqf+7k60
 DR58MgsN0nMrEMi4TM2qdNOyqAJtg5c6E8sThEg990lPPF/u7HsduVwObef0Z7jmsvlcIYULU1
 MMfcY9+HubVQeSV6yaIkt0stGA0INsFw1RU4BYSfFQ3izbb8EcwkgINYAt7RwQ5La0wNAbkUsm
 Xu8b/NMXBZghZF/lSYpYY8jrIVBbNnetKTkneazq5EsuBj5FIPW31DnJ6PLeGkmPZJM3ir2Bjo
 yBnhzS/jhqbAao7F7qy23YGY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 17:46:16 -0800
IronPort-SDR: qu9LEN3t/wSdON0/YwWQ2+wbyq/1UXMwsecUCeGnagIKr7QOc7iTnb9OH8njKEQItqVU5Ft4Rh
 CgrG0I5qNpTufw5qlrjnlhCpjNd6BIqne7OLh+m83vgzOrILA05aa9Pj148LrwXzLAqk5G8Nse
 GRO1hFpKDFceqIZvNgu3JZGFYoHLM0J/JrGQ9IBNZ8ZhgAytguBiVt0K23tK3vDFC6qYTZGHzk
 USFQMC7Hl5f/rNOcBqu1Gooz+eykQQw0Xd3pdqGLpVrgF4MhtJo0vtvCc7sZURSsKrZCiKtKyl
 7Uc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 18:12:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JJ0MN44RRz1RwFN
        for <linux-ide@vger.kernel.org>; Mon, 20 Dec 2021 18:12:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640052720; x=1642644721; bh=1mYZHjSDCP8vzdBYhvhCE1szrN/8Vt0SAmc
        m/UORrb8=; b=E+BDG7LVgzI66y+b7YrV8gvUy5W+O1I70O9t5cp2gkWNXrEKw9i
        uDLS6At3BpShpzq5DwWTlSu0AJizmJktKDnIXcrd4lyNyMSkHPY3zugwOxKFnTyd
        EIq2BbtaB7N4jAk799zssOaZVS36fJhPkug98DqoanN5z2/ofU6Hnrvb0ECD56JH
        2bD+Nc8MGVTkOxSNMfaEWXMiu4JpVOBnfCEypkCerA+z/5hxMOA/5WCIm8j/7tqD
        r3EcP1WwE5rD0b2VfUOcG2wXN2TSWPmnYS4YKKz76UWZdH1Fa63ziT9IA4SeVrKZ
        hqpNjmYhF7du+ifuGX+Mg2ViR7EXifYEwDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ALbJ_ckYjfy2 for <linux-ide@vger.kernel.org>;
        Mon, 20 Dec 2021 18:12:00 -0800 (PST)
Received: from [10.225.163.32] (unknown [10.225.163.32])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JJ0MM2WXpz1RtVG;
        Mon, 20 Dec 2021 18:11:59 -0800 (PST)
Message-ID: <d557af74-b166-7365-3949-57c6e1a6d132@opensource.wdc.com>
Date:   Tue, 21 Dec 2021 11:11:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/1] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211217112832.69875-1-andriy.shevchenko@linux.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211217112832.69875-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/17/21 20:28, Andy Shevchenko wrote:
> platform_get_irq() will print a message when it fails.
> No need to repeat this.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: left !irq check untouched (Damien, Sergey)
>  drivers/ata/libahci_platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index bfa267e6f045..18296443ccba 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -579,11 +579,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  	int i, irq, n_ports, rc;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "no irq\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  	if (!irq)
>  		return -EINVAL;
>  

Applied to for-5.17. Thanks !

-- 
Damien Le Moal
Western Digital Research
