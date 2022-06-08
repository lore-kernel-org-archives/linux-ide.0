Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483ACCCA47B
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 17:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiFHRXA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFHRW1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 13:22:27 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F36C40727D
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 10:13:58 -0700 (PDT)
Received: from [192.168.1.103] (31.173.87.89) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 8 Jun 2022
 20:13:55 +0300
Subject: Re: [PATCH] ata: libata-transport: fix {dma|pio|xfer}_mode sysfs
 files
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        <linux-ide@vger.kernel.org>
References: <b0f8a1d3-2550-31b2-702c-3294d0569187@omp.ru>
 <c9695894-3bc6-e825-8239-ea6aa3e4831e@opensource.wdc.com>
 <78ae75a3-7f11-b177-c430-ad746f7d106a@omp.ru>
 <a9a01deb-c314-3196-bd3e-947fcd8819b8@opensource.wdc.com>
 <ac79bf20-5db0-90fa-380d-3e16f81bd79f@gmail.com>
 <1c81b5a8-b1b3-7bac-b7e4-9de7127c48b0@opensource.wdc.com>
 <a3d25d32-9e97-e227-4a0b-1c083b29f7f6@omp.ru>
 <12518fe8-f286-fe20-089b-5055c32312b7@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <82c8076a-444c-e2d2-99d4-b93f97c47709@omp.ru>
Date:   Wed, 8 Jun 2022 20:13:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <12518fe8-f286-fe20-089b-5055c32312b7@opensource.wdc.com>
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
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;31.173.87.89:7.7.3,7.4.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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

On 6/8/22 1:17 PM, Damien Le Moal wrote:
[...]
>>>>>>>> The {dma|pio|xfer}_mode sysfs files are incorrectly handled by the
>>>>>>>> ata_bitfield_name_match() macro which leads to reading such kind of
>>>>>>>> nonsense from them:
>>>>>>>>
>>>>>>>> $ cat /sys/class/ata_device/dev3.0/pio_mode
>>>>>>>> XFER_UDMA_7, XFER_UDMA_6, XFER_UDMA_5, XFER_UDMA_4, XFER_MW_DMA_4,
>>>>>>>> XFER_PIO_6, XFER_PIO_5, XFER_PIO_4, XFER_PIO_3, XFER_PIO_2, XFER_PIO_1,
>>>>>>>> XFER_PIO_0
>>>>>>>>
>>>>>>>> Using the correct ata_bitfield_name_search() macro fixes that:
>>>>>>>>
>>>>>>>> $ cat /sys/class/ata_device/dev3.0/pio_mode
>>>>>>>> XFER_PIO_4
>>>>>>>
>>>>>>> Looks good, but Documentation/ABI/testing/sysfs-ata says:
>>>>>>
>>>>>>    Completely forgot that the sysfs files are documented as ABIs... :-(
>>>>>>    Hm, shouldn't that file be added to the libata's entry in MAINTAINERS?
>>>>
>>>>    So what's your opinion on that idea?
>>
>>    ???
> 
> Yep, it looks like other subsystems have their doc files listed there. So

   OK, you've finally replied, thanks. :-)

> we can add them. Will you send a patch for that ?

   Yes, I'll try to...
 
>>> OK. Then let's do code and doc fixes in one patch, not 2.
>>
>>    Doh! Just when I did 2 patches... :-/
> 
> Sorry. I replied a little late. Just squash the patches :)

   Squashing diffs is simple, the main issue lies in merging the change logs...

MBR, Sergey
