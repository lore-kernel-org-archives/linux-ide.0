Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D256AC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 20 May 2022 03:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbiETDhP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 May 2022 23:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiETDhO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 May 2022 23:37:14 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1390A132A3A
        for <linux-ide@vger.kernel.org>; Thu, 19 May 2022 20:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653017832; x=1684553832;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9f5lxC57JjMzz6o6O4umPPyZhRGrbQqGLxliLPouBLc=;
  b=It8HQLSnX58B2mdlyGLgWi2mB9AXBFQz3aG/98aYn11/ze638euqjN7n
   ZKa0lpQ1HPn3YQr8wnUhi53EdRpzhDj7b9UCpb/YPlFkb+RsR+w99pQOR
   zxMx4rPfeaXa00Z6PDp+L/FFOeBgkYW//Yl60wXRwvNrGbc/G/yUaAQ6O
   8h6Htfs7yIDv2kl46qrqFTmLuJ5eaRtYu6n5+mHg9u4QSIii0jvtr+JBv
   OIxtjjefLIlK4XmLYIMNS57SOKWGyjoNi7fL6Ec6Kit20o5bx0QC+skan
   Inan1DGvdJjqC8BXrcb57fNg4CS1/8RBidpYqduR+pmHLgYgzPC8BE4Rc
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; 
   d="scan'208";a="312849756"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 11:37:11 +0800
IronPort-SDR: bbqg6DxMrPW1FXe0MONINAceJUitKomt2zAi5hEFUlX4cxSM92mcmj2TsHNfjPqR9dKAYZ0D16
 HjbJWbSDxNFyIFAabRdG58+GY1VizQJt+sO2mcSh20Dn8PfZZ2hVJti1Y3VQ3CN2sUTwsZDXGJ
 NDvsdCU4+6QqqVrrLSDtNcu32+A5/sl6c/63r0HtzTowPoiC2BRQ69rIP3OE3sU/bp6Vy2HazS
 Izmbe/EkUEKALRB3NGxLqhkMnGAQoJ8Ii7ZgfE50S51+0bZAy5SILrm8r2YMCUlcY/NoLnbE1H
 kVUfzet0iR3lX/j6BKqTbLB0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 20:02:34 -0700
IronPort-SDR: oZlC9Qbw+jsuJW2NyVvFa+sznZEPpcMxZfeFUKRTsZyyu/8TpRcIGNh0wp7XQSbx4vboEmlu0B
 U/tVLGPXNFDoenSH9H4TUsJj6EsG1IOe2cKWKkcr9Yipdf8BYyAw+JsxI6Efo2wu0C/7xXM0qs
 H3EJgq8PEiTQYG6UGcuhQYYd2OkEWsLblznBZhwcehNN9XtOoXTGl/OHmd3TIxV0YOjvRm0rmZ
 CHJTuiNpDRiO2Xp9QBm/ErKntv56bnVnlTs02UnnXDq5SJkiVxucxfbtSxbyg47wQssyXNvp8x
 twk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 20:37:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4C8R2k9Lz1Rvlx
        for <linux-ide@vger.kernel.org>; Thu, 19 May 2022 20:37:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653017831; x=1655609832; bh=9f5lxC57JjMzz6o6O4umPPyZhRGrbQqGLxl
        iLPouBLc=; b=b/YGu2PDg7Or9hXuPTd4gRjUDgsBeHKg85x09zafpgA7IEqWZ4y
        0AmXNV6G2qJKqY6KQVbrgD1eTLJ8GSjzCgdR+3FyJeM84hj19ByhIh2pg6bWKMH5
        zXVrXq2xEjvFea61rrO8msjF2XBXAPSsHYNI93NPqqGOKSrwZNARERZNNFSdJgRG
        Ev7HAA2ldwkaBOer1LTeNWtYp/gvOirspmzoQYVNMxuQCGpM5kT6GviLhMS+1eIW
        DrfMvZ1qE5M11wfxB1ySJDex9iqZfDpsimQSDmI93kChTPg/0zzcq0W60ytRyj6B
        fDTvoBwqZsBDgdLRWu5D+09b5JpxAzsbkmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nq83auwDblee for <linux-ide@vger.kernel.org>;
        Thu, 19 May 2022 20:37:11 -0700 (PDT)
Received: from [10.225.163.45] (unknown [10.225.163.45])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4C8Q4m2Pz1Rvlc;
        Thu, 19 May 2022 20:37:10 -0700 (PDT)
Message-ID: <b8611310-c0f6-5252-f58e-09270e5a4f01@opensource.wdc.com>
Date:   Fri, 20 May 2022 12:37:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] ata: make packed transfer mode masks *unsigned int*
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <20220508204139.4961-2-s.shtylyov@omp.ru>
 <1e32829d-382a-c9c6-a24a-3b3524886700@opensource.wdc.com>
 <97ef20ab-ec3d-d2cb-e90d-645ba3c9dbc9@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <97ef20ab-ec3d-d2cb-e90d-645ba3c9dbc9@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/20/22 05:19, Sergey Shtylyov wrote:
> Hello!
> 
> On 5/16/22 2:17 PM, Damien Le Moal wrote:
> 
>>> The packed transfer mode masks are declared as *unsigned long* (which is
>>> a 64-bit type on 64-bit architectures), however the actual mask occupies
>>> only 20 bits (7 PIO modes, 5 MWDMA modes, and 8 UDMA modes), so we can
>>> safely use 32-bit *unsigned int* variables instead.  Convert all libata
>>> functions taking as a parameter or returning a packed transfer mode mask.
>>> This saves 470 bytes of object code in libata-core.o alone...
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> [...]
>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>> index 732de9014626..1429b7012ae8 100644
>>> --- a/include/linux/libata.h
>>> +++ b/include/linux/libata.h
> [...]
>>> @@ -1103,16 +1100,18 @@ extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
>>>  extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
>>>  			u32 val, unsigned long interval, unsigned long timeout);
>>>  extern int atapi_cmd_type(u8 opcode);
>>> -extern unsigned long ata_pack_xfermask(unsigned long pio_mask,
>>> -			unsigned long mwdma_mask, unsigned long udma_mask);
>>> -extern void ata_unpack_xfermask(unsigned long xfer_mask,
>>> -			unsigned long *pio_mask, unsigned long *mwdma_mask,
>>> -			unsigned long *udma_mask);
>>> -extern u8 ata_xfer_mask2mode(unsigned long xfer_mask);
>>> -extern unsigned long ata_xfer_mode2mask(u8 xfer_mode);
>>> +extern unsigned int ata_pack_xfermask(unsigned long pio_mask,
>>> +				      unsigned long mwdma_mask,
>>> +				      unsigned long udma_mask);
>>> +extern void ata_unpack_xfermask(unsigned int xfer_mask,
>>> +				unsigned long *pio_mask,
>>> +				unsigned long *mwdma_mask,
>>> +				unsigned long *udma_mask);
>>
>> Why not change all of these to unsigned int too ?
> 
>    Done in the 2nd patch.
> 
>> They are defined as "1LU << shift" but everything actually fits within 32 bits
> 
>    No, they are #define'd as *int* masks in ata.h, not as *unsigned long* in libata.h...

I meant the mask macro values used to set these fields are all defined as
unsigned long with "1LU << shift" defines. See enum ata_xfer_mask in libata.h.

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
