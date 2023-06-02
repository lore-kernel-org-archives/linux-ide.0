Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816F6C7EE2A
	for <linux-ide@archiver.kernel.org>; Fri,  2 Jun 2023 05:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjFBFEz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 2 Jun 2023 01:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjFBFEp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2023 01:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC46F1A6;
        Thu,  1 Jun 2023 22:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ACA064C1B;
        Fri,  2 Jun 2023 05:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1382C433EF;
        Fri,  2 Jun 2023 05:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685682283;
        bh=ksCxfJN+aHbHF2OgbiQ4Oveg146c/X4lqmXA6kgRpNY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZyOi/wLM3CDczJl+MEluL+INoSUCjtvbJnRPPimgpxDGIFDGBo/HQ4xJxCeEv+w8J
         b1/OTrw/zbNYuAWvjMwWTmTwXciQq/fenDDdcQevAASJB2evjvSRDAYSvteWvSxc2t
         KOqnuaGWwOmHLjVzOmFtymVRdfsYKznwGS4lPZ/wvLgxrBgqEZR3u/J9mTUWUYLgZf
         6Hg5pl/zrQnkoeKDY80czMK2bEBR1HHAExDOwByAbE86yrEZMAwvQ++iqIyEQMgFoz
         O51yNQIrUtcIsZZBFWYm78Uf/WrHkfn+puyXLeuHfvnqv8c6O8+d7Sn9QM12gurxwU
         Ns17qtcPxUpow==
Message-ID: <67f889a1-93ee-0c69-39d9-34e84ade7338@kernel.org>
Date:   Fri, 2 Jun 2023 14:04:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 38/43] pata: cirrus: drop legacy pinctrl
Content-Language: en-US
To:     andy.shevchenko@gmail.com,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-20-nikita.shubin@maquefel.me>
 <ZHlLbzK5exaVzaPj@surfacebook>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZHlLbzK5exaVzaPj@surfacebook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/2/23 10:52, andy.shevchenko@gmail.com wrote:
> Thu, Jun 01, 2023 at 08:45:43AM +0300, Nikita Shubin kirjoitti:
>> Drop legacy acquire/release since we are using
>> pinctrl for this now.
> 
> ...
> 
>>  	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
>> -	if (!drv_data) {
>> -		err = -ENXIO;
> 
> Wondering why it's not ENOMEM even in the original code?

Indeed...

> 
>> -		goto err_rel_gpio;
>> -	}
>> +	if (!drv_data)
>> +		return -ENXIO;
> 

-- 
Damien Le Moal
Western Digital Research

