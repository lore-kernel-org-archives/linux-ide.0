Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E1BC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 23:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbhLJXtb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 18:49:31 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4136 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbhLJXtb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 18:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639179955; x=1670715955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9yME3JRsAyo+LsxuqMyQDSwtN+9Xk8ZdysoZA4GjAIA=;
  b=GJoxBy9kiVUwWdlLWLA/Se2jsV+5i3zSvF2nqv6SMhTXQWIRT1F4pBq8
   wrqje7U3fFpX13PCvEUc9O5uj+cgHzsXgvJyoo0S0KvDLabAHRtGa86f6
   fE2+hwyAXdTo33LeVGo6DBVcuv/mrsHOXINZQJHoFXf7Z/wX49zcFPQyb
   eb27NUk/QuWX/21DqNZtsH5mkPnnuXqCxvh4UvD7l3g2NvjxvENUK0Zy2
   51ets04obfnVl9GWyoH32xidbgP0wgFPGEbmLZaiMKKcBfZHSPm7UkH62
   c0E+f+YdiXNE9f6pnjXJDweNTDCpnJKR13/1AbLwxK6Ngs6cnXJkQ9EHB
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,196,1635177600"; 
   d="scan'208";a="187979386"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2021 07:45:54 +0800
IronPort-SDR: GH60Los3z3QK0wkq0hT/yMCLuzzqH9yqayTJVOzB5IC6wUiFtE5Go4W8vogiRR7KLvzNVI9UfJ
 aa7HM6XPHtS/lzEq8pK5y4JxO82ZnXluv16uYRN4k+4EgsqXkAxYQsdmOa6yo8dbnZaJZsKRwL
 WF/ZuxI5Qc6vGkUEnWPPZl579Wk4xTBxeNYulsjETtxnUYa+9WdcuTFauXLREva92WDuXxEpmW
 XJmkTXP12RUFILr9uAv/cXdaY+XcVC8U8oHORzC42kSJhA1WjxDdnykDDVFZzUZpoJaeK2HX9B
 lGFcvs7GdSMx4L0gCQN7gTBM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:18:56 -0800
IronPort-SDR: MO2/A8yWfmNuI2WhM+sSQQs7ciqLt34OWqxt3SW/cBUD/t6gT6SOhv/Cr8FSzyOJM9xIn3gZ9G
 u5AB/U/O54NYRk8S8QV8JI3ubfptStLv8CqL6rXeAc3oEk96XQfY9Qr+P0nheE2AO4xzkzMERF
 GzH9+Nv6VGY/ITir1jpLyUM8uw+niTbKAf5N+qpg7aSKI5opLx7HlP6OBORzIQaRgw3IS4wAiP
 oIIOaJxE8IG3GQnpRvAaG2wgvyxnX2+kcyS3VM4r2D+Qt1y97M5nmbNYM2gSxU4x5kK19HNsDl
 OJ4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:45:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J9nbR2VsGz1Rwnv
        for <linux-ide@vger.kernel.org>; Fri, 10 Dec 2021 15:45:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639179954; x=1641771955; bh=9yME3JRsAyo+LsxuqMyQDSwtN+9Xk8Zdyso
        ZA4GjAIA=; b=XIAlJ05M8/qC9zoPznkf7ZUBgJQN5s2AN1bSQylw2fCIwDAYX7Z
        xnlQNT82qDY7/wod6te0mI7Bs/EPHB6UudNSWU94s8RtagRH8VV5+0/fOTMVOVlk
        C7XUIvpCzrReM5ba3XFOepRAS/FdL6IhpZ0SI7nkJwU3umlCBPHI9OKFCM4O0Xj2
        5MSMt0yjnkDlf1VwG3rXiMpqT9m5xl25d0zkv1K2u5VLLmladrwfPAKmvEKncgBK
        9lPIw8lgX1vewfvv9B8KtKLIGdA5tNx/tAJakMRqWv8OfqlhhH7KecLwO2J6BCDg
        8O+QEqiM9r6kuDO+IzXpVRZYx/ajyp7sIKA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 03-4mLPznkef for <linux-ide@vger.kernel.org>;
        Fri, 10 Dec 2021 15:45:54 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J9nbP3P1Kz1RtVG;
        Fri, 10 Dec 2021 15:45:53 -0800 (PST)
Message-ID: <549c1825-56e6-de9e-e109-77f0d06cfd0f@opensource.wdc.com>
Date:   Sat, 11 Dec 2021 08:45:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/10 17:59, Sergey Shtylyov wrote:
> On 12/10/21 1:49 AM, Damien Le Moal wrote:
> 
>>> platform_get_irq() will print a message when it fails.
>>> No need to repeat this.
>>>
>>> While at it, drop redundant check for 0 as platform_get_irq() spills
>>> out a big WARN() in such case.
>>
>> The reason you should be able to remove the "if (!irq)" test is that
>> platform_get_irq() never returns 0. At least, that is what the function kdoc
>> says. But looking at platform_get_irq_optional(), which is called by
>> platform_get_irq(), the out label is:
>>
>> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
>> 	return ret;
>>
>> So 0 will be returned as-is. That is rather weird. That should be fixed to
>> return -ENXIO:
>>
>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
>> 		return -ENXIO;
>> 	return ret;
> 
>    My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
> but returns -EINVAL instead.

Thinking more about this, shouldn't this change go into platform_get_irq()
instead of platform_get_irq_optional() ?

The way I see it, I think that the intended behavior for
platform_get_irq_optional() is:
1) If have IRQ, return it, always > 0
2) If no IRQ, return 0
3) If error, return < 0
no ?

And for platform_get_irq(), case (2) becomes an error.
Is this the intended semantic ?
I am really not sure here as the functions kdoc description and the code do not
match. Which one is correct ?

> 
>> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?
> 
>    Of course it isn't...
> 
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
