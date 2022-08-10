Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C907EC00140
	for <linux-ide@archiver.kernel.org>; Wed, 10 Aug 2022 13:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiHJNwI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 Aug 2022 09:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiHJNwH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2022 09:52:07 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1F6A490
        for <linux-ide@vger.kernel.org>; Wed, 10 Aug 2022 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660139526; x=1691675526;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8p/CQBS45j5tICeYzJJVMoA/fdD7DghNb+CoI4HMZYI=;
  b=riaX0/IKweVNro3c/aTIpbudDaA4BbVcwdmTW4soSSIz5+0xbJa7T5Z4
   oNf/TKLjGkrz3UzABoqlJIefA+FtoP4CHc3fCy+XPXATx+Q5KiST8ddih
   BzspLN1BOAakYDt+n43FVPjQH9vxc9vKtm88vGbEbDth0gPkGV/5lfn1X
   xLaQuFIkbDpxzC1vyD30bLqa6erGNgKMacDCGcpMgZq9ogeYeBBPjEca2
   uFvjqZyiMsKVGu8cTFJiQ009dF+oLs3VsLxeY93PpNl1vaZ85sRmkFXo1
   uK1noKi+sPmlU8jbv4Zv+IudsM6Tam3SKi+sGiU//Mz5yliaCLDX0uKCf
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="208346231"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2022 21:52:05 +0800
IronPort-SDR: 0rUR7eZHmQnUUNuTeD4vF0Oodgf6ydRM2JsD2kj8CeUBcHhaL6v6BgNrmdlZCccJlejnG24URb
 tNCBHgwtkiqTkvked/UVXSHbrZgeqL553qNhRO1f5Lae43ZRLpR/wOU+OZn59TsvBCm1pcTZk1
 OuW9kTS7eF3ybh4lYIbSLQX9bK524GqIS9daze6TXqRZUNtduiwlBRFeeaxK2Ta6RpRF+wAnef
 r2qaXKSICfX9LDA2nBZ4tJOBGXAvjXalkpYZ2RC6p4c5QHaY7hGYZbjhu/odoUBS72wrZ1JnOK
 ecYowmMVcV0Dyo2stOIRsvd/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 06:13:00 -0700
IronPort-SDR: 0V6Hll5QaNbZqAi3QBv66WYWIILZxl7FBdGPArkUM2W/BP4NS5fVt1jhPOYzKtEOGvpkhlAH3Q
 IoylM+p5kYfKpRQhTbN8L8KCGAQg8uJvi/EejKAYzsMbFHRxSvgdn8fvKaSlU/N1/mJo4gmvV/
 Jz93X7a/w6fWqYNqpAgPy2y1dFx5Amj108CPEFhv7nv7rYHdfirXDJsg+OP31UwfK1UC9KDlKn
 WUB0DnSJucdRo+TZxKuTRnTeArQ36ugOAOjXvxkT9D+ocDBeqsXu0Tu3vHGPOpDlyFNsc8JtR0
 FgM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 06:52:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2rw50c4Fz1RwqM
        for <linux-ide@vger.kernel.org>; Wed, 10 Aug 2022 06:52:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660139524; x=1662731525; bh=8p/CQBS45j5tICeYzJJVMoA/fdD7DghNb+C
        oI4HMZYI=; b=otEE04L7O38+4u+ZpwLBrDlSZUcEYa5JrBnDLS41uaCHAl947nQ
        LorvLUhPNZGApSJ6qhJJfz2aiSpFyt/tcxeHaVN0STPnS/tLnXFkLWzO0BcJL9BH
        8SZPTq3ibepP1sDLOyz5X3Xo+Y/BNUlgCbqvCxI6IG0dTnCjQVnCELdEGILYbUrl
        qNLVBj9n8r8EzOAx3iWGJtZEtO+X+D0wEjgA+32RPRwZcUMrbsvmfZ6YnFfeGT8R
        o8iatbjcu3hbRb4OmtvI8s/Oa/OhU9TT4FVFHWKG/t84gohcVnRURowKaSYiYJ/M
        EbvAq7gTpor3m5xtt8MB5JKPnQAGihWTmsA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Gj8ef2BYHjzP for <linux-ide@vger.kernel.org>;
        Wed, 10 Aug 2022 06:52:04 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2rw367vnz1RtVk;
        Wed, 10 Aug 2022 06:52:03 -0700 (PDT)
Message-ID: <b3ce0a28-0f94-6d2a-3f88-998da8f870b4@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 06:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-ide@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
 <16f03f81-a8c7-bacf-c74c-67231f7f7202@huawei.com>
 <ef84d2dd-84ea-e1c7-05ef-f0a082d4f7d0@opensource.wdc.com>
 <82dbf4d6-2d43-20ff-22a7-857f9f11a5ce@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <82dbf4d6-2d43-20ff-22a7-857f9f11a5ce@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/10 1:33, John Garry wrote:
> On 09/08/2022 15:57, Damien Le Moal wrote:
>>>> As far as I can see, this patch should not make a difference unless the
>>>> ATA shost driver is setting the max_sectors value unnecessarily low.
>>> For __ATA_BASE_SHT, we don't set max_sectors. As such, we default
>>> shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS (=1024) in
>>> scsi_host_alloc(). I assume no shost dma mapping limit applied.
>>>
>>> Then - for example - we could select dev->max_sectors =
>>> ATA_MAX_SECTORS_LBA48 (=65535) in ata_dev_configure().
>>>
>>> So with commit 0568e6122574 we would have final max sectors = 1024, as
>>> opposed to 65535 previously. I guess that the problem is something like
>>> this.
>>>
>>> If so, it seems that we would need to apply the shost dma mapping limit
>>> separately in ata_scsi_dev_config() and not use shost->max_sectors.
>> OK. Will have a look at that.
>>
> 
> We may need to introduce something like shost->max_hw_sectors, which is 
> set according to sht max sectors and dma mapping limits. That could be 
> also used in USB scsiglue slave_configure()
> 
> Or else set max_sectors value for __ATA_BASE_SHT, but I don't know a 
> sane value there considering ATA_MAX_SECTORS_LBA48 gives max_sectors of 
> 65535.
> 
> Damien, please let me know if you need help now. I am just waiting for 
> you to test to prove this theory about dev->max_sectors being capped. I 
> don't have an AHCI setup readily-available for testing - just SAS cards 
> or QEMU.

I am on it.

> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
