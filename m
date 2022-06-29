Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD47C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jun 2022 01:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiF2BPA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jun 2022 21:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF2BO7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jun 2022 21:14:59 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF23921E1B
        for <linux-ide@vger.kernel.org>; Tue, 28 Jun 2022 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656465295; x=1688001295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AYc1C7eAxiSsjnqUN0DfBfGp3xXz3pkgOLsc25aNAnI=;
  b=W3PA6N2s6WIN14it2c0CAgXPHslFgt5kcXlTAXkIxOKdKC+xdDA0kO9p
   Y3rqV95lx3yrM9Zow347iwIu2RSJMlgA5YHRLVBfEzbPV6Sg3wX7tjK8d
   iiXwJVWcvfRYXSaTljFWOzrs7l04RzQkymW8Q43BrDocEU21ZrPALB6+/
   bDoihJnm6C18WirNRzZhm6hmvYCJUoRHq9yam0JYOw41/gqEmL+DrQZd/
   Krg6oNqDHxdmYZP1SAakvcBblWeHFz22TaC6dWmFTRamXLuAlhV9YMgTE
   i2IZEnNRUmysP+mgcOf3AjxWsn/7QihQYX+6XMrEJzV+bKfArBtAPD+K6
   w==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="209212491"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 09:14:54 +0800
IronPort-SDR: egmvbxTwcZj4K9pPOYHysgPWGeukbtPLKS2WmxjGrs+T6QDZlwaefLnftSKvTzrW3b8+eS0fnZ
 /+vUcd41WYcmXSemH5WGX2ZnPj4ePGA2JzeGRrJ6aBAkaruBdjx7GXjNz7vAb3MPgdZagJaXRB
 Lv14L2RCwtx+XcDK0QEd/531chXMkSrYOhnyMMrsWPS98PHwr2afaqyAYOd5WVjPcDhCjeD3RC
 GCAwL6ZkKZ0DlF3rM/lBDEWBMUhz0zVYTt/XoKpIGma2Q2ONZBd/EX0j+ijI1kK4RQnAr10y1N
 yfr6Jb1+DTWwnBfGDwFpz0Ax
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 17:37:16 -0700
IronPort-SDR: uW9PBNWg9GPZ1g5fGELrQQO+y0bXgwBf+Cns6W28jLzJb8ldJUCUooJrT05GIAz3WSPddNucB/
 B50QJhGPxT7HsBRAOLKHdgT647ptkDeo6HZ6ijmsMJ86phFWJy9C08KgOfyTn1rJfN295rP8vN
 SuDMxXdTCfbTTGrLkHx47DDsnUJyvSzEZ0KLWopMSvkB8Yys1AoXhcqH1G+V85p5DxXypHcXvR
 A4WL25YCp5IVmWTHkYnE+VV/1nej6se617dViZep/TH6TBCztXj2j3NcoVyCBqhRBCYMJi5bwc
 rRA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 18:14:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXk5q5fKwz1Rw4L
        for <linux-ide@vger.kernel.org>; Tue, 28 Jun 2022 18:14:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656465295; x=1659057296; bh=AYc1C7eAxiSsjnqUN0DfBfGp3xXz3pkgOLs
        c25aNAnI=; b=L+6U2OIAVD0dFDb0iy7lxvcqo3tUox6FvfgHf7QQNcBCRFrDd0n
        wohPyiEeCAMGb+PZXUd63cDeaipUrfLckDK+ULIIjKxMqxBA/KJv1MbvfXe5T95W
        a9OJohnTf2PIhLgKoqn6+UOzZnpgQz6yVrVqn3wA2z+rGVvxE0KgUgTUKzWfmXRq
        I/yeTq24PFuQfBIfXM2ZRZKJiz/aVwfFvvVNqideW3tR7WcFf1pw73FjYybJQIuz
        fwhnuyG8M9kf9zrg2wS24fVqUWyhsv80qKzUjpKFvr4oNsi+sAKCl6Jxa9U9/vqB
        XUfO998RBhxIiM8ufMhIZVNacfogOyScx4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vHzbp1C02Y78 for <linux-ide@vger.kernel.org>;
        Tue, 28 Jun 2022 18:14:55 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXk5p2XxVz1RtVk;
        Tue, 28 Jun 2022 18:14:54 -0700 (PDT)
Message-ID: <9fd807fd-f019-4ad2-7f4f-6746e05098bf@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 10:14:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: pata_cs5535: Fix W=1 warnings
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Garry <john.garry@huawei.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
 <16f727b8-c3b0-c828-0c5b-6728a6e7934f@opensource.wdc.com>
 <9044b81f-76db-75de-db74-f45d6e5ea71e@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <9044b81f-76db-75de-db74-f45d6e5ea71e@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/28/22 19:05, Sergey Shtylyov wrote:
> Hello!
>=20
> On 6/28/22 11:59 AM, Damien Le Moal wrote:
> [...]
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
>=20
>=20
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>=20
>> Looks good, but I wonder why I am not getting this warning. I always d=
o
>> W=3D1 and C=3D1 builds. I tried allmodconfig now and I am not getting =
the
>> warning...
>=20
>    I can confirm the (fatal) warnings with RedHat gcc 10.3.1... but som=
ehow they only
> occur on x86_64 with allmodconfig indeed (which is strange)...

Compiling on x86_64 with allmodconfig with gcc 12 and sparse-0.6.4-2
(Fedora 36) does not give the warning... Weird.

>=20
> [...]
>=20
> MBR, Sergey
>=20


--=20
Damien Le Moal
Western Digital Research
