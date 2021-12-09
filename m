Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BE8C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 08:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhLIImr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:42:47 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:56486 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhLIImq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 03:42:46 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 7699D2307CED
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <8ee65aba-f518-a532-bef2-f6117f6de330@omp.ru>
Date:   Thu, 9 Dec 2021 11:39:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 33/73] pata_octeon_cf: Drop pointless VPRINTK() calls and
 convert the remaining ones
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-34-hare@suse.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211208163255.114660-34-hare@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 08.12.2021 19:32, Hannes Reinecke wrote:

> Drop pointless VPRINTK() calls for entering and existing interrupt

    s/existing/exiting/?
    BTW, I'm not seeing where you drop VPRINTK() calls in the interrupt 
handlers...

> routines and convert the remaining calls to dev_dbg().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/ata/pata_octeon_cf.c | 23 ++---------------------
>   1 file changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 7b80bbd9b1ed..de27428920a0 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
[...]
> @@ -617,9 +599,8 @@ static unsigned int octeon_cf_dma_finished(struct ata_port *ap,
>   	union cvmx_mio_boot_dma_intx dma_int;
>   	u8 status;
>   
> -	VPRINTK("ata%u: protocol %d task_state %d\n",
> -		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
> -
> +	ata_port_dbg(ap, "protocol %d task_state %d\n",
> +		     qc->tf.protocol, ap->hsm_task_state);

    You are replacing VPRINTK() here, not removing...

[...]

MBR, Sergey
