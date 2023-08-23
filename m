Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7ACEE49A0
	for <linux-ide@archiver.kernel.org>; Wed, 23 Aug 2023 16:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbjHWQf1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjHWQf1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2023 12:35:27 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E016CEE;
        Wed, 23 Aug 2023 09:35:22 -0700 (PDT)
Received: from [192.168.1.103] (178.176.72.129) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 23 Aug
 2023 19:35:18 +0300
Subject: Re: [PATCH v4 2/2] ata: pata_falcon: add data_swab option to
 byte-swap disk data
To:     Michael Schmitz <schmitzmic@gmail.com>, <dlemoal@kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-m68k@vger.kernel.org>
CC:     <will@sowerbutts.com>, <rz@linux-m68k.org>, <geert@linux-m68k.org>,
        Finn Thain <fthain@linux-m68k.org>
References: <20230822221359.31024-1-schmitzmic@gmail.com>
 <20230822221359.31024-3-schmitzmic@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <56654dc7-37e7-1fd7-0d3f-647563f4cc5a@omp.ru>
Date:   Wed, 23 Aug 2023 19:35:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230822221359.31024-3-schmitzmic@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.72.129]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 08/23/2023 16:19:10
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 179410 [Aug 23 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.72.129 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.72.129 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;178.176.72.129:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.129
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/23/2023 16:22:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/23/2023 2:00:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/23/23 1:13 AM, Michael Schmitz wrote:

> Some users of pata_falcon on Q40 have IDE disks in default
> IDE little endian byte order, whereas legacy disks use
> host-native big-endian byte order as on the Atari Falcon.
> 
> Add module parameter 'data_swab' to allow connecting drives
> with non-native data byte order. Drives selected by the
> data_swap bit mask will have their user data byte-swapped to
> host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
> all user data on drive B, leaving data on drive A in native
> byte order. On Q40, drives on a second IDE interface may be
> added to the bit mask as bits 2 and 3.
> 
> Default setting is no byte swapping, i.e. compatibility with
> the native Falcon or Q40 operating system disk format.
> 
> Cc: William R Sowerbutts <will@sowerbutts.com>
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: William R Sowerbutts <will@sowerbutts.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
> index 3841ea200bcb..7cf15bd9764a 100644
> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
[...]
> @@ -194,6 +199,9 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	ata_port_desc(ap, "cmd %px ctl %px data %pa",
>  		      base, ctl_base, &ap->ioaddr.data_addr);
>  
> +	ap->private_data = (void *)(uintptr_t)(pdev->id > 0 ?
> +		pata_falcon_swap_mask >> 2 : pata_falcon_swap_mask);

   How about:

	ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >>
			   (pdev->id > 0 ? 2 : 0));

[...]

MBR, Sergey
