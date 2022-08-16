Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE8C25B0E
	for <linux-ide@archiver.kernel.org>; Tue, 16 Aug 2022 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbiHPUCJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 Aug 2022 16:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiHPUCI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 Aug 2022 16:02:08 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF8C7E83A
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2022 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660680126; x=1692216126;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GW2FhXTQRa9w1jg97NyRwrL/BtMEvGXmVvkBoETYrKM=;
  b=csASfv0uF0gLgaHr324OXguKuirg0CK/B0VJuH2tVF1XPZ2z6teCzssV
   tDy6RTTV3e+ekLcqeXqwkjXnC+eQTj8RpeUTp/9UUH+yq9nqOZZdiLpWM
   vzavtHm20UTXxSXf506mFgWNrscSyjA+b5KMSkAHG4XFc4v3Yf+yRaQ81
   SJBLF0Hx+GOlRe16MGMCNiz7nhlQ0piNCevdP706bgzJdVv/Sp+OJZHaR
   1bcnDFJZC6OCCwSpktKqOB9OqYPJ7y8yO0XEFVbf+fqEOAaS66UOB8Hv0
   q70ZWyESE5/bMIOsPH8THPqhVBX+stzLySh1d4fpf24nyvPNIag8ujeRP
   g==;
X-IronPort-AV: E=Sophos;i="5.93,242,1654531200"; 
   d="scan'208";a="320962696"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2022 04:02:06 +0800
IronPort-SDR: nQk7jUZGv22MeuOBLmnyCaA4Wjx7o7sh4D/NrEyDGPNmZXo5ME+BgbTp9SF2o6cMteD6iwy3uy
 2FgLa+CU0FbM0Z14ZwDghSnCCG+t5ZOzRXIH2+3rPtNjvLSdbsDB/4353zpG6WAzgeOTFWWjC9
 rBD0QX+BCCFrxFTKZ8plicnde/9LaRB6tEPNPjKBmH4it3BIMch7W8Tdae/eqaoejGbR/09R8A
 HC6nElQagSKt7WYbPy3hmrhBlxpUXHB2jxN6t6Fx33PR+oWwl+7sLaCyJTmIp2fIgDMEJtp/Kw
 amdTGxnnABDEMxusTHU2EQC1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2022 12:17:34 -0700
IronPort-SDR: B4z5vxgVXhFh+YXcX+pTA9RGoGzkKdLnAK+82EFYybj4oBboHBXUH3URsGbUvxOsWD/uhK9hef
 KXukWP26vxYWdRF7Qpd/J15JPbq9HiVTI9a5NDYaS7WH4WXv60NSuwyo8FGICWWH0E2sTydcOY
 k4xWm6IRsK+RZF1SeA5/tR+FNWu+nqhstJjKN2uZt5XksK4Pb7LBHs146hO0mEcnSDWY83Twee
 TZ9yZGWFm5+lmpEoJtnIOl8UHbBQdWaqREE4RdeeeGG7YmlnUfeUwFcwmKYNT5Kth/SPJcSWuP
 oEY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2022 13:02:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M6hrF3vvjz1Rw4L
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2022 13:02:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660680124; x=1663272125; bh=GW2FhXTQRa9w1jg97NyRwrL/BtMEvGXmVvk
        BoETYrKM=; b=dLhQm9YOHTo9H6EkyC125YIp/Tqx9Ugdc+NMMOHd4S55KV0065z
        x9HCyQsPuihy+mUrei3Z8I2n7gHuEkLcCHHRuiOGBxQYMjrcM6ucFh890EQg2lt4
        g2UzFMuyMuklcaZN6Dd/1NXO20VNUa8xlX3N418aMdogoNyiuFYEWV8RiNRQay7t
        Br/Yr7B9kzaOVMugvtP9s0UY+Uf0EHe24KC8ndU/WJRD8EA08TfOepty2yb8dLGO
        GrxAB6pVHSDZ/bMn7c2MfwS16l7BGzE4Vjvd1s2QumeOyG0uhpDu4UR58JzUgGOL
        YOiBDmC//TAGlMOTkfMXnvi1R2HRpqui2sA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZU6hE7DFna-B for <linux-ide@vger.kernel.org>;
        Tue, 16 Aug 2022 13:02:04 -0700 (PDT)
Received: from [10.111.64.29] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.64.29])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M6hrC497jz1RtVk;
        Tue, 16 Aug 2022 13:02:03 -0700 (PDT)
Message-ID: <05a48c68-33ae-10e2-e565-6c124bad93c5@opensource.wdc.com>
Date:   Tue, 16 Aug 2022 13:02:03 -0700
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/16 9:38, John Garry wrote:
> On 16/08/2022 16:42, Damien Le Moal wrote:
>> On 2022/08/16 3:35, John Garry wrote:
>>> On 16/08/2022 07:57, Oliver Sang wrote:
>>>>>> For me, a complete kernel log may help.
>>>>> and since only 1HDD, the output of the following would be helpful:
>>>>>
>>>>> /sys/block/sda/queue/max_sectors_kb
>>>>> /sys/block/sda/queue/max_hw_sectors_kb
>>>>>
>>>>> And for 5.19, if possible.
>>>> for commit
>>>> 0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")
>>>>
>>>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
>>>> 512
>>>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
>>>> 512
>>>>
>>>> for both commit
>>>> 4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors according to DMA optimal limit")
>>>> and v5.19
>>>>
>>>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
>>>> 1280
>>>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
>>>> 32767
>>>>
>>>
>>> thanks, I appreciate this.
>>>
>>>   From the dmesg, I see 2x SATA disks - I was under the impression that
>>> the system only has 1x.
>>>
>>> Anyway, both drives show LBA48, which means the large max hw sectors at
>>> 32767KB:
>>> [   31.129629][ T1146] ata6.00: 1562824368 sectors, multi 1: LBA48 NCQ
>>> (depth 32)
>>>
>>> So this is what I suspected: we are capped from the default shost max
>>> sectors (1024 sectors).
>>>
>>> This seems like the simplest fix for you:
>>>
>>> --- a/include/linux/libata.h
>>> +++ b/include/linux/libata.h
>>> @@ -1382,7 +1382,8 @@ extern const struct attribute_group
>>> *ata_common_sdev_groups[];
>>>          .proc_name              = drv_name,                     \
>>>          .slave_destroy          = ata_scsi_slave_destroy,       \
>>>          .bios_param             = ata_std_bios_param,           \
>>> -       .unlock_native_capacity = ata_scsi_unlock_native_capacity
>>> +       .unlock_native_capacity = ata_scsi_unlock_native_capacity,\
>>> +       .max_sectors = ATA_MAX_SECTORS_LBA48
>>
>> This is crazy large (65535 x 512 B sectors) and never result in that being
>> exposed as the actual max_sectors_kb since other limits will apply first
>> (mapping size).
> 
> Here is how I read values from above for max_sectors_kb and 
> max_hw_sectors_kb:
> 
> v5.19 + 0568e61225 : 512/512
> v5.19 + 0568e61225 + 4cbfca5f77 : 512/512
> v5.19: 1280/32767
> 
> They are want makes sense to me, at least.
> 
> Oliver, can you confirm this? Thanks!
> 
> On this basis, it appears that max_hw_sectors_kb is getting capped from 
> scsi default @ 1024 sectors by commit 0568e61225. If it were getting 
> capped by swiotlb mapping limit then that would give us 512 sectors - 
> this value is fixed.
> 
> So for my SHT change proposal I am just trying to revert to previous 
> behaviour in 5.19 - make max_hw_sectors_kb crazy big again.

I reread the entire thing and I think I got things reverted here. The perf
regression happens with the 512/512 settings, while the original 1280/32767
before your patches was OK. So is your patch defining the optimal mapping size
cause the reduction to 512/512. It would mean that for ATA, we need a sane
default mapping instead of SCSI default 1024 sectors. Now I understand your
proposed change using ATA_MAX_SECTORS_LBA48.

However, that would be correct only for LBA48 capable drives.
ata_dev_configure() already sets dev->max_sectors correctly according to the
drive type, capabilities and eventual quirks. So the problem comes from the
libata-scsi change:

dev->max_sectors = min(dev->max_sectors, sdev->host->max_sectors);

when sdev->host->max_sectors is 0 (not initialized). So maybe simply changing
this line to:

dev->max_sectors = min_not_zero(dev->max_sectors, sdev->host->max_sectors);

would do the trick ? Any particular adapter driver that needs a mapping cap on
the adpter max mapping size can still set sdev->host->max_sectors as needed, and
we keep the same defaults as before when it is not set. Thoughts ? Or am I
missing something else ?


> 
>>
>> The regression may come not from commands becoming tiny, but from the fact that
>> after the patch, max_sectors_kb is too large, 
> 
> I don't think it is, but need confirmation.
> 
>> causing a lot of overhead with
>> qemu swiotlb mapping and slowing down IO processing.
> 
>>
>> Above, it can be seen that we ed up with max_sectors_kb being 1280, which is the
>> default for most scsi disks (including ATA drives). That is normal. But before
>> that, it was 512, which likely better fits qemu swiotlb and does not generate
> 
> Again, I don't think this this is the case. Need confirmation.
> 
>> overhead. So the above fix will not change anything I think...
> 
> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
