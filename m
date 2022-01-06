Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5C4C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  6 Jan 2022 04:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiAFEuw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:50:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42281 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiAFEuv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 23:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641444651; x=1672980651;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fxhRNLsyq2y4gmGVF+MxHtUdj9JqBUhcBq/7dmX17KQ=;
  b=OdisAESE7Kxtc9xQUHnsj073Xb1NQv8xLHDCfYFv4vTEgXmD5T26f4QQ
   nWpWl2P0yvNgfufhfgD+XJH8766QAs1pCHMRLXBeHm0MFc3X82Kpb86x0
   uVlYdaKkRArQjxLMLWncxD0EmNidlY3kWILSbjEelKTRIHj+6WKHKZfNK
   98tKfDrsF8sAvi2I/4UZX16QCy1Ysfl6CxcL1+z5vjuYrJMV/xUggzf04
   GbEgwz2nreUlK9qhyw8MGLUTlO9zc6SjmRzMRIUzZV9uoshot4Gl2CTMM
   FwS0wzj9zuV7F2MgkvNo+DiOqndb++F7BBpHdIAfIjSab5vxpylFD3OeB
   w==;
X-IronPort-AV: E=Sophos;i="5.88,266,1635177600"; 
   d="scan'208";a="188770630"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2022 12:50:50 +0800
IronPort-SDR: ONyRwFYupxUfoKIEuSYhWWH+VsZCUchmXqBlxuOo827CTHsajMfgQUjLZM8Oen7nfTLT0ZTzeB
 TIi1z8uSew93U/ET379FXIqA3uxx7+T7ZNkNVF6Azsmqcp53rVTRKwbIsiUpDfq5Vkd1gCVsRb
 NYaXfzfnhLQ965mXSbMbYstAhVk4+bJROsVKAEPdl67MUYMbeV1criwPF5uBvJfiQ/bjZBAGBF
 D4rqaYBZxbj3eGZgZce0eYHwLMxAxsRm4xNGBJVbxNZmRPnITOP8cz8pBptmJFRBY+Kvny28h+
 ZAil2diR6KQWwnJbOtG7n6JY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 20:24:42 -0800
IronPort-SDR: lNZZvWqnytAT6bUx7foS9hyv5+qfqyfd/779MrlFuhCWY11H5YHW8VBbq/yWo9LBzw68DT17jT
 OSJTy24q/BVpCeDIp1Q8DSd8IQVVncCPKP43mKGjtQyrn+uZuNTkvruOTIH96YgvDbzVZ5k0AB
 DH0RHCjIG8fRzQkih3dGDLLTUNJgBCl8Qzqbic+OeWceVZ4MR8su78I8z0gaPhHok7CQaKSzCv
 jL/m2o6zcOmK6RmIMf+p2lVXTAD9dLPsHDHu7g9HqNm2umrbSM39HQEQnOnBwSptb/fyQn+yOp
 GY0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 20:50:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTv7G4TNQz1VSkd
        for <linux-ide@vger.kernel.org>; Wed,  5 Jan 2022 20:50:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641444650; x=1644036651; bh=fxhRNLsyq2y4gmGVF+MxHtUdj9JqBUhcBq/
        7dmX17KQ=; b=gUo+1Wle1pzKqUdqIoTWDP+ut1UOOZ8bs+O10/NSsEAoIE7yPHF
        dgmsdXkdwzBiYGSN4Z/1quW25bW35lg/nadFwKxep16GzvQck/lY3kkT9I3j0nTL
        e/g4Pjhy/XnQUAEsP+H1LWmkiQDNEcltlOD+d9e3QskJBtSMzOaakmMOpdj3Os47
        XThzRCz/FWjxSJoc9pad87Jor/qXmcha3mXKnWXGulj6Q2VUsWDxqDrRbwmdoKUB
        MS6K8O43Ljjk7KjzrvkXEy929BnYV9DChFwUZcvo84M7GNbTBa81g6hnjehMwHUi
        m1CepYzNvC8qLbsjcRRQ+kO3lMGEq8NVVGw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jBCClCNYwGx9 for <linux-ide@vger.kernel.org>;
        Wed,  5 Jan 2022 20:50:50 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTv7F6rh4z1VSkV;
        Wed,  5 Jan 2022 20:50:49 -0800 (PST)
Message-ID: <28e7e124-dd00-8675-a5f3-04c7f11a12cb@opensource.wdc.com>
Date:   Thu, 6 Jan 2022 13:50:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 13/22] ata: pata_cs5535: add compile test support
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-14-damien.lemoal@opensource.wdc.com>
 <fb93163c-0f17-a817-b6ce-f101bc585011@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <fb93163c-0f17-a817-b6ce-f101bc585011@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 20:35, Hannes Reinecke wrote:
> On 1/4/22 11:58 AM, Damien Le Moal wrote:
>> Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
>> configs that do not have X86_32 enabled.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/ata/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index b706a3a64b11..daf57a4e8196 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -654,7 +654,7 @@ config PATA_CS5530
>>  
>>  config PATA_CS5535
>>  	tristate "CS5535 PATA support (Experimental)"
>> -	depends on PCI && X86_32
>> +	depends on PCI && (X86_32 || COMPILE_TEST)
>>  	help
>>  	  This option enables support for the NatSemi/AMD CS5535
>>  	  companion chip used with the Geode processor family.
>>
> Looks weird, but seems to be de rigeur in ata/Kconfig.

So it turns out that this one actually compile only with X86 32 and 64
because of the use of asm/msr.h functions.

So I changed it to:

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 9d37485c638b..c432cf205589 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -637,7 +637,7 @@ config PATA_CS5530

 config PATA_CS5535
        tristate "CS5535 PATA support (Experimental)"
-       depends on PCI && X86_32
+       depends on PCI && (X86_32 || (X86_64 && COMPILE_TEST))
        help
          This option enables support for the NatSemi/AMD CS5535
          companion chip used with the Geode processor family.

I kept your reviewed-by tag. Please let me know if this is OK.

> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
