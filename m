Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC441C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 08:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhLIIVA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:21:00 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:52096 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhLIIVA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 03:21:00 -0500
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 03:20:59 EST
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 1E0F522F7CC7
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <8745add9-ff52-1c0d-af84-d539cbf4720c@omp.ru>
Date:   Thu, 9 Dec 2021 11:09:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 71/73] pata_hpt3x2n: convert pr_err() calls
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-72-hare@suse.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211208163255.114660-72-hare@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 08.12.2021 19:32, Hannes Reinecke wrote:

> Convert pr_err() calls to dev_err()
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/ata/sata_gemini.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

   The subject doesn't match the patch itself. :-/

MBR, Sergey
