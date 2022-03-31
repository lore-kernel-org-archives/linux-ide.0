Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC44C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 31 Mar 2022 23:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbiCaXGC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 31 Mar 2022 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbiCaXGA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 31 Mar 2022 19:06:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E391925A2
        for <linux-ide@vger.kernel.org>; Thu, 31 Mar 2022 16:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648767853; x=1680303853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tucNaCUnD64doiDrH2VZYUE5jsE6WjQSguxgWFjc2AM=;
  b=aSiluPDsv0C6UKVK2OTXVAXA0hoITveRikWSveafe2l3jAy1Rjmc488m
   CBJugqVD2o5jLQ9Bu177YAusfZwnzKu9uxgeKMSTerS6rupnsYUaaCesO
   CHdHt2O1z68Eco4g0fIgKAfOz2w8Peh4TMFSuDjfBV9R9gBlYMrv2S0AL
   vVaPiSruUeJ3MyRzgaPvNjD5UnCEvOiVaCzf5enLrWU8OH/o1Q6T57ntE
   TG4JERZ9j+hoU0jjk7GJvBtSDStUWH67AH8v2oy8jbH1F8nLXQit8W4kl
   HHnfv2GLIP24gwPL+0yc9JDdcKC+5ZxZZH5Pvjdf6D/JwoXdUtQ8774J3
   g==;
X-IronPort-AV: E=Sophos;i="5.90,225,1643644800"; 
   d="scan'208";a="197688847"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2022 07:04:11 +0800
IronPort-SDR: u+D7LY4mb9GKzBAEceVHGdQNSkuOzE7AdSzil++9uf/yR4y+Rcsd13PJdQLStVmSiZh9eoSau2
 rimJNpzIo5vD3EbySgl10JIk422GOYoGKLPGWBgcH6X+EtxZEQFYoIW/gKx5U7E+D0H187HHSg
 GhBpTQwPwA+fFI7KFF0dNcetQO8k9skIGdpuxA8Li/DHCBTJ2rMS7xBVTv4sR/9Scqs2TiOZw1
 xENCm6jgl4ojI2qfzAlYNmfMZGLOryEyGNpWXqYONJtNAE15vpCpDeLgt3C7QjD6IJa3Gck8kz
 7nB2LO63aJpQ+VFwyCrVOwen
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2022 15:34:58 -0700
IronPort-SDR: ka8QPexfILRze2EwgNOOMs7S6/7TUzyPiboWQ3MVlbDT9Lu+972sgoMVSG4jep6y41HWr052ul
 N83TV2ryV4/pBc6JnYn/8ImhRzNho7I+xYK4dr34nasQomxwc12859PW1P+RzW2iB3s1REmdiF
 FrbeYdCLAnri9Y/Q5gxOAE+LVtcym8x7VT6NcllqaETruLuvqjw+4Q8//F1h3No6bOOoiHCNfG
 XC1PK+UNo38POySsqCMO0DCwKN9KClHounMH4Uc+iq7nF3gUkPNjCXQXVbW2NyDW8jo7hDqp/r
 sEs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2022 16:04:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KTzQ200hLz1SVnx
        for <linux-ide@vger.kernel.org>; Thu, 31 Mar 2022 16:04:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648767849; x=1651359850; bh=tucNaCUnD64doiDrH2VZYUE5jsE6WjQSgux
        gWFjc2AM=; b=A/bFKKl+a7d7ND+7qicmHRuI3H/QVGVym6kET2Hawf/02mK1BrP
        r45lOiz4r9wiW574prdunX7jjM670bu6YZZm5vfYA35uGY5hpUcbO6StQo4Z2AHh
        sZoOdfYWDb61fNb7ITw4orHCCLzFQQavdZe2GGGcOrX23L/SfhZgegwPDnHf0L73
        hUOX3e76uhb4VeeSIhXOQFmb94ee+/YKHo7GZq59xwF6tB1PoHnCRRCwiONgrBVw
        //2pq31nxOqs3RI73j/MVTEPsZky8ZhHraqvUrAZ0We/65nAqfOWd2K7oqPQ2ABL
        735rURjEnvDL2/MoRg2RkSKx7Jyy2C1uKDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xktQui40lFGn for <linux-ide@vger.kernel.org>;
        Thu, 31 Mar 2022 16:04:09 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KTzQ03Q8zz1Rvlx;
        Thu, 31 Mar 2022 16:04:08 -0700 (PDT)
Message-ID: <22f69d9a-7d0d-a408-70b3-11295f14b82d@opensource.wdc.com>
Date:   Fri, 1 Apr 2022 08:04:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Mario Limonciello <Mario.Limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
References: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
 <20220321212431.13717-3-pmenzel@molgen.mpg.de>
 <BL1PR12MB5157DDFD5E75360F032346D3E2169@BL1PR12MB5157.namprd12.prod.outlook.com>
 <cc7b4426-f6a6-e6b1-4aaf-0a713ee3d388@opensource.wdc.com>
 <5fb6af7b-d84f-cbae-7eb1-543f3a7e53e4@molgen.mpg.de>
 <d9837420-1cbb-ed5e-7043-985d9eb9d065@opensource.wdc.com>
 <b3e4435d-335c-1aba-1920-c225b46d09e7@molgen.mpg.de>
 <f6c78650-f22f-fcaf-a660-b1fc4ea7f641@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f6c78650-f22f-fcaf-a660-b1fc4ea7f641@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/31/22 23:42, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> Am 23.03.22 um 09:36 schrieb Paul Menzel:
>=20
>> Am 23.03.22 um 09:24 schrieb Damien Le Moal:
>>> On 3/23/22 15:55, Paul Menzel wrote:
>>
>>>> Am 23.03.22 um 06:01 schrieb Damien Le Moal:
>>>>> On 3/22/22 06:51, Limonciello, Mario wrote:
>>
>>>>>>> -----Original Message-----
>>>>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>>>>> Sent: Monday, March 21, 2022 16:25
>>>>
>>>> [=E2=80=A6]
>>>>
>>>>>> I seem to recall that we were talking about trying to drop the=20
>>>>>> debounce delay for everything, weren't we?
>>>>>>
>>>>>> So perhaps it would be right to add a 4th patch in the series to d=
o
>>>>>> just that.  Then If this turns out to be problematic for
>>>>>> anything other than the controllers in the series that you
>>>>>> identified as not problematic then that 4th patch can
>>>>>> potentially be reverted alone?
>>>>>
>>>>> Not quite everything :) But you are right, let's try to switch the=20
>>>>> default to no delay. I will be posting patches today for that.
>>>>> With these patches, your patches are not necessary anymore as the A=
MD
>>>>> chipset falls under the default no-delay.
>>>>
>>>> I am all for improving the situation for all devices, but I am unabl=
e to
>>>> judge the regression potential of changing this, as it affects a lot=
 of
>>>> devices. I guess it=E2=80=99d would go through the next tree, and ho=
pefully the
>>>> company QA teams can give it a good spin. I hoped that my patches, a=
s I
>>>> have tested them, and AMD will hopefully too, could go into the curr=
ent
>>>> merge window.
>>>
>>> Yes, correct, the plan is to get the generic series queued as soon
>>> as rc1 so that it can spend plenty of time in linux-next for people
>>> to test. That will hopefully reduce the risk of breaking things in
>>> the field. Same for  the default LPM change.
>>
>> But 5.18 or 5.19? If 5.18, sounds good to me, if 5.19, I=E2=80=99d be =
great if=20
>> my patches go into 5.18 cycle, as they have been tested, and it would=20
>> mean the whole change gets tested more widely already.
>>
>>> With the default removal of the debounce delay, your patches addressi=
ng
>>> only the AMD adapter are not needed anymore: this adapter will not ha=
ve a
>>> debounce delay unless the ATA_LFLAG_DEBOUNCE_DELAY flag is set.
>>
>> Yes, I understand.
>=20
> The merge window for Linux 5.18 is going to close in three days this=20
> Sunday. It=E2=80=99d be really great if my patches, tested on hardware,=
 could go=20
> into that.
>=20
>>>>> It would be nice if you can test though.
>>>>
>>>> Of course, I am going to that either way.
>>>
>>> Series posted with you on CC. Please test !
>>
>> Thank you. I am going to test it in the coming days, and report back.
>>
>> Maybe more people should be put in Cc (Dell, Lenovo, IBM, x86 subsyste=
m)=20
>> with a request to test this?
> Thank you for the patches, which are a big improvement. Let=E2=80=99s h=
ope, you=20
> can re-roll them, so they get into Linux very soon for everyone=E2=80=99=
s benefit.

I am waiting for 5.18-rc1 to rebase the patches and re-post them. Given
reviewed-by and tested-by tags, I will queue them for 5.19. With that in
mind, I am not planning to apply your previous patches for 5.18, as they
would conflict and would only end up being churn since the delay removal
by default will undo your changes.


--=20
Damien Le Moal
Western Digital Research
