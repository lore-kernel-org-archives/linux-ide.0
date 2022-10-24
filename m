Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9890BC38A2D
	for <linux-ide@archiver.kernel.org>; Mon, 24 Oct 2022 10:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJXKRE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 06:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJXKRE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 06:17:04 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F4A688AF
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 03:17:01 -0700 (PDT)
Received: from [192.168.1.103] (31.173.86.228) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Mon, 24 Oct
 2022 13:16:50 +0300
Subject: Re: [PATCH v2 3/3] ata: libata: Enable fua support by default
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
CC:     Hannes Reinecke <hare@suse.de>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <20221024072609.346502-4-damien.lemoal@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <52f3c988-3432-64d6-e38f-603b881c31ce@omp.ru>
Date:   Mon, 24 Oct 2022 13:16:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221024072609.346502-4-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.86.228]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/24/2022 09:50:18
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 173250 [Oct 24 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.228 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.228
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/24/2022 09:53:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/24/2022 7:44:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 10/24/22 10:26 AM, Damien Le Moal wrote:

> Change the default value of the fua module parameter to 1 to enable fua
> support by default for all devices supporting it. This parameter
> description is also updated to indicate it is deprecated and that
> libata.force=[no]fua should be used to control fua support.

   Mhm, where is that change? You only seem to change the default...

> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 27aec8e63a8c..867e2c423627 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -127,9 +127,9 @@ int atapi_passthru16 = 1;
>  module_param(atapi_passthru16, int, 0444);
>  MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>  
> -int libata_fua = 0;
> +int libata_fua = 1;
>  module_param_named(fua, libata_fua, int, 0444);
> -MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
> +MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on [default])");
>  
>  static int ata_ignore_hpa;
>  module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);

MBR, Sergey
