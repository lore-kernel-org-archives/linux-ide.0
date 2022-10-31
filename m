Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22485FA3740
	for <linux-ide@archiver.kernel.org>; Mon, 31 Oct 2022 09:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiJaJXj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Oct 2022 05:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJaJXW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2022 05:23:22 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12C7E023
        for <linux-ide@vger.kernel.org>; Mon, 31 Oct 2022 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667208139; x=1698744139;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kOgbJd88hthh0gLhNybO7yxfoUalJ+82cDsKro863GE=;
  b=Nu5onSPw6uQvzWwSmSAwRj+2/QR5GTSFD+ZnKYwAH9n8WkylHwM70OMn
   YBrWo7ItAU6Qvd1p9LV9BWqMM1ARQMl6hBWuPCK1f82m2d4o/xIhp1zDz
   /tucj/KaPG3W755WB/5M9nTtFa7GBF/IHfPC8xQ04OsR/UiaJQBgFlLLC
   rlul9UFmz1YmObC8g0Quav4cuxn1ncOJtQTUoYpvxSZEjuBjbhH2x+2QS
   OV6KVc2zZjHjjsDDvLSjadY8N+kTcgyMo4a9v0LKZkf1B6gznJNLm7K95
   mOioyJmeT9jt/abvOVcYlL0FoAP+ghBwIuN/7A2ilX/5VdYR4g4XDDCBa
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="215121651"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 17:22:11 +0800
IronPort-SDR: 6OR2446DLc4LcFkDY3wkwPV6bOYWaZVg+RLdqF50uEMpVHYQqOxWm+2kJTmOUmtyZnzMC2f+Se
 7Le3ZSR0XglNpiY5pPKDaoYH8fQPJ0IPKr6P7dgHr9rXE8G0/DukmkDWot9n/m30PZ3tY0UC2r
 u/b8k+8cVDwpelCFX6QXRgATYRxeZeL8q5HXuNj9r4rz7RHci1bocO5hlrMbuDd7xr4j9Omunb
 JRSnc7fmKc0GXe63Z0gl6lqvm9usqF4djXme+mhWX6Nejj7tDyJgXMu7qgEYmHMv3LXgHkkh0d
 rhyStmJTheQq2V91LJDJK/fc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2022 01:35:44 -0700
IronPort-SDR: 0jRaRMSpTNXhgFUKD8biedS5aCAxtBX7fCUFNlD3/DY1f7F1zBsuOMO9tVtX6goKbl0uX686xs
 doDK2q5tH/eTssb9ik4ewQjOhbkB19cOcy9l3Vy4Lix5czv8rVn2UyRbZbSRtS4zBg88FP0WUb
 aIHUkqZY3X8YByVU4+6Litf3cz0Mn1GeGn6yioS4JFvo+oTTnvInNDNHaAa/k2O8DECAn/w4k2
 mciJeg8Lb36cBIzbAWlFLhJWPUiplyhCDFVdLvYnmWlrjpd/8tVmD7i5s0WFPNDpc0U8pvtV1e
 VDU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2022 02:22:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N172p2qW9z1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 31 Oct 2022 02:22:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667208129; x=1669800130; bh=kOgbJd88hthh0gLhNybO7yxfoUalJ+82cDs
        Kro863GE=; b=luOspKr08uvklhCZ6jEUmePfKR5SlcCjZof1k8hWCZh6iD3J420
        hoolvFS03UWa/D1alsBYg3jwqol3X5O5+7nVl8qc3U45OFxHebYvToYEPT61Um/K
        +mWoZCK+A1BVDp163hoHvIkb/JKPELkNsfVBoZhqge0hLeTWnYWDMLcDDOigRlvU
        z7SFe9RNAMroP4m8mzsSVaN7BJPm0g4O/SYLvipFUPaqcl1tHw6gDW719SMv4wbB
        cg3D5wGmPOy3+uibO6jWCIY+kEB/qxEqEPq8bjx8nWG5U/udqL0e8/0F52IZof6y
        XJM0GxQi126+odzaMNaOFkMARLUOSExA3IQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XeZUMcWsTWjU for <linux-ide@vger.kernel.org>;
        Mon, 31 Oct 2022 02:22:09 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N172n0mbkz1RvLy;
        Mon, 31 Oct 2022 02:22:08 -0700 (PDT)
Message-ID: <9258a0f5-0800-669c-a11b-e40ebf6e5f1f@opensource.wdc.com>
Date:   Mon, 31 Oct 2022 18:22:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RESEND] ata: palmld: fix return value check in
 palmld_pata_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org, arnd@arndb.de
Cc:     s.shtylyov@omp.ru
References: <20221029074931.3189275-1-yangyingliang@huawei.com>
 <491dfec9-b6c5-5f20-a3f0-2a339e2d528c@opensource.wdc.com>
 <e76bdc54-f078-b8db-6258-3bfe4ac59329@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e76bdc54-f078-b8db-6258-3bfe4ac59329@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/31/22 17:13, Yang Yingliang wrote:
> Hi,
>=20
> On 2022/10/31 13:46, Damien Le Moal wrote:
>> On 10/29/22 16:49, Yang Yingliang wrote:
>>> If devm_platform_ioremap_resource() fails, it never return
>>> NULL pointer, replace the check with IS_ERR().
>>>
>>> Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> ---
>>> The previous patch link:
>>> https://lore.kernel.org/lkml/15e09c18-792b-931c-11c7-5ef284490eba@hua=
wei.com/T/#t
>>> ---
>>> =C2=A0 drivers/ata/pata_palmld.c | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
>>> index 400e65190904..51caa2a427dd 100644
>>> --- a/drivers/ata/pata_palmld.c
>>> +++ b/drivers/ata/pata_palmld.c
>>> @@ -63,8 +63,8 @@ static int palmld_pata_probe(struct platform_device
>>> *pdev)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* remap drive's physical memor=
y address */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem =3D devm_platform_ioremap_resource=
(pdev, 0);
>>> -=C2=A0=C2=A0=C2=A0 if (!mem)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(mem))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(mem);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* request and activate power a=
nd reset GPIOs */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lda->power =3D devm_gpiod_get(dev, "po=
wer", GPIOD_OUT_HIGH);
>> Arnd has a series of patches that removes this driver from the kernel =
in
>> 6.2. Do you need this fix for a stable release ?
> It's nice that you can merge this patch. If you don't take this, it's
> not a big problem.

Sorry, I got confused. This is a bug fix, so I will apply it to
for-6.1-fixes. I was thinking about 6.2, but the driver will then be gone=
.

>=20
> Thanks,
> Yang
>>

--=20
Damien Le Moal
Western Digital Research

