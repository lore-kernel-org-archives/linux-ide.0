Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DBACCA47C
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jun 2022 08:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiF2IYU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jun 2022 04:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiF2IYT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jun 2022 04:24:19 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6BE3B54D
        for <linux-ide@vger.kernel.org>; Wed, 29 Jun 2022 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656491057; x=1688027057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BwEp8PRIJqnl2WjKJf+Cr+1eOomjYmUFTCh+97ZoMC4=;
  b=XfZXotHnC/l+GlccDt/J/56GhdZTBMCh4iiOGimUxYAt9Wwwe8/hxVhn
   7ec5NvcgIKYYB1Hife+kcg3H+mkWSEJjM62lRSKnD7gMbRhhV52ssLfLy
   VI8lLuVDMKCYfJzRaJvKHXkaUHQhEYHToN6U78k2D5uoZYKFOFgdMuaNW
   agrFTThEjDyK5tK/PvavDEGa4pU7ernROjrrnGN+5u+a5x3nX/j31tcxD
   42Hqq7bgg9w09O0ePU2Wrd/Q4bMrfB7yU+Ux6Q6FuV/d+0YsrU6Cuxou0
   4aFymIlGnWPXGZ77fwI6xzUAJR9JeWmPnT421O31L3FiOWRkacED77w/P
   g==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="204367599"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 16:24:16 +0800
IronPort-SDR: 71dkMfok0aKsHsq64qULaIPrIf6F6Svf6vmwVVjSv7d1xndYMgjeuzRzY32ToOFiOzdvdhJ4Os
 zJBp0jpIYMI0MoFlOmHdw5N08l9dG1PV7Ifso2bmpT7oy/toHu3B2PMhz3mQzailc32n2zep12
 4avaDqk3NiSSWgvmkd48fgaKuMWXWHGQei99hB+Y4mtgDRriGyp2tcqD7NPG/tZvKLWKSq2bnV
 DJ0jQX8CfhbCwarILX/GM/RLpyFgrtPZHSFg43/ot9iUsebW/VUK7RX0qhK3peA2gfvV42bMAm
 ily4m11zgvaO742g96oiPYTn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 00:41:56 -0700
IronPort-SDR: FgEsVRX4H1Cf4Y/C4zWTmoMUTI8XIPRFbox79RRybraEu8Q/Tze/YsfR/M016f5jJ2I2/vzpAP
 C5Vun/RmAqMJbAss9vG3+Z4QBv9j9tuvA7AXITqtHuTbET2Rp2w5hq+0T+xW1embZdXAhLo3QB
 xurP7vRZ+13Ge/hAbfn7wDADkOUB8yuA7eZDu/2mfuKoi1JDUZGKC03zhYOj/TOSC57IM8Mcqd
 eUT+ff3awRF4DaMG1c/LKqJqqxZ+OxL6A7uDyZj8++R8WpyWX2Om9/vnGUvhVbf7FFFFcWtMNe
 MZg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 01:24:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXvdF28Dzz1Rwnm
        for <linux-ide@vger.kernel.org>; Wed, 29 Jun 2022 01:24:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656491056; x=1659083057; bh=BwEp8PRIJqnl2WjKJf+Cr+1eOomjYmUFTCh
        +97ZoMC4=; b=bOIyQFK461nAcMlO4rrkHTP4tRECkwwsTbgU0EMKxG6HHxDxw+w
        g5p8dw0/nRrSztvXOwy9w3+/Tc+nHFerRtqr54b+GA8LxMkMdwxMpmNgqvh5lx34
        ZE9gnFX1ojOLnQOAEu/jd5GR/IEbGUKwyNwtsjsJ65quLwGhEKk8S1VAHt7oT2ya
        tFCOb6+Pl3nzS7hzNP9IhdyVllTafxx6hZ+EyPhvdd9jUi6sGUe/MMjZVvICAvn2
        Ng2PZI24qHAIleoK/dLE024SUJr4+vOelBcNukL/bq+p6HZ+myG3a1ds62eS1LxH
        geCpTh60cS2F7E0E2S9SNcE9ySNI+kwXQ1A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a48r1Ik3B5yK for <linux-ide@vger.kernel.org>;
        Wed, 29 Jun 2022 01:24:16 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXvdD1dhHz1RtVk;
        Wed, 29 Jun 2022 01:24:16 -0700 (PDT)
Message-ID: <eb3bc00d-f0c7-57eb-cd7b-cf4243999c31@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 17:24:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: pata_cs5535: Fix W=1 warnings
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
 <16f727b8-c3b0-c828-0c5b-6728a6e7934f@opensource.wdc.com>
 <9044b81f-76db-75de-db74-f45d6e5ea71e@omp.ru>
 <d26b8345-02e9-e461-c506-b429c44f74df@omp.ru>
 <7a78b7d0-fe02-4efe-cfbb-5a4a1b5b2f91@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7a78b7d0-fe02-4efe-cfbb-5a4a1b5b2f91@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/29/22 16:41, John Garry wrote:
> On 28/06/2022 19:39, Sergey Shtylyov wrote:
>> On 6/28/22 1:05 PM, Sergey Shtylyov wrote:
>> [...]
>>>>> x86_64 allmodconfig build with W=3D1 gives these warnings:
>>>>>
>>>>> drivers/ata/pata_cs5535.c: In function =E2=80=98cs5535_set_piomode=E2=
=80=99:
>>>>> drivers/ata/pata_cs5535.c:93:11: error: variable =E2=80=98dummy=E2=80=
=99 set but not used [-Werror=3Dunused-but-set-variable]
>>>>>    u32 reg, dummy;
>>>>>             ^~~~~
>>>>> drivers/ata/pata_cs5535.c: In function =E2=80=98cs5535_set_dmamode=E2=
=80=99:
>>>>> drivers/ata/pata_cs5535.c:132:11: error: variable =E2=80=98dummy=E2=
=80=99 set but not used [-Werror=3Dunused-but-set-variable]
>>>>>    u32 reg, dummy;
>>>>>             ^~~~~
>>>>> cc1: all warnings being treated as errors
>>>>>
>>>>> Mark variables 'dummy' as "maybe unused" to satisfy when rdmsr() is
>>>>> stubbed, which is the same as what we already do in pata_cs5536.c .
>>
>>     Wait, what do you mean by "stubbed", the version in <asm/paravirt.=
h>?
>=20
> Ah, this mentioning of stubbed is wrong on my part. I was distracted by=
=20
> the stub in pata_cs5536.c - that's what my text editor showed me for th=
e=20
> defintion of rdmsr()
>=20
> Hi Damien,
>=20
> I see that you applied this patch. If it has not been pushed can we han=
d=20
> edit the commit message or I can send a v2? Or maybe we can live with i=
t...

Send me an updated commit message and I will amend.

>=20
> Thanks,
> John
>=20
>>
>>>>>
>>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> [...]
>>
>> MBR, Sergey
>> .
>=20


--=20
Damien Le Moal
Western Digital Research
