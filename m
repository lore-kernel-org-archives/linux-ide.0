Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAEAC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jun 2022 08:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiF2IYr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jun 2022 04:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiF2IYr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jun 2022 04:24:47 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023823BF88
        for <linux-ide@vger.kernel.org>; Wed, 29 Jun 2022 01:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656491085; x=1688027085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AjhPOFbRCAVVpWITsrOe0anHqorsbYYstfbAHDzMisE=;
  b=pxRn0fOD9BpsU04QIlyRhbspF8BdBl+/w99f2hMTLEhlSznYJD4Mix5Z
   mj3EbehaanvZY972YS/1ZZO95sTLlktgUrur/MBUGmZ5XCURTQWjaRrUf
   K3tfQTNukRqlh7y0wCOd9/k76ccUUHiY/qHUopcvLednWyYhaPbp2kBBl
   Q3i+Ia7P0HUaaP/8vaTOGOZEechzeiZnLB+xCTFZDqNVp7Ii7/7HjTb+v
   9E+cDnfFrhooW07eS6vrRsLzv5Isf3g627N+26sFnEvdiEPCxcj60xA+a
   hKBR6vlVODj/aJ3Z3Z09NoL8mU1VVkpKDDore/X4f6VNZuwRA8f7C9HuJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="308690109"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 16:24:45 +0800
IronPort-SDR: +0rYYCMYWLXeogisEioIIPRNmv0PTYKUy3axUUN0MRBnpay4ZycGJxreDpr68ygioPA7aChYLE
 H/jR9/FEIYddPpgHNgRQydBlSRmFciZfrGgbEOAV0rNb7rOgmtlQ9w7vDAC9IcMPgODBWmIBvd
 CqzCsIRdJ98vN0xbEE3AlR6CQ4L4fIAqtyR2px2C5qbVZzzscp7vPa0ijTTcSPmgAIosmOzmNE
 hfp+kM2jDlmBFGW6M/TuHYyXaAj1TUGUMDsySMnjexnUl5hJa9/Gkxj/hyh5HOt1z3ROEFLpj+
 aPW7gzdO5c1o1kaXDJcylKHS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 00:42:24 -0700
IronPort-SDR: jcZRxvu7f7t/VVHY3vjTKmfkuYYrEinb7Miky5532ZbbbGPrjOi44qE5oBBN9ytiXNhTWrXO77
 DzaYWTCvwXwFkMqCYIveM8SmXXD5Rtz1Jn/lcGLIcDESkxokY1dtV1BVNpFXtJ2tAJOfLztGqI
 aSCRtSTe69GmAPEwd1vPyEW/JfqKBKiTXfkAh/hTOH8w9aq/DuRjMRwQkJ7Zq30jGyuZHfPYBO
 46CW8vCM4OT5FIQmeIbX+kM/FFQ6sdCvEV4fLZGb07eZeHHxpKL6Sc8kPUr83QRmNcV/AwZG3w
 Puw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 01:24:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXvdm74wRz1Rwnl
        for <linux-ide@vger.kernel.org>; Wed, 29 Jun 2022 01:24:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656491084; x=1659083085; bh=AjhPOFbRCAVVpWITsrOe0anHqorsbYYstfb
        AHDzMisE=; b=f4KMrv0T558Vn290lglMeOnpRgM/tnLvwyasnRINiD6TD/Cc1Hc
        2yomsmv8LfVntiQ7GXFwUkCfRKRAY7qvGQbkr9P1QpY/SYkkhIoX2LD0FC1C2S7j
        5si/YK0AAM1giKgqSsMmuK7/eOFgxGgmu2nZwiCk1O/ge2rzdrkXU52ICY3spbY6
        al3z0VVWsrrfQhOpr1vl5fJenrtuK4YXLxrGgFIA4KlKFbVZ9jukOl66Ax7MYsR5
        h90n0fF4NTKu5YdmMllJMqVq5Okh07VYSGcgxkqxLsX07uF0iihUuG4Eot0/wlLO
        x+B//BwgzWidtwSG/6bzg0Q9vSt9imHiHdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DKZEwf2wb69M for <linux-ide@vger.kernel.org>;
        Wed, 29 Jun 2022 01:24:44 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXvdk2Vfxz1RtVk;
        Wed, 29 Jun 2022 01:24:42 -0700 (PDT)
Message-ID: <bf9d1cc7-c03d-f5a8-bb96-cfcd352ac36e@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 17:24:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, joro@8bytes.org, will@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
 <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
 <38ae1cc8-1411-bb54-e082-0f7b91cb9e63@huawei.com>
 <20220629054027.GB16297@lst.de>
 <da7027d9-bd81-cfb0-f70e-2405f40023fa@opensource.wdc.com>
 <65e05dd1-8e92-5f6b-d68e-72987fcebf59@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <65e05dd1-8e92-5f6b-d68e-72987fcebf59@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/29/22 16:43, John Garry wrote:
> On 29/06/2022 06:58, Damien Le Moal wrote:
>> On 6/29/22 14:40, Christoph Hellwig wrote:
>>> On Tue, Jun 28, 2022 at 12:33:58PM +0100, John Garry wrote:
>>>> Well Christoph originally offered to take this series via the dma-mapping
>>>> tree.
>>>>
>>>> @Christoph, is that still ok with you? If so, would you rather I send this
>>>> libata patch separately?
>>>
>>> The offer still stands, and I don't really care where the libata
>>> patch is routed.  Just tell me what you prefer.
> 
> Cheers.
> 
>>
>> If it is 100% independent from the other patches, I can take it.
>> Otherwise, feel free to take it !
>>
> 
> I'll just keep the all together - it's easier in case I need to change 
> anything.

Works for me.

> 
> Thanks!


-- 
Damien Le Moal
Western Digital Research
