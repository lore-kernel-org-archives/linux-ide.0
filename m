Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1368C433EF
	for <linux-ide@archiver.kernel.org>; Fri,  1 Apr 2022 07:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbiDAHZ1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 1 Apr 2022 03:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiDAHZ1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 1 Apr 2022 03:25:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C063FE2F6A
        for <linux-ide@vger.kernel.org>; Fri,  1 Apr 2022 00:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648797815; x=1680333815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TWNYz16IUVsmgokJSw4okyfK4eZR0Q6853862YU4gJw=;
  b=LcZmP35G6EBKjmHaOIDwD5X6DjPyBV6AnT07RnS6eXNNWhNkNUXWaNq8
   b/cHKfm4g0i+q0LhVeCkHL/zB6RAsIT1a/vi5XMdc/9pCEpOm/OHi4T7D
   X7XZQCtjtNwnhhXFjGSCTHcd0Tx+xwx1jNRHkq0E/187JXrhrBQALqN8z
   sX7iXf2Kk4X9HbOVLsBNnILt1P+UGfuJTRxUCkoOslz3Iz79GBcoVc9vh
   1L58JxAd8Z0jJ7NX3B+OYJvs7Z6u8+3xp5cZKlew2AiTKuVrPBDHcrOCZ
   +sgaNoNCpWIgpIibpElHuKUnepk5LdKQHi1eIg8l4XVqgi2OSh9RhzMvc
   w==;
X-IronPort-AV: E=Sophos;i="5.90,226,1643644800"; 
   d="scan'208";a="308778185"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2022 15:23:34 +0800
IronPort-SDR: NSwtTSfD8yiLkQRJJ3Z9XL/daa3rYfYc4cSUaIuJZ0+/aLWdiHrzG5K4FrPZC99u5qYHGddVDC
 8LNMWibU7AQgxSWrn/Iq+hEpIGO7lkZ+4R/9k3AUeLmHBqLY4tpEqJZPAGHPduiBEFYo0UpOJZ
 ZAxH0z/6dVoiGTKsPQzfzGn9qWSgRqep9eh+oFPtiV0p9LUY3RNtaYE+pOuhF3hbTd+cdDkTL5
 6jtT9v+mR72Ub0fuG0Md1uW6eOG/kM5Jc2j7hEy/ka8C1/h4vUfaWhD3OrEdPK6edXQ/8YFEEK
 9JMeH820dcm14no5f9lXZmMY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2022 23:54:22 -0700
IronPort-SDR: 5DUw5oRA+GvGBIlngwmE/hrRd8oGzbDuFWeAS3ca+GPJCJvh+JThtSwWCiRLCxjUh9OlHbKvSO
 dvF/Lf8AdVTDw4F/B916VgVlATxv4uT+BcuKB4uU8bd97KKrSREh66dDmUGdJJ8Vr9SO72rQSQ
 jZeI/I+5Vlj7VaR4jfU2LyrN+xnS9QclDo61TjoGU4t39orTNC7LtLhn24qMmyfyexAAibIFCd
 QT1BRnqxUh9aDayVifqxGKRfyg+q5mKAdLD7ebzCWQsLwrj7iwswdBt9xKn0uTRYXJBPNqdReo
 j7o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2022 00:23:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KVBVG35pbz1Rwrw
        for <linux-ide@vger.kernel.org>; Fri,  1 Apr 2022 00:23:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648797813; x=1651389814; bh=TWNYz16IUVsmgokJSw4okyfK4eZR0Q68538
        62YU4gJw=; b=CKQXYFs0hGiojP4txOUlDP9hkgySgTYZ3frX9h2/bWiplcLUbZR
        +u+sA9OKKQd3hYZkYJ5KDSKuBOVZ+h1Zbx4JlLEVrTzB+847qDB5EWZ1cN5kU1pC
        cSQzoQyuQ3boEHJOA2bJe/HAQNGvAAJHGuAqe4c37viHwpT8EVfaRVxfMo4USJMF
        SMHvQwxSfmRCgCzcv/VfTlhW+MSo3F5YoBWlB7kCTpzF/l8WZQXJCLeKmLXRFMmy
        nwTO1WkYJ/7xlp4Lha2upwSa4z1o5OQhNO/owyO8IUg7tlAfcE9Nqq2wq4AHDw0+
        EGu95eR1dz+yWslgS0KMimhSlM5RS9e/bQQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qbwdO7bD8wZr for <linux-ide@vger.kernel.org>;
        Fri,  1 Apr 2022 00:23:33 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KVBVD5DNSz1Rvlx;
        Fri,  1 Apr 2022 00:23:32 -0700 (PDT)
Message-ID: <85f8c8cb-b4b9-b3ed-e79f-a1a161c9b672@opensource.wdc.com>
Date:   Fri, 1 Apr 2022 16:23:31 +0900
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
 <22f69d9a-7d0d-a408-70b3-11295f14b82d@opensource.wdc.com>
 <67950993-2eb9-c180-7c80-98c9954c9b22@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <67950993-2eb9-c180-7c80-98c9954c9b22@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/1/22 14:18, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> Thank you for your reply.
>=20
>=20
> Am 01.04.22 um 01:04 schrieb Damien Le Moal:
>> On 3/31/22 23:42, Paul Menzel wrote:
>=20
>>> Am 23.03.22 um 09:36 schrieb Paul Menzel:
>>>
>>>> Am 23.03.22 um 09:24 schrieb Damien Le Moal:
>>>>> On 3/23/22 15:55, Paul Menzel wrote:
>>>>
>>>>>> Am 23.03.22 um 06:01 schrieb Damien Le Moal:
>>>>>>> On 3/22/22 06:51, Limonciello, Mario wrote:
>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>>>>>>> Sent: Monday, March 21, 2022 16:25
>>>>>>
>>>>>> [=E2=80=A6]
>>>>>>
>>>>>>>> I seem to recall that we were talking about trying to drop the
>>>>>>>> debounce delay for everything, weren't we?
>>>>>>>>
>>>>>>>> So perhaps it would be right to add a 4th patch in the series to=
 do
>>>>>>>> just that.  Then If this turns out to be problematic for
>>>>>>>> anything other than the controllers in the series that you
>>>>>>>> identified as not problematic then that 4th patch can
>>>>>>>> potentially be reverted alone?
>>>>>>>
>>>>>>> Not quite everything :) But you are right, let's try to switch th=
e
>>>>>>> default to no delay. I will be posting patches today for that.
>>>>>>> With these patches, your patches are not necessary anymore as the=
 AMD
>>>>>>> chipset falls under the default no-delay.
>>>>>>
>>>>>> I am all for improving the situation for all devices, but I am una=
ble to
>>>>>> judge the regression potential of changing this, as it affects a l=
ot of
>>>>>> devices. I guess it=E2=80=99d would go through the next tree, and =
hopefully the
>>>>>> company QA teams can give it a good spin. I hoped that my patches,=
 as I
>>>>>> have tested them, and AMD will hopefully too, could go into the cu=
rrent
>>>>>> merge window.
>>>>>
>>>>> Yes, correct, the plan is to get the generic series queued as soon
>>>>> as rc1 so that it can spend plenty of time in linux-next for people
>>>>> to test. That will hopefully reduce the risk of breaking things in
>>>>> the field. Same for  the default LPM change.
>>>>
>>>> But 5.18 or 5.19? If 5.18, sounds good to me, if 5.19, I=E2=80=99d b=
e great if
>>>> my patches go into 5.18 cycle, as they have been tested, and it woul=
d
>>>> mean the whole change gets tested more widely already.
>>>>
>>>>> With the default removal of the debounce delay, your patches addres=
sing
>>>>> only the AMD adapter are not needed anymore: this adapter will not =
have a
>>>>> debounce delay unless the ATA_LFLAG_DEBOUNCE_DELAY flag is set.
>>>>
>>>> Yes, I understand.
>>>
>>> The merge window for Linux 5.18 is going to close in three days this
>>> Sunday. It=E2=80=99d be really great if my patches, tested on hardwar=
e, could go
>>> into that.
>>>
>>>>>>> It would be nice if you can test though.
>>>>>>
>>>>>> Of course, I am going to that either way.
>>>>>
>>>>> Series posted with you on CC. Please test !
>>>>
>>>> Thank you. I am going to test it in the coming days, and report back=
.
>>>>
>>>> Maybe more people should be put in Cc (Dell, Lenovo, IBM, x86 subsys=
tem)
>>>> with a request to test this?
>>> Thank you for the patches, which are a big improvement. Let=E2=80=99s=
 hope, you
>>> can re-roll them, so they get into Linux very soon for everyone=E2=80=
=99s benefit.
>>
>> I am waiting for 5.18-rc1 to rebase the patches and re-post them. Give=
n
>> reviewed-by and tested-by tags, I will queue them for 5.19.
>=20
> As discussed in the other thread, it=E2=80=99s impossible to be 100 % c=
ertain,=20
> it won=E2=80=99t break anything.

Yes, that is why I want to push the patches early in the cycle to be able
to revert if too many problems are reported.

>=20
>> With that in mind, I am not planning to apply your previous patches
>> for 5.18, as they would conflict and would only end up being churn
>> since the delay removal by default will undo your changes.
> Obviously, I do not agree, as this would give the a little bit more=20
> testing already, if changing the default is a good idea. Also, if the=20
> conflict will be hard to resolve, I happily do it (the patches could=20
> even be reverted on top =E2=80=93 git commits are cheap and easy to han=
dle).

The conflict is not hard to resolve. The point is that my patches changin=
g
the default to no debounce delay completely remove the changes of your
patch to do the same for one or some adapters. So adding your patches now
and then my patches on top does not make much sense at all.

If too many problems show up and I end up reverting/removing the patches,
then I will be happy to take your patches for the adapter you tested. Not=
e
that *all* the machines I have tested so far are OK without a debounce
delay too. So we could add them too... And endup with a long list of
adapters that use the default ahci driver without debounce delay. The goa=
l
of changing the default to no delay is to avoid that. So far, the adapter=
s
I have identified that need the delay have their own declaration, so we
only need to add a flag there. Simpler change that listing up adapters
that are OK without the delay.

>=20
> Anyway, I wrote my piece, but you are the maintainer, so it=E2=80=99s y=
our call=20
> and I stop bothering you.
>=20
>=20
> Kind regards,
>=20
> Paul


--=20
Damien Le Moal
Western Digital Research
