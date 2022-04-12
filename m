Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09ADC433FE
	for <linux-ide@archiver.kernel.org>; Tue, 12 Apr 2022 12:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354801AbiDLMzG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355584AbiDLMyY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Apr 2022 08:54:24 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A0BF56
        for <linux-ide@vger.kernel.org>; Tue, 12 Apr 2022 05:28:32 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 3A34120D6036
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: pata_via: fix sloppy typing in via_do_set_mode()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <009887e0-8c99-928e-06d0-e2e5882cf6ad@omp.ru>
 <0abe1b22-3686-f04b-253c-9d53692e5ca2@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <112d919a-f957-3692-87ad-d7417fff3dfb@omp.ru>
Date:   Tue, 12 Apr 2022 15:28:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0abe1b22-3686-f04b-253c-9d53692e5ca2@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/12/22 2:03 AM, Damien Le Moal wrote:

>> The *unsigned long* variable 'T' is initialized with an *int* value
>> (luckily always positive) -- to avoid that, declare the 'via_clock'
>> variable as *unsigned int* and make the divisible constant *unsigned*
>> too.  While at it, make the 'via_clock' and 'T' variables *const* as
>> they are never re-assigned after initialization -- the object code
>> remains the same as gcc previously used copy propagation anyway...
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
>>  drivers/ata/pata_via.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Index: libata/drivers/ata/pata_via.c
>> ===================================================================
>> --- libata.orig/drivers/ata/pata_via.c
>> +++ libata/drivers/ata/pata_via.c
>> @@ -248,8 +248,8 @@ static void via_do_set_mode(struct ata_p
>>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>>  	struct ata_device *peer = ata_dev_pair(adev);
>>  	struct ata_timing t, p;
>> -	static int via_clock = 33333;	/* Bus clock in kHZ */
>> -	unsigned long T =  1000000000 / via_clock;
>> +	const unsigned int via_clock = 33333;	/* Bus clock in kHz */
>> +	const unsigned long T = 1000000000U / via_clock;
> 
> This looks OK, but via_clock is never used apart from here. Why even
> bother having a variable ? I suspect this was a mean of documenting the
> value meaning. To really clean this, I would define T as a macro...

   I think *const* is preferable...

> But looking at other pata drivers, they all do something similar, and many
> of them have the same type issue. E.g. pata_amd:
> 
> 	int T, UT;
> 	const int amd_clock = 33333;	/* KHz. */
> 	u8 t;
> 
> 	T = 1000000000 / amd_clock;
> 	UT = T;
> 
> Also, ata_timing_compute() takes int as argument. So I do not think that

   Ah, I failed to check that! The code cited above is correct then...

> the type change is mandated, unless that function is changed too, but that

   We should change T's type to *int* then...

> could lead to a very large set of changes. Unless these are causing
> problems, I am tempted to leave everything as is (apart for the clearly
> wrong "static" declaration of via_clock).

    I'll prepare v2 then...

MBR, Sergey
