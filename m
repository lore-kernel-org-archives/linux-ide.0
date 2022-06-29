Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53751C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jun 2022 23:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiF2XEF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiF2XEE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jun 2022 19:04:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5126F1
        for <linux-ide@vger.kernel.org>; Wed, 29 Jun 2022 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656543843; x=1688079843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ptrmLR99DmPF+HuZkx+sytXL0IpohrYTge6kXuvw7is=;
  b=WWLjb5x6pOIiuR+1bu5aPwSQkJFPQt/mCqD3KyO7r7mCkDdplcqEIEr+
   URbCBoSeDMMUeidHYfVe69yF72/8zMFcxNsFLNAIqszCPvFDNkLUR5cj0
   FGIirMb+0iPRmn7+CI1SZK+xB0zFTfeuqCKu/Yk2YGY+t8Qf1B2XHntQw
   Qgqrr1E5Tps9cfBIkcqGxn+LOBZ87Rf8As2s5ZnoRWihitHXi+A2Iap51
   isBQGd+swqC8zvnVn45NOnDRCYhCQSY0UTZ6zVqW2nmSLJMbRen6fV3IO
   oeh0gJw7kA0lXx4PM9S+3IKdr5SyQCemjaG3nVa1gkXbDtAAWmpKoyboN
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,232,1650902400"; 
   d="scan'208";a="308757730"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2022 07:04:00 +0800
IronPort-SDR: k8vJ8Cg8a6uiZANDe6Kzaknes5adjVvUJeTMZPRvHRc0/RqBp3g8SHbPx9rMmAKr9u9TsZsjke
 S4eCYPYT+AH1NLNzBJBEyhb9d4ofyepnCTXEt5x+MVOaAhS5q9neV324ScSVBxOqs/2i/HaHja
 m6YLG6kH8YegPmYKkTitwE3bu46FMikL+plQhye48Wa83JlEKZ5UQl6liQsE9HyTmvOecnJWxr
 1Je7uWeZE9WSg7s5bp1O2QP8yz1SYGY+Q3jWCq9oIezthkFF0aC6F4tdHuOh+2jUY5HZIsZOZi
 kkDl9/FCrNCHpBxOf13noWmz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 15:21:39 -0700
IronPort-SDR: 1lPhVLY30gaU7W9vMjBiLIThEycR/YHYcrd+rNcml0K+wDXDhLclRdRRCsEmFn3Jun+yQFbak1
 rRlZ/7+yF6Q9vk/DZ/ioGZEE8T/3zrDo/pYiyb4k5X52dP+x1DUkzQg3YbVPRwSt/g8P1Hf84/
 c1SD8QCqPFKDR/7qjO0hgb+FlMZjWA2RxzT5iC/bhRI/aJ/of/lAWffo7CaCVbW6bsnr8rMJWC
 pY6v5Jb7GkUYu+TSylOuFAUp/jmuludfSF+Yh+1nAScC40llopHPO3KKCELP6B8H1iqOh2tA79
 EiI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 16:04:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYH8J1jgYz1Rw4L
        for <linux-ide@vger.kernel.org>; Wed, 29 Jun 2022 16:04:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656543839; x=1659135840; bh=ptrmLR99DmPF+HuZkx+sytXL0IpohrYTge6
        kXuvw7is=; b=O0UEptYFIHQ2xrlcdooiCDQC+bLGyPQ8V0TOJAZfEsIF5Idr1KC
        hePTwDcjoYED3X0mAKifiixDGVaaY39gL3YGagavf1b7NcJvReo6g0BqBUbIHxs8
        vE1HEA0I04aw0+ndOqCXtlzv19ab3mtbSAS9CziyAJAmBQ0vZYBrTDsXTg0DI+Z4
        6OXmSh+Fmyj/ydn2/oaHFzU9XqnBIoLj11uGwnOEhv9Vxn73CM+lvCP+OnfWr1UE
        QA1zMeZ8pBTXhIFSyYkip+aVq8n/RrVrjxpkMo11E5kB/7umgmwqKEkFYzsgstHs
        mf1wz0gyRw4ln5GxbS2lhXOGIvHHUgtxLKQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q5x1VaqC3dOx for <linux-ide@vger.kernel.org>;
        Wed, 29 Jun 2022 16:03:59 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYH8H0Jy2z1RtVk;
        Wed, 29 Jun 2022 16:03:58 -0700 (PDT)
Message-ID: <9448ff77-9b0e-95fd-1366-a5103fdb3ea0@opensource.wdc.com>
Date:   Thu, 30 Jun 2022 08:03:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: pata_cs5535: Fix W=1 warnings
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Garry <john.garry@huawei.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
 <69ed5587-52fd-4171-b97f-091df8b377c6@opensource.wdc.com>
 <9caef01c-b601-c19f-10eb-720e8d7b35dc@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <9caef01c-b601-c19f-10eb-720e8d7b35dc@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/29/22 22:32, Sergey Shtylyov wrote:
> On 6/29/22 4:51 AM, Damien Le Moal wrote:
>=20
>>> x86_64 allmodconfig build with W=3D1 gives these warnings:
>>>
>>> drivers/ata/pata_cs5535.c: In function =E2=80=98cs5535_set_piomode=E2=
=80=99:
>>> drivers/ata/pata_cs5535.c:93:11: error: variable =E2=80=98dummy=E2=80=
=99 set but not used [-Werror=3Dunused-but-set-variable]
>>>   u32 reg, dummy;
>>>            ^~~~~
>>> drivers/ata/pata_cs5535.c: In function =E2=80=98cs5535_set_dmamode=E2=
=80=99:
>>> drivers/ata/pata_cs5535.c:132:11: error: variable =E2=80=98dummy=E2=80=
=99 set but not used [-Werror=3Dunused-but-set-variable]
>>>   u32 reg, dummy;
>>>            ^~~~~
>>> cc1: all warnings being treated as errors
>>>
>>> Mark variables 'dummy' as "maybe unused" to satisfy when rdmsr() is
>>> stubbed, which is the same as what we already do in pata_cs5536.c .
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> Applied to for-5.20. Thanks !
>=20
>    Why not to 5.19? The warnings are fatal as can be seen from the comm=
it log...

This is only a compile warning and nobody complained, not even the 0-day
bot/linux-next builds, and for years... Most definitely not an urgent fix=
.

But yeah, sure, can do 5.19 fixes too.

>=20
> MBR, Sergey
>=20


--=20
Damien Le Moal
Western Digital Research
