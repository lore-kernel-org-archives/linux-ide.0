Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924FCC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 11 Apr 2022 20:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiDKUp0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Apr 2022 16:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiDKUpZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2022 16:45:25 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8248E0FD
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 13:43:08 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru D216020A6018
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: pata_sil680: fix result type of
 sil680_sel{dev|reg}()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <9fceaba7-22e0-8cb2-fc69-04c0b8ece7db@omp.ru>
 <1a56a6cc-5062-fd25-4285-aa53b4ad0eba@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <bfd973a5-87ea-148e-ea88-72881b202761@omp.ru>
Date:   Mon, 11 Apr 2022 23:42:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1a56a6cc-5062-fd25-4285-aa53b4ad0eba@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 4/11/22 2:47 AM, Damien Le Moal wrote:

>> sil680_sel{dev|reg}() return a PCI config space address but needlessly
>> use the *unsigned long* type for that,  whereas the PCI config space
>> accessors take *int* for the address parameter.  Switch these functions
>> to returning *int*, updating the local variables at their call sites.
>> Add the empty lines after some declarations, while at it...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> ---
>> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
>> repo.
>>
>>  drivers/ata/pata_sil680.c |   27 +++++++++++++++------------
>>  1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> Index: libata/drivers/ata/pata_sil680.c
>> ===================================================================
>> --- libata.orig/drivers/ata/pata_sil680.c
>> +++ libata/drivers/ata/pata_sil680.c
>> @@ -47,9 +47,10 @@
>>   *	criticial.
>>   */
>>  
>> -static unsigned long sil680_selreg(struct ata_port *ap, int r)
>> +static int sil680_selreg(struct ata_port *ap, int r)
>>  {
>> -	unsigned long base = 0xA0 + r;
>> +	int base = 0xA0 + r;
>> +
>>  	base += (ap->port_no << 4);
>>  	return base;
> 
> The variable "base" is rather useless here... A simple:
> 
> 	return 0xA0 + r + (ap->port_no << 4);
> 
> would work too and is a lot cleaner.

   Yes, probably... but it's a matter of a separate patch, I think.
Note that both functions are inlined by gcc.

[...]

MBR, Sergey
