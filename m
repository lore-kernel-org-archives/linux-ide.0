Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D944BC433EF
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 02:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AFD610E9
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 02:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhIGCJj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Sep 2021 22:09:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1274 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhIGCJj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Sep 2021 22:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630980512; x=1662516512;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=4Xqw17M5SodFl6WmAW+4S4T4YUm23MM/HNmNfLb0Dl8=;
  b=Ux6exfj6gEpg5sTBNhufCQ55DL7i6vMUTwXV8E7nU9lazGJ8IK4FBfHu
   SQKoEfh1EeoW5ebGMpQhhPDDsrGMU8H0s9cMyvxRFmiBVg/2ZxcxiB6pW
   d8C78Rz15sHEuDpsMALsCht3jEsPtli7bs5tprldVgPN4sXTOKCAaTQet
   bTBZHhSMpV8KBlMUyLzbTfGeEA62INE2ZKooXhQKec2UmSuqq6w9fo3TQ
   /KndMTfnEO2NQBAcVO+lGB+raM3s+JNs9R4p7b/mmD4Tz8OsgO3J0Kkwv
   9ElCKZw85ZaUuuNYpDDwzUlt9RZSBpsmu7LENiRDT+HXb7rUE93rAQV2m
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,273,1624291200"; 
   d="scan'208";a="179334815"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 10:08:31 +0800
IronPort-SDR: 2n6Qf92fLaLIwa1ecYIDpLjAPCxp69Lhp4bkyrN/zDdlwZcfLj8iES7jYypY3nbycPItqptbwb
 umOrBKbQlK9g0UfHDrwyaNjewAelVZ0WVw7VOrPvGOB5oNA9emNLSE+ob/keLYejE5H+lJkgk6
 cpn0UaJsR1UUhu6HkDpduJyGfdBwSSIBx/acV4fMqF1v6XXcAFwMFWVRb29B3dDnm3dB/4r8ET
 Hoh1s6pqbawraOcEjejKrmaOerEOQa/AfAMpzpD3GWg7VjVeVHSMCjVBK6QnQOUFFcl16UtZsx
 RYdfcDpVRzUMPBtva02lB8dz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 18:45:12 -0700
IronPort-SDR: GbE0u0+NBaxEea84QhMMAjr6yipULa3jdqBDzeAWMxEEkiudRMQEfHhJ699J4T+0G4YxkD+EGr
 XOV3Im260UdgkdPB1V0SYjOv2KE9ScFykXxAil4XiqQP8PFmp2fWJOcgDGTmvRv3aJqZSZeyyc
 NDjgNsbgA4wHCDMTwySVqUJ1ZlZ9nPFI0P9NV6Xhjb5YerXKvmUwlJrbZ7ahbBzMMFCgQi8HW2
 XiPlC0DUKV+VwISq1wWsz4toHcXm3Z1d9/NWAYMu+WArtMj4MXQE1wYok5Yf/7MHXaOFKRlTjS
 cdk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 19:08:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H3TFr5clXz1RvlR
        for <linux-ide@vger.kernel.org>; Mon,  6 Sep 2021 19:08:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-language
        :content-type:in-reply-to:mime-version:user-agent:date
        :message-id:organization:from:references:to:subject; s=dkim; t=
        1630980512; x=1633572513; bh=4Xqw17M5SodFl6WmAW+4S4T4YUm23MM/HNm
        NfLb0Dl8=; b=C07mCAZHcNV9N4QriHbdNjHnU71LK2sl6KDJ5UJtQ3cki2+d8GX
        hpSPFhoUkKB2FSQi5+eXK4PNHXSs+WWcsBRp3Fl84D+Db7RfWlyO4pgiJJbs4hui
        FEQ7bpcqX5obTSnIvqoAXo6nnXhrY4EZs9220PgMY58Y4LaG7cfulF9OPKZbvpYE
        /hlD4jRqbiwLav9Ffk2jo6Z8ACQcbIojQr3eYVXAv83t1UdzjEqRDFetgbXs/Qhf
        MEHT+sTS5Hk2bCBYIj2a8Em9UHMtch/JBsbGaeV8g4GhAYgs3ipvfsVhDY0cLILf
        gtvPXLL+yUWf1GKW/uYw1b/7zMekeMm5mlA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3ZfM4iTVTyVQ for <linux-ide@vger.kernel.org>;
        Mon,  6 Sep 2021 19:08:32 -0700 (PDT)
Received: from [10.225.48.54] (unknown [10.225.48.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H3TFr0j2xz1RvlP;
        Mon,  6 Sep 2021 19:08:31 -0700 (PDT)
Subject: Re: [PATCH] libata: pass over maintainership to Damien Le Moal
To:     Jens Axboe <axboe@kernel.dk>,
        ALWAYS copy <linux-ide@vger.kernel.org>
References: <b4cafca7-ad37-ec70-7b89-9025c35902a8@kernel.dk>
 <4f9b5f1d-7130-9434-8c54-23b4117bbad7@opensource.wdc.com>
 <1b3ad1ca-b3d9-3258-059c-44d74344b9a3@kernel.dk>
 <0ddfe118-39c2-ea97-73e0-9751c8efe94e@opensource.wdc.com>
 <fad3b185-da43-9657-0f7a-469b9f62149a@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
Message-ID: <dec7319f-dab5-61dc-b767-d6364e4c6f51@opensource.wdc.com>
Date:   Tue, 7 Sep 2021 11:08:30 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fad3b185-da43-9657-0f7a-469b9f62149a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/09/07 9:57, Jens Axboe wrote:
> On 9/6/21 6:52 PM, Damien Le Moal wrote:
>> On 2021/09/07 9:50, Jens Axboe wrote:
>>> On 9/6/21 6:47 PM, Damien Le Moal wrote:
>>>> On 2021/09/07 9:45, Jens Axboe wrote:
>>>>> Damien has agreed to take over maintainership of libata, update the
>>>>> MAINTAINERS file to reflect that.
>>>>>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>
>>>>> ---
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index fb1c48c34009..ed9e3770d8b5 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -10597,10 +10597,10 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>>>  F:	drivers/ata/sata_promise.*
>>>>>  
>>>>>  LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
>>>>> -M:	Jens Axboe <axboe@kernel.dk>
>>>>> +M:	Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>>>  L:	linux-ide@vger.kernel.org
>>>>>  S:	Maintained
>>>>> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
>>>>>  F:	Documentation/devicetree/bindings/ata/
>>>>>  F:	drivers/ata/
>>>>>  F:	include/linux/ata.h
>>>>>
>>>>
>>>> Jens,
>>>>
>>>> Thanks for sending this. I did name the tree "libata" but since this includes
>>>> many drivers, would "ata" be a simpler and more general name ?
>>>
>>> I think libata is fine, but it's really up to you. 'ata would definitely work
>>> too, especially now that all the old IDE code is gone.
>>
>> OK. Since I think everybody is used to libata, let's keep that then.
> 
> It's the most straight-forward for sure.
> 
> Want me to add you Acked-by to the patch?

Yes. Thanks.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>



-- 
Damien Le Moal
Western Digital Research
