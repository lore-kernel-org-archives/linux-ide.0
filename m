Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F9FC67871
	for <linux-ide@archiver.kernel.org>; Mon, 24 Oct 2022 22:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJXWIS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 18:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiJXWH6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 18:07:58 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE063EA5B
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 13:21:13 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1on2V8-00075g-Lg; Mon, 24 Oct 2022 20:48:42 +0200
Message-ID: <f1456224-f644-dce5-15ea-fecc965788e1@maciej.szmigiero.name>
Date:   Mon, 24 Oct 2022 20:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
Content-Language: en-US, pl-PL
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v2 0/3] Improve libata support for FUA
In-Reply-To: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 24.10.2022 09:26, Damien Le Moal wrote:
> These patches cleanup and improve libata support for the FUA device
> feature. Patch 3 enables FUA support by default for any drive that
> reports supporting the feature.
> 
> Changes from v1:
>   - Removed Maciej's patch 2. Instead, blacklist drives which are known
>     to have a buggy FUA support.
> 
> Damien Le Moal (3):
>    ata: libata: cleanup fua handling
>    ata: libata: blacklist FUA support for known buggy drives
>    ata: libata: Enable fua support by default
> 

Thanks for the updated series.

In general (besides the small commit message thing that Sergey had
already mentioned) it looks good to me, so:
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Thanks,
Maciej

