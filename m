Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA91C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jan 2022 17:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiAXRP7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:15:59 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:34324 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiAXRP7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2022 12:15:59 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru F0ABD20517C4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: pata_pdc202xx_old: make make static read-only array
 pio_timing const
To:     Colin Ian King <colin.i.king@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>
References: <20220123222246.5801-1-colin.i.king@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <312af033-20f0-0288-94cc-e3fc9dd5d6b0@omp.ru>
Date:   Mon, 24 Jan 2022 20:15:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220123222246.5801-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

   Too many verbs in the subject. :-)

On 1/24/22 1:22 AM, Colin Ian King wrote:

> The static array pio_timing is read-only so it make sense to make
> it const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

   With that fixed:

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
