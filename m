Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D849C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 24 Apr 2022 18:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiDXSUm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiDXSUl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 14:20:41 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B106AA64;
        Sun, 24 Apr 2022 11:17:30 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 6E0992323C3E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 4/5] ata: libata-core: Allow forcing most horkage flags
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
References: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
 <20220407123748.1170212-5-damien.lemoal@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b74cbd2a-c9a2-2f3a-3421-3a79098ca3fd@omp.ru>
Date:   Sun, 24 Apr 2022 21:17:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220407123748.1170212-5-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/7/22 3:37 PM, Damien Le Moal wrote:

> To facilitate debugging of drive issues in the field without kernel
> changes (e.g. temporary test patches), add an entry for most horkage
> flags in the force_tbl array to allow controlling these horkage
> settings with the libata.force kernel boot parameter.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/libata-core.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 75856f4210d7..121cb55a219a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6230,9 +6230,27 @@ static const struct ata_force_param force_tbl[] __initconst = {
>  	force_horkage_onoff(ncqtrim,	ATA_HORKAGE_NO_NCQ_TRIM),
>  	force_horkage_onoff(ncqati,	ATA_HORKAGE_NO_NCQ_ON_ATI),
>  
> -	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
> +	force_horkage_onoff(trim,	ATA_HORKAGE_NOTRIM),
> +	force_horkage_onoff(trim_zero,	ATA_HORKAGE_ZERO_AFTER_TRIM),
> +	force_horkage_on(max_trim_128m, ATA_HORKAGE_MAX_TRIM_128M),
> +
> +	force_horkage_onoff(dma,	ATA_HORKAGE_NODMA),
>  	force_horkage_on(atapi_dmadir,	ATA_HORKAGE_ATAPI_DMADIR),
> -	force_horkage_on(disable,	ATA_HORKAGE_DISABLE)
> +	force_horkage_on(atapi_mod16_dma, ATA_HORKAGE_ATAPI_MOD16_DMA),
> +
> +	force_horkage_onoff(dma_log,	ATA_HORKAGE_NO_DMA_LOG),
> +	force_horkage_onoff(id_dev_log,	ATA_HORKAGE_NO_ID_DEV_LOG),
> +	force_horkage_onoff(log_dir,	ATA_HORKAGE_NO_LOG_DIR),

   Underscores in the names with "no" (without underscore) would look inconsistent,
wouldn't they? Maybe drop the underscores here?

[...]

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

MBR, Sergey
