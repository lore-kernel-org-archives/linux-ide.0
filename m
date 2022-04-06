Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5B7C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  6 Apr 2022 08:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiDFIM6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Apr 2022 04:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383772AbiDFILB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Apr 2022 04:11:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5641FA2B
        for <linux-ide@vger.kernel.org>; Tue,  5 Apr 2022 18:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649209687; x=1680745687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VuoVmwsM1kjAIgmEzd4iWUN0hXYBPqUPYmlYGxx90q0=;
  b=If+xhkA2c06hgevkwfwCSEiZU8ERqW6FnRWAH7zHfBPEQyCSrQirgaC+
   eIHviGpySXLUoJvV3u+trnY2RUlhbzD0Mm61Lq+ICPcunsYowYO7hP8pd
   14zajnEO08F3l1jS20M43Ohy/WvIx5huzZ63TZQSmmi+Fw41ES7T6iYrA
   7YxEiWsOa1tNnFrjfRj9wafiClTKH9AEnrbGit+M99kNBwBOoBZd/ypEN
   goHW5BUpvrNbGwgdvGMJ7TzFQ9oahJ3F25OLInoyhxtEP2nY/HuJgO4Jo
   mIBIy28U/6qLd+E8OsD0qeRYOyYyY1f5KWMjjnTUvfKGNhhKKAW2bnXQX
   w==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="202037229"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 09:48:05 +0800
IronPort-SDR: 8RrUkUq4a6PYhEItmil4jK+o6hUO7IMlwN0ausqDQY7ybZuFtc+ZpUDh5uPxD1Gy5BrSLTkVd4
 EgJzetenJS0GtLFWx/Sbj0cbAVT6Ca7OgJKYByk74Qff+r0AnVUixHjwW8chjiFvaAGuu9rQUl
 w/Wb1omtWoursIr6V19aGp9HA5n7yPhyEQtqExqpOVq+PtxbftDckDGdbJ8qRhlgiIuKFEDM4H
 SvOVCJBvJpJEbmCjdkBY3YgDRChTDQX33MUw0gbNLp1O3gkXxG+h6En9DT5AbK+ETldbggHtNH
 juq9AxHAeRaH8qRNoquw/M0U
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:18:48 -0700
IronPort-SDR: f7VZIhQPveBUP19hIF5GPOBtP2SYt2Z+NiMXI8opO1x5Ia5b+qK0DU4gHtg9rBc7DygMcLGZss
 zsmvw3AFO0y16Aa/sbDA0rbgk6h6ulgBlO9+Lc8Aiy4ULK5Mw7FA4XD0g0iJ19ru5gbXpxkpwX
 RYDVvynry3luKTvb+rn1QtBR0HLGLdysDeDdSoJQwiwKjTE9hPxgk6hINDXNLNJfjJau9KVgjD
 J3qhMAnwJcqBnH1cAzJ86NX9huNCotcJd503XDYgSoaaLA7vfKmhC1WxcXmM+nSLuKe/ybLB3x
 l2c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:48:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KY6ps4m5Pz1SHwl
        for <linux-ide@vger.kernel.org>; Tue,  5 Apr 2022 18:48:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649209685; x=1651801686; bh=VuoVmwsM1kjAIgmEzd4iWUN0hXYBPqUPYml
        YGxx90q0=; b=E4UOnw8BjAuFsxgUNz1JVDSZoX8yQLctisFANLe1Z/7C0dFuEJk
        LfdRZDbW8aSOdPPRAKOLeHbtE6mmG+YYKwab0H3EYIozRVzMTdKBgE2ik7HJHuwe
        1b/tZXQrhQEBKn14uwEUh3KXtkYU3AwYxZb/cftSIWs4sLb5Ii1/2OmbJOA5JmTM
        pMTGewU2Q4eeocqSTsJgcr3aFdUI/EEHKR3ZwRZqyhl210d7gKEwFqJzkMZnFvWx
        sVkMFEpQFSvwkCv/cyub/aWGqmuHgeyvyl77QlJzkoPLP94S2ray/pI2ibZtgHr6
        MBrtS9l0xhBIHxhWo4d1BYM4S1B2CX7v4tQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jN3lCrqcwlAt for <linux-ide@vger.kernel.org>;
        Tue,  5 Apr 2022 18:48:05 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KY6pr31hmz1Rvlx;
        Tue,  5 Apr 2022 18:48:04 -0700 (PDT)
Message-ID: <f7bbb09f-562f-fce2-cd16-a1c67fc334b5@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 10:48:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] libata: Inline ata_qc_new_init() in
 ata_scsi_qc_new()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
 <1649083990-207133-3-git-send-email-john.garry@huawei.com>
 <20220405055252.GA23698@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220405055252.GA23698@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/5/22 14:52, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 10:53:10PM +0800, John Garry wrote:
>> From: Christoph Hellwig <hch@lst.de>
>>
>> It is a bit pointless to have ata_qc_new_init() in libata-core.c since it
>> pokes scsi internals, so inline it in ata_scsi_qc_new() (in libata-scsi.c).
>>
>> <Christoph, please provide signed-off-by>
>> [jpg, Take Christoph's change from list and form into a patch]
>> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Although I still think merging the two patches into one to avoid all
> the churn would be much better.

I agree. Let's merge these 2 patches.


-- 
Damien Le Moal
Western Digital Research
