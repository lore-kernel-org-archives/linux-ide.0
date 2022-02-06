Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA9C433EF
	for <linux-ide@archiver.kernel.org>; Sun,  6 Feb 2022 10:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiBFK0B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Feb 2022 05:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBFK0A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2022 05:26:00 -0500
X-Greylist: delayed 86 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 02:25:55 PST
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBE9C06173B
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 02:25:55 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru F37FD20DCCF0
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v4 0/3] Use *switch*es instead of *if*s in the Artop PATA
 driver
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20220205203434.15339-1-s.shtylyov@omp.ru>
 <987579a5-6a16-34b5-cb8e-d037f442402a@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <265f1415-8faa-7494-4aae-73f5db244b2c@omp.ru>
Date:   Sun, 6 Feb 2022 13:25:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <987579a5-6a16-34b5-cb8e-d037f442402a@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/6/22 5:01 AM, Damien Le Moal wrote:

>> Here are 3 patches against the 'for-next' branch of Damien Le Moal's
>> 'libata.git' repo. The driver abuses the strings of the *if* statements
>> where a *switch* statements would fit better...
>>
>> Sergey Shtylyov (3):
>>   pata_artop: eliminate local variable in artop_init_one()
>>   pata_artop: use *switch* in artop_init_one()
>>   pata_artop: use *switch* in atp8xx_fixup()
> 
> Please change the patch title prefix to "ata: <drv>: xxx".
> So "ata: pata_artop: xxx" in this case.

   As you wish, of/c.
   But I do think "pata_" speaks for itself and saves the valuable patch subject space...

[...]

MBR, Sergey
