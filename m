Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E571C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 29 Sep 2021 14:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F7061288
	for <linux-ide@archiver.kernel.org>; Wed, 29 Sep 2021 14:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbhI2OmE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Sep 2021 10:42:04 -0400
Received: from mxout02.lancloud.ru ([45.84.86.82]:54440 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344537AbhI2OmD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2021 10:42:03 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 2EA65236520F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] drivers/ata: Fix kernel pointer leak
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210929121618.1157415-1-qtxuning1999@sjtu.edu.cn>
Organization: Open Mobile Platform
Message-ID: <563011b8-52cd-3bae-a6f6-4611ab5863da@omp.ru>
Date:   Wed, 29 Sep 2021 17:40:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929121618.1157415-1-qtxuning1999@sjtu.edu.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 29.09.2021 15:16, Guo Zhi wrote:

    I'd recommend the subject prefix to be just "pata_atp867x: "...

> Pointers should be printed with %p or %px rather than cast to
> 'unsigned long' and pinted with %lx

    Printed.

> Change %lx to %p to print the secured pointer.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>   drivers/ata/pata_atp867x.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
> index 2bc5fc81efe3..c32b95f48e50 100644
> --- a/drivers/ata/pata_atp867x.c
> +++ b/drivers/ata/pata_atp867x.c
> @@ -447,11 +447,11 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
>   #ifdef	ATP867X_DEBUG
>   		atp867x_check_ports(ap, i);
>   #endif
> -		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
> -			(unsigned long)ioaddr->cmd_addr,
> -			(unsigned long)ioaddr->ctl_addr);
> -		ata_port_desc(ap, "bmdma 0x%lx",
> -			(unsigned long)ioaddr->bmdma_addr);
> +		ata_port_desc(ap, "cmd 0x%p ctl 0x%p",
> +			ioaddr->cmd_addr,

    This line shouldn't be broken up, it's not long at all.

> +			ioaddr->ctl_addr);
> +		ata_port_desc(ap, "bmdma 0x%p",
> +			ioaddr->bmdma_addr);

    Hmm, I've looked at the driver and got an imperession it only uses the I/O 
ports, not MMIO...

[...]

MBR, Sergey
