Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9625C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 20 Feb 2022 17:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiBTRUI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:20:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBTRUI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 20 Feb 2022 12:20:08 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3935220FF
        for <linux-ide@vger.kernel.org>; Sun, 20 Feb 2022 09:19:44 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru A69F02033962
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: pata_hpt37x: fix PCI clock detection
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <02715925-4a0f-30dd-86b8-85786cf6484a@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9b5390aa-cd68-9b59-928a-c98e5de1a9e2@omp.ru>
Date:   Sun, 20 Feb 2022 20:19:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <02715925-4a0f-30dd-86b8-85786cf6484a@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/19/22 11:04 PM, Sergey Shtylyov wrote:

> The f_CNT register (at the PCI config. address 0x78) is 16-bit, not 8-bit!
> The bug was there from the very srart... :-(

   Start! :-)
   Damien, maybe this description is too terse? I can try to be more explanatory...

> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org

[...]

MBR, Sergey

