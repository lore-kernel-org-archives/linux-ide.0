Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E748DECAAD8
	for <linux-ide@archiver.kernel.org>; Wed, 14 Sep 2022 08:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiINI0s (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 14 Sep 2022 04:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiINI0r (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 14 Sep 2022 04:26:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2656525E
        for <linux-ide@vger.kernel.org>; Wed, 14 Sep 2022 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663144005; x=1694680005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RJasnKN4AtekG0e84CcrCtN7mNyviZ5IxOBZ9H57Yko=;
  b=oyru3bj6SoA2WV29dvqyo1qa41i7PJbzBY8uMYIYeHLze8fhR6E5o5Do
   JYd+YFbQimAojg9RfRItuNDZbLdSflaOQy6sC7FgxeTpFIXQuezNGRV3Y
   95cdtCIXiEARXD8AiBK46njIccg1aQ1DD4kmEt+0ySYQXQibVX70CKexM
   h8b9D2QwD9RonGtSWKzQRxS4er0J7nVPRijnhHOFloZDEUoGtkYzLodeL
   A7vh44izucpM5+6qenjFQ04wf7Abd0EKsoQAPZeFFjPARc9OOTs7ZL2F7
   1AduWT8RXZixWnX9mXh5doYIE8HfiaejAvVGwlCxFjnh0ykLI791sfv/0
   g==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654531200"; 
   d="scan'208";a="211308799"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2022 16:26:45 +0800
IronPort-SDR: PEvsAmKRViExPHAoc4PWDLic1O1xBq7z92co1pItgVCWUCqaFrd7ZMavG0CAY5dQ50kbmJkEC+
 nJIv74VeJPUH2Lu/W/HTGneoA/Pj5VbOZq3w4xvyxJNF0aWog/1OqY++ijT4JMdebynOLIvyvH
 Vo6dgNRx3i3EleyXfu4b3rWKAnld+kTUKdQGtf/9uXVorw0RIljTxpeqhrzRs2JWy04oKFe+TH
 Hzwq9q+KHMg20TnYE+00gkgbsoLDURzT0M3zHdY295JR6HnCEXYr+axF6bEAeLaJ9Kip/Py69y
 5P9UQ53g04HiVOdWg7PJbhLt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2022 00:41:31 -0700
IronPort-SDR: IBOAuXglwIrGZfJPE9/Dbcekt9c/TPiDekn8kvkCK5YD6yywwnP0D2j5tpl9XwDna4nRgbkJ0m
 EgGPyiSw6HOdNcSp2vRLg7utU6hmmmoBe8K3YkzADtc4EzLRMGnEk2IbWSDbb8gc4ofxLe78E8
 AbWxnHrZdfL8nkTT9HDuMryudCZoDTvXE8/gZ31PcHE1/xBsb6Xz1pDlZ3ZfAHUTWjC/w1tDHT
 O3tW0pbRpXz/i+lIkaY7i3jqbvEMcUG50zhXMYABmmKiqbD/DQHMuSOXhvUB/oXdGySo1jrpYp
 wEM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2022 01:26:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MSD2X5dRwz1RvTp
        for <linux-ide@vger.kernel.org>; Wed, 14 Sep 2022 01:26:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663144004; x=1665736005; bh=RJasnKN4AtekG0e84CcrCtN7mNyviZ5IxOB
        Z9H57Yko=; b=MpdAg3XTmwqZojJ77pIHJ79RsChaErgzrD62Ndby1qVqZvCqfeW
        kF5GduMTaB7sx2+8OFwsH2NY/bkJg0T1tCGsNZsyQKWgq8QP84pAhbk9F508rXr4
        keCJOgy/q3V7sK8B2pLtjgtbqgzl/qv9w92xtAueBYhCCKOj6M4x7KdaEmZsH/6o
        2hsraGocKXym4xMmkPR9hsfg/xuHtEdMrfP/SSVeQC3+rMc/6Oz7iI+HEuk3k8iz
        NScMpOuy4gSZfC0JdLmzuSEmM8hFohULnZ5VAWXCe12qCExpkblNQi8WQJhIate9
        sHV2PPH5G22q5S2iJQihZhP1Se7RFnlacJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OWtPCHPGS4yk for <linux-ide@vger.kernel.org>;
        Wed, 14 Sep 2022 01:26:44 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MSD2W0tTYz1RvLy;
        Wed, 14 Sep 2022 01:26:42 -0700 (PDT)
Message-ID: <fa09ed5b-9c56-267e-6d13-0e020b8887e4@opensource.wdc.com>
Date:   Wed, 14 Sep 2022 09:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <MN0PR12MB6101E77F03E5A21AEC8A5D6DE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/09/13 16:28, Limonciello, Mario wrote:
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

Yes, patches from Runa touch the same area. We need to put everything tog=
ether i
a nice series. Will try to do so, but busy this week and next (Plumbers a=
nd
vacation). If you can Mario, that would be welcome too :)



--=20
Damien Le Moal
Western Digital Research

