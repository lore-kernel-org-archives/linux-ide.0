Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E510BC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 17:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiFHRXn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiFHRWw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 13:22:52 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE9340E5C
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 10:15:07 -0700 (PDT)
Received: from [192.168.1.103] (31.173.87.89) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 8 Jun 2022
 20:15:04 +0300
Subject: Re: [PATCH 0/4] Unify PCI clock detection in the HPT37x/HPT3x2N
 drivers
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20220515204126.4866-1-s.shtylyov@omp.ru>
 <b7ca6700-1896-ec12-d298-c2341c79f169@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <8ee5d744-9759-365b-db40-12c8bed25978@omp.ru>
Date:   Wed, 8 Jun 2022 20:15:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b7ca6700-1896-ec12-d298-c2341c79f169@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.87.89]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/08/2022 16:53:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 171013 [Jun 08 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 485 485 30d410687e032eeb95d5c3c4fb66dc8aafb87b20
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 31.173.87.89:7.7.3,7.4.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.89
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/08/2022 16:55:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/8/2022 2:12:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/8/22 9:47 AM, Damien Le Moal wrote:
[...]
>> Here are 4 patches against the 'for-next' branch of Damien Le Moal's
>> 'libata.git' repo.
>> The PCI clock frequency detection code in the HighPoint HPT37x/HPT3x2N drivers
>> has needlessly diverged, so trying to unify it...
>>
>> Sergey Shtylyov (4):
>>   ata: pata_hpt37x: move claculating PCI clock from hpt37x_clock_slot()
>>   ata: pata_hpt37x: factor out hpt37x_pci_clock()
>>   ata: pata_hpt37x: merge hpt374_read_freq() to hpt37x_pci_clock()
>>   ata: pata_hpt3x2n: pass base DPLL frequency to hpt3x2n_pci_clock()
>>
>>  drivers/ata/pata_hpt37x.c  | 113 +++++++++++++++++++------------------
>>  drivers/ata/pata_hpt3x2n.c |  19 ++++---
>>  2 files changed, 70 insertions(+), 62 deletions(-)
>>
> 
> Applied to for-5.20. Thanks !

   Thanks, better late than never... :-)

MBR, Sergey
