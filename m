Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0590C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 03:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiAEDku (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 22:40:50 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:41230 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234541AbiAEDku (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 22:40:50 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTFcx6N05z1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 19:40:49 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641354049; x=1643946050; bh=dgdhy56DTvXTOwmGF1KFHYoNXB7nRAAFT3R
        vVIpFxic=; b=swb0qql05u9UIBuzw9mE/+T1XtmiD6x78Nfn7s8PYmkoZl58rNJ
        iGnGsYXYB7ZPNCscDNxYUfBC8sffUk8Cp78YjRQVjtOmzn3JHoqY0OyDxESTale8
        FB+dBLnaNpPRe4Fvim3SDCZVxO5BApwebZQ6n4wrdPj0M1Rcw8h5cu7eWFAzxZN3
        GY/cR1sytJOVMgYidywBaJmHDpyCsh6vQnidzTN8N5p8YwLQVM1wEpBnT3lwSZk9
        bAiPp7y0ElD2MPP9/pI2lQI7TQTn0qSUDXn0ZsLc6ryNNLkuQ9WvO25SmGQqY0ud
        gvO0qNQfWg8czY1ONRN3cFN5j2FzMYtlFbg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jk9b08rhqc-M for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 19:40:49 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTFcx1d9Sz1VSkV;
        Tue,  4 Jan 2022 19:40:49 -0800 (PST)
Message-ID: <f6c5efc9-8645-c729-09e2-e7ab868d80f5@opensource.wdc.com>
Date:   Wed, 5 Jan 2022 12:40:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 22/22] ata: ahci_xgene: Fix id array access in
 xgene_ahci_read_id()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-23-damien.lemoal@opensource.wdc.com>
 <88f71464-135d-7cae-287d-8961eff37333@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <88f71464-135d-7cae-287d-8961eff37333@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 20:51, Hannes Reinecke wrote:
> On 1/4/22 11:58 AM, Damien Le Moal wrote:
>> ATA IDENTIFY command returns an array of le16 words. Accessing it as a
>> u16 array triggers the following sparse warning:
>>
>> drivers/ata/ahci_xgene.c:262:33: warning: invalid assignment: &=
>> drivers/ata/ahci_xgene.c:262:33:    left side has type unsigned short
>> drivers/ata/ahci_xgene.c:262:33:    right side has type restricted __le16
>>
>> Use a local variable to explicitly cast the id array to __le16 to avoid
>> this warning.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/ata/ahci_xgene.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
>> index 68ec7e9430b2..d5075d0f8cb1 100644
>> --- a/drivers/ata/ahci_xgene.c
>> +++ b/drivers/ata/ahci_xgene.c
>> @@ -239,6 +239,7 @@ static bool xgene_ahci_is_memram_inited(struct xgene_ahci_context *ctx)
>>  static unsigned int xgene_ahci_read_id(struct ata_device *dev,
>>  				       struct ata_taskfile *tf, u16 *id)
>>  {
>> +	__le16 *__id = (__le16 *)id;
>>  	u32 err_mask;
>>  
>>  	err_mask = ata_do_dev_read_id(dev, tf, id);
>> @@ -259,7 +260,7 @@ static unsigned int xgene_ahci_read_id(struct ata_device *dev,
>>  	 *
>>  	 * Clear reserved bit 8 (DEVSLP bit) as we don't support DEVSLP
>>  	 */
>> -	id[ATA_ID_FEATURE_SUPP] &= cpu_to_le16(~(1 << 8));
>> +	__id[ATA_ID_FEATURE_SUPP] &= cpu_to_le16(~(1 << 8));
>>  
>>  	return 0;
>>  }
>>
> Hmm. I would think that the 'id' argument is wrong; it really should be
> '__le16 *', as it only gets converted later on with the call to
> swap_buf_le16(id, ATA_ID_WORDS) in
> drivers/ata/libata-core.c:ata_dev_read_id(). So when this function is
> called the argument really _is_ __le16, only the declaration doesn't
> tell us.
> 
> Maybe one should rather fix this?

Good point. Sending V3 with this patch changed to fix read_id()
operation interface.

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
