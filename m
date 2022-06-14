Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21323C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jun 2022 23:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiFNXqk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFNXqj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2022 19:46:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2914CD4A
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 16:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655250397; x=1686786397;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PMEQNP4r/rkBFsS4r2if7KKTKAU6tsa+GCqXMTk+KwY=;
  b=GXs3JTWD3Ht5FWTLncNzWXFJNk0VQSn65/kYtJnmMOnXPjXLU5EoKmHx
   jvTZxh2vcoX7lI/+ZV1fiGAvO9+CONWf76YplRNV9FCtRmJH3x6Et8oG2
   BAMf8dTcTCb7GPL4nCYulCjCHdhY1Y13PG2549zpZvzlk7ghy62QraVM6
   LS89iVbpLvFGUO0AmTPEutKjznH/k2+QI8841TlkYPjWasv1LO1AI3HBd
   iJ3g9iqDdywZL348Tw9lRsIZKERFKGzQLnQzy53MXoMG1aQqmM/A2yTcQ
   WhngD5qhRUEClMTwDTr2/Xb4YqeQwzPP/Kg541QOV5d5ybP42eUTo7z5l
   g==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647273600"; 
   d="scan'208";a="208020777"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 07:46:36 +0800
IronPort-SDR: NMJ03/ABZV3PJeRThBwfGAwj6E6XQ9g62fy2jYzCon0867LXt04FTK0k6Ailb0EycwkjSJsGCS
 UB5m1+T4guAPE1ux/hV14++1vLYtOXabPVHH3BYvfa3VVxOJAYK2eLG1W29ERuBpTq85OD3jW8
 u9tsog22ArT24K/OjdHC1p4k2nfIoZmoESFPLzvyYZTI7H1HidQiCfZ/2ODmu9r9SLBZHrJY/W
 Y2miuNLTYZKVOypr8zOfLvahPgOBirfWhPXfn0N29s2G3rbXNv7Ox1XNpHTHppFTTd8vWiTPrC
 F79ENYBfEaJpqpOnBXpqOPvH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:09:35 -0700
IronPort-SDR: cYuYEuiqrnHlueqZYi7G6dcfwYnOP58AK21MUKmpuJFoyckLbQhHeYm+oW7OQdSmBds6u4149b
 tr36TjTfQYg/QHl9aac/dkQS6+sjeYnUl0m9FW7dVlJJK/ZhcgYikjVnAZUe1V3Fjg9LUa1c8I
 QKf1Wq/23Ax0m0jWqJ5XwHt/r+nszmngBWtDbvV2oHaLUilFlB00qOgl0WMbl4XxdKe2tOOhQU
 93aEKN4WHx9oy0hdEe6E1MVDf10Be+JmVgIA1vbvGtkLdeje/SqBCL5I7CPrNfHuhCEnNOaGbL
 YFI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:46:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LN4pN5GzXz1Rvlx
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 16:46:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655250396; x=1657842397; bh=PMEQNP4r/rkBFsS4r2if7KKTKAU6tsa+GCq
        XMTk+KwY=; b=OALtHvVkM6zbo5lsGbKcWBz1bQ1eytaXxpCmz5Zp4/ngwF24zGb
        OrWe0eBxw6TinKjkct1Pm/yPaWQILPNhfLvIIiVEosENfh+fhuxzu/hqaROt0rT7
        CC023KCRsXnQbEPtRk8kL75ya/SAiu4PKXqKw/dewhat2xnD9/i+nmGo0fwqow4n
        sCbcAtlx66ZJehJnPMakaCCpJIrG1GiDR7tunV01QGJVpqogbmqu9e9FfAePCov0
        5ACMoYFsKTrZHCS/WcWFxr2JHJTlTsp8fFuqACxO4NNOepFAv4G1RhSyxz8YVHXa
        WHdkzqipzV63IbCx19aXY4PX+NS3Oo3Z2Vw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Elk3Jv_4G2FX for <linux-ide@vger.kernel.org>;
        Tue, 14 Jun 2022 16:46:36 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LN4pN01fzz1Rvlc;
        Tue, 14 Jun 2022 16:46:35 -0700 (PDT)
Message-ID: <cef2c6a3-375d-c540-171a-a92474449486@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 08:46:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-core: [_sg]fix sloppy parameter type in
 ata_exec_internal()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <226fc2b1-ecb9-19d9-d7f0-2c6bc0fc8edf@omp.ru>
 <de30104b-f299-ab7e-c687-06ca513aa7a7@opensource.wdc.com>
 <8b6d5cfe-a353-c894-337d-00e4bdfa67f5@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8b6d5cfe-a353-c894-337d-00e4bdfa67f5@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/15/22 03:43, Sergey Shtylyov wrote:
> On 6/14/22 8:24 AM, Damien Le Moal wrote:
> [...]
>>> Make the 'timeout' parameter to ata_exec_internal_sg() *unsigned int* as
>>> msecs_to_jiffies() that it calls takes just *unsigned int* for the time in
>>> milliseconds. Then follow the suit with ata_exec_internal(), its only
>>> caller; also fix up ata_dev_set_feature(), the only ata_exec_internal()'s
>>> caller  that explicitly passes *unsigned long* variable for timeout...
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>> analysis tool.
>>
>> Since you are changing this function signature, can you also make it
>> static since it is only used in libata-core.c ? The declaration in
>> drivers/ata/libata.h is useless.
> 
>    Hopefully you don't mean I should do it in the same patch? :-)

The patch you sent is changing the function signature. So yes, doing it in
the same patch is fine with me. I do not see the need for 2 patches for
that. Instead of "fix sloppy parameter type in ata_exec_internal_sg",
rename the patch "fix ata_exec_internal_sg signature" and then all changes
naturally belong to the same patch.

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
