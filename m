Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F338C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jun 2022 21:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbiFJVVG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiFJVVF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2022 17:21:05 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BEB15C8A4
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2022 14:21:02 -0700 (PDT)
Received: from [192.168.1.103] (31.173.80.9) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 11 Jun
 2022 00:20:54 +0300
Subject: Re: [PATCH 0/3] Make PATA transfer mode masks always being 32-bit
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <f4b5fd32-0182-53d4-ca6b-a1f11abbcba8@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <446dab29-c8b1-22c6-156c-1a2d266ca30f@omp.ru>
Date:   Sat, 11 Jun 2022 00:20:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f4b5fd32-0182-53d4-ca6b-a1f11abbcba8@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.80.9]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/10/2022 21:06:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171067 [Jun 10 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 489 489 b67d2e276d358fa514f5991440453e6a402e3a26
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.9 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.9 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;31.173.80.9:7.7.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.9
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/10/2022 21:10:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/10/2022 6:32:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/8/22 9:44 AM, Damien Le Moal wrote:

>> The PATA transfer mode masks (direct and packed) in libata are sometimes
>> declared as *unsigned int* and sometimes as *unsigned long* (which is a
>> 64-bit type on 64-bit architectures), while the packed mask really only
>> uses 20 bits and the PIO/MWDMA/UDMA masks use up to 8 bits. Switching to
>> the uniform 32-bit masks saves siginificant amount of the object code...
>>
>> Sergey Shtylyov (3):
>>   ata: make packed transfer mode masks *unsigned int*
>>   ata: make ata_device::{pio|mwdma|udma}_mask *unsigned int*
>>   ata: make ata_port_info::{pio|mwdma|udma}_mask *unsigned int*
>>
>>  drivers/ata/libata-acpi.c      |  8 +++---
>>  drivers/ata/libata-core.c      | 38 +++++++++++++-------------
>>  drivers/ata/pata_acpi.c        |  2 +-
>>  drivers/ata/pata_ali.c         |  2 +-
>>  drivers/ata/pata_amd.c         | 14 +++++-----
>>  drivers/ata/pata_hpt366.c      |  2 +-
>>  drivers/ata/pata_hpt37x.c      |  6 ++---
>>  drivers/ata/pata_hpt3x2n.c     |  2 +-
>>  drivers/ata/pata_pdc2027x.c    |  4 +--
>>  drivers/ata/pata_serverworks.c |  4 +--
>>  drivers/ata/pata_sis.c         |  2 +-
>>  drivers/ata/pata_via.c         |  2 +-
>>  include/linux/libata.h         | 49 +++++++++++++++++-----------------
>>  13 files changed, 67 insertions(+), 68 deletions(-)
>>
> 
> Are you going to resend this as a single patch ?

   No, I'd like to avoid that... Please merge as is.

MBR, Sergey
