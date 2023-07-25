Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A2EEB64DD
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jul 2023 23:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGYXdm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjGYXdl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jul 2023 19:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0D71BF6
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 16:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C4B861949
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 23:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCACC433C9;
        Tue, 25 Jul 2023 23:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690328019;
        bh=5rUawVlVov7gPrkSjULeRRqOx0P/Zo3kJvk0Mj8tDzs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eNC8b8zExt0UfNWbeuu15vIEWemxJAIZoa2GeG1yyixV+4A/pWce/QL7KcxgjqcBM
         5BKlPGwzHkblA2S5rm2YwQHqxVZ70Ei1iXttTXW1da3Jj7mWuNTnKqQ51ELIsIqMPn
         H/BfpZHXbkHKMUQVk+0j8yCvCFghrnxAOrmHVgiRjOfIglgpnZ96w5S5v604chLJKZ
         kX7+ewBWXpANOHkhuQ5iQrnKM61udOAujXsvfCMOMxvcjbIaaiuwzviTRNXo9fxTGJ
         nZByE8/H3E9FzjoEO4wTxBNUM++QbP2OIT78UNv1uQQlYVnnKebs9zzdWVUyngTD5N
         GZ48TpPHMp7Cw==
Message-ID: <a3a4b64f-8e96-68ef-30a5-ca1a5ae28366@kernel.org>
Date:   Wed, 26 Jul 2023 08:33:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: pata_octeon_cf: fix error return code in
 octeon_cf_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
Cc:     s.shtylyov@omp.ru, robh@kernel.org
References: <20230725122809.521331-1-yangyingliang@huawei.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230725122809.521331-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/25/23 21:28, Yang Yingliang wrote:
> The 'rv' will be set to 0 after calling of_property_read_reg(),
> return correct error code in the error path.
> 
> Fixes: d0b2461678b1 ("ata: Use of_property_read_reg() to parse "reg"")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied to for-6.5-fixes with some tweaks. Thanks !


-- 
Damien Le Moal
Western Digital Research

