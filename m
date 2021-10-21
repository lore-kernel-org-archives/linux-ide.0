Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74027C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 21 Oct 2021 08:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47ED5603E5
	for <linux-ide@archiver.kernel.org>; Thu, 21 Oct 2021 08:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJUIjl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:39:41 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:59130 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhJUIjj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Oct 2021 04:39:39 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 2B0FB20CB033
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <e1f96f77-cf44-7783-bf88-0814bbabbfbc@omp.ru>
Date:   Thu, 21 Oct 2021 11:37:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ata: sata_mv: Fix the return value of the probe function
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1634795836-1803-1-git-send-email-zheyuma97@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <1634795836-1803-1-git-send-email-zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 21.10.2021 8:57, Zheyu Ma wrote:

> mv_init_host() propagates the value returned by mv_chip_id() which in turn
> gets propagated by mv_pci_init_one() and hits local_pci_probe().
> 
> During the process of driver probing, the probe function should return < 0
> for failure, otherwise, the kernel will treat value > 0 as success.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   drivers/ata/sata_mv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 9d86203e1e7a..7461fe078dd1 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -3897,7 +3897,7 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
>   
>   	default:
>   		dev_err(host->dev, "BUG: invalid board index %u\n", board_idx);
> -		return 1;
> +		return -ENODEV;

    Doesn't -EINVAL fit better here?

[...]

MBR, Sergey
