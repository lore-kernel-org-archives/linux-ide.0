Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D1C27C6D
	for <linux-ide@archiver.kernel.org>; Wed, 16 Aug 2023 22:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347028AbjHPWw2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Aug 2023 18:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347040AbjHPWwK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Aug 2023 18:52:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CF8FD
        for <linux-ide@vger.kernel.org>; Wed, 16 Aug 2023 15:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25C9464EE7
        for <linux-ide@vger.kernel.org>; Wed, 16 Aug 2023 22:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9D5C433C8;
        Wed, 16 Aug 2023 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692226328;
        bh=plNu6aC0mFjKzXNxMqWpXvbYxui7oXvcEIjMyDShaC0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zj8ZzdUnx11yz93AUTFUi2l+PItUWu5fr4BVsuZDaUztR0TrdyNwDYRGDNUpVk84L
         XPCW6N0EAAUgeKG0m5zkgjsvy7oPgS1mmepSP1gFiu/t9ghTYOav2LEHfqvT5yjAVI
         6i3r/pgwy5YDMk7FfKogLAEDvDVNUHCK2B7E0fRuENaKgPjru4hqXOaE9OrJptjymt
         8CgAEsB2vYRVWZ7dxCMJOMuanf+hht9/EuDfDq6gzqyPBuieBKZIBJaii8PrFjwLno
         5JmChp4tgDmMxywQRF/T+2x2SMK1ncniaqaspJ05FaklD8zc2D9ksp4VGBZYsyXEiA
         7DdEqKG1P4ohA==
Message-ID: <e3d16a5d-f0c1-7aa4-d977-3b70c6b0d995@kernel.org>
Date:   Thu, 17 Aug 2023 07:52:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] ata: pata_imx: Use helper function
 devm_clk_get_enabled()
To:     Li Zetao <lizetao1@huawei.com>, s.shtylyov@omp.ru,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230815151352.1907861-1-lizetao1@huawei.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230815151352.1907861-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/16/23 00:13, Li Zetao wrote:
> After the commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
> prepared and enabled clocks"), it can replace the pair of functions,
> devm_clk_get() and clk_prepare_enable() with a single helper function
> devm_clk_get_enabled(). Moreover, the driver will keeps a clock prepared
> (or enabled) during the whole lifetime of the driver, it is unnecessary to
> unprepare or disable clock explicitly when remove driver or in the error
> handling path.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Applied to for-6.6. Thanks !


-- 
Damien Le Moal
Western Digital Research

