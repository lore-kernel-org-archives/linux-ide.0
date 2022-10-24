Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347FEC67871
	for <linux-ide@archiver.kernel.org>; Mon, 24 Oct 2022 23:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJXXwE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiJXXvn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 19:51:43 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9C2FF6A9
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666649373; x=1698185373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SFvq6dG4rEGkOwJTCEAA7a3nizRSE1YrOdaEENGx+h0=;
  b=Sh67YTyBrFwHu8d0ziNEbhEWaGknEloOt8Gy2myojxA32GLgSKKkfqrs
   Y5FKZkn7KZ/JJm1dK0dk+JZ246IF+5MP+FzRbutNltvUo5UAR+uBecvZ/
   BMBS3GJg5j/ms0uQfsuBg/SMiTuDMrGhe/s8BfGbLsguibe4BSxQ1ZPHD
   ylTf5qGyNn6vvwP2JTdj0VtPcVO/eZxWtFJ1Vkd6GcKweetljModIztIa
   /J59ZDQ6J9QEcvANuA8H6XpW7mSrxOGyguOC2DrhWi9ymX1pL0ath5Dy/
   amxE47xny9qpsytlJGctRjKhnggfASERrpjOil0/n+owLjlw9VhvPE6+L
   w==;
X-IronPort-AV: E=Sophos;i="5.95,210,1661788800"; 
   d="scan'208";a="326741159"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 06:09:05 +0800
IronPort-SDR: 11bYa9WdAHNUMl6wbjVfJIZu7X67l6PUOkVlz3kcrDWTBQLGqS0FSQUfl8rtBDdRlyT1LXL3j4
 3Z6cdyQQCoFb4rl4N7WNIwt654QxoFVfcHmDZchDK1RvH7sqAOTdGDLBbSatrgkbd0DBP6Cb/F
 +J2w7WLKQ75k/ebAfCCdBBTMKuP2YynDq3V6nlS4ZbD6He521BQKMyypylCUHrvn9hta1sBx0p
 F5SFNHHnXPqC51C8yrf8hv7vC66t2dpVP5/s2DREFpIV2uOQEYWFkYQ1nIXRsJH53sTNwozUkI
 w8mxDSXkDGTQ11jS5vPxA6dd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 14:28:30 -0700
IronPort-SDR: /PN9INiDggF/2sFVbq5Juu0GZNw7sU6ezCtZkDox7QtiejHhwKcb8aBV69HAPWowkrCqSF6p7z
 6y7BCeGkwijfnS6n5CE67Ta7diOincTbRbuvr2q3og9UPDjXZ3Gz4PWS2urjz7pC3UmHA5gzjA
 NU8U6C4M5pItDC5bL7o+SODM4sFHExMiGIObLCCi5Xh+WzVXHXdzbEjtdsUYF+WlLjq7HsTK6Z
 TDu+6uTgWTlgn2UKdFrbCaPNbY6ARQpEE4N2dCJKIg9wiFyEeWtN9TMM9mAh8/1irpJ7052hcQ
 LW8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 15:09:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mx8Nx1wcwz1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 15:09:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666649344; x=1669241345; bh=SFvq6dG4rEGkOwJTCEAA7a3nizRSE1YrOda
        EENGx+h0=; b=lY8ERBeO6Z3zAQxWz5YtpOkgKnHbgZkkEg7Akr89LjBAV3Ygtep
        XY1gYPWruZcIwqzHZVKSKtNYjWEKXJG+DxnkN0dSgNL/uDGM6gyjYBpmtrvVIxr5
        1ILviHL9TUSW8RcJOjoX0vMqJwkrD8R8j6Bd2+zQVN5Ghn7Tioq8XatM+QVCxAuX
        ZPJBQPUUV2Jg7kyfqXOvGismvJREYI7GIEBA934l80ZK1qx5NupldNBPtchm37my
        vRsFqUe8oVjvUrWd9CIpITUn0wup1+UF6J6q2d4WjdGV4Gjsor+3AKD8a9yX4c6n
        GfdAgWnhBURqq6SdP8FzqoCbikEREkdjvkg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xIL0i6LcnqzY for <linux-ide@vger.kernel.org>;
        Mon, 24 Oct 2022 15:09:04 -0700 (PDT)
Received: from [10.225.163.8] (unknown [10.225.163.8])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mx8Nw1tWyz1RvLy;
        Mon, 24 Oct 2022 15:09:04 -0700 (PDT)
Message-ID: <1401aa25-38de-c5e0-f9de-7aeb7ce0af9d@opensource.wdc.com>
Date:   Tue, 25 Oct 2022 07:09:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 0/3] Improve libata support for FUA
Content-Language: en-US
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <f1456224-f644-dce5-15ea-fecc965788e1@maciej.szmigiero.name>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f1456224-f644-dce5-15ea-fecc965788e1@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/25/22 03:48, Maciej S. Szmigiero wrote:
> On 24.10.2022 09:26, Damien Le Moal wrote:
>> These patches cleanup and improve libata support for the FUA device
>> feature. Patch 3 enables FUA support by default for any drive that
>> reports supporting the feature.
>>
>> Changes from v1:
>>   - Removed Maciej's patch 2. Instead, blacklist drives which are known
>>     to have a buggy FUA support.
>>
>> Damien Le Moal (3):
>>    ata: libata: cleanup fua handling
>>    ata: libata: blacklist FUA support for known buggy drives
>>    ata: libata: Enable fua support by default
>>
> 
> Thanks for the updated series.
> 
> In general (besides the small commit message thing that Sergey had
> already mentioned) it looks good to me, so:
> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Thanks. I need to do some more testing using some very old drives I found.
So far, no issues: detection works, some drives have FUA, other not. For
the ones that have FUA, I am running fstests (ext4 and xfs) to check for
weird behavior with REQ_FUA writes. Once I complete all tests I will queue
this.

> 
> Thanks,
> Maciej
> 

-- 
Damien Le Moal
Western Digital Research

