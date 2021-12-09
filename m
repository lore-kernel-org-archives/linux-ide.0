Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7CCC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 08:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhLIIMG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:12:06 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:44162 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhLIIMG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 03:12:06 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru BEA3220CB566
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <42217736-b951-9d40-9079-600695a4160a@omp.ru>
Date:   Thu, 9 Dec 2021 11:08:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 69/73] pata_octeon_cf: Replace pr_XXX() calls with
 structured logging
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-70-hare@suse.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211208163255.114660-70-hare@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 08.12.2021 19:32, Hannes Reinecke wrote:

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/ata/pata_octeon_cf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index de27428920a0..64bb65ef8f02 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -273,9 +273,9 @@ static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
>   	dma_tim.s.we_n = ns_to_tim_reg(tim_mult, oe_n);
>   	dma_tim.s.we_a = ns_to_tim_reg(tim_mult, oe_a);
>   
> -	pr_debug("ns to ticks (mult %d) of %d is: %d\n", tim_mult, 60,
> +	ata_dev_dbg(dev, "ns to ticks (mult %d) of %d is: %d\n", tim_mult, 60,
>   		 ns_to_tim_reg(tim_mult, 60));

    Shouldn't you realign this like with the moved ( above?

> -	pr_debug("oe_n: %d, oe_a: %d, dmack_s: %d, dmack_h: %d, dmarq: %d, pause: %d\n",
> +	ata_dev_dbg(dev, "oe_n: %d, oe_a: %d, dmack_s: %d, dmack_h: %d, dmarq: %d, pause: %d\n",
>   		 dma_tim.s.oe_n, dma_tim.s.oe_a, dma_tim.s.dmack_s,
>   		 dma_tim.s.dmack_h, dma_tim.s.dmarq, dma_tim.s.pause);

    Same here.

MBR, Sergey
