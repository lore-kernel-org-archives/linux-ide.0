Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2DC433EF
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jun 2022 23:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiFLXSZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Jun 2022 19:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbiFLXSV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jun 2022 19:18:21 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0374506D
        for <linux-ide@vger.kernel.org>; Sun, 12 Jun 2022 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655075898; x=1686611898;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=J48Gl24Vv69vZcjCQDyHlWkKGeoUISoB3Dzsh6xwC7w=;
  b=Hxl/AqcjkF1NMzn99A2NaEQgSGo5ngclw7ZYfUOdZ1O0/Icz6o56ZR2c
   2wDyMZqpLKVM4Eo0tAYKxmTyK9T4pSSCjWzFlV6jdM4nwh/V07MwYripT
   I38mUpvEbwcvhYhEuJOqj0mk5LwbWRQeRd8yFhGjM5i2jh/VbIEqEllG9
   P3pxc1Wt52MTA7Cc+S6V86j9tISANnPkSif+qdLsoJY5xlci2uSOZf/lD
   seYqJ+f7S7jwZFjyduETkbrwjxA0u9JBosVK5K3f8QlQUmFX3hwaB9MZj
   q6VQnpodAtIK73a/aSRM2e1+8Z8FUZucM1h5kb5kYMd+wVVfFoNHcNPLs
   g==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="202941142"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 07:18:18 +0800
IronPort-SDR: IwMCW9j57x9oUEnsl6NUVg6b9DvU84kuKBUQ0KZIZnLl0kFFhtAy9Bx9zJBooucQaNPDlupGnk
 Si1NBZ9idAxTWBEv/G5GyCZ4VVdb9MfXdltB7sNAnpQf6BP8qMQLApSAxwW+CJ1uX925Gu1QD+
 1dyKRFPIy3b1uZg/EOgzzH8A9z3vcgZ0ufyhY9Gc1vwxe2d72kv7VX1igEa3u4CQ+avOnhTbiw
 MK+px+7HK7Jpj9w3a191oWmtTLtP/AH4sYYxsil+I6H0qGdpgVbq7KwHn235Jb9sGrKhw5bjAl
 SkysRge8iv0Bypk4wjOjzlIj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 15:36:58 -0700
IronPort-SDR: aEMLBWkrbf+819A+BtzSBNkd7YcCQhx0GJITMz+fdSd3OUAdCXJhCt01DXf3z1r91bZM/E7wxe
 d7JaVLrV5JglyubzCy0BMir55qIEGDk9AMlyZ80e6nhvYlrMkgqJKmUeSPdA6JWLcHyoXmwqNy
 IlTyXFFOpdVBD7W3TBwBg8mjj2MmKM7HOO+ZVe4GMOc6YUmJ4bcL8k3HtA6wIUZO7upD5kUjyy
 WWVKjq4Zw+rWl4a/sie4SjO4+EGGZBJJ+VMZviQmBLa3HAHaei4vY0phr4eoqffTlJ0qmkOGZU
 2PY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 16:18:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LLrGf16gPz1Rvlx
        for <linux-ide@vger.kernel.org>; Sun, 12 Jun 2022 16:18:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655075897; x=1657667898; bh=J48Gl24Vv69vZcjCQDyHlWkKGeoUISoB3Dz
        sh6xwC7w=; b=KTg6an16dOtItd/j5A/MVcvhTckAZ3VXN25hKKTeQ9P4Z3bo+An
        tI/3YXjp548uc9s2L3zjBeJKmyFrOpESibPct5qdLqZJXnglzMtOpaV0FZrxtfrz
        8dKZi7ipNTx+QJqTcxCf6HWi3sM/nZZAywQqfPnF6U9JBZV9OzRIvT8cYmOzx6Bd
        KJ9FWl221kBExKNATXNiYjlpPz0kb9TCa+CB8nZyIwsPVSSnyHCWIsukMDo0Bfkb
        I7ckiVpT24lsH5jiSb4Jqi2eHhKP2JMr3zvQIhsG6q4/C6OTzazRi1CZVbaXuEIN
        j7v8SXlxb1QqdyLEIL5HqPw/OYqsp8zpqRQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tvvNS77pFtaK for <linux-ide@vger.kernel.org>;
        Sun, 12 Jun 2022 16:18:17 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LLrGd2xWVz1Rvlc;
        Sun, 12 Jun 2022 16:18:17 -0700 (PDT)
Message-ID: <9ad43de9-238f-4247-6db3-f586ee1fc7be@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 08:18:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] ata: make packed transfer mode masks *unsigned int*
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <20220508204139.4961-2-s.shtylyov@omp.ru>
 <1e32829d-382a-c9c6-a24a-3b3524886700@opensource.wdc.com>
 <97ef20ab-ec3d-d2cb-e90d-645ba3c9dbc9@omp.ru>
 <b8611310-c0f6-5252-f58e-09270e5a4f01@opensource.wdc.com>
 <0dcf280d-24b6-913c-49cb-b2ae8bd047b4@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0dcf280d-24b6-913c-49cb-b2ae8bd047b4@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/11/22 05:19, Sergey Shtylyov wrote:
> On 5/20/22 6:37 AM, Damien Le Moal wrote:
> 
>>>>> The packed transfer mode masks are declared as *unsigned long* (which is
>>>>> a 64-bit type on 64-bit architectures), however the actual mask occupies
>>>>> only 20 bits (7 PIO modes, 5 MWDMA modes, and 8 UDMA modes), so we can
>>>>> safely use 32-bit *unsigned int* variables instead.  Convert all libata
>>>>> functions taking as a parameter or returning a packed transfer mode mask.
>>>>> This saves 470 bytes of object code in libata-core.o alone...
>>>>>
>>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> [...]
>>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>>> index 732de9014626..1429b7012ae8 100644
>>>>> --- a/include/linux/libata.h
>>>>> +++ b/include/linux/libata.h
>>> [...]
>>>>> @@ -1103,16 +1100,18 @@ extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
>>>>>  extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
>>>>>  			u32 val, unsigned long interval, unsigned long timeout);
>>>>>  extern int atapi_cmd_type(u8 opcode);
>>>>> -extern unsigned long ata_pack_xfermask(unsigned long pio_mask,
>>>>> -			unsigned long mwdma_mask, unsigned long udma_mask);
>>>>> -extern void ata_unpack_xfermask(unsigned long xfer_mask,
>>>>> -			unsigned long *pio_mask, unsigned long *mwdma_mask,
>>>>> -			unsigned long *udma_mask);
>>>>> -extern u8 ata_xfer_mask2mode(unsigned long xfer_mask);
>>>>> -extern unsigned long ata_xfer_mode2mask(u8 xfer_mode);
>>>>> +extern unsigned int ata_pack_xfermask(unsigned long pio_mask,
>>>>> +				      unsigned long mwdma_mask,
>>>>> +				      unsigned long udma_mask);
>>>>> +extern void ata_unpack_xfermask(unsigned int xfer_mask,
>>>>> +				unsigned long *pio_mask,
>>>>> +				unsigned long *mwdma_mask,
>>>>> +				unsigned long *udma_mask);
>>>>
>>>> Why not change all of these to unsigned int too ?
>>>
>>>    Done in the 2nd patch.
>>>
>>>> They are defined as "1LU << shift" but everything actually fits within 32 bits
>>>
>>>    No, they are #define'd as *int* masks in ata.h, not as *unsigned long* in libata.h...
>>
>> I meant the mask macro values used to set these fields are all defined as
>> unsigned long with "1LU << shift" defines. See enum ata_xfer_mask in libata.h.
> 
>    What does it have to do with {pio|mwdma|udma}_mask? These *enum*s values are
> used solely for the packed mask...

These values are updated in patch 1, which I had missed. So OK.


-- 
Damien Le Moal
Western Digital Research
