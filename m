Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D47ECAAD1
	for <linux-ide@archiver.kernel.org>; Sat, 27 Aug 2022 18:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiH0SsL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 27 Aug 2022 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiH0SsK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 27 Aug 2022 14:48:10 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C872357230
        for <linux-ide@vger.kernel.org>; Sat, 27 Aug 2022 11:48:08 -0700 (PDT)
Received: from [192.168.1.103] (178.176.77.218) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 27 Aug
 2022 21:47:59 +0300
Subject: Re: [PATCH] ata: pata_macio: Remove unneeded word in comments
To:     Shaomin Deng <dengshaomin@cdjrlc.com>,
        <damien.lemoal@opensource.wdc.com>, <linux-ide@vger.kernel.org>
References: <20220825145215.5542-1-dengshaomin@cdjrlc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <2bdd8528-97d2-11de-5346-9602d7ff83ac@omp.ru>
Date:   Sat, 27 Aug 2022 21:48:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220825145215.5542-1-dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.77.218]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/27/2022 16:50:08
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 172417 [Aug 26 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 496 496 76afdfb3eafb219d63a59f0593e2cada48535e98
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.77.218 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.77.218
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/27/2022 16:52:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/27/2022 4:00:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 8/25/22 5:52 PM, Shaomin Deng wrote:

> There is unneeded word "to" in line 669, so remove it.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

> ---
>  drivers/ata/pata_macio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index bfea2be2959a..076212fdb9d9 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -666,7 +666,7 @@ static u8 pata_macio_bmdma_status(struct ata_port *ap)
>  	 * a multi-block transfer.
>  	 *
>  	 * - The dbdma fifo hasn't yet finished flushing to
> -	 * to system memory when the disk interrupt occurs.
> +	 * system memory when the disk interrupt occurs.

   Could replace "to" with "the" as well..

[...]

MBR, Sergey
