Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF5AC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 23:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346601AbiCXAA0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 20:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiCXAAZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 20:00:25 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415A9522DB
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648079934; x=1679615934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M9WSsT8Ng6JmfiG1zix0/+/p61NPO50AMxJoR9pWq5A=;
  b=LFUswVDEZckzRjJfAKc3zIEH1sqBB//p3ZhZIMFGiIplpJslukDM8FeI
   qmYLsTM9m/uuqyL4ADSCw13zuCh4P5MexQ8wTE11wpfCYPLEYxWaby3c+
   vYNyy8RQy7SyagpPcoomoC8y0Th4NoDeI0MVFnhPBNiDi2FKskqNwhXbi
   VnzezI0U0LL8s6saX+z5KsaKnkBUVrps762jikEPqM0OS6yEEXEm88Udi
   J9TpbU35xS6b8zUFX7bQ3nsU4GZRHnjS+wMuhe8pgB+NZPeu0MtWS9OhE
   pbZ0qnUWQNhaQYFJ9hXRxQQm1xDvE8IqEYmo2PJV4IQUc7udZN5r7W69p
   w==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="300260347"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 07:58:53 +0800
IronPort-SDR: P8NGoZ0d9dAYe3yjsZdXfmFfguHriFUyVZArFw+y9Qgzns4j/X7r0PV04bzqq0XjepIFq7E66Q
 QwgwU/Mx4gnUf6Ggyst8mT8X2xCObDYNv7eTPs1rguhxqokcyr9Va3G6ju3nF3PwquDT1QAAqx
 +h0JOwkFhuoTvpMqT6bF2jao//0xyzEv3bnMs08gq//BpkkUtjFA0DG0B3laPb3O1Y+Lie4ScN
 oyYLnGhKUtKoPBhltMUa+ewUkKLr0WrrNHALdH/6xFymgKsNsW9g/Jf179DuRzFUjfcHiW5uL7
 4pHGhIjvaaD5H1LaLTxCzBfb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:30:45 -0700
IronPort-SDR: JukAW1+iCknuspg7rXfY0Dj759om632F8dpwMJvhCh8vx6GElEw9bQJsA7w9bccHKQ91mBAjjg
 dxqiJvB5NIxlnLb0eYN2/XX2+bG4ecU6V1yZ3zJM7gU+E3dj7+L+SSd9sO8IOfMvzB4UoQbeE+
 v4UMb6Goej4BpM1A4EdGBBWTtm7HDhdcWDYW7PN35tAtROOpa2p6UVUNy9+Kt/pUAgzQKUdfD/
 JH4Org5UJ7Xi84m6m3HWTnJxoL20cvCy6pPT2/R+fSnczva2103WY9cVD5QlkafoB2/BlbImMx
 OPY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:58:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP50s08lxz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:58:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648079932; x=1650671933; bh=M9WSsT8Ng6JmfiG1zix0/+/p61NPO50AMxJ
        oR9pWq5A=; b=NRWYojTybHIbFPr0Z0YaxqbtiPKAmkvb0uKR/FuQhlIE/9l60kS
        LreNLE32Irnk7l5XBCkis00Xau5D8suADZeNQZXBk1gd2m3OpzYtoJUbtQgJow+g
        RFu9jbJYBI6NAhcBNpPLI6zivbnpp+KWFsT0GMqEhOLDC2bIHBxh+8Rt9nCi07NK
        WuMmqZX9JQo7e+zp+sjkGk0u7F8Hh7fQNmy1dg+WkA+VHDnInPX9ZGFeIwUSdTfH
        7isueau+iOOgTGNrYTo3eazDhgNPUNYtegA0U1pNp7xsim36HBivWj5btznss010
        /DOB8ULfW99XKtyEgKP6C2qbw88S5/misLQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0Q2Ql3W-9qpT for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 16:58:52 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP50q6Nstz1Rvlx;
        Wed, 23 Mar 2022 16:58:51 -0700 (PDT)
Message-ID: <f755d95a-83e5-1d3c-9255-f0111ac4d273@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 08:58:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/4] Remove link debounce delays by default
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <faf15c10-88f4-b530-ce6f-95209e4d5daf@molgen.mpg.de>
 <e272c885-58f8-b046-a951-9069601afba8@opensource.wdc.com>
 <c1aaaaac-aacb-5e71-9dc9-db235e469a3d@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c1aaaaac-aacb-5e71-9dc9-db235e469a3d@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/23/22 19:59, Paul Menzel wrote:
>>> It=E2=80=99d be great if you gave an example benchmark.
>>
>> No need for a benchmark. This is not hot path stuff. This code runs on=
ly
>> during device discovery on boot and on resume after suspend.
>> So apply the patches and reboot, check dmesg if you see errors or not =
and
>> if your disks are all there. Same after a suspend+resume.
>=20
> Yes, I know what I need to check. I meant, that you write without this=20
> patchset my system with HBA controller X and 32 [vendor/model] disks=20
> attached reaches the message Y in Z1 seconds, and with the series Z2=20
> seconds.

There is going to be too much variation from machine to machine as that
depends on the adapter & devices used for testing. The only sensible thin=
g
to do is to compare timing before patching with timing after patching and
see if there are some gains. On my test rig, I have so many drives and
various HBAs connected that the boot time gains overall are nil. But I do
see faster per-ata drive scan times.

>=20
>>>> Comments and lots of testing are welcome !
>>>>
>>>> Damien Le Moal (4):
>>>>     ata: libata-sata: Simplify sata_link_resume() interface
>>>>     ata: libata-sata: Introduce struct sata_deb_timing
>>>>     ata: libata-sata: Remove debounce delay by default
>>>>     ata: libata-sata: Improve sata_link_debounce()
>>>
>>> [=E2=80=A6]
>>>
>>> I am wondering how sure we can be, there won=E2=80=99t be any regress=
ions? Not
>>> having the boot disk detected is quite a serious issue/regression, an=
d
>>> it should be made easy for users to fix that without having to rebuil=
d
>>> the Linux kernel. A Linux kernel CLI parameter to enable the delay wo=
uld
>>> be helpful for effected users.
>>
>> I am working on another series for that. The patches will allow
>> controlling most horkage and link flags on/off using libata.force kern=
el
>> boot parameter. That will allow figuring out problems without patching=
 in
>> the field, for patches to be later added.
>=20
> Sounds good. But this needs to be available before the changes at hand,=
=20
> doesn=E2=80=99t it?

Not really. For now, we need to check if these patches break anything,
regardless of the libata.force changes. I consider libata.force for field
debugging. A user should not have to use it to get a system running. The
kernel should have sensible defaults for that and things should run out o=
f
the box without the need for additional kernel boot parameters.

--=20
Damien Le Moal
Western Digital Research
