Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCB6C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 08:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiCUIC0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244075AbiCUICY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 04:02:24 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B932E0A0
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 01:00:56 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru C8DBC22D2018
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2 2/2] ata: libata-core: Disable READ LOG DMA EXT for
 Samsung 840 EVOs
To:     Christian Lamparter <chunkeey@gmail.com>,
        <linux-ide@vger.kernel.org>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
 <fe2ff41a52ce2647fd12f69a0d6eba8e3cf05b06.1647720651.git.chunkeey@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <468f57ae-47e8-7032-b391-7ddfd6853dbb@omp.ru>
Date:   Mon, 21 Mar 2022 11:00:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <fe2ff41a52ce2647fd12f69a0d6eba8e3cf05b06.1647720651.git.chunkeey@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 3/19/22 11:11 PM, Christian Lamparter wrote:

> Samsung' 840 EVO with the latest firmware (EXT0DB6Q) locks up with
> the a message: "READ LOG DMA EXT failed, trying PIO" during boot.
> 
> Initially this was discovered because it caused a crash
> with the sata_dwc_460ex controller on a WD MyBook Live DUO.
> 
> The reporter "Tice Rex" which has the unique opportunity that he
> has two Samsung 840 EVO SSD! One with the older firmware "EXT0BB0Q"
> which booted fine and didn't expose "READ LOG DMA EXT". But the
> newer/latest firmware "EXT0DB6Q" caused the headaches.
> 
> BugLink: https://github.com/openwrt/openwrt/issues/9505
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
> v1 -> v2: removed Reported-by Tag (Damien)
> 	  opened up a issue + added BugLink (Andy)
> ---
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0c854aebfe0b..760c0d81d148 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4014,6 +4014,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +	{ "Samsung SSD 840 EVO*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_NO_DMA_LOG |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },

  Shouldn't this entry be modified instead?

[...]

MBR, Sergey
