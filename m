Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCB1C63706
	for <linux-ide@archiver.kernel.org>; Wed,  7 Dec 2022 15:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLGPPh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLGPPe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2022 10:15:34 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E66174F
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 07:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670426132; x=1701962132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bVoGkw+X84VJ7BOqchRYfb4zBhhEAZDkBHYvKmDuHAQ=;
  b=OdHqVpV46qRDGlC18D3NPnVSBz58npjRq9wtDOyIi8QTK0VoF4uZdV3b
   wwlUtxU422bQIWtClz+r9X1UXT80jL3u6qoPTN7QWP5dwrrb0tpgQEJQm
   RWO3U++Mv3ttAASrAzF5vG9h71F6ZcLosAXuRKz12MtKxyN14q6Qja0hC
   UVgNWuzqFeD/NLHIIMaXR4vs7L3fYDJ5chWdDtIsVop1gMhKGGc5MHQiN
   rZfSHveJuoKT2v8yItu1YJBC9FEkXM2HZ/swjkwTqHO1xj37T/DnKwuOT
   yn9tW/mpvkH4NNmX7u9w6X3FyJ4dVTmb0rWtOJ0yf8eceIKJJRF4zX8Li
   w==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="330200222"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 23:15:32 +0800
IronPort-SDR: C5JIpkHDzbpz06vHIchiHrahP35mjhYdOkm4jmBGwTOGnXP3Zl4B+XHlPPatuhQaLPJr4qVEOQ
 jck/8rhZgsKJ4Ae8YzVw8VV0FAeSVGiXxtjYAMhAsJN/ysVXEpdaaxE6/0Netmtv3//NryBHs/
 h/mGn0IYPT2u9naB+KAn9aiKHAE3etONydtfVkMGLj4XjEVo0zkyUZMw5nq1VuMqsKUWjl4DwB
 l9VzSf5b3ZAlta25ulm1GpwLYLZrTIhoa9uuU3mUgs7dvwxMhKEuBG+FR79D9pFdh/hCj4i/9D
 7Ow=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 06:28:19 -0800
IronPort-SDR: T+uVHptxpOAG/TBVR2Vm4k/ngvQcG5hL8HnYFbYQ4DFL/rgqBq1TVuGY5AIsiyNNW4lKQp8SAP
 yfv8F57UKpXlM79MvfyiRFDaK62OZXkD3ez85FGINnZsgvFeQh8iB383RQtJnYikm8sSXiUPsN
 QZo9f0yyxCX/LJ3E55Xx3QCxpL5eefVjL6/fCZZpoeHRnsGwe91YolkSPuX1gHefA1tU9Oz+l+
 OgAGRFl1oSHLVNo9BAZ0PXBDgVEgRmYZ5xPmcy8qEALCEqwqcDDDzMGHMJgXoUu9eO3HBMZz38
 yqg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 07:15:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NS17S31wMz1RvTp
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 07:15:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670426132; x=1673018133; bh=bVoGkw+X84VJ7BOqchRYfb4zBhhEAZDkBHY
        vKmDuHAQ=; b=p0llbitGO+Q3LQ9XE9giV8LXcLq5jPRe1vZxPnKC8PS0tD44AuT
        IQOwd4BwCBb4PDRbnv+8VJW7uJKvpu8CHW0Mrl0eWRmDApE2rvAZYKry7wXn7Vx2
        Bf+8Zx6I9OOF0sdTz3skFYzuXKBrJuIFybSnzO0bN3YUIGrXnQvW5FLzi+zF07vr
        m9Iy7Ri0j+/ZIIbE8Vejbgp5JWmE07DwjqqC1itFW6zHLYGV7KU1ZSP0vfkVcu+K
        lCWghHHFg6cukRUhESjOYxtU1McGK6No0vuPOKyaQjNuP+eX13uCKVQixqmzYOMY
        0qtsh4mn6H8GQ9U3+jN7+TusJjwPTlt7Tsw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rVG9D6qk_UAH for <linux-ide@vger.kernel.org>;
        Wed,  7 Dec 2022 07:15:32 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NS17R3XkRz1RvLy;
        Wed,  7 Dec 2022 07:15:31 -0800 (PST)
Message-ID: <7ee6b490-baa7-44f5-733d-528755f37d81@opensource.wdc.com>
Date:   Thu, 8 Dec 2022 00:15:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] libata: Sort Pioneer model in blacklist names
 lexicographically
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221207102656.12486-1-pmenzel@molgen.mpg.de>
 <4d105e81-7f99-a17a-2a84-5eb70c74cc91@opensource.wdc.com>
 <5ba31f2c-89b0-c059-dda0-674db08e7466@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5ba31f2c-89b0-c059-dda0-674db08e7466@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/7/22 22:26, Paul Menzel wrote:
> Dear Damien,
> 
> 
> Am 07.12.22 um 14:22 schrieb Damien Le Moal:
>> On 12/7/22 19:26, Paul Menzel wrote:
>>> Fixes: commit ea08aec7e77b ("libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M and BDR-205")
>>> Cc: Niklas Cassel <niklas.cassel@wdc.com>
>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> ---
>>>   drivers/ata/libata-core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index d3ce5c383f3a..c08c534b7fc7 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -3990,8 +3990,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>>   	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
>>>   
>>>   	/* These specific Pioneer models have LPM issues */
>>> -	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },
>>>   	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },
>>> +	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },
>>
>> Nah... Not worse the trouble. If anything, I would rather have the entire
>> ata_device_blacklist array entries sorted alphabetically by vendor and models.
> 
> What trouble?

Manner of speaking. I meant the patch value is not worth the time to
process it.
As suggested, sorting the entire array would be a more valuable change.

> 
>>>   	/* Crucial BX100 SSD 500GB has broken LPM support */
>>>   	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
> 
> 
> Kind regards,
> 
> Paul

-- 
Damien Le Moal
Western Digital Research

