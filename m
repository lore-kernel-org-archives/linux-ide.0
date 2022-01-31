Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244B6C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jan 2022 21:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiAaVFz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:05:55 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:46284 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiAaVFy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jan 2022 16:05:54 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru E420720C90CA
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] libata: ata_{sff|std}_prereset() always return 0
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <d63ddc77-ddc8-d15a-030f-592cece64742@omp.ru>
 <4c79f0c7-a147-f371-5c06-28a0827bbea2@opensource.wdc.com>
Organization: Open Mobile Platform
Message-ID: <59ce902d-74a2-aeb3-663e-de5a2bb70625@omp.ru>
Date:   Tue, 1 Feb 2022 00:05:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4c79f0c7-a147-f371-5c06-28a0827bbea2@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/29/22 8:24 AM, Damien Le Moal wrote:

>> ata_std_prereset() always returns 0, hence the check in ata_sff_prereset()
>> is pointless and thus it also can return only 0 (however, we cannot change
>> the prototypes of ata_{sff|std}_prereset() as they implement the driver's
>> prereset() method).
>>
>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]
>> Index: libata/drivers/ata/libata-sff.c
>> ===================================================================
>> --- libata.orig/drivers/ata/libata-sff.c
>> +++ libata/drivers/ata/libata-sff.c
>> @@ -1708,16 +1708,14 @@ EXPORT_SYMBOL_GPL(ata_sff_thaw);
>>   *	Kernel thread context (may sleep)
>>   *
>>   *	RETURNS:
>> - *	0 on success, -errno otherwise.
>> + *	0 on success.
> 
> Well, since the function *always* return 0, I would just say so, since
> "on success" can of imply that there may be failures.
> Something like "0, always" would be better I think.

   Agreed.

>>   */
>>  int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
>>  {
>>  	struct ata_eh_context *ehc = &link->eh_context;
>>  	int rc;
>>  
>> -	rc = ata_std_prereset(link, deadline);
>> -	if (rc)
>> -		return rc;
>> +	ata_std_prereset(link, deadline);
> 
> I am not a big fan of such change. If ata_std_prereset is changed to
> actually return an error, the above change would result in a bug...
> 
> What about fixing things properly:
> 1) The ata_std_prereset comment says it: ata_std_prereset should not
> fail, so let's make it a void function.

   Hm... we can't, as ata_std_prereset() sometimes directly implement prereset()
and pmp_prereset() methods and those should return *int*...

> 2) The only direct user of ata_std_prereset as the pmp_prereset port op
> is libata-pmp.c, so let's just add a static function there that calls
> ata_std_prereset and return 0.

   I think you've missed 'ata_base_port_ops' also using ata_std_prereset()...

> 3) ata_sff_prereset also always return 0. So ideally, we should also
> make it void and have a wrapper for the drivers using it as the prereset
> port op.

   There are no drivers using it as a method -- only libata-sff.c does it,
others have a wrapper around it.

> But there are more places to change than for ata_std_prereset,
> so not sure this makes the code cleaner. Worth looking into it though.
> 
> Thoughts ?

   I think I'd like to keep my approach...

[...]

MBR, Sergey
