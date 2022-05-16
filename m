Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36804C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 16 May 2022 11:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiEPLYr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 16 May 2022 07:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243147AbiEPLYp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 16 May 2022 07:24:45 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1211B387BD
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2022 04:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652700282; x=1684236282;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=FTlt+tA65l8s4jEvN+gXqV8wgn/CcuPmRQfp68j+TAA=;
  b=W3kZwHRO0MIMoQwiBNxZrIw3VJ59m+21lcPlxECbPKFQ2EZxyurtTUF1
   YRykysci+bPVyaSR5Qawyz/PwZOwXD8kN0dv1J+67En80ZDNy841NIkG8
   oScT2sbwSRYRSTrOVkWHfZMbBW9GBsaoT/2awerPPKVD47s2lqwNmeVj9
   vFAgxa+QtlJ5loNETPF2Gu+dSMWF9H+HkKxZJQ0ODF0mxTUeoucXzlcS4
   R3FlzH9pIbQ3OpciNahpWxLChtPnc1I3n40WGSr4H0w48qUk0Fhft3t4T
   6RrOkzNTPTLZ/f2zbDRpaltNaG4GCl0+oHq9xDpTz43bt4nLtGZKHj8GA
   A==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647273600"; 
   d="scan'208";a="201289134"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 19:24:41 +0800
IronPort-SDR: pu96qgoLu/BMy3accpMXs/8sjHhQvITI32FCX8fWTMGeytyZVQqLVx5OEUpsw99ru3krgXStvO
 qCyl93PV150wi/J8Qc3AefPfGfiOhs2vbeC97n8BmfpIDSSGUSmo6ANKMLmn2HPL3c8Bd47eBF
 3z4KNG3y2ZsS/JCenlLE5T9D7mU0IV3bvldtMzvpHonrQN6KwyN3I9Rg5sNBs9XnuumiY+7g53
 dF0XmuRBNOZHEHpKdNuRr3VgPqvqCjisPfquCpCAJeugwLrPA/BVKTFJTGNcs5jlB8xZrkxWZd
 LCR7It2iiMndctaA8/dp8EIm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 03:48:33 -0700
IronPort-SDR: p25P77UYHbvHc5hHZFtZyupVq5dkjLJIfFsc2NJ8HjMbQRVw+k/Gfw/4pugYr78waeXkK4X5I3
 O7ViKSraM2T6Wd6av1OYUPy6LCsQxh0CKHSbjFC4VkvcnD8fH8jHTd2oY9p43zdoWs8wjASVsc
 1jQ9yFLfZNRKkfAKFoBUh5Q8S/FYHrQJ7tcarhZEkCe/u63F3VYGtZBpJOYfb4rpX3d6gE8iU9
 QhyhN0WyADLOxp0koQw6rDHkft5i7RXu1NogyiAgcydTBz7lmygQCvzIXTwcxxaShDmDpkdEfx
 RXo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 04:24:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L1xjh2JXCz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2022 04:24:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652700280; x=1655292281; bh=FTlt+tA65l8s4jEvN+gXqV8wgn/CcuPmRQf
        p68j+TAA=; b=U8nw9XY81JpPfiV9fv6jhbGGpyLsmUwttQ5vKrr7m+Gj8ybeoOL
        QqLygegM/+Z7ISJzmtUD5s2sH7HWP5cBab10SqSTXZtpTvr4IoJ+zfz2QBdj6MEC
        GgNQHw0KHrLqkXwunqFkKI4ogCeffbm8Piek5Dq5OACGQio71QwMd1mSO7MqVng5
        W9SnqaW9g7yGVP8iYUcFU6ukC+83bqGDzKYgi0bv14ErWnslrRuNwbj107LQxQMP
        HQMZPUub9Wo6Zh1H6a1oIxxEl4pSmoPDB5ZOURs5Tw4t9vf2LcmSAE3nfqzFfzOm
        1Mq0D3TLSP8YXVjBBWGzMHNMzSY5GwrjaRQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UyVyk0Y8Uiz3 for <linux-ide@vger.kernel.org>;
        Mon, 16 May 2022 04:24:40 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L1xjf6cjzz1Rvlc;
        Mon, 16 May 2022 04:24:38 -0700 (PDT)
Message-ID: <e2401700-c91e-6ad1-af56-c293662947e5@opensource.wdc.com>
Date:   Mon, 16 May 2022 13:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] ata: Remove unneeded ERROR check before
 clk_disable_unprepare
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220513075554.127677-1-wanjiabing@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220513075554.127677-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/05/13 9:55, Wan Jiabing wrote:
> ERROR check is already in clk_disable() and clk_unprepare() by using
> IS_ERR_OR_NULL. Remove unneeded ERROR check for ftide->pclk here.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Applied to for-5.19. Thanks !


-- 
Damien Le Moal
Western Digital Research
