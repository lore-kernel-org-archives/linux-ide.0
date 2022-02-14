Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A80C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 14 Feb 2022 08:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbiBNIhY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:37:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiBNIhY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Feb 2022 03:37:24 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD2391
        for <linux-ide@vger.kernel.org>; Mon, 14 Feb 2022 00:37:14 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 5B56020E782E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2 1/2] ata: libata-sff: refactor ata_sff_set_devctl()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20220213151032.4694-1-s.shtylyov@omp.ru>
 <20220213151032.4694-2-s.shtylyov@omp.ru>
 <82f8b8fd-56c8-b6ed-9658-822643e0e0c9@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9bd9671f-e990-3ebe-a8d8-a3683ef58eeb@omp.ru>
Date:   Mon, 14 Feb 2022 11:37:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <82f8b8fd-56c8-b6ed-9658-822643e0e0c9@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/14/22 2:25 AM, Damien Le Moal wrote:

>> Commit 41dec29bcb05 ("libata: introduce sff_set_devctl() method") left some
>> clumsy checks surrounding calls to ata_sff_set_devctl() which Jeff Garzik
>> suggested to factor out...  and I never followed up. :-(
>>
>> At last, refactor ata_sff_set_devctl() to include the repetitive checks and
>> return a 'bool' result indicating if the device control register exists or
>> not.
>>
>> While at it, further update the 'kernel-doc' comment -- the device control
>> register has never been a part of the taskfile, despite what Jeff and co.
>> think! :-)
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> This patch has "v2"... I do not recall seeing a v1 and the cover letter has no
> changelog (and no v2 tag)... Is this a new series ?

   That v2 is there by mistake, please ignore it.

[...]

MBR, Sergey
