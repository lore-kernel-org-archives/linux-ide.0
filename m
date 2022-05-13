Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA9DC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 13 May 2022 21:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379654AbiEMVBc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 May 2022 17:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356303AbiEMVBb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 May 2022 17:01:31 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8554830E;
        Fri, 13 May 2022 14:01:28 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 041C720A6E80
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: Remove unneeded ERROR check before
 clk_disable_unprepare
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220513075554.127677-1-wanjiabing@vivo.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f9772e83-3f1e-0d05-abbb-07f2382e3cd5@omp.ru>
Date:   Sat, 14 May 2022 00:01:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220513075554.127677-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/13/22 10:55 AM, Wan Jiabing wrote:

> ERROR check is already in clk_disable() and clk_unprepare() by using
> IS_ERR_OR_NULL. Remove unneeded ERROR check for ftide->pclk here.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
