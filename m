Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AABEC43334
	for <linux-ide@archiver.kernel.org>; Tue, 19 Jul 2022 11:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiGSLpo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 19 Jul 2022 07:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiGSLpn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jul 2022 07:45:43 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B79183B0
        for <linux-ide@vger.kernel.org>; Tue, 19 Jul 2022 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658231142; x=1689767142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HoB6mNAGD8qprJcACnGtFLQCTHjRhxeUO8i/3z716MM=;
  b=pQiXQlijCha9OfAXTfwQSczRQcU32WE6SXkC2lcLzXxnKzIIQCS5OdHR
   cJnRFTN5A84WJZq4lfV2THZ0IlZyw+9gvrNzbd+YYL/eWAcwrnAaRW6aB
   4kBhfAqMrjZr6qVKpxuQRXzo2iMnK9iW5vtrWL9rbL46wIvbTQWyvy7e2
   rEnv4Eo5X98WbBCmaXBUhn88Cf6dVO2u1eiD4qrqtPiCgdhYxbAMhs/69
   CNy/9uv29o3CwCL4TRWEpxrwvb/VxsC//0JP7YJ8DSnZxNY3BSI65FfoL
   rX+j1213nA7UlUoJBSebwwl6MNManpi3Jk1E06RTaYU4HFScg0q/BScBA
   w==;
X-IronPort-AV: E=Sophos;i="5.92,284,1650902400"; 
   d="scan'208";a="310657185"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 19:45:40 +0800
IronPort-SDR: 9FX6815yIb6pNZIB9qJ1ol++St100bRg1iw0B8tYw22lmYW5mXIGw9rFbkqXqAM4UlUS3MceJF
 ilHn6es/ab5p8gxXtiuumNlHAWTc9+KQQ05yb8GRa1LCo6NjoaYbjf1wEHXD8yowqDgOotiSE3
 9RLWCfPm+Gd/T1+WPM13uMGhoM0tmna5alu6Wm8OaFG6sHFtChlq2Ye43VcaM4ULAyPO0qDjWO
 2U6v5JqUfmQv257PSuQsKpXIqjc2pNZ5niAxcHPSD/gOxf7yfQi+t2UBqyRQSsemMvYM0K2JOy
 9i/c6Jzxjpl1AYY2FWwtcZ24
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 04:07:04 -0700
IronPort-SDR: 7u4r5fIEBO6R5WEBYuiXzLCYer8Eco24bVm1krOGe4FPcHEp7HQqSFyieD3f+DaFTZVLBKA8Lx
 tVwncU/Y5pPlrPpdEIzX/M2iZdo2IXaYBCCCuh5b4Y3cVetstYIGONRxAqt8BNVFPbpAQjXTcK
 qSay1jwSuNQsDqUN5M9VjMUzbzayP6V360igDualBDS507pPZe7S4zJJ6jASL3+XKb7UgRxeht
 PGAhw0o1oVpjiw1KTho29M0tFX6u2hpa6WBXWAQnttzKUARGTLbKE5owPaLWh9Dv04UKR5+mNI
 o0k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 04:45:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LnH8M4gk5z1Rwnm
        for <linux-ide@vger.kernel.org>; Tue, 19 Jul 2022 04:45:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658231139; x=1660823140; bh=HoB6mNAGD8qprJcACnGtFLQCTHjRhxeUO8i
        /3z716MM=; b=bI5x5AJX6ASzFR52bquaFd1g4HlLNDkT32aXjh+B8xLB4T+qrtk
        gTRUnCyUTs1LiiViBL8gcDXT0iz/hVHOqGoER9t4rDE0JcSXAMCgJ1sWwcDzaWaz
        Es7kcmfWWXS/wUYBWOJmA9FeXQQhyA0Hv02zUFBf0aV5qsRWGfQQ2hktV43yaqGO
        b9FEw4jJhChG+2qCPX7hI3f/WNTtGFcxIpsb1fGYW+BmgfVL+DwXSqY3ZAu7okeg
        Q/dgGSTMAug8IVoxiF3Z9j4YlmzSl9pfFwXIM6I3cqGGjE27MJflJtcptRdOvYRw
        /xYSWY93gPea66g8if+8zZ1OjI8hXkFPsIw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fHcskA1WV7Rk for <linux-ide@vger.kernel.org>;
        Tue, 19 Jul 2022 04:45:39 -0700 (PDT)
Received: from [10.225.163.120] (unknown [10.225.163.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LnH8L4MyNz1RtVk;
        Tue, 19 Jul 2022 04:45:38 -0700 (PDT)
Message-ID: <1ac89860-957f-a24d-82ee-d40e5345d04e@opensource.wdc.com>
Date:   Tue, 19 Jul 2022 20:45:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Date:do not initialise statics to 0
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220719112908.7333-1-gaoxin@cdjrlc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220719112908.7333-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/19/22 20:29, Xin Gao wrote:
> do not initialise statics to 0
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  drivers/ata/pata_artop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index 20a8f31a3f57..1aad8df2ea87 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -37,7 +37,7 @@
>   *	test stuff.
>   */
>  
> -static int clock = 0;
> +static int clock;
>  
>  /**
>   *	artop62x0_pre_reset	-	probe begin

Very weird patch title.

Is this solving any static analyzer or compiler warning ? If not, this is
not a very useful change.

-- 
Damien Le Moal
Western Digital Research
