Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36B8ECAAD8
	for <linux-ide@archiver.kernel.org>; Fri, 16 Sep 2022 14:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiIPO0D (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Sep 2022 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiIPOZi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2022 10:25:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E21870B4
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663338330; x=1694874330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0f2NXsnt09kykeOUx0p0v9D2F1AQozDVggYV4cUMoxU=;
  b=ncG/+edKlUfE5O9SJkERIXZtT1htW2gu/+Ib3OhAUct5aLbwmJhKVYra
   +zXFBREOxMXwGhlY2asgkwML2GR0J6HtI+1853uShLbLuK3cyA0QG1seo
   O6w3B1QhtYgYxFQtice8/FrZMWFPI2UZlB8PGuGrcVz1UeXWmFZzX38vJ
   TOGLyPAwThJOp14VyEhtM3t5WR3TRRqUn8W/W69e57tGdvSDx9rHZEDHh
   d3/fPKa61cb0se5O+6OtSLbyiSXlonnf4wvgTdQTryC+c2ebQuHINsYVa
   u+y1InQuS0EycTCIUkLg1rb00jfEXiYGnhxpqb+6TAnzde0KjqjE74OBV
   w==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="209931116"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 22:25:30 +0800
IronPort-SDR: ULclBQnurj3mwNIifkgXnOiC49FiPK5S/B/cGdwOLSotWQiwuBLcPjMmFCwLK/l4wF+ptbIcDz
 LDkr2lydUsk7YSBKOkdzeF79QJAmMJO5MwLpdpCOUCCVVOh4jaaV7f76av71jb9sn6DuHOSpLj
 FRs28jQ1bQ9uvgZJyCvwFSrl1tgs/PWXGBzlYAWswaO/NpzkQcdrTE0w4RGMykgp1TgPkDKfR9
 EswtZ0Nb4b+Uc+MjswViuLxnC2/5b/Rog1Dz6RniBbPPTyNcd9eKAopU6vFVVx1QyGDH3VhUQT
 O3a89oDXniIXlQ5EpkyHbP67
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 06:45:40 -0700
IronPort-SDR: VRZJGGZURRYB2x7QwFliPTMjKwtG+XYQJ8M8uqTtPHUHDGo0mwHGQ4DU3grq+DuX3aAbuYsm1o
 rNzLNuC1hEFIWsyUO0q7FdcT3+E5v8nwC3jWDobezY/UEjvkRTGmazhMPmrsPU8XgO3Eu24rwq
 5SSmFasiAajgRnxNuDA39+qtrGWzOzwi6tYJVdsVnWfvJgXfB50xuWW/v/Raa56HlVHBV5HYiv
 5HH5pYufUCpAyW2N3c88lG9hm29V3og5UwuSfuUr5P1yecLG1xfEHaqgLLrUmbWogzHe7KouLT
 a90=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 07:25:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MTbvZ040Qz1RvTr
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 07:25:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663338329; x=1665930330; bh=0f2NXsnt09kykeOUx0p0v9D2F1AQozDVggY
        V4cUMoxU=; b=auys+ML6/U7Ohc24y50KIrz2vB7aXYM2DbiK/Gtt/wn9Djq/ZkM
        3gXRp76Te5EfCQSyTjSWIM0GBIkjyY1DeTDsmsMMPaSYnWPp6W1VGy6m7BFpHqGV
        EV2QVCIl5SNfxfdab+mWTlJB2bOLnWBT4HJFSEaMg+Jdf7Fc2uW1jHy4yaOWqBFT
        M9wzrajhNs+8gPnmRZPcpQE1PgH435SAb6K+rLkOhWU9geBhe7JEjDlsVW6kj98R
        5TWQUM/i+kQCV2KKwOx5EL9ZhcdvSAMzMXbVNWURnKsYW1I0SDo7mCwZNcxAEWKv
        6i8rFP2HD/pWtM7j8lqN1fPL0BkipeJCJZw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id djbJ4EjW0umJ for <linux-ide@vger.kernel.org>;
        Fri, 16 Sep 2022 07:25:29 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MTbvW2v4zz1RvLy;
        Fri, 16 Sep 2022 07:25:27 -0700 (PDT)
Message-ID: <9bf170d7-4b7f-fd9e-872a-be67dfec8598@opensource.wdc.com>
Date:   Fri, 16 Sep 2022 15:25:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] ata: libata-scsi: Improve ata_scsiop_maint_in()
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20220825223912.355011-1-damien.lemoal@opensource.wdc.com>
 <Yw9v7gZwJwp7SjNN@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yw9v7gZwJwp7SjNN@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/31 15:27, Niklas Cassel wrote:
> On Fri, Aug 26, 2022 at 07:39:12AM +0900, Damien Le Moal wrote:
>> Allow translation of REPORT_SUPPORTED_OPERATION_CODES commands using
>> the command format 0x3, that is, checking support for commands that are
>> identified using an opcode and a service action.
> 
> So, while the function ata_scsiop_maint_in() has the kdoc:
> *      ata_scsiop_maint_in - Simulate a subset of MAINTENANCE_IN
> 
> It actually only handles a MAINTENANCE_IN service action (command).
> 
> The name is thus quite misleading.
> Perhaps you could do a patch 1/2 that renames the function so that
> it is more clear that it only handles a single service action.
> 
> (If we ever add translation support for more than one action,
> we could reintroduce a ata_scsiop_maint_in() which calls the
> correct function to translate the correct service action.
> 
> 
> 
>> Allow translation of REPORT_SUPPORTED_OPERATION_CODES commands using
>> the command format 0x3, that is, checking support for commands that are
>> identified using an opcode and a service action.
> 
> If you rename the function, the commit message will make more sense,
> but could be further clarified to something like:
> 
> """
> The ata_scsi_report_supported_opcodes_xlat() currently only handles
> currently only handles a command specifying "REPORTING OPTIONS" field
> set to 0x1.
> 0x1 means:
> return data in one_command format if:
> -The opcode in REQUESTED OPERATION CODE is supported,
> REQUESTED SERVICE ACTION field is ignored.
> If opcode implements service actions, then terminate the command
> with CHECK CONDITION and sense key set to ILLEGAL REQUEST and
> additional sense code set to INVALID FIELD IN CDB.
> 
> Add support for translating a "REPORTING OPTIONS" field set to 0x3.
> 0x3 means:
> return data in one_command format if:
> -The opcode in REQUESTED OPERATION CODE does not have service actions
> and the service action in REQUESTED SERVICE ACTION is set to 0x0; or
> -The opcode in REQUESTED OPERATION CODE has service actions and the service action in REQUESTED SERVICE ACTION is supported.
> else:
> the command support data shall indicate that the command is not supported,
> i.e. the support field is set to 0x1 rather than 0x3 or 0x5.
> """

I have dropped this patch for now. Will rework it.

> 
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/ata/libata-scsi.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index f3c64e796423..99ebd7bf3a9c 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3252,11 +3252,12 @@ static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
>>  	u8 supported = 0;
> 
> A supported value of 0x0 means "Data about the requested SCSI command
> is not currently available".
> 
> However, considering the differences between 0x3 and 0x1, if we want to
> follow the spec strictly, we should initialize the variable "supported"
> to 0x1 rather than 0x0, when the supplied REPORTING OPTIONS is 0x3.
> 
> REPORTING OPTIONS 0x3 mentions that "supported" should be 0x5, 0x3 or 0x1.
> So (according to the spec) 0x0 does not appear to be a valid value when
> REPORTING OPTIONS is 0x3.
> 
>>  	unsigned int err = 0;
>>  
>> -	if (cdb[2] != 1) {
>> +	if (cdb[2] != 1 && cdb[2] != 3) {
> 
> Considering that this function never terminated a command with
> sense key and additional sense code set before, none of the commands
> support a service action.
> 
> Therefore, we could change this to only allow commands where:
> cdb[2] == 1; or
> cdb[2] == 3 && REQUESTED SERVICE ACTION (cdb[4] && cdb[5]) == 0x0
> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

