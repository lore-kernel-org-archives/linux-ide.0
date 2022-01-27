Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F49DC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 02:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiA0CPS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 26 Jan 2022 21:15:18 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20863 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiA0CPR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jan 2022 21:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643249717; x=1674785717;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=koizvhqZQhyhzGOf2KY9qXoCJNHtohDiLlRaxO3HbiI=;
  b=gjPLuk+YPHEs29kOQLJydt1PuoNyMoP92vYDknJgTN5UP1i2QslHcF6o
   fAg95qYrUHITkJROGiOncIe4JPwpBVihWC2cDjrkn7TzSfIrf7O9EuwHT
   PgVa8R76ugwssBwsYdkYUS/O+pIpPTrFVhChEieBqWze00ZCuKfZIag+1
   Z9hCIQk/f58RTpKMncCWULItiR/rB5J+qHTh7vMUDsRdLpHEPnBgPCd1J
   MhgEEQ/F5D8MaWSoYvXHFH/ChBMXwXWKYfBwGpSgMwljOSrIwBUSLmzAj
   K/A1e3eadjtGotRGZrQwQJ5GjAguWtrXx7ntIOKIcv4fUu8mx5Hsvhvig
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,319,1635177600"; 
   d="scan'208";a="190429260"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2022 10:15:15 +0800
IronPort-SDR: p1JZROgjedfCyLtmpCjUaoPt9tRM7Ss6mP2PeUK2zjsFIz02Rm+rKni0WJndxiLNF7/pP64xcM
 PlELcO41uOeW87VFqRS6h7FFFqX0caocGM69eeykhu+SmlrBmBnpDJwmtuNz1yjMJ2egQlsYBy
 OD3OWfeFDlrKL5n5RgZ6uhXUwNAmGiP7D9F7FIerxFqDUcFZ681maQ2la4TijmuhCoAsiXYTJX
 KdNiSAzoQghU8jB62cKLfplqz9uCpxS2DpJZZO+kEHV+gwEjf4Z5JaJZBY4z7+XyLijcHRulY+
 8k8ustvJ8HSnzDO7NhQjJjsG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 17:48:33 -0800
IronPort-SDR: nMumSBdqem5PDUNKH7xm/QBv5X6/+YeeqRREx8XeUCOcQ+1pbwhRnHDh7CrTmvUSEgvfF4Rpyj
 LumK6kYdQUQygyA1IPjbMTDK7xJzBucbwwHyCVWI9/j+BLNnONawQ1AEujASG64OgUzJoWeYoN
 3YkbbWgFBeqpKVdMtF327IO4/Udj0w7D0lL3g8rSs+qIRfLqCo+fbZl8nYaWA+4T6q6yySIBr5
 ClqzlZpaTZkLSiemjUsVAFKJPG0eg6OWz0c8AAn4GvRxCVAsK9+LWAxefvHzzypgSuzwnmw82V
 pwg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 18:15:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jkkh24smvz1SVnx
        for <linux-ide@vger.kernel.org>; Wed, 26 Jan 2022 18:15:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643249714; x=1645841715; bh=koizvhqZQhyhzGOf2KY9qXoCJNHtohDiLlR
        axO3HbiI=; b=tUtb7l5sxiIxEUHZMIQP8rrNk2igozlmTew3oldE4le3QT07xz1
        oEECnxmKA2AS3+abbDHJasCILWb4V7r4ATs8YQ5gRoAiwGAzj+9ppF4D9cCrO3fQ
        XSQF7xmRVwSORKlNs9977DYiEdkrgqewxDNchqFiK2AOCURhHfWVlxquonbd4wE6
        Wr4U3QxqkX0WWSigMbJ6zjgRJ11yS6tqzuVG2Gc2X+po8DUmZBAPHt9Ntu16y6yj
        mNFKXyX6S5T2knT9T3yTjmVG+ikN1wttb2NB4Iy5fDRiM4eq30MqjQhL9X1j5fPH
        I3TBTTlINt+xYWNoLse4LUXt2mj3ZFhLr3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EbxxadrvewSz for <linux-ide@vger.kernel.org>;
        Wed, 26 Jan 2022 18:15:14 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jkkh10LLVz1RvlN;
        Wed, 26 Jan 2022 18:15:12 -0800 (PST)
Message-ID: <f7262bda-8669-3910-9e8c-e72a68eb3325@opensource.wdc.com>
Date:   Thu, 27 Jan 2022 11:15:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_platform: Fix a NULL pointer dereference in
 __pata_platform_probe()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220124164525.53068-1-zhou1615@umn.edu>
 <578d6a7e-1488-43b9-9bfe-9c99c88da4fd@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <578d6a7e-1488-43b9-9bfe-9c99c88da4fd@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/25/22 18:46, Sergey Shtylyov wrote:
> On 1/24/22 7:45 PM, Zhou Qingyang wrote:
> 
>> In __pata_platform_probe(), devm_kzalloc() is assigned to ap->ops and
>> there is a dereference of it right after that, which could introduce a
>> NULL pointer dereference bug.
>>
>> Fix this by adding a NULL check of ap->ops.
>>
>> This bug was found by a static analyzer.
>>
>> Builds with 'make allyesconfig' show no new warnings,
>> and our static analyzer no longer warns about this code.
>>
>> Fixes: f3d5e4f18dba ("ata: pata_of_platform: Allow to use 16-bit wide data transfer")
>> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Please see my note about the typo in the fix. I kept you RB tag. Let me
know if that is OK.

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
