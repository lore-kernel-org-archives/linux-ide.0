Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0A6CCA473
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jun 2022 00:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245162AbiFPAbh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 20:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiFPAbh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 20:31:37 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D95710A
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 17:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655339496; x=1686875496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J4Y9wKkt06E+VVt0NnuJS5WQFB9LInYK8Z8767j+vko=;
  b=mFinrey16E4xZ35GVwPBSMTesDQAWtLxBUy1rmro7Le1ZYKUd43AgjCe
   fkkNzVKTThkS26m/GEc1F4KW01Pyri3dET28r+Nc0t34UNKzEcMQEmQ8b
   b4d5fyZ75VR2cy1qHhIb+olTJRmq+OkujT4Tw4nfauo9mOjsgpDXwXWvQ
   1SQvotM+6ehs7Tarv3oYuRkdJHymCohEUHpvZEVV5IMYxEX1Ls6PxfQUB
   uumKYkfpTsTsFj1X9xEmZf2xwV1VelpsSHwlcwD822RqVUHi4ryi5ArZY
   WRrXixg2PYZRkj528HdK1VQk6XeoaEPOOP7iB0DOFHdO5raPLvPqk+ovK
   A==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="307573729"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 08:31:34 +0800
IronPort-SDR: PoFH7Vq4AsGxV2RbRELF9Th70TtHtZINpovRiwwNK64rglqSAMwH453F+fgsmkteNZsLbCLKb4
 X4JtVe/MUas1yvA/wpM3yH8uq4Wd4MZlOkwS2lz0nL4AlPZe9cUPk0/Ma+3MzymiiNdjxU1Bm1
 LQMJbCe12IGkzXMnBBAQlLo+LhZ8466jXiO2u9Jd6lP2oGlwBGB1k9Fpqvp1v3RiNNKI2TpgBG
 nS+xs5i/tgz66UIXfN48znvUeo8WznQZPxk3EofwCrO1PSxfCmPX3OmLGwgNGaaN4rIceMssGg
 CMsz7k3YIeYSJG5I9brDPw1m
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 16:54:24 -0700
IronPort-SDR: nlbBwRddXFCFhxAGpi/Z2qaCgBGJ+tS+7ZhX9wIWbymaV7QIwNk34snemDEy6t6ttpvTzNWL7B
 EAPLv3/DDw75Mi+1yib0GMrnwbhDL2VD+OUTmWcZp9ucYeks8cyauk6rdRIB97QBPDd3LWRQ+t
 grMNF8dH+gLUwV61LjmdsByzPZXGVGa/UV1YIgCtFoRhSh/9OEIHw1CTxrSx6ubCErF52zpM8k
 X+AzCSsraCNZzwJ7ibeyuIVMBP26zB1s7vWGqpF5x2Po5U/EbjXPTnyjlfaoLtvQjvD+1Abq1I
 k+U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 17:31:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNjlp3qJRz1Rvlx
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 17:31:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655339493; x=1657931494; bh=J4Y9wKkt06E+VVt0NnuJS5WQFB9LInYK8Z8
        767j+vko=; b=PP8LAnE1EMtjRy07QVwzbzWvAVqgr/SlOCl7utLfLbHpn7FYlqz
        OF69rmm2s02I9FqrPvviNgo+SLOpRFFZhhh5dbqr5SyFHKHvWUTiO5J9C8St09ee
        dhX3R41wI1UkEL04Iod7+QZIWskkJJSNycUkzn0jqqRD+wZWg5C1IbdA9yBPtR2B
        Xg/BJSOWTA9GkDg7ZoUSvkg2phZHDYRVrkxcc8T6NR8QC53jzvzliv/tIrie0u9C
        aY3hqeDAsO+wWK7F8gv6t1SZW3um66mIj/8QEEck+pU23X4Wrmsk0XRtibciNYXb
        jKEVdMvdLV/XZe+HF2hBytKFtlSj/Yu5eRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bchFErUPRGPX for <linux-ide@vger.kernel.org>;
        Wed, 15 Jun 2022 17:31:33 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNjll5zM3z1Rvlc;
        Wed, 15 Jun 2022 17:31:31 -0700 (PDT)
Message-ID: <bfaf0208-8416-c159-93f8-8cc31dbc7ef5@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 09:31:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 19/23] ata: ahci: Add DWC AHCI SATA controller support
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
 <6c02f8ef-8aea-8f80-590d-343f67a96f8d@infradead.org>
 <20220610215850.ju76kxjquwef6kd3@mobilestation>
 <73716f9f-892c-41c5-89f0-64a1985438aa@infradead.org>
 <20220615213029.3upsmasnnhigqozm@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615213029.3upsmasnnhigqozm@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/06/16 6:30, Serge Semin wrote:
> On Fri, Jun 10, 2022 at 04:34:13PM -0700, Randy Dunlap wrote:
>> Hi Serge,
>>
>> On 6/10/22 14:58, Serge Semin wrote:
>>> On Fri, Jun 10, 2022 at 09:34:46AM -0700, Randy Dunlap wrote:
>>>> Hi--
>>>
>>> Hi Randy
>>>
>>>>
>>>> On 6/10/22 01:17, Serge Semin wrote:
>>>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>>>> index bb45a9c00514..95e0e022b5bb 100644
>>>>> --- a/drivers/ata/Kconfig
>>>>> +++ b/drivers/ata/Kconfig
>>>>> @@ -176,6 +176,16 @@ config AHCI_DM816
>>>>>  
>>>>>  	  If unsure, say N.
>>>>>  
>>>>> +config AHCI_DWC
>>>>> +	tristate "Synopsys DWC AHCI SATA support"
>>>>> +	select SATA_HOST
>>>>> +	default SATA_AHCI_PLATFORM
>>>>
>>>
>>>> I don't think this needs to default to SATA_AHCI_PLATFORM.
>>>> It might build a driver that isn't needed.
>>>> And it's incompatible with "If unsure, say N."
>>>
>>> Basically you are right, but this particular setting is connected with
>>> the modification I've done in the drivers/ata/ahci_platform.c driver
>>> in the framework of this commit. I've moved the "snps,spear-ahci" and
>>> "snps,dwc-ahci" compatible devices support to the new driver. Thus
>>> should I omit the SATA_AHCI_PLATFORM dependency their default kernel
>>> configs will lack the corresponding controllers support. If it's not a
>>> problem and we can rely on the kernel build system ability to ask
>>> whether the new config needs to be set/cleared, then I would be very
>>> happy to drop the default setting. What do you think?
>>
> 
>> I'd prefer to try it like that.
>> If it becomes a problem, we can go back to this v4 patch.
> 
> Agreed then (seeing Damien is silent about your comment).

I have not thought about it :)
I do not use SATA PLATFORM at all, so I am not familiar with its dependencies.
Will have a look and do my usual build tests anyway.

> 
> -Sergey
> 
>>
>>>>> +	help
>>>>> +	  This option enables support for the Synopsys DWC AHCI SATA
>>>>> +	  controller implementation.
>>>>> +
>>>>> +	  If unsure, say N.
>>>>
>>>> -- 
>>>> ~Randy
>>
>> Thanks.
>> -- 
>> ~Randy


-- 
Damien Le Moal
Western Digital Research
