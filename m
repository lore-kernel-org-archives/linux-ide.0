Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD66EB64DD
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jul 2023 23:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGYXE7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGYXE6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jul 2023 19:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC88CB6
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 16:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8F6661935
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 22:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C538C433C7;
        Tue, 25 Jul 2023 22:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690324113;
        bh=VQW91zDGUFzGQWY99BYtp0j+x/K1kSLT4CFwrhP7470=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nfa7jbM+vWLHrKdcTORa62EAPaeNiHefyN+cN8ey6LfTv8njYD7mton4S/t/GQVR+
         6K/xqr4a/Guiexzt56eYlgg+vXyH0U7RSGPQHba9VUjnuSS/LSA9Wg5DVEPrCw0qTO
         UfZB2lOrrlOsewVcUPjanH48j/TDAv54NukqwFIdkplIz4/KXtWqC81fTmfKUI/Kff
         +UyuOs180klH6tuJkOwB4VybEoT6eM2wdOFL+puqWErCOR2zqTQalc2uoEg38jCgUg
         zvQ2UvLRMpCukMyRx3PClYwGeLbemqaEJD+5ZzYF4zmftRQR+Xy/U2TNh5SWcwnzQl
         6+DvfJHN4QG0w==
Message-ID: <c87ef5da-e2d4-34b6-db3e-c547b97a5c90@kernel.org>
Date:   Wed, 26 Jul 2023 07:28:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: pata_octeon_cf: fix error return code in
 octeon_cf_probe()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
Cc:     robh@kernel.org
References: <20230725122809.521331-1-yangyingliang@huawei.com>
 <373ece73-6089-f60a-6db5-5a18880c12a6@omp.ru>
 <cb55c4e9-6021-635c-d077-c516200a34f5@omp.ru>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <cb55c4e9-6021-635c-d077-c516200a34f5@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/26/23 00:20, Sergey Shtylyov wrote:
> On 7/25/23 6:19 PM, Sergey Shtylyov wrote:
> [...]
> 
>>> The 'rv' will be set to 0 after calling of_property_read_reg(),
>>> return correct error code in the error path.
>>
>>    Thanks for catching this!
>>    It also means tht the initializer for 'tv' is pointless.
> 
>    Sorry, 'rv'. :-)
> 
>> A material for a clenup, I think...
> 
>    Might as well do it here... Damian?

I will clean it up when applying.

> 
>>> Fixes: d0b2461678b1 ("ata: Use of_property_read_reg() to parse "reg"")
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

