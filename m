Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99F3C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 17 Feb 2022 10:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbiBQK54 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:57:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbiBQK5w (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2022 05:57:52 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AE513EB5
        for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2022 02:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645095458; x=1676631458;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XDBboTfe1WwcDVd7/8UZb3eQxinMvo+yKo2uDEsbDFo=;
  b=aKNorDXZ+puLmyKBVQOpazR+c7W2IRUl6CenDWLNiNXwMBezEtxuONCF
   FsgEb8g3D+7labFpC/L+aM1DFKWxnr6YJ14FKZW4eT2s1doIY7LKCpkrp
   Q4j3+3+n6cfxllzWs3gJwFnA+q2sUzXxXIuo99ET/pxA8JmJv2tHLo8Cu
   lU8WSRiEhYh8yMv3XfEMGGBF2e6EaZEP5M5dBqw6JzDLIy0E7gUrEl+AI
   qmsChcdWk8MUNRzrHbRBqkC0WAl5FM2DcmqahKBB29O32Q9xzqr43Iz2J
   k7V4z9i3Ez7psn+VRUdGgk/RphF7+/gX+f4dJ5QOdn/1a6yaVeqxG60WR
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,375,1635177600"; 
   d="scan'208";a="297293696"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2022 18:57:38 +0800
IronPort-SDR: QSC5i6F7vtZKqyCtV/924b61kvz5YH/1p7lNHOrupHP9aHElSXP8rrmzmlXhApGlLgKoDDyR5H
 G9gonnZno5gtWSRdAc31uZbQdRgW2J4o1c233CacFRy4VRHp3XC0tp3N3sHOha6c2qF77Q1b73
 mp/ljlfZwRvTGgiNw0xuGoqil8aVw+kNGHm+DD3Ny1n8Eio/83zCAT9r27srBRLGi7M0RT15Su
 jxm2B4sHPj38ebM74nCc5BMlNcj7uCuWKleIKc1hFmpC78GFvVrl5VCQYXLPT1SrGAis9OBjxj
 QO6Rrq8rtwKFWCe8tiyN+TKa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 02:29:16 -0800
IronPort-SDR: yNpQTx3/2vkMYWnDlK0CoJwY8Zp2qFXRJc7pDAonGKjbK7jAoM4mL+i0mVkMEpjsi/jm8fJqMT
 78iYKcOmf8PeycPGFWhH7HUnOwhndIOznBIVvst9OKR7WwGs2APdGH4PdqH93JrnrzJngNuLey
 4YuqeK0r8b5IUUR9lwa2LOclU11Ph+/092/TdecsHtZh+5JvPRzkTidZw5WVoMjOUb3bVyIWDW
 p1fLEfkDbfkZeJ94OJc9PwU6Uig7cQNqBoNs02DWRj0yqU6M25mRNIG8xj2P3Qs5hv1Nq9Ndjv
 XZE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 02:57:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JzsH60XlSz1SHwl
        for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2022 02:57:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645095457; x=1647687458; bh=XDBboTfe1WwcDVd7/8UZb3eQxinMvo+yKo2
        uDEsbDFo=; b=Q+taZF1wxuMfc3W1T2hJE5ocnngClypRwdn9wiau0pCMXIM6s4g
        vVTLjGp7D6DUwemzeFkAB8MfuP/FIHrS85VsQP0XKgp5ZxBkIkgAgbNy2vRD/sgp
        8Hfa/N4u2/TTX7y7by/jFBRlIWSt81bMwF7R+jmnQqDCqX6IAyBcDL+dQJnSO89S
        1ut/hLwK3rB+g01bt3O4uKg2QyShqEAPcp/u+jIgqlBUkTfrX5PPt/4GdKbza+Jt
        iu9N7+eBKQlCn9hW1YmG16e0pLxRusd35otoBGn/WvFdRv1PUuCrZMKet+Y3FJHX
        VG6/2IkLV04ZHLl6lecLp8pwzaqnfzsIlHg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QiczbtSpLNa9 for <linux-ide@vger.kernel.org>;
        Thu, 17 Feb 2022 02:57:37 -0800 (PST)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JzsH51yHHz1Rwrw;
        Thu, 17 Feb 2022 02:57:37 -0800 (PST)
Message-ID: <101340fd-4215-481b-747b-424f9116111f@opensource.wdc.com>
Date:   Thu, 17 Feb 2022 19:57:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_hpt37x: merge mode setting methods
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <4e5e9ea0-f7ac-025a-f94f-a4f0ee009420@omp.ru>
 <0303c512-9193-3d4d-3db7-6ecf391948de@opensource.wdc.com>
 <dbee2241-c540-7f52-1314-9054db292580@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <dbee2241-c540-7f52-1314-9054db292580@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/17/22 18:49, Sergey Shtylyov wrote:
> On 2/16/22 2:29 PM, Damien Le Moal wrote:
> 
>>> After commit e0afcf140e6e ("ata: pata_hpt37x: disable fast interrupts in
>>> prereset() method") HPT370's and HPT372+'s PIO/DMA mode setting functions
>>> have become identical -- merge them.
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>
>>> ---
>>> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
>>> repo.
>>>
>>>  drivers/ata/pata_hpt37x.c |   71 +++++++---------------------------------------
>>>  1 file changed, 11 insertions(+), 60 deletions(-)
>>>
>>> Index: libata/drivers/ata/pata_hpt37x.c
>>> ===================================================================
>>> --- libata.orig/drivers/ata/pata_hpt37x.c
>>> +++ libata/drivers/ata/pata_hpt37x.c
> [...]
>>> @@ -604,8 +556,7 @@ static struct ata_port_operations hpt370
>>>  };
>>>  
>>>  /*
>>> - *	Configuration for HPT371 and HPT302. Slightly different PIO and DMA
>>> - *	mode setting functionality.
>>> + *	Configuration for HPT371 and HPT302.
>>
>> Shouldn't this be HPT372 ?
> 
>    No, HPT372 ops are situated below -- they inherit from these.

Yep. Got it (checked the code :)). All good.

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
