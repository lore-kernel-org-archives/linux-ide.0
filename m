Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F35EB64D9
	for <linux-ide@archiver.kernel.org>; Thu,  6 Jul 2023 20:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGFUbS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 6 Jul 2023 16:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGFUbR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jul 2023 16:31:17 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CAF19B2
        for <linux-ide@vger.kernel.org>; Thu,  6 Jul 2023 13:31:16 -0700 (PDT)
Received: from [192.168.1.103] (178.176.74.43) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 6 Jul 2023
 23:31:06 +0300
Subject: Re: [PATCH 0/8] Fix the remaining sloppy timeout typing in libata
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
References: <20230616194607.7351-1-s.shtylyov@omp.ru>
 <7f8b4eaf-e227-a069-a3c9-3deecf0e5c5a@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <8c54e4e9-9d92-1a29-fc7f-4c305df292ae@omp.ru>
Date:   Thu, 6 Jul 2023 23:31:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7f8b4eaf-e227-a069-a3c9-3deecf0e5c5a@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.74.43]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 07/06/2023 20:08:19
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 178485 [Jul 06 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.43 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.43 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 178.176.74.43:7.1.2,7.7.3,7.4.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.43
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/06/2023 20:18:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/6/2023 6:28:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/23/23 2:49 AM, Damien Le Moal wrote:

>> Here are 8 patches against the 'for-next' branch of Damien's 'libata.git' repo.
>>
>> The libata code still often uses the 'unsigned long' type for the millisecond
>> timeouts, while the kernel functions like msecs_to_jiffies() or msleep() only
>> take 'unsigned int' parameters for those. I've started fixing the timeout types
>> from ata_exec_internal[_sg]() that tripped the Svace static analyzer and posted
>> couple patches, promising to post a large continuation series somewhat later...
>> in my worst nightmare I couldn't imagine that this would take a whole year! :-(
>>
>> Sergey Shtylyov (8):
>>   ata: libata: fix parameter type of ata_deadline()
>>   ata: libata-core: fix parameter types of ata_wait_register()
>>   ata: libata-eh: fix reset timeout type
>>   ata: fix debounce timings type
>>   ata: libata-scsi: fix timeout type in ata_scsi_park_store()
>>   ata: libahci: fix parameter type of ahci_exec_polled_cmd()
>>   ata: ahci_xgene: fix parameter types of xgene_ahci_poll_reg_val()
>>   ata: sata_sil24: fix parameter type of sil24_exec_polled_cmd()
> 
> We could merge patches 1-5 together as core updates, followed by driver patches.

   I'd like to avoid that. Please! :-)

> Anyway, looks all OK to me but we are a little too close to the merge window. So
> I will apply this once we have 6.5-rc1.

   Sigh, even more delaying...
   /me blames his stupidly long illness on December tho...

[...]

MBR, Sergey
