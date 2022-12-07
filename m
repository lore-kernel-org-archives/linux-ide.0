Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9825C352A1
	for <linux-ide@archiver.kernel.org>; Wed,  7 Dec 2022 05:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiLGFkb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Dec 2022 00:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLGFk3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2022 00:40:29 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D55801A;
        Tue,  6 Dec 2022 21:40:29 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p2nAQ-0005zb-RR; Wed, 07 Dec 2022 06:40:26 +0100
Message-ID: <9524e401-15f7-443b-7648-1836cb9e924a@leemhuis.info>
Date:   Wed, 7 Dec 2022 06:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     regressions@lists.linux.dev
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
 <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation>
 <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
 <20221017155246.zxal2cfehjgaajcu@mobilestation>
 <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
 <201c873d-83a9-a006-f5b9-368135e8dadd@leemhuis.info>
In-Reply-To: <201c873d-83a9-a006-f5b9-368135e8dadd@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670391629;7a7fd96c;
X-HE-SMSGID: 1p2nAQ-0005zb-RR
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 01.12.22 14:02, Thorsten Leemhuis wrote:
> [Note: this mail contains only information for Linux kernel regression
> tracking. Mails like these contain '#forregzbot' in the subject to make
> then easy to spot and filter out. The author also tried to remove most
> or all individuals from the list of recipients to spare them the hassle.]
> 
> On 30.11.22 10:40, Naresh Kamboju wrote:
> 
>>
>> We have been noticing this problem [a] & [b] on Linux mainline master 6.1.0-rc7
>>
>>     Test error: mkfs.ext4
>> /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 failed; job
>> exit
>>
>> Please suggest a way forward on this reported issue on arm32 TI BeagleBoard X15
>> device. Build and Kernel configs details provided in the metadata section.
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced v6.0..v6.1-rc7
> #regzbot title ata/arm32: TI BeagleBoard X15 doesn't boot
> #regzbot ignore-activity

#regzbot fix: ata: libahci_platform: ahci_platform_find_clk: oops, NULL
pointer
