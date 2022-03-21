Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E112C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 12:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbiCUMjm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiCUMjl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 08:39:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B1A1A9
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647866295; x=1679402295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OwWqDa6x+ILrFeQjYw0dBR58qwzyArlOswX7trtsVeQ=;
  b=CHfOcR0KD4+HlPeTcVmhliaKGTZFr+cSwiEBvDXKSaBF7vraLkJKfwlX
   +5j9TYoSsSBWsmWgV63bF3kXOQEV4402nxa1pwOLLjVrnItVceOmEVIT9
   QhO4g5J4wWq5Z/y3IOjjj8g27R5yU5qbzgvmtNY3VN5GiSqvKjDLbPnya
   3z6EatFzZAgtqkV7QJNU6/vRosH+6bdRgP4q2a9JLH2q03ToLQkYxUvWw
   aZutOZ3MQiKe1Is+5NCR9ns9epadK15azEokm+olkqUU695opIBw3VKrW
   YmTWYqycRYLN66RFWAV4SZ5H0Ub5GOaEfyoqPQ6ObHvYqz/QAe2p2FSLp
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,198,1643644800"; 
   d="scan'208";a="300014493"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2022 20:38:14 +0800
IronPort-SDR: 4UjQ1o3UmChgagcqIlc9+ci8HCY9ilJb7wJmLad4T0RkL0C/bTEssgiUqa4ajjfSwNrfjD84Zy
 a9RQZBlwrT315dcFOApoDvpVrQKJTj53QKE4C6Ak+9EukgGOo1P3YEk7Z6phEGO7FoPfyZa9+d
 fDd6Wl9vQNDLgTP7dC77W9yZx5jR0o4ZHQMbsYYh4euFAhM7R+nIIdsa3PFt48ONt7/M2TL6OV
 uwZzBuJXfKvJ5JtfuxmSTC7E0zO3cjUhA629HgTdJmbNSltfy0uXkW3vXZjqQaXQRz4N1ej4IY
 ora/XZZZrf+kXNPzk3nwh703
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:09:14 -0700
IronPort-SDR: QNc6tUvgl3UPbQauYMgUr73uQGB0b+206f+M1T16HezDmI/g/h9Qo3JvvEB96vF5dvwN9CBNC0
 TYM5UMLO41o0p2mUajOI1awi+my84oHFvPDv/X/D96EBcrQmnhPV0fOOkvhS7lqYtNGEwlibqY
 P1MBRm/HTUXK0+3BE3UqgzBsbukRC/iAdxiDHoZwL17Nz/RowVUAwj/mjmIkxNCOJj7t5udlkd
 StpW8NdtELELH0iFeNnM2jsmppNlYUzv0bC6lKKEgl2KIdOk7gNHWiXouRzUoQQ1PaDjxuoJw7
 Weg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:38:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KMZ0P6ZnPz1SVp1
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 05:38:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647866293; x=1650458294; bh=OwWqDa6x+ILrFeQjYw0dBR58qwzyArlOswX
        7trtsVeQ=; b=qcSz36A2OwML6KuEFfzZXPJbuorSSQsZRWXHhcosgxrgw0iCgma
        8bd/1jE81PI2NVzvi8i1Kq6wvfSyNz86FeW/Vrdcc0P7mIoGZR6gQgxen2qEakGR
        njzHKysafvFCcRS34C0kUp42qEbHVZ+vDy2WPDUdF/WsCshptdQsk6PTjXHKyVNV
        KwE4UpBF9RVQN4y9uS2e8FymiEbkGUL8Q1NDJYXsHN5WUbuTcNzb9+SZUtnulZGG
        lUkJQbpr9KJyJW6FFsZfTea8qayRyRny0fO4c8qt914ceaAx8d5EJjceRiNIsQnb
        JaRp8dQYisFbJHZFEMyzHphk9DRU7cuke1Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oSjVl44HI5lB for <linux-ide@vger.kernel.org>;
        Mon, 21 Mar 2022 05:38:13 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KMZ0N3c6Mz1Rvlx;
        Mon, 21 Mar 2022 05:38:12 -0700 (PDT)
Message-ID: <9ab4e798-9ee9-5ac7-229f-d42f85a63583@opensource.wdc.com>
Date:   Mon, 21 Mar 2022 21:38:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/2] ata: libata-core: Disable READ LOG DMA EXT for
 Samsung 840 EVOs
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>
References: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
 <fe2ff41a52ce2647fd12f69a0d6eba8e3cf05b06.1647720651.git.chunkeey@gmail.com>
 <468f57ae-47e8-7032-b391-7ddfd6853dbb@omp.ru>
 <YjhWtp+AdcN1ot9t@smile.fi.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YjhWtp+AdcN1ot9t@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/03/21 19:43, Andy Shevchenko wrote:
> On Mon, Mar 21, 2022 at 11:00:51AM +0300, Sergey Shtylyov wrote:
>> On 3/19/22 11:11 PM, Christian Lamparter wrote:
> 
> ...
> 
>>> +	{ "Samsung SSD 840 EVO*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>>> +						ATA_HORKAGE_NO_DMA_LOG |
>>> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>>>  	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>>>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>>
>>   Shouldn't this entry be modified instead?
> 
> Wouldn't it modify much more devices with unknown outcome?
> I would be on the safer side as done by this patch.
> 

Yes, I think so too. A little googling shows that there are "840 xxx", "840 PRO
xxx" and "840 EVO xxx", at least as product names. Not sure how all these are
grouped with the actual device reported model.

-- 
Damien Le Moal
Western Digital Research
