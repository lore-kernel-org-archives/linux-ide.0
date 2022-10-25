Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50979C38A2D
	for <linux-ide@archiver.kernel.org>; Tue, 25 Oct 2022 08:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJYI7R (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Oct 2022 04:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiJYI7P (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2022 04:59:15 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DC2156269
        for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2022 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666688354; x=1698224354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cc4eR1NUSrZBqmgByfoUhk2d47RnUfv7h30hvrz3QPE=;
  b=R6tMB6+LPsmQW5fiY61pdMUvXcBN+Om3D4edpQlI6LSZvidSVeYsvWJT
   /u+jeP6SMqZRaf8LdLG4xkCYOdCH2iXCynDKC5u4rJGRpzjHmMG0lAq6j
   jlooTk04+gVnPGvwXusGT+6klHNQBuHdNY6Schb6td1soW9qPbxT+mSI9
   Jg8RzBXhz0VOZ/wJMYW+D9utPHNFYgl0tAOUyxibCzX14wxdNw7ggipfh
   aGrbTkoNe7CSFwzewncN4/8FmtBMjzbVGLafjyg+l0ODaPBhtyFJkbijj
   MagFJa8SSdOCEFDVPDJZtozMa071Aei3GoCVio8oWThLdOy4pIDxNMzdy
   g==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661788800"; 
   d="scan'208";a="215039763"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 16:59:13 +0800
IronPort-SDR: qf+/ARzW0HbwlFkyJCVjMp7EOW282X34/TtTT0vJdjXOzJ1Ktv/AcLBUh2HXgRG93EToSYTspu
 Xn52MzmF1F8v3Lf8jJB6HEkmEx4oWUpqDjJjrjjBdKtUanRWdZSeTpp0p0BMDxYWyH9+FrZm+U
 Purlus80fg2CvmCRquIEJUSFZiAiKXfiVyUZaYRSxs146xlLqbFqz47k2sctAvdl8H6Ar0pa1f
 ZNboH8NrU/cWq4eIy7pDWOPHVenY3hqnIWGao69I6scDq6LrDbnwkQtS0WBLdLirLch09c3fwo
 ay+aEKBeuNo17y4v5Xsn1GOg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2022 01:12:55 -0700
IronPort-SDR: dAIE2RWn6qaXgOoaRaXD5fF4ORu31TNHY6lULCKRVUAbr101RRLOfZh5QvDsgPfFvH+pcQhQ6o
 bbW/VG3FYMlZTGKwoJZp6cDRM5iGWTR4Gu8Yx2DiA5gCMoHtkT6LCVOd7B6/vOabQzjFL2TMmd
 jNHxWv3me8LJ3PLfAPapnoE/rLIRYTSYgiVYEWpY5AEoI745z2Stn3FHsGZfJ5QL97fMc9eMHd
 n2N/9g0/lRLmzH9wtD+gsiTA56FziduRfY9o9HkiUY8V0e1vgXEchzQB3pk/rIZJfp+Qvzah0k
 Cdg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2022 01:59:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MxQq21gDWz1RvTr
        for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2022 01:59:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666688349; x=1669280350; bh=cc4eR1NUSrZBqmgByfoUhk2d47RnUfv7h30
        hvrz3QPE=; b=n/wrNbhk41hyfj8u1bQTj0n/CnuHi619/Wopxi+5JY3Bh2jHoCe
        bdmdkKS0ZDfz+6EyNdBDJZuJysYwEq5VJPBbQEDhLw01/u7iSHVF0eU12qjDswAx
        pLkTJwZaW9lqefuKmEVNx+xlBTD5ZOCjGzkUbLWkDBRUrqwpRnL3WHKTfuB+U+Gc
        DOcqq7TI4OKN7K664Xw0hN5lPoJA4sPYKe6O+ixnmZoS0lxMwvExWK9WQZCBYW0R
        b2KGZouwYNun71/bhFjIrr2wuJmZqi9nLqYFwdwuOEvUwoSUJCQIb6pUlZJhDdis
        HgDZVdoam3OV8plBLYiesOi/KEQMCXGA28A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7Jjew2-V6FIu for <linux-ide@vger.kernel.org>;
        Tue, 25 Oct 2022 01:59:09 -0700 (PDT)
Received: from [10.225.163.8] (unknown [10.225.163.8])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MxQq105GLz1RvLy;
        Tue, 25 Oct 2022 01:59:08 -0700 (PDT)
Message-ID: <26def87e-6e44-17ae-f928-030c837c9dbe@opensource.wdc.com>
Date:   Tue, 25 Oct 2022 17:59:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 0/3] Improve libata support for FUA
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <f1456224-f644-dce5-15ea-fecc965788e1@maciej.szmigiero.name>
 <1401aa25-38de-c5e0-f9de-7aeb7ce0af9d@opensource.wdc.com>
 <a44337f7-3e8f-abcc-5695-f2e571087e8d@opensource.wdc.com>
 <709fb497-df73-0ee7-06db-1fb4c2e50cf6@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <709fb497-df73-0ee7-06db-1fb4c2e50cf6@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/25/22 16:05, Hannes Reinecke wrote:
> On 10/25/22 01:26, Damien Le Moal wrote:
>> On 10/25/22 07:09, Damien Le Moal wrote:
>>> On 10/25/22 03:48, Maciej S. Szmigiero wrote:
>>>> On 24.10.2022 09:26, Damien Le Moal wrote:
>>>>> These patches cleanup and improve libata support for the FUA device
>>>>> feature. Patch 3 enables FUA support by default for any drive that
>>>>> reports supporting the feature.
>>>>>
>>>>> Changes from v1:
>>>>>    - Removed Maciej's patch 2. Instead, blacklist drives which are known
>>>>>      to have a buggy FUA support.
>>>>>
>>>>> Damien Le Moal (3):
>>>>>     ata: libata: cleanup fua handling
>>>>>     ata: libata: blacklist FUA support for known buggy drives
>>>>>     ata: libata: Enable fua support by default
>>>>>
>>>>
>>>> Thanks for the updated series.
>>>>
>>>> In general (besides the small commit message thing that Sergey had
>>>> already mentioned) it looks good to me, so:
>>>> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>
>>> Thanks. I need to do some more testing using some very old drives I found.
>>> So far, no issues: detection works, some drives have FUA, other not. For
>>> the ones that have FUA, I am running fstests (ext4 and xfs) to check for
>>> weird behavior with REQ_FUA writes. Once I complete all tests I will queue
>>> this.
>>
>> Actually, I need to take this back. Checking again the code, I found an
>> issue with this entire FUA support: for a drive that does not support NCQ,
>> or one that has NCQ but has its queue depth set to one, then for a REQ_FUA
>> write request, ATA_CMD_WRITE_MULTI_FUA_EXT or ATA_CMD_WRITE_FUA_EXT will
>> be used. All good, BUT ! sd.c may also send read requests with the FUA bit
>> set if the read request has REQ_FUA set. For read commands, the regular,
>> non FUA commands ATA_CMD_READ_MULTI, ATA_CMD_READ_MULTI_EXT, ATA_CMD_READ
>> or ATA_CMD_READ_EXT will be used since ATA does not define a FUA version
>> of these. This means that the REQ_FUA flag will be ignored: this entire
>> code is broken as it is assuming that the read command processing on the
>> drive is consistent with executions of ATA_CMD_WRITE_MULTI_FUA_EXT or
>> ATA_CMD_WRITE_FUA_EXT. I do not want to bet on that, especially with old
>> drives.
>>
> Now you got me confused.
> What exactly would be the semantics of a READ request with the FUA bit 
> set? Ignore the cache and read from disk?
> That would only make sense if the cache went out of sync with the drive, 
> which really shouldn't happen, no?

For the NCQ read command, FUA text says:

If the Forced Unit Access (FUA) bit is set to one, the device shall
retrieve the data from the non-volatile media regardless of whether the
device holds the requested information in the volatile cache. If the
device holds a modified copy of the requested data as a result of having
volatile cached writes, the modified data shall be written to the
non-volatile media before being retrieved from the non-volatile media as
part of this operation. If the FUA bit is cleared to zero, the data shall
be retrieved either from the device's non-volatile media or cache.

So all well for NCQ, everything as expected, no surprises at all here.

But no equivalent behavior defined for non-NCQ read commands, and with
libata.fua enabled, ata_rwcmd_protocol() will cause any REQ_FUA read to
fail, which is the safe thing to do, but that is not what one gets when
libata.fua is disabled. So enabling libata fua by default could
potentially break some use cases out there of people using REQ_FUA reads
without realizing that it is doing nothing in non-NCQ case.

I have not checked the block layer though. Does the preflush/sync
machinery also triggers for reads ? I do not think so. I think REQ_FUA is
ignored for reads.

> 
>> I would be tempted to restrict FUA support to drives that support NCQ,
>> given that with NCQ, both READ FPDMA QUEUED and READ FPDMA WRITE have the
>> FUA bit. But then, the problem is that if the user changes the queue depth
>> of the drive to 1 through sysfs, ncq is turned off and we are back to
>> using the EXT read & write commands, that is, only write has FUA.
>>
> Hmm. Is this a requirement? We _could_ use the NCQ variants even with a 
> queue depth of 1, no?

Absolutely, yes. Running NCQ commands at QD = 1 is perfectly fine.
I think that this "do not use NCQ when QD == 1" is there mostly to deal
with drives that have a buggy NCQ implementation. Not sure. It has been
like this forever. Would need to do some git archeology about that one.

>> So if we want a solid ata FUA support, we would need to always use NCQ
>> regardless of the drive max queue depth setting...
>>
> Sure, that would be the way I would be going.
> If the drive supports NCQ we should always be using the FPDMA variants, 
> irrespective of the queue depth.
> Additionally we _might_ make FUA dependent on NCQ, and disallow FUA for 
> non-NCQ drives.
> (Where it's questionable anyway; if you only have a single command 
> outstanding the pressure on any internal cache is far less as with NCQ.)

Yes, that is my thinking too. Will try this and see how it looks.

> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research

