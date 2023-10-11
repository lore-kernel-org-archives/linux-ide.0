Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B1CD6E5A
	for <linux-ide@archiver.kernel.org>; Wed, 11 Oct 2023 11:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjJKLKW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 Oct 2023 07:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjJKLKH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 Oct 2023 07:10:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2498115;
        Wed, 11 Oct 2023 04:09:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E4DC433C9;
        Wed, 11 Oct 2023 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697022576;
        bh=3kH+pQQjIkIDI8ifN14G+a5TCPOKhClhNMLfZIwqfOE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kIljUxRiUIiiOVuTlucAyG9/v2Ua8NWK58vO/XKKWqu/tg5hvowuiyqFHMrxxmCNc
         aYaatK3Zvn3HpNKOM5fN7TTeJ0AL4TtoZKtZBWKpHbqVdDYTpPS6Iruov0w0005L64
         7WHkBnQPRK8XLpGo/xydt7Ev9lDSY/Mtpq7kY/rzD5QYqpiSYj8hiJKYE9erzccIN2
         JnmGMwt4aL6ONjBzXPf2lcN6XIBisQ4HIips3os17nib2tv/BOR7mjIgItDDW6ER+b
         WjXyPNt09GpypWTmr3vitG5r6gulvr963IfmRf5r9or4uxzAntJZAs3xYW8MQqAZPM
         ZFt+ZW1PmR7Zw==
Message-ID: <79b0f043-2dcf-49cc-b52a-e1ab21554610@kernel.org>
Date:   Wed, 11 Oct 2023 20:09:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
Content-Language: en-US
To:     Ma Ke <make_ruc2021@163.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231010122916.4080132-1-make_ruc2021@163.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231010122916.4080132-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/10/23 21:29, Ma Ke wrote:
> In mv_platform_probe(), check the return value of clk_prepare_enable()
> and return the error code if clk_prepare_enable() returns an
> unexpected value.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Applied to for-6.7. Thanks !

-- 
Damien Le Moal
Western Digital Research

