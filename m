Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C6AC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 08:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhLII3l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:29:41 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:47112 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbhLII3f (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 03:29:35 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 1482720CD061
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <4fcc5ee3-b65f-7837-c738-03b097e49d7c@omp.ru>
Date:   Thu, 9 Dec 2021 11:25:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 59/73] pata_cypressx: convert blank printk() calls
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-60-hare@suse.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211208163255.114660-60-hare@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 08.12.2021 19:32, Hannes Reinecke wrote:

> Convert blank printk() calls to structured logging.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/ata/pata_cypress.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
> index 5b3a7a8ebef6..3be5d52a777b 100644
> --- a/drivers/ata/pata_cypress.c
> +++ b/drivers/ata/pata_cypress.c
> @@ -62,7 +62,7 @@ static void cy82c693_set_piomode(struct ata_port *ap, struct ata_device *adev)
>   	u32 addr;
>   
>   	if (ata_timing_compute(adev, adev->pio_mode, &t, T, 1) < 0) {
> -		printk(KERN_ERR DRV_NAME ": mome computation failed.\n");
> +		ata_dev_err(adev, DRV_NAME ": mome computation failed.\n");

    s/mome/mode/?

[...]

MBR, Sergey
