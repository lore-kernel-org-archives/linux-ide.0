Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495CCC433F5
	for <linux-ide@archiver.kernel.org>; Tue, 15 Feb 2022 11:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiBOLUx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:20:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiBOLUq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Feb 2022 06:20:46 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99711107D1A;
        Tue, 15 Feb 2022 03:20:34 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 3F369210DAD6
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: add/use ata_taskfile::{error|status} fields
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <e99172ca-cf0e-5510-60fc-b19dc48658ac@omp.ru>
 <49690264-a2b8-b11e-e944-1d2333f73334@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f3786f07-0892-143c-e457-de6b0e93a5b3@omp.ru>
Date:   Tue, 15 Feb 2022 14:20:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <49690264-a2b8-b11e-e944-1d2333f73334@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/15/22 12:13 AM, Sergey Shtylyov wrote:

>> Add the explicit error and status register fields to 'struct ata_taskfile'
>> using the anonymous *union*s ('struct ide_taskfile' had that for ages!) and
>> update the libata taskfile code accordingly. There should be no object code
>> changes resulting from that...
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> ---
>> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
>> repo plus just posted 'drivers/ata/libata-scsi.c' patch.
> 
>    Oh, and the 2 patch series for 'drivers/ata/libata-sff.c' posted not so long ago...
> There are only some offsets, so should probably apply indeptendently as well... :-)

   The 0-day robot found a bug in the file I forgot to build check, so scratch this patch.
I've now fixed the bug and built tested all affected files, and gonna post v2 later today...

MBR, Sergey
