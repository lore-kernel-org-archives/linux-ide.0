Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8499AC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 13 Jan 2022 00:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiAMAeN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Jan 2022 19:34:13 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42795 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiAMAeN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jan 2022 19:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642034053; x=1673570053;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=545fTs9x0QZ4588uvRzStDOfjDxqu1bN3mh/rTFWYOc=;
  b=Ke0ja1iId2QO+yT6muAcSr7TwI4zidk40Jri12BCV8+D5fhGvYoOIe23
   YTc9D5beMXj4Y8fiVDA6v2I95pTLj29geW6nTHGuTp6xZqX4IhEna/eFX
   Yp9hQtcAWRzi+cDJpIRZWr3lDO3q/hEVmMFtjppMNV90wzs0YLuoJAcn3
   EO5BT5dytToYjK+ejNAWmB03q5bWkHqsDE4TyaUs/FIBvW7pmBm6k0M26
   ITRy4ao/Y+p6NqC06hdG3rIHZV6+BtLCgn4xduQBhJyQFxQ8ulzP3V61w
   ccA2UGtXnhog9VtVEkmJyzb8Wc5WZu/YC1+9f/PnsxxNI+Wr64oYPcqOi
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,284,1635177600"; 
   d="scan'208";a="302192494"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2022 08:34:12 +0800
IronPort-SDR: 706MrSc7XO2SnEyCZRP4JozfitujznV5zslZjnzdHOG++EfmXTktmq01/sztA6WScNd61aSaMw
 d7qsK11Y2+Gt/xDObpiECybczPkEBix0Kdoy/hb1UGCQICBknXfz9qlzv/XskbHw0TnOfx4w27
 0DA38MFTIIeKO449DekYi/7JgkkMvN0lD3O97lDwldQv4xShSaOZL8b3SdRFInJ4Y6+NC+BQtN
 jymOjnaOFMFA0q4QXnQOjG9/zaOby385kc1aOfzxQMtY3rlYo/SmJyl7N7xrp7yut7OebeNbJo
 b9PvLAfUjiec/jwoFeQ7ykv2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 16:06:34 -0800
IronPort-SDR: Q3Xi/puAffoZwJT7QNwXbITLsS0JlI9733AcvIiMgDlAFhiKiqcyF3St5m7GYKYWP85DnvDK/X
 66o5GXQutI/07qszllaMUtdhGiwiQx9wr3z2hKVQ/L1miAb5JRukZpOX6NSU63UHs3CFdluiYZ
 F3DXvjIoLS3NTLUe7mUT46RwvMaqaY5kn6Yb9V+fE22N4PWvKC90xKdt2pLdalwG2A0IzF/YmD
 p/1ZuvkZlvKLj0NfJwKO1OHutg5vvdHBYVf/pxoxrGfspxU6ACiSkQTfKqUSvB7OhL1kmN+T7+
 9m4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 16:34:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JZ55w44jlz1VSkZ
        for <linux-ide@vger.kernel.org>; Wed, 12 Jan 2022 16:34:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642034051; x=1644626052; bh=545fTs9x0QZ4588uvRzStDOfjDxqu1bN3mh
        /rTFWYOc=; b=hIcPg37jgvfeTDVrdk7SMyP7EAq9e7HhP1Fvmrval92KxVlOVjA
        Vdepo4uaD/OoIvd5QMrw0zqEYyM/PCJIUaZXYkHOe8jYuTNEmXdRFDp36f6h22N+
        5NJYYIQUdOMnsIAMibTseieQTdOUr1LBhQCe3DTB58OCoKeDzX4VrrtvePTtVPWs
        FVLsZqotp+rpB62ZYVwBnh7J/apV4hWD2aNOyV6MuHWp96IyMJdbKE4UMYcuV//1
        nKk2eu+J88IgBha3Zk4oSnTStn99GQVbzu2rkuG4YCxpoywTBetcWgv0nhTjhSaY
        PhSAFSOP743sw9HfUvx6C5P5Q7hoyPsevjA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VvN6XyIcCYaa for <linux-ide@vger.kernel.org>;
        Wed, 12 Jan 2022 16:34:11 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JZ55v09HRz1VSjC;
        Wed, 12 Jan 2022 16:34:10 -0800 (PST)
Message-ID: <ede2b0d1-9bdc-e5d0-6a0c-c5c7216754a6@opensource.wdc.com>
Date:   Thu, 13 Jan 2022 09:34:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH][RESEND] sata_fsl: Use struct_group() for memcpy() region
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220112220652.3952944-1-keescook@chromium.org>
 <df3eefdc-d8d1-48fa-f5f7-9c2f2382842b@kernel.dk>
 <202201121515.8679164D6@keescook>
 <ec4d9eb0-3999-db52-1eec-bc6351dd4f07@opensource.wdc.com>
 <202201121628.A8B11A1@keescook>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202201121628.A8B11A1@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/13/22 09:30, Kees Cook wrote:
> On Thu, Jan 13, 2022 at 08:47:37AM +0900, Damien Le Moal wrote:
>> On 1/13/22 08:15, Kees Cook wrote:
>>> On Wed, Jan 12, 2022 at 03:23:40PM -0700, Jens Axboe wrote:
>>>> On 1/12/22 3:06 PM, Kees Cook wrote:
>>>>> In preparation for FORTIFY_SOURCE performing compile-time and run-time
>>>>> field bounds checking for memcpy(), memmove(), and memset(), avoid
>>>>> intentionally writing across neighboring fields.
>>>>>
>>>>> Use struct_group() in struct command_desc around members acmd and fill,
>>>>> so they can be referenced together. This will allow memset(), memcpy(),
>>>>> and sizeof() to more easily reason about sizes, improve readability,
>>>>> and avoid future warnings about writing beyond the end of acmd:
>>>>>
>>>>> In function 'fortify_memset_chk',
>>>>>     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
>>>>> ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>>>>>   199 |    __write_overflow_field();
>>>>>       |    ^~~~~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>>> Cc: linux-ide@vger.kernel.org
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> ---
>>>>> Jens, can you take (or Ack) this? It's a dependency for the FORTIFY_SOURCE
>>>>> improvements that are close to being finished. :)
>>>>
>>>> I don't maintain libata anymore, so Damien is the guy to nudge ;-)
>>>
>>> Ah-ha, okay, thanks.
>>>
>>> /me waves "hi" to Damien. :)
>>
>> Hi Kees,
>>
>> This is already queued up in libata tree for-5.17 branch. I have not
>> sent my PR to Linus yet as I am letting things soack a little longer in
>> for-next (for the various arch compile tests).
> 
> Oh thank you! Sorry I missed the pull. I didn't see it in -next yet, so
> I assumed it hadn't been pulled anywhere.

Uh... Weird. That one has been in libata for-next since a while back. So
it should be in linux-next.

> 
>> Please check that branch to see if all is OK !
> 
> Found it:
> https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/log/?h=for-next
> 
> Yup, looks good:
> https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?h=for-next&id=23c72ffedeed6d513144fa09834b1eb0cb2b7373

OK !

> 
> Thanks!
> 


-- 
Damien Le Moal
Western Digital Research
