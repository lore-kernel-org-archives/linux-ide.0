Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65CAC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  6 Oct 2022 22:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJFWUw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 6 Oct 2022 18:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiJFWUv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2022 18:20:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07E4AE859
        for <linux-ide@vger.kernel.org>; Thu,  6 Oct 2022 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665094849; x=1696630849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ed66ZfvjqdUinhLv/eIR4kRB4ISdWi8bfQ9X8VDttzs=;
  b=MTTWl7QOwRTV5RnKQ6fM6E29wRE48HmFqs/2CLgewPZs5moQAjDDRf37
   1IoFGtZ9fTdPi5dZDJ78gjb/Gm3lPQolTQr25c30bdQukGCvYQUITJr7M
   1OriAzQVCuwRQcMnRfid8JwZEd0mB8u2sO0iWLPqTTnM0pIZ6EURG6+D2
   KxS/Xbk64ybbf60r4N4gXG+gr89dyL+82O/mWYmIknPly6JCbpFNyL00K
   JxHchFebFG5nafPV27AIvNZXnxaUHS+x+mNP5iwIGUl2BJ/QoKRHpJ28z
   MQK2E18uuxV7tyH9efV9DUWGRpvV075wtPaMEBDkSGyyUJonzUIhh8YkL
   g==;
X-IronPort-AV: E=Sophos;i="5.95,164,1661788800"; 
   d="scan'208";a="325284979"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 06:20:49 +0800
IronPort-SDR: 3OMm8pmywtymvu1sDx+4xnacF7qR89Uo/Hj/E1F2iH+h/XrxKLZlKqOZ0+8byWnAPY3DmMHPn0
 /o9gGHDc0cGX7kORtM+3k59fwcbPXjytyZMzYPOa59GOukXB+mg6jwN4ih5UEm0SE4QRqI8k03
 AImZ6xJByT17cTemb/7UbrR0+GLjisKHgO9zpLYyYzM70kU2gI31vS51d++WeqTlr1njN7orl1
 QugO7vW02ohGhq8RtMRTI7wWr/83oEmDU8eE/v8/00S16FkUMojgqiAv9JXt7EdmN/xqg5b0qL
 Ivalt4nNfP3QPC8oDHFX/+P+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 14:40:34 -0700
IronPort-SDR: aB0qm1G+c2g1lJ42yhSD7xF1Ar35w4D8TP01wHweDkjuWwnjtAVALpI2mYGM0Oz8XJ64dHODtq
 eIQTMML6FRKMxqUJ5n6bGy69Kmi7Su4GedywzC0VaK9RUIwfAb4SYIejSLXk3ulPCJwmRhG6m3
 9ubzey7VnxHbwYBa6PUnQV9TDfo1uY1wTAQQpp2zkNNvPp6fDzI7PoPoQi9Kc5PV8m9lu0lYGn
 JkLIhsEHErVwkmC9rnNL+nkP+7f1uYnqRGW7Roa3nH55A14/NLpBm6E8qhKhaXf3Zczc95dCt5
 UJM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 15:20:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mk5Vm5nsmz1RvTp
        for <linux-ide@vger.kernel.org>; Thu,  6 Oct 2022 15:20:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665094848; x=1667686849; bh=Ed66ZfvjqdUinhLv/eIR4kRB4ISdWi8bfQ9
        X8VDttzs=; b=nNSLn9ue0u1AlIjMTH8DOgdrLtQlSAYKV1jJobeap2y6AX0yrS3
        TBJRPseCObARidt1eTKwfnsdTbGlokBcoWI536dTWCZZDtp8uO+IIm8d+c6JWUy6
        k62tv9yiZ+w9Oln/Vl/J4/8YJVBblHb/NeKKteuBr77iRtnTbDeMLKGqBqFCBXJy
        ixrUKwNbi8l37MoLrDUPP2hsLCyfEZgRdlBNodK1Vvzg6A4JpVR78Ghq2xAwGa0m
        ICFGrEfsB4KsK4e/elgKqMKRtnWmDLv5NL4mW4ho3odFbKt12anXg5Y0kNOa7Kyn
        MbfKFm5GDDZe9N64LmHY7qnNAdM7ekjuoAQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pZYh0FKUcH7G for <linux-ide@vger.kernel.org>;
        Thu,  6 Oct 2022 15:20:48 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mk5Vl3kXVz1RvLy;
        Thu,  6 Oct 2022 15:20:47 -0700 (PDT)
Message-ID: <28712bad-8215-4246-7370-42d204488aa3@opensource.wdc.com>
Date:   Fri, 7 Oct 2022 07:20:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] ata: allow enabling FUA support in Kconfig
Content-Language: en-US
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
 <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
 <24a48f71-8a79-6311-1e43-494df0458a32@opensource.wdc.com>
 <7ecf20b7-794a-39d8-0b03-8f19d9167efd@maciej.szmigiero.name>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7ecf20b7-794a-39d8-0b03-8f19d9167efd@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/6/22 22:06, Maciej S. Szmigiero wrote:
> On 6.10.2022 01:38, Damien Le Moal wrote:
>> On 9/27/22 04:51, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Currently, if one wants to make use of FUA support in libata it is
>>> necessary to provide an explicit kernel command line parameter in order to
>>> enable it (for drives that report such support).
>>>
>>> In terms of Git archaeology: FUA support was enabled by default in early
>>> libata versions but was disabled soon after.
>>> Since then there were a few attempts to enable this support by default:
>>> [1] (for NCQ drives only), [2] (for all drives).
>>> However, the second change had to be reverted after a report came of
>>> an incompatibility with the HDD in 2011 Mac Mini.
>>>
>>> Enabling FUA avoids having to emulate it by issuing an extra drive cache
>>> flush for every request that have this flag set.
>>> Since FUA support is required by the ATA/ATAPI spec for any drive that
>>> supports LBA48 and so these days should be pretty widespread let's provide
>>> an ability to enable it by default in Kconfig.
>>
>> This can be done by adding "libata.fua=1" to the CONFIG_CMDLINE option. So
>> I do not see the need to add yet another config option.
> 
> A specific Kconfig option is more structured than a free-form
> CONFIG_CMDLINE (which is also technically a per-arch option, but seems
> to be widely supported across arches).
> 
> That's why there is a lot (100+) of similar Kconfig default-changing
> options, a quick sample of these (in no particular order):
> SOUND_OSS_CORE_PRECLAIM, SND_INTEL_BYT_PREFER_SOF, LSM,
> SECURITY_SELINUX_CHECKREQPROT_VALUE, SECURITY_LOADPIN_ENFORCE,
> SECURITY_APPARMOR_DEBUG_MESSAGES, IP_VS_TAB_BITS, IP_SET_MAX,
> MAC80211_HAS_RC, SLUB_DEBUG_ON, KFENCE_SAMPLE_INTERVAL, PRINTK_TIME,
> DEBUG_OBJECTS_ENABLE_DEFAULT, RCU_NOCB_CPU_DEFAULT_ALL, ...
> 
> libata currently has only one similar option: SATA_MOBILE_LPM_POLICY,
> so it's not like a person performing kernel configuration is
> overloaded with questions here.
> 
> But at the same time, I respect your decision as a maintainer of
> this code.

I am not dead set on pushing back on this, but as usual, whenever we can
avoid adding config options, we should. Given that libata has had fua
disabled forever, I am not convinced yet that there is a strong need for
that new option. But if distros prefer the config option approach, we can
make that happen.

If anything, I would be tempted to switch fua support to on by default
after some time if we do not get many reports of broken drives. You did
mention that old mac minis drives did not like it, but these are not even
blacklisted in libata-scsi. They should. Only one model of maxtor drives
is. We should add an ATA_HORKAGE_NO_FUA flag and start a proper blacklist
of drives not liking fua. Without that in place, switching to on by
default as your config option allows could break many (old) systems.


> 
>>
>> Patch 1 looks good. I will queue it up once rc1 is out.
> 
> Thanks,
> Maciej
> 
> 

-- 
Damien Le Moal
Western Digital Research

