Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE1CEE0213
	for <linux-ide@archiver.kernel.org>; Wed, 13 Sep 2023 23:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjIMXvN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Sep 2023 19:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjIMXvM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Sep 2023 19:51:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C97E4B
        for <linux-ide@vger.kernel.org>; Wed, 13 Sep 2023 16:51:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91B7C433C7;
        Wed, 13 Sep 2023 23:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694649068;
        bh=h+0PQDMv+AHctRlqBke6EXdpwh01dc0S7raXZQrEvVI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bMLOh/18N/VwK7zeTwTObp20J3Qol2FcJ5pakHxWPGoct7zmLNwTB4FLsGCtFyLmh
         tSVJeSu8aLHqbBGqRQjVXpbueq0O03k7xizQY8lolE6GF/h7S9nqa9qEv+Wx5OaKnI
         UsIMH7Z57tbBXdnWBTEVTW99N5ouXgUYZR0RwAnrCu0s2BB6Am5E6jJPL/O2Ld5fml
         DJDE14x5quA7VD/k23bVj+51WGNIoypSvMog229+F0d1fP+ozhT/F545JguCsXHyoH
         RC2QfsCa5Kw6QaUSsHIMsm7cEuhlXS4nXcP0q6EQSsTiftwb9jTEvg3nD7/LP4IzXa
         5YozBSNXtwERw==
Message-ID: <1da815e4-1335-83dd-f625-7fdcbec348eb@kernel.org>
Date:   Thu, 14 Sep 2023 08:51:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] ata: libata-eh: do not thaw the port twice in
 ata_eh_reset()
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>
Cc:     Li Nan <linan122@huawei.com>, Li Nan <linan666@huaweicloud.com>,
        linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230913221917.1217856-1-nks@flawful.org>
 <20230913221917.1217856-2-nks@flawful.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230913221917.1217856-2-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/14/23 07:19, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> commit 1e641060c4b5 ("libata: clear eh_info on reset completion") added
> a workaround that broke the retry mechanism in ATA EH.
> 
> Tejun himself suggested to remove this workaround when it was identified
> to cause additional problems:
> https://lore.kernel.org/linux-ide/20110426135027.GI878@htj.dyndns.org/
> 
> He and even said:
> "Hmm... it seems I wasn't thinking straight when I added that work around."
> https://lore.kernel.org/linux-ide/20110426155229.GM878@htj.dyndns.org/
> 
> While removing the workaround solved the issue, however, the workaround was
> kept to avoid "spurious hotplug events during reset", and instead another
> workaround was added on top of the existing workaround in commit
> 8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").
> 
> Because these IRQs happened when the port was frozen, we know that they
> were actually a side effect of PxIS and IS.IPS(x) not being cleared before
> the COMRESET. This is now done in commit 94152042eaa9 ("ata: libahci: clear
> pending interrupt status"), so these workarounds can now be removed.
> 
> Since commit 1e641060c4b5 ("libata: clear eh_info on reset completion") has
> now been reverted, the ATA EH retry mechanism is functional again, so there
> is once again no need to thaw the port more than once in ata_eh_reset().
> 
> This reverts "the workaround on top of the workaround" introduced in commit
> 8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

We need a fixes tag. Same for patch 1.

> ---
>  drivers/ata/libata-eh.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 5c493b6316eb..4cf4f57e57b8 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2803,9 +2803,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  		slave->eh_info.serror = 0;
>  	spin_unlock_irqrestore(link->ap->lock, flags);
>  
> -	if (ata_port_is_frozen(ap))
> -		ata_eh_thaw_port(ap);
> -
>  	/*
>  	 * Make sure onlineness and classification result correspond.
>  	 * Hotplug could have happened during reset and some

-- 
Damien Le Moal
Western Digital Research

