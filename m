Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD9EC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  6 Apr 2022 12:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiDFM0I (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiDFMZp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Apr 2022 08:25:45 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F21116B71
        for <linux-ide@vger.kernel.org>; Wed,  6 Apr 2022 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649232621; x=1680768621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W+sQyQXwqNPtg3DW2PfzXKmUropifws/e8bOcPZZ7OU=;
  b=F9Sc59HfiJlJVdOVnykGOKQaa6Zw/NForIX8EnRM+F6wFJdAowmiozOm
   YlVuYBZe1vHNr4qQTtCBq9vtcyv3C7d72q3mW9TKfiSjByxUj2rJ3fDgc
   uS0tmHbfaQENB5MbvNoxnJLOEL4Vry/mMY0vA7ydHS05/oVtM8D7KI2R1
   zQrCZk9WYz8AiE8BS5qm2Ct5Nv0GC6O/IN57+NtTCDz1t6OVybxvYa/jz
   yUgJlW1NOo7dOgcsCrcBB1u6WvRfPNSZHXkpYoBn7jGH2aGO0FoFZNf3j
   VxsRgfrR9BEgd0KWA0ATVvAkfKwgC5HhC1JvrZgeKR6kHVuOfzCt/GD/2
   g==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643644800"; 
   d="scan'208";a="198116343"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 16:10:18 +0800
IronPort-SDR: tuessS+1U3/VcUVbq0+wC1JkNAw8H2p3TtYXRFU0Ie4hY1UGvzjPxF5iQ1JTjbCEaBw/OvMmva
 g4SFXDBhOnW6diuLbs5hAtui9hmKEHkbb2dl4uuEOzHaWxlQXEM8XeZPc6QwS77zaN2WNXc4iO
 WmLXQewSAZTdN5LeUMrPortbIdTRKCDyLA+gX4UqFJrwM+Z73+Pi8XDldqhs66TVXkbdCjhLxL
 kJ7JUw2cLPWl62ZlTZtkt542N3cg2tPG+qlsr+AxcO0oC8EcsnVHUsADALylXM9zgeoSqh3+PW
 Q+mRWZOZGVO2cgjeVgkEfu45
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 00:40:59 -0700
IronPort-SDR: z59sMQsbFMG45ys8JXH3cDkj3ZbndWXnDkihF8D0MFc6VWUq4w4SbzLggJ//fsYp1y6veQJpfu
 meWAYqwvcQFnrjJdnwRP7hC7IHu+gkHAGp+SAdEhz6VJkyvRa/Q2GyBS2lCP99mrZhJUERKjxv
 6d+114kdMvOdYfnUy9jHbewHHTj1a2oeDxy5xcFsx1ACPKd/5wPuOZ4xZKpE/COMykWMKAtaxV
 S81dySK2A2hfIe9qTL3jGQqivE12lGGE131x9wANaYrJS3MZuCzQO9CR8dAILtyl5ITM6gZGXm
 0lI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 01:10:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KYHHs25y5z1SVny
        for <linux-ide@vger.kernel.org>; Wed,  6 Apr 2022 01:10:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649232616; x=1651824617; bh=W+sQyQXwqNPtg3DW2PfzXKmUropifws/e8b
        OcPZZ7OU=; b=Y6xg7hgBprDMhQ9Dd9yZYi4n5vw1VkHmGMIB+1Gb/HpwKMH3Nc8
        gmrqc9mu3pjeJ1LUydu6p2X3dmmBsJP3EoDbypQA/8EgW2uuzAZcnQXTLBie40HT
        sZpZjRgozIo+IbnV0QDFQl4B0efwec0utMN5DpPxOY7t6+MzUGJMwgNrWPRE6gzX
        sQts++PNkctblTnuD72tngEIhJqlOYt5lgcByWZ/T5f+Fy4SRXuAA3els6ycoCXg
        5uW49QQMj7eArdp23KXOlIUuB9dpUlsIxPbld4lYaY6sFmcc5C0mol9wz1bfBHq1
        XnmlhUEWsKdxBbVph8Ztd4qXHawIv/MbS5Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zjW3383hQZ3A for <linux-ide@vger.kernel.org>;
        Wed,  6 Apr 2022 01:10:16 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KYHHq6LY1z1Rvlx;
        Wed,  6 Apr 2022 01:10:15 -0700 (PDT)
Message-ID: <0c6c0c64-74f8-e15a-d79e-0866b5cc209d@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 17:10:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] libata: Use scsi cmnd budget token for qc tag for
 SAS host
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
 <1649083990-207133-2-git-send-email-john.garry@huawei.com>
 <a3cce73f-2e91-309d-bee0-a34a30335a18@opensource.wdc.com>
 <ab6a13c1-90c4-63f0-c48d-c1faa0ae68fd@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ab6a13c1-90c4-63f0-c48d-c1faa0ae68fd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/6/22 16:12, John Garry wrote:
> On 06/04/2022 02:39, Damien Le Moal wrote:
>> On 4/4/22 23:53, John Garry wrote:
>>> For attaining a qc tag for a SAS host we need to allocate a bit in
>>> ata_port.sas_tag_allocated bitmap.
>>>
>>> However we already have a unique tag per device in range
>>> [0, ATA_MAX_QUEUE) in the scsi cmnd budget token, so just use that
>>> instead.
>>
>> The valid range is [0, ATA_MAX_QUEUE - 1]. Tag ATA_MAX_QUEUE is 
>> ATA_TAG_INTERNAL which is never allocated as a valid device tag but 
>> used directly in ata_exec_internal().
> 
> But that is what I have in [0, ATA_MAX_QUEUE), which is same as [0, 
> ATA_MAX_QUEUE - 1].

Oh ! I missed the ")" !
I would prefer an explicit [0, ATA_MAX_QUEUE - 1] to be clear :)

> 
> Thanks,
> john


-- 
Damien Le Moal
Western Digital Research
