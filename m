Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C2C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jan 2022 09:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiAYJvl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:51:41 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:40712 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiAYJrG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jan 2022 04:47:06 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 8785420CBB9F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: pata_platform: Fix a NULL pointer dereference in
 __pata_platform_probe()
To:     Zhou Qingyang <zhou1615@umn.edu>
CC:     <kjlu@umn.edu>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220124164525.53068-1-zhou1615@umn.edu>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <578d6a7e-1488-43b9-9bfe-9c99c88da4fd@omp.ru>
Date:   Tue, 25 Jan 2022 12:46:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220124164525.53068-1-zhou1615@umn.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/24/22 7:45 PM, Zhou Qingyang wrote:

> In __pata_platform_probe(), devm_kzalloc() is assigned to ap->ops and
> there is a dereference of it right after that, which could introduce a
> NULL pointer dereference bug.
> 
> Fix this by adding a NULL check of ap->ops.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: f3d5e4f18dba ("ata: pata_of_platform: Allow to use 16-bit wide data transfer")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
