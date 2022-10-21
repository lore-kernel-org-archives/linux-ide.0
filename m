Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9C9C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 06:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJUGuY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJUGuR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 02:50:17 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21A85BC82
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666335007; x=1697871007;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4HZL8varuwaD1OLHHmE9otBppZBleq/gxHH3YyCcM3w=;
  b=leBgmcS2t6RGi0Mev41zhtKZXJ3mshreeWil7UnHF6pKkVKniBLizWEF
   anBi/Q3g5wjTswb2HtDsU8qocxKWsymnNQVkc8dDbIwU0hmiaawAmVRlj
   Z0KLKDoNRrAsnUdXporXzrCQ7vLX1VB+XNauQweZcbAILJiBimyu6TYqq
   9buqrXouMQuO1I23k4SB7RMB91yZTq2AlXyzDNfuiq4xs0sAzpB2kkV8R
   13N7Zo0KwExvj193lxcTBNFeZQZpkOZbh3za2bDV/+pMMIYFD6e6CB2KN
   IMeV1xa84+ULyjV9pNE2hxfg51T3Z/IKuzGukPqZphN017dwpPvY+LK2f
   A==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="212723403"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 14:50:05 +0800
IronPort-SDR: kSsUGhHeDAmh22mVtLtvi9KpajQReDIPG5xEpUriiR8UP2U58TKNOLfQs0jVqp6Qog96OuJM8f
 VaG/J62q2IArHu6PQl3BDyDJ9CXXLlUaC9liVXDZdzXBy4JDC1TyQ6fnap1h5zWKh+E7DKXTWq
 ROTH2XXBcPH3JQVjucNnlees+hOclxGrxwdp24I33dsQVF0ep7MCwYoydc+iJlNB+MgAH2ZIAg
 N/AEtq8z4oILICv4VEfeKQUFSRJ49wTvEZesBarh5d/hivod9BwkbL0cI0eRdfwu5dtUXprabP
 P3b8KP8fo2ceSRNC4WYBkAou
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 23:09:33 -0700
IronPort-SDR: PyBsUy6rhsPyrVh2X7473FcFLHUSGquFYkybR1ZRu6iA47mbA3kjNt0qZtyQoDxxfzmSXTApob
 tCKFJy6wm3c5bcnA0oULPYxYOPFpxr9u6yHVoA9aoWvE0rikE2a1QIgu8zA4gxewEM6DTc/N5S
 sl1Ule/n2I9MBHiSuPkH8jJMqZISwdOMi42Qh6saEE4gKTeR+9BJwZ2Muh6+u3fj8VxUeB1uuj
 6HJe3j8c3OZ971KM84OIYqxbXph33t/adKmKGEBOm3nCFLNY34Qbv1BHzErl+Ul9rv+2PU52Vo
 A0c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 23:50:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mtw7w5Z8kz1RvTp
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 23:50:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666335004; x=1668927005; bh=4HZL8varuwaD1OLHHmE9otBppZBleq/gxHH
        3YyCcM3w=; b=jfdjIcTvIjCvJGBoJe1eKC8sR8G3iPN5MSGAp6geyG/3nNCCq+w
        lOlNoSBglORgpwXKu42geCcQoXaJcQdZ6cQyYRAU6K1EwAuWfSjWIB6xnHEV1RES
        H2R6DsUoN+t4syZtrcLYj+PUuSGk6BrbylzL0m1axcWDj9/raETh71k4zf5nmMpZ
        fLf5hkmZooTbuDlyJMaMC4V82sHrZJAB1AOu6vP+yA8EQ0OdnRtIJPPCDZhRAgKT
        DauI61ilobMjk9SFcrumlTz5y6cZIk7b7Q5GsEcbkbJTOWe8MgKIKWegHHsPhJMs
        9JrC0xmnAMF+eG0swsSYOAmjf0AUuWBpPPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2pZt-hVP0EOO for <linux-ide@vger.kernel.org>;
        Thu, 20 Oct 2022 23:50:04 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mtw7v6Trhz1RvLy;
        Thu, 20 Oct 2022 23:50:03 -0700 (PDT)
Message-ID: <1ccb3faa-a727-6b4b-cabc-320c7a21ca09@opensource.wdc.com>
Date:   Fri, 21 Oct 2022 15:50:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/3] ata: libata: allow toggling fua parameter at runtime
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
 <20221021053809.237651-3-damien.lemoal@opensource.wdc.com>
 <c1fc6322-d6d4-4579-1281-130e0546883b@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c1fc6322-d6d4-4579-1281-130e0546883b@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/21/22 15:21, Hannes Reinecke wrote:
> On 10/21/22 07:38, Damien Le Moal wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Currently, the libata.fua parameter isn't runtime-writable, so a
>> system restart is required in order to toggle it.
>> This unnecessarily complicates testing how drives behave with FUA on and
>> off.
>>
>> Let's make this parameter R/W instead, like many others in the kernel.
>>
>> Example usage:
>> Disable the parameter:
>> echo 0 >/sys/module/libata/parameters/fua
>>
>> Revalidate disk cache settings:
>> F=/sys/class/scsi_disk/0\:0\:0\:0/cache_type; echo `cat $F` >$F
>>
>> [Damien]
>> Enabling fua support by setting libata.fua to 1 will have no effect if
>> the libata module is loaded with libata.force=[ID]nofua, which disables
>> fua support for the ata device(s) identified with ID or all ata devices
>> if no ID is specified.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>   drivers/ata/libata-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 6008f7ed1c42..1bb9616b10d9 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -128,7 +128,7 @@ module_param(atapi_passthru16, int, 0444);
>>   MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>>   
>>   int libata_fua = 0;
>> -module_param_named(fua, libata_fua, int, 0444);
>> +module_param_named(fua, libata_fua, int, 0644);
>>   MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
>>   
>>   static int ata_ignore_hpa;
> Hmm. I guess you'll need to revalidate the drive when changing that; but 
> this can be done in a later patch.

Well, this is not sysfs, we cannot do this automatically easily...
And thinking about it now that you mention it, going from fua=1 to fua=0
can actually cause problems. The reverse not, since scsi side would still
see fua=0 until revalidation.

So... Unless we find a way to link the param write to reavlidation, we
should actually not allow this.
Maciej ? Thoughts ?

> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research

