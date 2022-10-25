Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD5BC67871
	for <linux-ide@archiver.kernel.org>; Tue, 25 Oct 2022 01:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiJYBMh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiJYBMR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 21:12:17 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996643ECCB
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666657379; x=1698193379;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=tQVc9zSnzUU3AYsRWylAUvEhn1qrMSkIaBRoLXuhCOY=;
  b=ZZMFusRN0L6F2WlsbHQhtjtYIiF5jSuuhMk9nc66LJotqBBBM1CNJ8zK
   i8P8zDBRsWepyQ+eMB/8VcFlqhgRmrwCf1DXAGFKeYjwZ2F/INxALyHPs
   ekT70AZPXn4EyhwvA47pDnTWUaatfgBcx6sjxFOU/RCnk84ltZQjT2HEw
   i33xi+nTc+LD3YDA67F95xjH9mbQhBLKcYebaOk5kWJuEty+rnK+y3rsi
   5bR5iBkB0FAzh8cvzixKXj2jh+3uHdk8Y226UuUKrVglFu/USd0iK7Ys2
   aOKafMdtOnIkSFWa+/GLYsS2HKRXfHLZCi3n6ifXKyJveR4HmL1oqBKBK
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,210,1661788800"; 
   d="scan'208";a="212943139"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 08:22:58 +0800
IronPort-SDR: tIe/c4iVNH8ALlwySAbcD8jwtWDjx4k5oe4HB3RYuIsfAelQsKEcsaVxcWHBYpWR3rfsxaDDXx
 NhWM5vFsPEtr5bV4j0HsrB97NTIuHGm5BmfaIKNwhZDZ+05CesyoLMV++9OvVJXsspvYk1SR+K
 VVD40odFkWlRVG3kNjacXL2MkN7jQkMsSixeB+aQ7pPJS9x2Axpk6pwrp56rXvJrdvDi39Y3aZ
 w1jGC+prEuL8w5Qm2KSxnM4nxvihCZ4mJczGKu0LxiFrC6/yCNGtMujtAyidkavxCCdB9QAs62
 +0gN7R7d11PhmA28uSU6xMg7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 16:36:41 -0700
IronPort-SDR: 21PlPbElvUSXMdATRU0k4ZvW/nOH4ShQlD+yyrEbEBQBuovs1tUdFvwuojmB1LRcguEGAAGRyv
 VkTgfuvYfgQV+dno5CpVO8nmSUnDcuyB1hsg8GVedTuO490cKdaY4hXSbQxxFZAKasWXWhIoUm
 H+ql9PXtYGfvSHkd5CcKFcleMX8TYX5KAhPV2PLLzm80OhGLTgkfnBQsJT0DISMIvKg7L2dCdq
 r90ud3YKmx8TVW9amuZMrWzIWSOG138AOKUSrQe8bdVoKtYUS2qeCHGpUeZxNhDJpYGzl8fqN1
 OrQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 17:22:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MxCMQ0W0Bz1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 17:22:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666657377; x=1669249378; bh=tQVc9zSnzUU3AYsRWylAUvEhn1qrMSkIaBR
        oLXuhCOY=; b=XW6+kQvQjTOPbBaIj/fK7QGDGB/tkjIRqf1jYIBa3OPNeaI+pZ3
        bRTmYj2c2kMdkWO1uND3l+bplLfmcl0YRXU2YfUPpYXOW9WaR7eXHuF7xV4UOCz/
        1FPrbnj+MHR0fzSFd3tSnAJDwFkQz7TfHl5pdkUcIHPZrdN3yN/0RPmTiBWpNr1m
        GAyGQsBm5YgkEEw9FF6zuJgXkTYDU+Oc8cMCc7x7rWPSC2MK4yiPht5iI6XwOueV
        fXCv0+YoxRaSKob0LRLUfDxcWlLuCZc1z8ZyfkS0U3UeUG37ILTrqOd313zfnR/r
        ijR7CAT9cMaPnxV7XqmWhl2yqMCYyei9/CQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NTuptZRkdymH for <linux-ide@vger.kernel.org>;
        Mon, 24 Oct 2022 17:22:57 -0700 (PDT)
Received: from [10.225.163.8] (unknown [10.225.163.8])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MxCMN5w4dz1RvLy;
        Mon, 24 Oct 2022 17:22:56 -0700 (PDT)
Message-ID: <f7b8ceec-90b4-0b78-e727-5467892015d0@opensource.wdc.com>
Date:   Tue, 25 Oct 2022 09:22:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 0/3] Improve libata support for FUA
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <f1456224-f644-dce5-15ea-fecc965788e1@maciej.szmigiero.name>
 <1401aa25-38de-c5e0-f9de-7aeb7ce0af9d@opensource.wdc.com>
 <a44337f7-3e8f-abcc-5695-f2e571087e8d@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a44337f7-3e8f-abcc-5695-f2e571087e8d@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/25/22 08:26, Damien Le Moal wrote:
> On 10/25/22 07:09, Damien Le Moal wrote:
>> On 10/25/22 03:48, Maciej S. Szmigiero wrote:
>>> On 24.10.2022 09:26, Damien Le Moal wrote:
>>>> These patches cleanup and improve libata support for the FUA device
>>>> feature. Patch 3 enables FUA support by default for any drive that
>>>> reports supporting the feature.
>>>>
>>>> Changes from v1:
>>>>   - Removed Maciej's patch 2. Instead, blacklist drives which are known
>>>>     to have a buggy FUA support.
>>>>
>>>> Damien Le Moal (3):
>>>>    ata: libata: cleanup fua handling
>>>>    ata: libata: blacklist FUA support for known buggy drives
>>>>    ata: libata: Enable fua support by default
>>>>
>>>
>>> Thanks for the updated series.
>>>
>>> In general (besides the small commit message thing that Sergey had
>>> already mentioned) it looks good to me, so:
>>> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>
>> Thanks. I need to do some more testing using some very old drives I found.
>> So far, no issues: detection works, some drives have FUA, other not. For
>> the ones that have FUA, I am running fstests (ext4 and xfs) to check for
>> weird behavior with REQ_FUA writes. Once I complete all tests I will queue
>> this.
> 
> Actually, I need to take this back. Checking again the code, I found an
> issue with this entire FUA support: for a drive that does not support NCQ,
> or one that has NCQ but has its queue depth set to one, then for a REQ_FUA
> write request, ATA_CMD_WRITE_MULTI_FUA_EXT or ATA_CMD_WRITE_FUA_EXT will
> be used. All good, BUT ! sd.c may also send read requests with the FUA bit
> set if the read request has REQ_FUA set. For read commands, the regular,
> non FUA commands ATA_CMD_READ_MULTI, ATA_CMD_READ_MULTI_EXT, ATA_CMD_READ
> or ATA_CMD_READ_EXT will be used since ATA does not define a FUA version
> of these. This means that the REQ_FUA flag will be ignored: this entire
> code is broken as it is assuming that the read command processing on the
> drive is consistent with executions of ATA_CMD_WRITE_MULTI_FUA_EXT or
> ATA_CMD_WRITE_FUA_EXT. I do not want to bet on that, especially with old
> drives.

Correction here: a REQ_FUA reads would end up being mapped to the "0"
command as returned by ata_rwcmd_protocol(), resulting in the user getting
back an EIO for any FUA read if libata FUA is enabled. With libata fua
disabled that was not happening. Digging further though, I do not see any
in-kernel code using REQ_FUA for reads. But it does not look like that is
forbidden either. Applications using SG_IO may use it anyway (e.g. to do
write verify type operations).

> 
> I would be tempted to restrict FUA support to drives that support NCQ,
> given that with NCQ, both READ FPDMA QUEUED and READ FPDMA WRITE have the
> FUA bit. But then, the problem is that if the user changes the queue depth
> of the drive to 1 through sysfs, ncq is turned off and we are back to
> using the EXT read & write commands, that is, only write has FUA.
> 
> So if we want a solid ata FUA support, we would need to always use NCQ
> regardless of the drive max queue depth setting...
> 
> Thoughts ?
> 
>>
>>>
>>> Thanks,
>>> Maciej
>>>
>>
> 

-- 
Damien Le Moal
Western Digital Research

