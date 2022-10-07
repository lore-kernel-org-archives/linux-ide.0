Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B639CC433F5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 22:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJGWlI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 18:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJGWlG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 18:41:06 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B623778BEC
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665182464; x=1696718464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EjRssl1daDe09JoKN81W40Eva9O4vDDRqQJOMhoSowk=;
  b=leIoot9RZSTGYtxCzhPH0Xpbv0pauPnWtQey/MzOeEu8fDT9Rd0lEtTk
   qDyF3dG+YxkGBpA2YAPMBMy4CDh4ouKY3zoLdieL3FqGTyqeSNLyD3L/x
   Ska/S744XL/zbz+Dm/0mBVVvgrQ35a6RBBFu2L/VoSQTXhQ587vw4K3lD
   M3D7RZRdcLHWdJJOAvKUt1+BGbFJId4cfjLLvF9GjsFaw/jmb8Tt/BLU/
   fSlMkpwcrhXxF8HJAJh20vKQ5tsC9dLuG88eRHqKgbG2HLo0oz4oYnK7F
   bmobI1Yup46Yx3HiXbz8bgSS+nmS6CXy1bQEA9PaNYB2EKqaDMFcHAn3m
   g==;
X-IronPort-AV: E=Sophos;i="5.95,168,1661788800"; 
   d="scan'208";a="211610067"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2022 06:41:04 +0800
IronPort-SDR: UOux8aGGxFzZfRZRBCftgwsWlp3DfD5AT/wdJe1BAkQcOaVBTQhzW5+dlhqiLzh24y8zZ/R9Ro
 njiwjlmpTb4mBO4m8A1X3arGR2qgNN2yRkd7h+3M2pMojMvB7E4Fp3l/Q34SSJ9IPZNVmgshhx
 T1eBSNKcEfEvpnVR3fBQe1y1Y5g16Kk/490KD1Zkr7qd3Up+FlOxOLSxKY/5sO+XhbTng9hOAY
 t0eZ3s7Vjfh1rV/b/4RHYx7It3lDdVTcUgn1zqc8MP2rWHPdm/f54yGB10ntFVxJi6WrKOgEEB
 xyPNQyNmLgpeSxdXI/1UrzJw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 14:55:13 -0700
IronPort-SDR: VuSZoshvcEXLvKO96eVKwXEvD+cSmVvCZ+H4yyoVBoJzmPkJQ/lI1vgmnB8iDA9F0ZvOJ64eBm
 y21oplSh1Ho73A5Ec256CR/IKDjO9uasMDE3SA5CLQMmvavrX7/EvLL50SmGzAUPUvzcU3Yu8v
 v/D4D/YVVr1uWfGfBmijf/i/m6g0wUmI0riu9v+Qo8C2AN0RFMB2vLWyjM0YNZMKFzYm6jy3Im
 BJIiSE0bZVKTr5Ir/q+K+jCthcZTRqZcDcTe20/RnRDjBRufJFhKYTXe1XehrsQ+6BCHMLWoNA
 r58=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 15:41:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mkjvg72L2z1RvTp
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 15:41:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665182463; x=1667774464; bh=EjRssl1daDe09JoKN81W40Eva9O4vDDRqQJ
        OMhoSowk=; b=RO5s+zASK0PXbEWTgJwhuwA9Yb6rxc0+6XDTWj0g8pCt2bFCUDh
        VNIiBZZOZ1nl/BNtNQhNJL1pnivfKKi8vza//46FTpy1+IKn7fyj8TKdJgAgY6Nm
        YO+Ri5i3b6lHO6/E9WmWCexoXW2fjJP1vFeoqDvGwhtF5wUPzvO5zpBxRztgwHO8
        VgGPLStSKNOhHzb1/5T7zzn9/rNc6UEySas4CGl3/8FB1HY1c/jJROjZqa7ENp8T
        CTTDAteZM1q2iTGX6fIU2QtLaxN/AXcwZD57YxHnFxBlK4ARyKK11/GBHJ43RhYI
        wHPso3tER7d4/xARGBEmB7efXNAdgPxhTxg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9NXZS01BfjWc for <linux-ide@vger.kernel.org>;
        Fri,  7 Oct 2022 15:41:03 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mkjvf6dDSz1RvLy;
        Fri,  7 Oct 2022 15:41:02 -0700 (PDT)
Message-ID: <cb78be0f-633c-29ee-a3c8-cc05d8108cf9@opensource.wdc.com>
Date:   Sat, 8 Oct 2022 07:41:01 +0900
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
 <28712bad-8215-4246-7370-42d204488aa3@opensource.wdc.com>
 <7cf5744e-78ec-79c3-98af-2a716167ea1a@opensource.wdc.com>
 <31f8c4d1-1575-e64d-f42a-ce864e060975@maciej.szmigiero.name>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <31f8c4d1-1575-e64d-f42a-ce864e060975@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/7/22 23:14, Maciej S. Szmigiero wrote:
> On 7.10.2022 00:53, Damien Le Moal wrote:
>> On 10/7/22 07:20, Damien Le Moal wrote:
>>> On 10/6/22 22:06, Maciej S. Szmigiero wrote:
>>>> On 6.10.2022 01:38, Damien Le Moal wrote:
>>>>> On 9/27/22 04:51, Maciej S. Szmigiero wrote:
>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>
>>>>>> Currently, if one wants to make use of FUA support in libata it is
>>>>>> necessary to provide an explicit kernel command line parameter in order to
>>>>>> enable it (for drives that report such support).
>>>>>>
>>>>>> In terms of Git archaeology: FUA support was enabled by default in early
>>>>>> libata versions but was disabled soon after.
>>>>>> Since then there were a few attempts to enable this support by default:
>>>>>> [1] (for NCQ drives only), [2] (for all drives).
>>>>>> However, the second change had to be reverted after a report came of
>>>>>> an incompatibility with the HDD in 2011 Mac Mini.
>>>>>>
>>>>>> Enabling FUA avoids having to emulate it by issuing an extra drive cache
>>>>>> flush for every request that have this flag set.
>>>>>> Since FUA support is required by the ATA/ATAPI spec for any drive that
>>>>>> supports LBA48 and so these days should be pretty widespread let's provide
>>>>>> an ability to enable it by default in Kconfig.
>>>>>
>>>>> This can be done by adding "libata.fua=1" to the CONFIG_CMDLINE option. So
>>>>> I do not see the need to add yet another config option.
>>>>
>>>> A specific Kconfig option is more structured than a free-form
>>>> CONFIG_CMDLINE (which is also technically a per-arch option, but seems
>>>> to be widely supported across arches).
>>>>
>>>> That's why there is a lot (100+) of similar Kconfig default-changing
>>>> options, a quick sample of these (in no particular order):
>>>> SOUND_OSS_CORE_PRECLAIM, SND_INTEL_BYT_PREFER_SOF, LSM,
>>>> SECURITY_SELINUX_CHECKREQPROT_VALUE, SECURITY_LOADPIN_ENFORCE,
>>>> SECURITY_APPARMOR_DEBUG_MESSAGES, IP_VS_TAB_BITS, IP_SET_MAX,
>>>> MAC80211_HAS_RC, SLUB_DEBUG_ON, KFENCE_SAMPLE_INTERVAL, PRINTK_TIME,
>>>> DEBUG_OBJECTS_ENABLE_DEFAULT, RCU_NOCB_CPU_DEFAULT_ALL, ...
>>>>
>>>> libata currently has only one similar option: SATA_MOBILE_LPM_POLICY,
>>>> so it's not like a person performing kernel configuration is
>>>> overloaded with questions here.
>>>>
>>>> But at the same time, I respect your decision as a maintainer of
>>>> this code.
>>>
>>> I am not dead set on pushing back on this, but as usual, whenever we can
>>> avoid adding config options, we should. Given that libata has had fua
>>> disabled forever, I am not convinced yet that there is a strong need for
>>> that new option. But if distros prefer the config option approach, we can
>>> make that happen.
>>>
>>> If anything, I would be tempted to switch fua support to on by default
>>> after some time if we do not get many reports of broken drives. You did
>>> mention that old mac minis drives did not like it, but these are not even
>>> blacklisted in libata-scsi. They should. Only one model of maxtor drives
>>> is. We should add an ATA_HORKAGE_NO_FUA flag and start a proper blacklist
>>> of drives not liking fua. Without that in place, switching to on by
>>> default as your config option allows could break many (old) systems.
>>
>> To be extra clear, I think that this fua module parameter is silly. If a
>> drive says it supports fua, we should use it and not have a global
>> parameter to disable it for all drives. So no config option needed for it.
>>
>> That is also why I am not keen on taking that config option. It is not
>> really improving anything at all and would prefer nuking the fua module
>> argument and have a proper blacklisting of buggy drives.
>>
>> But such a change is painful as we'll be able to update the blacklist with
>> users getting corrupted FSes on buggy drives. The time may have come to do
>> this change though as the number of buggy drives out there is hopefully
>> small enough now.
> 
> So your proposal is basically to switch the existing fua option default
> to "on" and deal with the fallout (hopefully minimal) by blacklisting
> misbehaving drives as they get reported, right?

Yes. The risk though is that if the fallout are not minimal and we get too
many bug reports, we'll likely have to revert. So this needs to be
attempted early at the beginning of a cycle to get plenty of testing.

> In this case, my vote would be to still keep the "libata.fua" parameter
> available (at least for the time being) so people have some way of
> working broken drives around without having to recompile their kernel
> (maybe also print a kernel log message if libata.fua=0 is provided asking
> people to report these drive models to linux-ide@).

If we add a proper "nofua" horkage flag to blacklist buggy drives, we need
to move the fua parameter to be an argument of the force parameter so that
disabling fua can be done per drive (port) or for all drives, similarly to
other tweak (noncq, nodmalog, etc)

> 
> Thanks,
> Maciej
> 

-- 
Damien Le Moal
Western Digital Research

