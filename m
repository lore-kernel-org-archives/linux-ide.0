Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35942C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 18 Feb 2022 11:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiBRLRq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Feb 2022 06:17:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiBRLRp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2022 06:17:45 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E320F6F
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2022 03:17:20 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 9E1B620E0C77
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: libata-sff: fix reading uninitialized variable in
 ata_sff_lost_interrupt()
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>
References: <5e02673b-57d2-40b1-ceba-55abfb251089@omp.ru>
Organization: Open Mobile Platform
Message-ID: <1f350282-0b44-755a-f1e7-308fcaa24483@omp.ru>
Date:   Fri, 18 Feb 2022 14:17:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5e02673b-57d2-40b1-ceba-55abfb251089@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/18/22 2:05 PM, Sergey Shtylyov wrote:

> Due to my sloppy coding in commit 2c75a451ecb0 ("ata: libata-sff: refactor
> ata_sff_altstatus()"), in ata_sff_lost_interrupt() iff the device control
> register doesn't exists, ata_port_warn() would print the 'status' variable
> which never gets assigned.   Restore the original order of the statements,
> wrapping the ata_sff_altstatus() call in WARN_ON_ONCE()...
> 
> While at it, fix crazy indentation in the ata_port_warn() call itself...
> 
> Fixes: 2c75a451ecb0 ("ata: libata-sff: refactor ata_sff_altstatus()")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---

   Forgot to mention that it's against the 'for-next' branch of 'libata.git'. :-/

[...]

MBR, Sergey
