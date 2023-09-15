Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B694BEE3F2F
	for <linux-ide@archiver.kernel.org>; Fri, 15 Sep 2023 06:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjIOGah (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 15 Sep 2023 02:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjIOGah (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 15 Sep 2023 02:30:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43792722
        for <linux-ide@vger.kernel.org>; Thu, 14 Sep 2023 23:30:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EFBC433C7;
        Fri, 15 Sep 2023 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694759410;
        bh=1aopO01oPuHWf7YXsD0HEOWomkdshwpUyrZ6h6TK73o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lFX34nV01LiYpFHQqG5fSPbFnsD+pq3efuZD8lvDDI8OiNIOzb+mZk4ysO5tSIs35
         QDSSAEAbMqWCPscSNr+eM3uzisOV2/TMbzK1oz3X9K6cofv4MGpV4OVqYVwqTMqvKB
         h9Vp/9Ezv8bHbVyoLsOxMTSmfzdSO6M4CtKlLGcGidlYNbUTC/4nkmB+m2C3ux4oSP
         obrHK4D3aeqbQcWdSbEEJzxdhRSR+9Q1gF2cgnM0omvjA3f76B1CuC43OeK4jIEzL4
         l5MovFC5hwQfLxoF8KY0acASkEgp17VlD7Ul+/LYegSzVGkaTjsBGjlIDnXmMo0/Yy
         APomfKMXVnTrw==
Message-ID: <6713f78a-ff4d-2bb5-d454-3fa8793a66c0@kernel.org>
Date:   Fri, 15 Sep 2023 15:30:08 +0900
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

I queued this and patch 1 also in fo-6.6.-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research

