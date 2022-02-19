Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3966CC433EF
	for <linux-ide@archiver.kernel.org>; Sat, 19 Feb 2022 09:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiBSJw0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 19 Feb 2022 04:52:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiBSJwZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 19 Feb 2022 04:52:25 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD2B692A7
        for <linux-ide@vger.kernel.org>; Sat, 19 Feb 2022 01:52:05 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru C3BFC20C601B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] ata: libata-sff: fix reading uninitialized variable in
 ata_sff_lost_interrupt()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>
References: <5e02673b-57d2-40b1-ceba-55abfb251089@omp.ru>
 <b6a7f09a-9e15-aac2-b80b-96f12f2df0a1@opensource.wdc.com>
Organization: Open Mobile Platform
Message-ID: <e429b92e-1848-37fd-0585-3c5b8e7bb92c@omp.ru>
Date:   Sat, 19 Feb 2022 12:52:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b6a7f09a-9e15-aac2-b80b-96f12f2df0a1@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/19/22 5:39 AM, Damien Le Moal wrote:

>> Due to my sloppy coding in commit 2c75a451ecb0 ("ata: libata-sff: refactor
>> ata_sff_altstatus()"), in ata_sff_lost_interrupt() iff the device control
>> register doesn't exists, ata_port_warn() would print the 'status' variable
>> which never gets assigned.   Restore the original order of the statements,
>> wrapping the ata_sff_altstatus() call in WARN_ON_ONCE()...
>>
>> While at it, fix crazy indentation in the ata_port_warn() call itself...
>>
>> Fixes: 2c75a451ecb0 ("ata: libata-sff: refactor ata_sff_altstatus()")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> I squashed this in the commit being fixed.

   I'm seeing a few typos/errors in the updated patch #2:

> In ata_sff_lost_interrupt(), wrap the ata_sff_altstatus() call in a

  s/a/the/?

> WARN_ON_ONCE()

   + check?

> to issue a warning if the if the device control registert

   Register? :-)

> does not exist. And while at it, fix crazy indentation in the
> ata_port_warn() call itself...

   Not clear why you (we?) emphasize this by using "itself"...

   Well, if you choose to fix those, I'll be thnakful. But you may as well
ignore me. :-)

[...]

MBR, Sergey
