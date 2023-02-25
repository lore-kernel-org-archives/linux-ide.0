Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E7C7EE2D
	for <linux-ide@archiver.kernel.org>; Sat, 25 Feb 2023 09:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBYJTG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 25 Feb 2023 04:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBYJTG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 25 Feb 2023 04:19:06 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB68D13528
        for <linux-ide@vger.kernel.org>; Sat, 25 Feb 2023 01:19:03 -0800 (PST)
Received: from [192.168.1.103] (178.176.72.250) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 25 Feb
 2023 12:18:53 +0300
Subject: Re: [PATCH 0/2] Drop unused helpers from <linux/ata.h>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20230224203903.9860-1-s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <da05d5f2-163b-4194-dc31-76d4283624fb@omp.ru>
Date:   Sat, 25 Feb 2023 12:18:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230224203903.9860-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.72.250]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 02/25/2023 08:57:49
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 175702 [Feb 23 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 504 504 dc137e1f9c062eb6c0671e7d509ab442ae395562
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.72.250 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.72.250 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.250
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/25/2023 09:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/25/2023 4:43:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/24/23 11:39 PM, Sergey Shtylyov wrote:

> Here are 2 patches against the 'for-next' branch of Damien Le Moal's
> 'libata.git' repo.
> 
> All the functions moved from drivers/ide/ (with a rename) to <linux/ata.h>
> by Bart Z. (back then drivers/ide/ maintainer) never saw any use except by
> drivers/ide/ -- thus, when it was removed from the kernel, these functions
> became unused; 3 of them have been dropped by Niklas Cassel, and now I am
> dropping 2 remaining functions...
> 
> Sergey Shtylyov (2):
>   ata: drop unused ata_id_to_hd_driveid()
>   ata: drop unused ata_id_is_lba_capacity_ok()
> 
>  include/linux/ata.h | 71 ---------------------------------------------
>  1 file changed, 71 deletions(-)

   Sorry for trying to send the same series twice, and ignore this one please.
I forgot how to run 'git send-email' again... :-/

MBR, Sergey
