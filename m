Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC50C433EF
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 20:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiBGU4M (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 15:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiBGU4M (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2022 15:56:12 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E8CC0612A4
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 12:56:10 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 03A58208FC44
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] pata_hpt3x2n: fix writing to wrong register in
 hpt3x2n_bmdma_stop()
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <2ce292b5-d49f-740e-1445-be7375963a58@omp.ru>
Organization: Open Mobile Platform
Message-ID: <47572144-f0b3-ab14-94ee-6a95a4abd0ac@omp.ru>
Date:   Mon, 7 Feb 2022 23:56:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2ce292b5-d49f-740e-1445-be7375963a58@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/7/22 11:32 PM, Sergey Shtylyov wrote:

> The driver's bmdma_stop() method writes to the wrong PCI config register
> (0x52 intead of 0x54) when trying to clear the state machine on secondary
> channel -- "luckily", the write falls on a read-only part of the primary
> channel MISC. control 1 register, so no collateral damage is done...

   Sorry, s/1/3/. Could you fix while applying please?

> 
> Alan Cox fixed the HPT37x driver in commit 6929da4427b4 ("[PATCH] hpt37x:
> Two important bug fixes") but forgot to check the HPT3x2N driver which has
> the same bug. :-/
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
