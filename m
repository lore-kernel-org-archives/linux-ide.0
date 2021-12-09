Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201AFC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 08:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhLII1z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:27:55 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:53638 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhLII1z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 03:27:55 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 6ABBF2303D0B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <17dd6662-3f82-75b1-9a1f-c6d47c0ef585@omp.ru>
Date:   Thu, 9 Dec 2021 11:24:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 64/73] pata_sil680: convert blank printk() calls
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-65-hare@suse.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211208163255.114660-65-hare@suse.de>
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
>   drivers/ata/pata_sil680.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index 81238e097fe2..0da58ce20d82 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -308,17 +308,17 @@ static u8 sil680_init_chip(struct pci_dev *pdev, int *try_mmio)
>   
>   	switch (tmpbyte & 0x30) {
>   	case 0x00:
> -		printk(KERN_INFO "sil680: 100MHz clock.\n");
> +		dev_info(&pdev->dev, "sil680: 100MHz clock.\n");
>   		break;
>   	case 0x10:
> -		printk(KERN_INFO "sil680: 133MHz clock.\n");
> +		dev_info(&pdev->dev, "sil680: 133MHz clock.\n");
>   		break;
>   	case 0x20:
> -		printk(KERN_INFO "sil680: Using PCI clock.\n");
> +		dev_info(&pdev->dev, "sil680: Using PCI clock.\n");
>   		break;
>   	/* This last case is _NOT_ ok */
>   	case 0x30:
> -		printk(KERN_ERR "sil680: Clock disabled ?\n");
> +		dev_err(&pdev->dev, "sil680: Clock disabled ?\n");

    Could remove a space before ?, while at it?

[...]

MBR, Sergey
