Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D09C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 13 Dec 2021 21:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbhLMVgE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:36:04 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36229 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhLMVgE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Dec 2021 16:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639431364; x=1670967364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y1aijt6W5xSLElwfb451rPpPyfNoxCPVqIiqCMNnxpU=;
  b=fdWokLAOVFlso1cLK4+Q08IfTUBBeXUXJ5NWtIsHQSAIGH3/RJVDmYzF
   Qe8z1mEN3wm9sXMbMZt9EGEg+uBlNTdRWxZTPiYhW/OPbHqcuOQOnRrSh
   LMsEPDQt2WkDNTes7ZRRitzKPh3lwp4ctfoe/NRLFC2igi6WoEm9cHBFf
   4twY+9F3UFdOfsjzfynqbZ9dJFS1YAnRUXebG15Y5LeF+nS3MpIGbZUrl
   ORj7f0/xhBauR1mjFcHHehs7maqV0xeLYOoUW+Suk8KvNgYzEFA18jAk4
   VngouGStJYaegVHfeanTNh4udgaGg0p5UBCY6XZgpq3vDkru4cjtCB3Os
   w==;
X-IronPort-AV: E=Sophos;i="5.88,203,1635177600"; 
   d="scan'208";a="189171312"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2021 05:36:03 +0800
IronPort-SDR: k/gXL8Jk3ayaO/hSlUNswKg6iz/wd0R9X98ulmfHkAdvow82ZDTyBDPJHsJrcg8JPEtLVYDoFh
 gVLdnTqZ+lHINHSFk5QMazVC1VSuov4pe+n6pzcA3RNRYvPnoLKl371Ltqc1v0zMNYzkN1B2Jg
 7fex5qJH+XdBczpR6kkdCGqxFsf68q1/A6af4XVW3NAMWQuVsV/dz8drK4l8IR+D8nqeteCrhY
 3Gd0PUwRixHhYdS9GCLpXc6yiNshdU5V2INRrxBD1+AngncpR9vgfBmFpLp2M9EuucNUfAPh1p
 u5YNFPKaej+/pqsTQl2h13Ex
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 13:09:01 -0800
IronPort-SDR: 1474BbOyyTNbIdOuGmM+usOkVBoI/72YHtJQsqk0uBJlHh6SSuWZfw8pEgVlnDJfYBPQuJAkT2
 z0BVOrpfkw2zsPINgoNLybhEIApZLwuhvv4e4x2q395IfR+MpZ8OGGdOja9ElOzGHIbpm56KPc
 In5vDYXC4mXIDaT9jWVoiwn5KcvzKyP0AmJ9ZkvZ69ANdzflp0fey5A10a59vg6i8mpZgVwHYa
 IQZ37dKEf3k55uuDOdw+JXclIck1XDuM6oTGi9e0BeVUPkXoY5N1A3kGmW7rlE+lm9JGebC/ZC
 Y6w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 13:36:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JCZZC25gKz1Rwns
        for <linux-ide@vger.kernel.org>; Mon, 13 Dec 2021 13:36:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639431362; x=1642023363; bh=Y1aijt6W5xSLElwfb451rPpPyfNoxCPVqIi
        qCMNnxpU=; b=daLbqARzPgpNwqofhGN03xEMK/W86BSGUcIk906EahyJc0Q6y/0
        2Ht+gu0i4+HiaPe/JhUJxcWw7NTSVjlRX2s8KajJ+xWOXnAHkOTTw1I24IPJsvIg
        AqaP3eYp5KF58iT5H2g3inA+1RyATrIIlWtAd3zaiCkY2yemXmuB0Q+OYy84o32P
        Lm4ULST0RIBvAlCiLUiaZuReq1zCu1PYxaC7xrNaJQkNHB0VjB7/7MpfY4Rv8TMg
        mZTx46OfYOMToxnx/bN2HFs90nkh/UDkLQhRVc6IOD92Us8nIiUfiDbPTDe+Bdkb
        GbQXBwuxmsWP3IvLV7zu1jKQuDi3GGKF4lg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iaacZjzWbdgf for <linux-ide@vger.kernel.org>;
        Mon, 13 Dec 2021 13:36:02 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JCZZ947Brz1RtVG;
        Mon, 13 Dec 2021 13:36:01 -0800 (PST)
Message-ID: <0d967bb4-0b80-c293-b7d5-f49c9cc38718@opensource.wdc.com>
Date:   Tue, 14 Dec 2021 06:36:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <549c1825-56e6-de9e-e109-77f0d06cfd0f@opensource.wdc.com>
 <5322dafd-86ad-a293-6005-29384cb96cc8@omp.ru>
 <de3dc434-8b87-5d9d-7fe8-bd44ff2bcbfb@opensource.wdc.com>
 <Ybcz85/ZoXRCmbbD@smile.fi.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <Ybcz85/ZoXRCmbbD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/13 20:52, Andy Shevchenko wrote:
> On Mon, Dec 13, 2021 at 07:39:31AM +0900, Damien Le Moal wrote:
>> On 2021/12/11 19:25, Sergey Shtylyov wrote:
>>> On 11.12.2021 2:45, Damien Le Moal wrote:
> 
> ...
> 
>>>>>> So 0 will be returned as-is. That is rather weird. That should be fixed to
>>>>>> return -ENXIO:
>>>>>>
>>>>>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
>>>>>> 		return -ENXIO;
>>>>>> 	return ret;
>>>>>
>>>>>     My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
>>>>> but returns -EINVAL instead.
>>>>
>>>> Thinking more about this, shouldn't this change go into platform_get_irq()
>>>> instead of platform_get_irq_optional() ?
>>>
>>>     Why? platform_get_irq() currently just calls platform_get_irq_optional()...
>>>
>>>> The way I see it, I think that the intended behavior for
>>>> platform_get_irq_optional() is:
>>>> 1) If have IRQ, return it, always > 0
>>>> 2) If no IRQ, return 0
>>>
>>>     That does include the IRQ0 case, right?
>>
>> IRQ 0 being invalid, I think that case should be dealt with internally within
>> platform_get_irq_optional() and warn/error return. IRQ 0 showing up would thus
>> be case (3), an error.
>>
>>>
>>>> 3) If error, return < 0
>>>> no ?
>>>
>>>    I completely agree, I (after thinking a bit) have no issues with that...
>>>
>>>> And for platform_get_irq(), case (2) becomes an error.
>>>> Is this the intended semantic ?
>>>
>>>     I don't see how it's different from the current behavior. But we can do 
>>> that as well, I just don't see whether it's really better...
>>
>> The problem I see is that the current behavior is unclear: what does
>> platform_get_irq_optional() returning 0 mean ? IRQ == 0 ? or "no IRQ" ? I think
>> it should be the latter rather than the former. Note that the function could
>> return ENOENT (or similar) for the "no IRQ" case. With that, case (2) goes away,
>> but then I do not see any difference between platform_get_irq_optional() and
>> platform_get_irq().
>>
>> If the preferred API semantic is to allow returning IRQ 0 with a warning, then
>> the kdoc comments of platform_get_irq_optional() and platform_get_irq() are
>> totally broken, and the code for many drivers is probably wrong too.
> 
> Yeah, what we need to do is that (roughly a roadmap):
>  - revisit callers of platform_get_irq_optional() to be prepared for
>    new behaviour
>  - rewrite platform_get_irq() to return -ENOENT
>  - rewrite platform_get_irq_optional() to return 0 on -ENOENT
> 
> This is how other similar (i.e. _optional) APIs do.

Sounds like a good plan to me. In the mean time though, your patch 1/2 should
keep the "if (!irq)" test and return an error for that case. No ?


-- 
Damien Le Moal
Western Digital Research
