Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC26EB64DD
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jul 2023 23:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGYXfL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjGYXfJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jul 2023 19:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4880A1FCF;
        Tue, 25 Jul 2023 16:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FB261938;
        Tue, 25 Jul 2023 23:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954EBC433C8;
        Tue, 25 Jul 2023 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690328103;
        bh=FBbc5V63e6sL0phu+X3Ges8NLZoxCVBOjNs2xldkd1A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FgTdY2bsPEE/JnW/CQyPw7Db1avhYZCpTgTUGn8ib4tEOO7sY958fMcnGDlBTGKxK
         7tO5RIS8PG/o2IMQUQ2L5EGCyFrQU1gpdD1O/Huh05gkwwPyxZ1X3UAd+je8/YVgrZ
         jcGIAnPF3qG7XuCxE23dGbyAbIoQ8+nhUMaJApXRnOaE83DE2BB5x5y9wRjQKX+klA
         nMsnIhvSHF5xCqs5AY3vxUMhsbU3An4bG5EW59/7HD7eojKiZjsh+7UBRfAwy+pFVG
         z9y3Dk1XKRSzVBvcipBZEGV2wVdFD2p7/DSUSJuIzVD6pPKUe76mqntHMM/XXxPlxX
         QZjhMlMopzTXA==
Message-ID: <09b3a989-6215-5eac-0723-a8745d3f896d@kernel.org>
Date:   Wed, 26 Jul 2023 08:35:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] ata: pata_arasan_cf: Use dev_err_probe() instead
 dev_err() in data_xfer()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, Viresh Kumar <vireshk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "open list:LIBATA PATA ARASAN COMPACT FLASH CONTROLLER" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230725030627.1103-1-duminjie@vivo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230725030627.1103-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/25/23 12:06, Minjie Du wrote:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> acdev->host->dev is not ready yet.
> At this point dev_err() will have no output.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Applied to for-6.5-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

