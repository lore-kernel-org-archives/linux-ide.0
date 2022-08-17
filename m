Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97992C25B08
	for <linux-ide@archiver.kernel.org>; Wed, 17 Aug 2022 15:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbiHQPzP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 17 Aug 2022 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiHQPzF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2022 11:55:05 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF39598A6F
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2022 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660751703; x=1692287703;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Da4nMJ1F9CkVDkvWNzoxhW66X+iNWqedHoEO8QVLg1M=;
  b=Jm39MN4MYhcURh9wmgDEXCBEL0D8lqhnOCg9IC2LLRlxO9En03UcSEm0
   A9GtoCVVCjtK08sMyxrY3yiwR0P+pBWdPL7iXO8CwXuqB2vjzdM/V7ISt
   fI4AEjU36nR/5fiUTjTB+/+nKNbdewLSQim0eRCnYRO6YeP34Wy32CV6q
   RkRbH3sbvzzIweMBZM7C2z+oUgqydstCFWp+PqeNNPQMvXPP1lr+e0OWJ
   pItcvVjZIqtt7xY/ZzFGxn+hb6wMIURTR2hLs2tahtcUSqvdWJPUXx5cq
   fUJ4f6949PCdV9+i7Flzc3dQfddHeiZUZLWKxIGHF96g27H+tKHCsmjyl
   g==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654531200"; 
   d="scan'208";a="208953480"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2022 23:55:02 +0800
IronPort-SDR: q6dNK6EewoSZlqBlWmJjtDzQZufHq5aeDn2ggm+bwRuEHeIlCGYK/eIV+zZnoq0SFxPGsdj0kQ
 z357GtzhCqNzQQkwKhCensuYOuoCZWIiQsMeNwQq1Q3Zr2WsuD/kMMUETfq6BoG5eACPG6QEEA
 HMIyEBjq9T2h41oERPLkqN6WcYYiHNxbdV3StLRtuNy7cCSMW0stEa6fdduEUZUCa14JctFy6E
 U/RvgrwDhLWH9KKauYrXyjU7lLQSD08AQt86Bo1j/a/sqOL9AKrqSlXICAF7YC+5WPGs/LIqxS
 3NhDvjt+Jtul3BHNHNcA/OBJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 08:15:50 -0700
IronPort-SDR: ubxZIm88k0zXQb4rFNWfQvjjPm0Saukt/pHSa8FGHznR1yi38Ft+ho4n7y9JcXKr7h0LwMC+Tr
 wJcnBy1c/B0HuoHTDexUvVAIWj80AG+b5MlqDU4fqElnfYuGybqJqrt8sxqnufNeUts+Q9d4Gj
 HXLrJcTp5yr+XAR3y++/GEYMvA4nFv7BCJjfnz2gMbu6gVg5qNkpBpfj88XyJOsYQUWp0EyX6n
 7szqSp8S7wDFpNepEzOvpZc/HqJPKg4hlGp6ZClCt4URZ43AqXFm5U3I6Q0xHyEKGxEaXOTAtU
 xlI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 08:55:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M7CJk5ptlz1Rwnx
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2022 08:55:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660751701; x=1663343702; bh=Da4nMJ1F9CkVDkvWNzoxhW66X+iNWqedHoE
        O8QVLg1M=; b=a8E4b6TYglEZqemoz/IvureRzXS2h0BxBVr6myCFT2djYIy2Q8a
        uOrg4utMi2iF33DWYAUjZqOmQaw1UBg+6PgpvdnUc0iK3eCJPYfDxFwhTf6dfmTY
        JHnFaA/ID4knX74B60BkhAOSskHkaZkiSU6f38w2oHAMtukmu3yxxD/Xs5Lru4Zp
        sxx4mUhPpPhdUoL3KQ6NLjyBu2lS0QUZIsOdWFD7Pl5qXlud0P12cRKB95aXshh1
        QMDX19qWOf/gEkJY/DXJihU7aS22PvfgMk07HAt18C2uG2m0ArHlQOxCAS74EytQ
        p1z4ZW1/Gu7LXGJqpKytFjoPi5uNgNzKd6g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YBm4r1dk4JQn for <linux-ide@vger.kernel.org>;
        Wed, 17 Aug 2022 08:55:01 -0700 (PDT)
Received: from [10.11.46.122] (unknown [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M7CJh5Fs8z1RtVk;
        Wed, 17 Aug 2022 08:55:00 -0700 (PDT)
Message-ID: <e46c8627-3444-1dd1-8fd9-a10b7f3f3851@opensource.wdc.com>
Date:   Wed, 17 Aug 2022 08:55:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Oliver Sang <oliver.sang@intel.com>
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
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
 <YvXeuCAK780OuJPz@xsang-OptiPlex-9020>
 <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
 <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
 <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
 <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
 <43eaa104-5b09-072c-56aa-6289569b0015@opensource.wdc.com>
 <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
 <05a48c68-33ae-10e2-e565-6c124bad93c5@opensource.wdc.com>
 <c93e529d-b688-9910-50c4-779c2f85fbc3@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c93e529d-b688-9910-50c4-779c2f85fbc3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/16 13:44, John Garry wrote:
> On 16/08/2022 21:02, Damien Le Moal wrote:
>>> ou confirm this? Thanks!
>>>
>>> On this basis, it appears that max_hw_sectors_kb is getting capped from
>>> scsi default @ 1024 sectors by commit 0568e61225. If it were getting
>>> capped by swiotlb mapping limit then that would give us 512 sectors -
>>> this value is fixed.
>>>
>>> So for my SHT change proposal I am just trying to revert to previous
>>> behaviour in 5.19 - make max_hw_sectors_kb crazy big again.
>> I reread the entire thing and I think I got things reverted here. The perf
>> regression happens with the 512/512 settings, while the original 1280/32767
>> before your patches was OK.
> 
> Right, that's as I read it. It would be useful for Oliver to confirm the 
> results.
> 
>> So is your patch defining the optimal mapping size
>> cause the reduction to 512/512.
> 
> The optimal mapping size only affects specifically sas controllers, so I 
> think that we can ignore that one for now. The reduction to 512/512 
> comes from the change in ata_scsi_dev_config().
> 
>> It would mean that for ATA, we need a sane
>> default mapping instead of SCSI default 1024 sectors.
> 
> Right
> 
>> Now I understand your
>> proposed change using ATA_MAX_SECTORS_LBA48.
>>
>> However, that would be correct only for LBA48 capable drives.
>> ata_dev_configure() already sets dev->max_sectors correctly according to the
>> drive type, capabilities and eventual quirks. So the problem comes from the
>> libata-scsi change:
>>
>> dev->max_sectors = min(dev->max_sectors, sdev->host->max_sectors);
>>
>> when sdev->host->max_sectors is 0 (not initialized).
> 
> That cannot happen. If sht->max_sectors is 0, then we set 
> shost->max_sectors at SCSI default 1024 sectors in scsi_host_alloc()
> 
> For my proposed change, dev->max_sectors would still be initialized in 
> ata_dev_configure() according to drive type, etc. And it should be <= 
> LBA48 max sectors (=65535).
> 
> So then in ata_scsi_dev_config():
> 
> dev->max_sectors = min(dev->max_sectors, sdev->host->max_sectors)
> 
> this only has an impact for ahci controllers if sdev->host->max_sectors 
> was capped according to host dma dev max mapping size.

Got it. I think your fix is fine then. It brings everything the defaults to what
they were before the dma max mapping patches.

> 
> I will admit that this is not ideal. An alt approach is to change 
> ata_scsi_dev_config() to cap the dev max_sectors only according to shost 
> dma dev mapping limit (similar to scsi_add_host_with_dma()), but that 
> would not work for a controller like ipr, which does have a geniune 
> max_sectors limit (which we should respect).
> 
> Thanks,
> John
> 
> 
>> So maybe simply changing
>> this line to:
>>
>> dev->max_sectors = min_not_zero(dev->max_sectors, sdev->host->max_sectors);
>>
>> would do the trick ? Any particular adapter driver that needs a mapping cap on
>> the adpter max mapping size can still set sdev->host->max_sectors as needed, and
>> we keep the same defaults as before when it is not set. Thoughts ? Or am I
>> missing something else ?
>>
>>
>>>> The regression may come not from commands becoming tiny, but from the fact that
>>>> after the patch, max_sectors_kb is too large,
>>> I don't think it is, but need confirmation.
>>>
>>>> causing a lot of overhead with
>>>> qemu swiotlb mapping and slowing down IO processing.
>>>> Above, it can be seen that we ed up with max_sectors_kb being 1280, which is the
>>>> default for most scsi disks (including ATA drives). That is normal. But before
>>>> that, it was 512, which likely better fits qemu swiotlb and does not generate
>>> Again, I don't think this this is the case. Need confirmation.
>>>
>>>> overhead. So the above fix will not change anything I think...
> 


-- 
Damien Le Moal
Western Digital Research
