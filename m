Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04477ECDFA1
	for <linux-ide@archiver.kernel.org>; Tue, 25 Oct 2022 23:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJYXVx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiJYXVv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2022 19:21:51 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B6550730
        for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2022 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666740109; x=1698276109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9xxqB/b2yckUA4lfgNv7efLk6Az1RkKyYGwvKACk3y0=;
  b=n9DCloSyTQwsTncw794cvVd0BXL9uYsGPzek5UlMIntJZBt05rBxr+m0
   crNfMkiR/2LOCbC1x6zxpWPgcA5SV3VwkbkyA++EBEbmq5WPW35je5Sdg
   PjWcrnd5Uv4t1ww5b0LJtt2TeQZrJaMXM45FHjSVo60b6q6geepvaNgKT
   jXZeTLfKRRDubaWEvN4CuGSwsCJRnm7vXZe7fgBX2XIozSGBK3mE1Bzvs
   UIUIzG+VWa1mX7IZuLcWdTgxh7NUVcp8DySndEMyxqOHHnw5gdvvWZPfZ
   2Jrh2jj7o8wIlAOLY1s8tMzXywbqeWGiZ3Pdq8pcktPB2MHeWjIjC3L0D
   A==;
X-IronPort-AV: E=Sophos;i="5.95,213,1661788800"; 
   d="scan'208";a="319058619"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2022 07:21:48 +0800
IronPort-SDR: h7LtSIYvXUABIetrP2DjxS34btLUUtXvJgaFGzusT5leH/P+3Z+C4fcbBaJIc6qgjEE8bxzG0l
 OUKqbvpdEM29xK453payMPyeCQnrIq4gzkU+UPz8kJu6ofVZbquQYFxCVJSFDi/ieX6YYMFQAr
 r1JNhzskFCNOhHAOK2KgH+Jb8qG2djPCbYmZGX+acDTg570x5zEunwbYUe/baYjfu0oQc1CbKj
 mVdEeLdwCfu1LKb/HlAU4AQt20x1lxi+7bJu4NuvBsbprWrbaUiMPpwXP6B+/DVOYBNlJI2bmc
 SmntSh9gtSZRBVfFJQ7q+iys
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2022 15:35:29 -0700
IronPort-SDR: JWLi1YiMimx5wmksDTV9p5TsDOjpWCUMcl5DCM744QT8pLdHBs7cG7yM8ozOj/hcPOXfcSgWDz
 oa5owidptu67lb7YbWog3JVeVyddjC77xm77WApsR8fTYyl1xna6qqgFdJSsz83Ii1Cjyme773
 eSk3OXB488Kmvuljrz6ExQPaubTAtWvYOmWteMUIR2soPh15XhRHWlU4cU5RaAvXZxkR8a+5eI
 XefZdHZYK+sM/jA1ENlVHlP6wxPfTdYVAXwesdh2VdpRoaHTaukFhxSOp990hw3N7XEeMokEIh
 fhA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2022 16:21:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MxnyM6Qkfz1RwqL
        for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2022 16:21:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666740106; x=1669332107; bh=9xxqB/b2yckUA4lfgNv7efLk6Az1RkKyYGw
        vKACk3y0=; b=upxCphV1oEdN8fQqOMXPLW4BR0yRoec6AI5gadXel4pYHgvl3qU
        56rqjm8wunyWlbm5NCKlO9ubOvrzQQZkLoIWDKMPBLZRmOmpsrT8FinFNpZoL++O
        2GmlEjXkbs22YQY2f8GiWvgIuVmuQnLqQ9gFnggRi5SGCwp3kpTn+97AQtCEDxSh
        vmBL5ER9UxNsap77OoexAGRp3lZEuXA2EVzTOLGkSMxIJEoWEYZklkTYW6gOuops
        qNZ19HvMvOHxTDmkDfo+xyRFZyol6oHxTN6IZRhEwF7Uf8v4Do4pU8QiFNgw2Bde
        fqC/548Qflcrx8B6R2+eChSOoR5A+OXHwFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A89pNLGGm4qm for <linux-ide@vger.kernel.org>;
        Tue, 25 Oct 2022 16:21:46 -0700 (PDT)
Received: from [10.225.163.8] (unknown [10.225.163.8])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MxnyL18V2z1RvLy;
        Tue, 25 Oct 2022 16:21:46 -0700 (PDT)
Message-ID: <75efd863-88b8-4eaf-8f2a-f6f94fabf0cc@opensource.wdc.com>
Date:   Wed, 26 Oct 2022 08:21:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 0/3] Improve libata support for FUA
Content-Language: en-US
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <f1456224-f644-dce5-15ea-fecc965788e1@maciej.szmigiero.name>
 <1401aa25-38de-c5e0-f9de-7aeb7ce0af9d@opensource.wdc.com>
 <a44337f7-3e8f-abcc-5695-f2e571087e8d@opensource.wdc.com>
 <709fb497-df73-0ee7-06db-1fb4c2e50cf6@suse.de>
 <26def87e-6e44-17ae-f928-030c837c9dbe@opensource.wdc.com>
 <f950360e-5b52-a64d-8804-52c8028b3b03@maciej.szmigiero.name>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f950360e-5b52-a64d-8804-52c8028b3b03@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/26/22 03:13, Maciej S. Szmigiero wrote:
> On 25.10.2022 10:59, Damien Le Moal wrote:
>> On 10/25/22 16:05, Hannes Reinecke wrote:
>>> On 10/25/22 01:26, Damien Le Moal wrote:
>>>> On 10/25/22 07:09, Damien Le Moal wrote:
>>>>> On 10/25/22 03:48, Maciej S. Szmigiero wrote:
>>>>>> On 24.10.2022 09:26, Damien Le Moal wrote:
>>>>>>> These patches cleanup and improve libata support for the FUA device
>>>>>>> feature. Patch 3 enables FUA support by default for any drive that
>>>>>>> reports supporting the feature.
>>>>>>>
>>>>>>> Changes from v1:
>>>>>>>     - Removed Maciej's patch 2. Instead, blacklist drives which are known
>>>>>>>       to have a buggy FUA support.
>>>>>>>
>>>>>>> Damien Le Moal (3):
>>>>>>>      ata: libata: cleanup fua handling
>>>>>>>      ata: libata: blacklist FUA support for known buggy drives
>>>>>>>      ata: libata: Enable fua support by default
>>>>>>>
>>>>>>
>>>>>> Thanks for the updated series.
>>>>>>
>>>>>> In general (besides the small commit message thing that Sergey had
>>>>>> already mentioned) it looks good to me, so:
>>>>>> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>>
>>>>> Thanks. I need to do some more testing using some very old drives I found.
>>>>> So far, no issues: detection works, some drives have FUA, other not. For
>>>>> the ones that have FUA, I am running fstests (ext4 and xfs) to check for
>>>>> weird behavior with REQ_FUA writes. Once I complete all tests I will queue
>>>>> this.
>>>>
>>>> Actually, I need to take this back. Checking again the code, I found an
>>>> issue with this entire FUA support: for a drive that does not support NCQ,
>>>> or one that has NCQ but has its queue depth set to one, then for a REQ_FUA
>>>> write request, ATA_CMD_WRITE_MULTI_FUA_EXT or ATA_CMD_WRITE_FUA_EXT will
>>>> be used. All good, BUT ! sd.c may also send read requests with the FUA bit
>>>> set if the read request has REQ_FUA set. For read commands, the regular,
>>>> non FUA commands ATA_CMD_READ_MULTI, ATA_CMD_READ_MULTI_EXT, ATA_CMD_READ
>>>> or ATA_CMD_READ_EXT will be used since ATA does not define a FUA version
>>>> of these. This means that the REQ_FUA flag will be ignored: this entire
>>>> code is broken as it is assuming that the read command processing on the
>>>> drive is consistent with executions of ATA_CMD_WRITE_MULTI_FUA_EXT or
>>>> ATA_CMD_WRITE_FUA_EXT. I do not want to bet on that, especially with old
>>>> drives.
>>>>
>>> Now you got me confused.
>>> What exactly would be the semantics of a READ request with the FUA bit
>>> set? Ignore the cache and read from disk?
>>> That would only make sense if the cache went out of sync with the drive,
>>> which really shouldn't happen, no?
>>
>> For the NCQ read command, FUA text says:
>>
>> If the Forced Unit Access (FUA) bit is set to one, the device shall
>> retrieve the data from the non-volatile media regardless of whether the
>> device holds the requested information in the volatile cache. If the
>> device holds a modified copy of the requested data as a result of having
>> volatile cached writes, the modified data shall be written to the
>> non-volatile media before being retrieved from the non-volatile media as
>> part of this operation. If the FUA bit is cleared to zero, the data shall
>> be retrieved either from the device's non-volatile media or cache.
>>
>> So all well for NCQ, everything as expected, no surprises at all here.
>>
>> But no equivalent behavior defined for non-NCQ read commands, and with
>> libata.fua enabled, ata_rwcmd_protocol() will cause any REQ_FUA read to
>> fail, which is the safe thing to do, but that is not what one gets when
>> libata.fua is disabled. So enabling libata fua by default could
>> potentially break some use cases out there of people using REQ_FUA reads
>> without realizing that it is doing nothing in non-NCQ case.
>>
>> I have not checked the block layer though. Does the preflush/sync
>> machinery also triggers for reads ? I do not think so. I think REQ_FUA is
>> ignored for reads.
> 
> It seems like the block layer is indeed capable of doing a {pre,post}-flush
> on reads - neither op_is_flush() nor blk_flush_policy() or
> blk_insert_flush() have any checks for request direction.

OK. But the problem remains that if fua is enabled, this machinery will
not trigger and we end up with a read error in ata.

> But, as you mentioned, no higher level kernel code seems to actually issue
> such FUA reads.

Which leaves SG_IO applications: translating a read with FUA bit set needs
to use NCQ read, always. But since that was not working before (the user
would get a read error), and nobody complained, I guess this is OK.

> 
>>>
>>>> I would be tempted to restrict FUA support to drives that support NCQ,
>>>> given that with NCQ, both READ FPDMA QUEUED and READ FPDMA WRITE have the
>>>> FUA bit. But then, the problem is that if the user changes the queue depth
>>>> of the drive to 1 through sysfs, ncq is turned off and we are back to
>>>> using the EXT read & write commands, that is, only write has FUA.
>>>>
>>> Hmm. Is this a requirement? We _could_ use the NCQ variants even with a
>>> queue depth of 1, no?
>>
>> Absolutely, yes. Running NCQ commands at QD = 1 is perfectly fine.
>> I think that this "do not use NCQ when QD == 1" is there mostly to deal
>> with drives that have a buggy NCQ implementation. Not sure. It has been
>> like this forever. Would need to do some git archeology about that one.
> 
> As Niklas has mentioned the NCQ will be disabled if there are too many
> errors (for buggy implementations), so it should be safe to always make
> use of it when it is supported by the drive.

I checked with the ATA specs gurus, and NCQ FUA is always supported (if
NCQ is supported), regardless of support for WRITE DMA FUA EXT. Problem
is, that switching off NCQ has to go hand in hand with switching off FUA.
See below.

> 
>>>> So if we want a solid ata FUA support, we would need to always use NCQ
>>>> regardless of the drive max queue depth setting...
>>>>
>>> Sure, that would be the way I would be going.
>>> If the drive supports NCQ we should always be using the FPDMA variants,
>>> irrespective of the queue depth.
>>> Additionally we _might_ make FUA dependent on NCQ, and disallow FUA for
>>> non-NCQ drives.
>>> (Where it's questionable anyway; if you only have a single command
>>> outstanding the pressure on any internal cache is far less as with NCQ.)
>>
>> Yes, that is my thinking too. Will try this and see how it looks.
> 
> In my opinion, having FUA dependent on NCQ totally makes sense
> considering that there are no ATA_CMD_READ_FUA{,_EXT}.
> 
> In this case the NCQ disabling code in ata_eh_speed_down() will probably
> need to clear the queue FUA flag too.

Yes, that is the difficulty because this needs also a revalidation at scsi
layer. The flag is set there, not in libata. And if there is a mounted
file system on the drive, switching randomly from "have fua" to "sorry, no
more fua" might cause problems... Not 100% sure though.

Given that FUA reads do not seem to used at all, if we restrict FUA
support to drives that support both NCQ *and* WRITE DMA FUA EXT, then we
should be OK.

Let me rewrite the first patch for that and see how it looks.

> 
> Thanks,
> Maciej
> 

-- 
Damien Le Moal
Western Digital Research

