Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DE4C32771
	for <linux-ide@archiver.kernel.org>; Wed, 21 Sep 2022 05:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIUFBq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Sep 2022 01:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIUFBo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2022 01:01:44 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8A97F104
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 22:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663736491; x=1695272491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q5cIs7tgeel9shnKbHvteslGBGGfLbtwZglccJg4n5Y=;
  b=HM5gmlgF4B54/pSUtosCAhsTzCiMiUjwG8Gk4gwofIYii9qBlSw+RDrn
   Mxo6N+CFyAdkdQcoBf62Z2rvdy0SSOhxe7k3nZM6FW3BmdpCFRJMUh9Er
   LNQP1iC3WJOnjQRQuZoY3LluKhuc+j6jpM2+6PjNdBpQXT+LHSEaCW0ot
   Sg6U9MRyV5nE+Cvhbrls0NBgbBVEmgI/SEDo1rI/X+F+6JmMeWnGbgfpv
   cglgsU1YAJsvAx7HmruggaCITzAVnTq+qM1Ju6Wl7rUufR6zBCfbyoTiq
   mImSioNyCcdizC4VfIMRMG1Cb+n0QTNllF/UijWYNOVNIKEVe9e4DtTyE
   g==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654531200"; 
   d="scan'208";a="212314269"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 13:01:30 +0800
IronPort-SDR: mYgwCczTivA0ixRNM371xpvExqCb5z+nuvTH2mYelDwlnOD6VLdpG5hVEmAb9Ej+JbHRQ2+JMz
 IJcquwSucfEmdqFi6yzxPODqjvsNUMkvfMevncrWSKsGKF2oeN8Xl8fVFm4SAoVW5UEFqDzW2M
 L5gRd7D9YA5XXcfiZZmR13VmZOFBHGF9hZGEwh9hkqOw/jd1ZAgEKAhH1dynCSmbe6f4QpVEhd
 jM7SgibFKiJhLadkdlnI9Ur8REwUiz91SK8FBYJiP1TFY9X46kcs/sLeuSFOQ7Uq6KOR2wQsN5
 eHBRXnE8W+nD0UjkkH8F6q7f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 21:21:35 -0700
IronPort-SDR: 1W48a4/4JyETXv62xkJddBKaF/ath/ZMnnFRfDGkPUZmbQKXLcYU1oQo5nHQj/JG3r+0OyeP+V
 vu00QpCTeWXPniJq3eBRa0nCZsCIpfwnn/wljJFB/Q2Xk18DoOT3b91A45NE0fGWk1v3buDdd4
 QNjyH08Uqw/SK4I1/iBujFta2mTCGv0wfvJVGikUkI0vqeoeUeFv9I2+Qx0PDuX29+qUtI2c/D
 MCEBHvGClCjIyQy5AErLRjVSKoP4BC7NkLX4ZrTg2CgboBAnfxzPrayb6YK0NQ0GK9yqPWPQ8N
 uYU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 22:01:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXR8T5z3zz1RwqL
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 22:01:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663736489; x=1666328490; bh=Q5cIs7tgeel9shnKbHvteslGBGGfLbtwZgl
        ccJg4n5Y=; b=cVboLpvWwpWspG+0bv4b0UQRTDyekpBFNW10nUXqK/0Nd44mZwH
        JikleBya7AmsIFKSPXgqcmyzXls0XUYgqBvDV+sZhMD9Axh5onjYRvul2yMeyuXX
        oWAgUJqjFExqlXe/BcVQvARS+tnkGY+MX1oqiPQqjbmfVG+V701eIKO0+NGpyGJI
        q0CENqvyoYf8prK5SMXY+SeSwi+GiOyWInUROoTgJw71eq9CyEBxYVvtNeP//hyw
        oORyLuaXmqMB7zDvInAChUxWrE/ZQ/cgNnUr4WWEjeIznc56YmX+ooToOfmDgaas
        jOLN/BIbI1nC0momJ61WCGwfbCrJ/7T+HAw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fADFhBY-s1IA for <linux-ide@vger.kernel.org>;
        Tue, 20 Sep 2022 22:01:29 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXR8R2jqzz1RvLy;
        Tue, 20 Sep 2022 22:01:27 -0700 (PDT)
Message-ID: <cf2d8276-ee36-9923-1444-1dd7d489b172@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 14:01:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
 <20220321212431.13717-3-pmenzel@molgen.mpg.de>
 <BL1PR12MB5157DDFD5E75360F032346D3E2169@BL1PR12MB5157.namprd12.prod.outlook.com>
 <cc7b4426-f6a6-e6b1-4aaf-0a713ee3d388@opensource.wdc.com>
 <5fb6af7b-d84f-cbae-7eb1-543f3a7e53e4@molgen.mpg.de>
 <d9837420-1cbb-ed5e-7043-985d9eb9d065@opensource.wdc.com>
 <b3e4435d-335c-1aba-1920-c225b46d09e7@molgen.mpg.de>
 <f6c78650-f22f-fcaf-a660-b1fc4ea7f641@molgen.mpg.de>
 <22f69d9a-7d0d-a408-70b3-11295f14b82d@opensource.wdc.com>
 <67950993-2eb9-c180-7c80-98c9954c9b22@molgen.mpg.de>
 <85f8c8cb-b4b9-b3ed-e79f-a1a161c9b672@opensource.wdc.com>
 <65012735-0a92-1071-e8e0-9d101c247a64@molgen.mpg.de>
 <3135eed0-b7e3-42fa-5b6c-80360f34e428@opensource.wdc.com>
 <893fe832-d522-112e-53ec-0f030c15af0d@molgen.mpg.de>
 <318b0452-9814-6276-95a5-10478e5a1b7d@opensource.wdc.com>
 <178704d0-b5fd-f750-b77e-fece6c6d81dd@molgen.mpg.de>
 <MN0PR12MB6101E77F03E5A21AEC8A5D6DE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <MN0PR12MB6101E77F03E5A21AEC8A5D6DE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/14/22 00:28, Limonciello, Mario wrote:
> [Public]
>=20
>=20
>=20
>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Tuesday, September 13, 2022 10:23
>> To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Hans de Goede
>> <hdegoede@redhat.com>; linux-ide@vger.kernel.org; LKML <linux-
>> kernel@vger.kernel.org>
>> Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for =
AMD 300
>> Series Chipset SATA Controller
>>
>> Dear Damien,
>>
>>
>> Am 01.09.22 um 00:13 schrieb Damien Le Moal:
>>> On 8/30/22 18:05, Paul Menzel wrote:
>>
>> [=E2=80=A6]
>>
>>>> Am 01.06.22 um 10:58 schrieb Damien Le Moal:
>>>>> On 6/1/22 01:18, Paul Menzel wrote:
>>>>>>>>> With that in mind, I am not planning to apply your previous pat=
ches
>>>>>>>>> for 5.18, as they would conflict and would only end up being ch=
urn
>>>>>>>>> since the delay removal by default will undo your changes.
>>>>>>>> Obviously, I do not agree, as this would give the a little bit m=
ore
>>>>>>>> testing already, if changing the default is a good idea. Also, i=
f the
>>>>>>>> conflict will be hard to resolve, I happily do it (the patches c=
ould
>>>>>>>> even be reverted on top =E2=80=93 git commits are cheap and easy=
 to handle).
>>>>>>>
>>>>>>> The conflict is not hard to resolve. The point is that my patches=
 changing
>>>>>>> the default to no debounce delay completely remove the changes of=
 your
>>>>>>> patch to do the same for one or some adapters. So adding your pat=
ches
>> now
>>>>>>> and then my patches on top does not make much sense at all.
>>>>>>>
>>>>>>> If too many problems show up and I end up reverting/removing the
>> patches,
>>>>>>> then I will be happy to take your patches for the adapter you tes=
ted. Note
>>>>>>> that *all* the machines I have tested so far are OK without a deb=
ounce
>>>>>>> delay too. So we could add them too... And endup with a long list=
 of
>>>>>>> adapters that use the default ahci driver without debounce delay.=
 The
>> goal
>>>>>>> of changing the default to no delay is to avoid that. So far, the=
 adapters
>>>>>>> I have identified that need the delay have their own declaration,=
 so we
>>>>>>> only need to add a flag there. Simpler change that listing up ada=
pters
>>>>>>> that are OK without the delay.
>>>>>>>
>>>>>>>> Anyway, I wrote my piece, but you are the maintainer, so it=E2=80=
=99s your call
>>>>>>>> and I stop bothering you.
>>>>>>
>>>>>> I just wanted to inquire about the status of your changes? I do no=
t find
>>>>>> them in your `for-5.19` branch. As they should be tested in linux-=
next
>>>>>> before the merge window opens, if these are not ready yet, could y=
ou
>>>>>> please apply my (tested) patches?
>>>>>
>>>>> I could, but 5.19 now has an updated libata.force kernel parameter =
that
>>>>> allows one to disable the debounce delay for a particular port or f=
or all
>>>>> ports of an adapter. See libata.force=3Dx.y:nodbdelay for a port y =
of
>>>>> adapter x or libata.force=3Dx:nodbdelay for all ports of adapter x.
>>>>
>>>> This is commit 3af9ca4d341d (ata: libata-core: Improve link flags fo=
rced
>>>> settings) [1]. Thank you, this is really useful, but easily overlook=
ed. ;-)
>>>>
>>>>> I still plan to revisit the arbitrary link debounce timers but I pr=
efer to
>>>>> have the power management cleanup applied first. The reason is that=
 link
>>>>> debounce depends on PHY readiness, which itself depends heavily on =
power
>>>>> mode transitions. My plan is to get this done during this cycle for
>>>>> release with 5.20 and then fix on top the arbitrary delays for 5.21=
.
>>>>
>>>> Nice. Can you share the current status?
>>>
>>> No progress. I need to put together a series with all the patches tha=
t
>>> were sent already. Unless Mario can resend something ?
>>
>> No reply from Mario.
>=20
> I think what happened here is there was related patches from another pa=
rty
> that got tangled up with this.

Niklas and I are investigating this again now because Niklas discovered=20
that one AMD AHCI adapter leads to drive resets when the drive goes to=20
low power mode. The adapter is:

  SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA=20
Controller [AHCI mode] [1022:7901] (rev 51)

If we switch to performance mode (no LPM), the reset disapears. But if=20
LPM is enabled, any command sent after the disk goes to low poer mode=20
(device initiated), there is a link reset...


--=20
Damien Le Moal
Western Digital Research

