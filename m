Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD9C4332F
	for <linux-ide@archiver.kernel.org>; Fri,  9 Dec 2022 09:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiLIJob (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLIJoa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Dec 2022 04:44:30 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813845E9FE
        for <linux-ide@vger.kernel.org>; Fri,  9 Dec 2022 01:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670579069; x=1702115069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iWMbRk0BW+gI39YjgSWP4kWkKRgW+ZTVj4kYYCYlNA4=;
  b=rc8K9fUtZfYZzXx/e8PhgMt+9wmUZ9lZl+UU9LzFAIcJurlS3+yBRi6o
   dKSCYj0hUHokraJpIro+mWg6Zxk8bjMVXW2AhJycloodGg5d9OR6NvvyC
   zy6AropjHWN89ZUNZdHcbqO+28aB7y87XhCtrW1KDXeFwrjmLAurCUaAm
   0GUWTWfPQ9gJsKkycD4C8TaDmeNX1wjBUZdmgp8V7Gq0IXoLLVnv8mVy4
   ontGN88UgrWtWLGogGSFn9ZEYptU6F+6GXwFkox0g2x79Ogvv8NpyfxCW
   AsVlURPHIvDFsff6+UMmUiMPtNTPIOMcF+EwSrZCtbPniiP7WoUpeFDI4
   w==;
X-IronPort-AV: E=Sophos;i="5.96,230,1665417600"; 
   d="scan'208";a="216479356"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 17:44:28 +0800
IronPort-SDR: +RXOD5Oad/nGaDVQo4aUk48tHlKZ/4y19o/2VwwytizfeoGY8tAovXMGTn1MDMsKsq24DIdFoh
 +zzksIB3VA2Yy2NtCt7uyhOgDwX9/XUqQSXKBLthJH89mC956EFiD9NxYeJO87IXLVQLh8tdMZ
 8hUOtIeZVOj28n3RrKpAhnz3/O+ovSeTgi5j3HsPZ8UwLKZic58L2q4RXid64zvK3R9iuyeqM4
 ZIjQ4TUnvV64b4FH9dq8Y2d7kXiRw5K+U7UXwXnUmtsi3o3Kh+LyMLbrRdgyWjAvSQGjSPOEnR
 v10=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2022 00:57:12 -0800
IronPort-SDR: hum2xNChgX2tSpiJct1jJy9bsBk5dH8TDfjpEAwxcHjRiVhUV0FdmmWo03q9yR7LiofuaaupME
 Boui5FXAhTjZCJDH8p/qHWGoWfrU4+rijudJM5g+HOE8BDnAjwFPQBnwIkVM6Ax/m0mfvn4kbU
 UQvmqE9BMa6DS/SJVUOPnKNYvVz4W1lwNQvoySjymVNACB26b8Tej2391pawbwj0j9AsUbjVed
 tBy5XEokrcwUqigzrPdtGhfnax02L75vRe7jq8zqK6v7b5fUn6AttsJ8ZPOSh7tryGuDHRFbEB
 I6w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2022 01:44:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NT5hX5b9Wz1RvTr
        for <linux-ide@vger.kernel.org>; Fri,  9 Dec 2022 01:44:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670579068; x=1673171069; bh=iWMbRk0BW+gI39YjgSWP4kWkKRgW+ZTVj4k
        YYCYlNA4=; b=WMq0D5n3HGukDxEp86pw+pugJTRrZG7maiCO0RZT0MoasR/AQO/
        otuf6FAS394ujSBKwRWkvyRJLGHcqV8uLPBoOLGnidwjSQkx3eDYiKA46i663jUB
        WdiiOrnP+IxFoUa4SQIoXil6P3HfJs9XpqQ1F1isVjglY0MY/2hW3Da/m/og5O6k
        8K4qo+ff0LfWp+8aEk+MlxZ3YEMPjYC0xS1RlnRK900X6G8+zBOqFioTDrc+vMZ0
        slO6TIAHSS3htprAZQJCceGUnUdMm0kKIf2GrjEgBY1UAya30KiOIHHLJ5VaCDLg
        tNYnAI6HVym7BZsZSqih0rEd5/96OHVka+A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E3GG4eY5i369 for <linux-ide@vger.kernel.org>;
        Fri,  9 Dec 2022 01:44:28 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NT5hX0ZzDz1RvLy;
        Fri,  9 Dec 2022 01:44:27 -0800 (PST)
Message-ID: <de0b3cb0-7fdf-45dc-e930-ec83328545a7@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 18:44:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] libata/ahci: Fix PCS quirk application for suspend
Content-Language: en-US
To:     Adam Vodopjan <grozzly@protonmail.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <OM8HSmyIGyT2XF-f70AR7JA5kLpuIYEu5mYEIpyUT-4CC-u7ezc6po32ZIGOSN_7PlsF0RhOvUs8HpVJiAHGrh2ytgiBEltBpz0MuKiy-vg=@protonmail.com>
 <2911ead1-c458-30f7-47a8-5cce343ddff6@opensource.wdc.com>
 <bzhQ9jwYSZq-dhfZRPhFi7RmdFRG1Fry0N0LBmvm0GLhDM_kl96AU3-XvVKaDYhPw-b4P2H_6AcYj5cQlB2IuzBqaz-F7bVyJvrxiG6tKws=@protonmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bzhQ9jwYSZq-dhfZRPhFi7RmdFRG1Fry0N0LBmvm0GLhDM_kl96AU3-XvVKaDYhPw-b4P2H_6AcYj5cQlB2IuzBqaz-F7bVyJvrxiG6tKws=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/22 18:35, Adam Vodopjan wrote:
>> Looks good now. I will queue this up for 6.2 and add cc: stable. 
>> Thanks.
> 
> Thanks for your reviews. Mby it is important to remind: branch 4.19.y
> is affected as well. Older lts branches are OK.

All LTS kernels containing the patch you identified with the "Fixes" tag
will get this patch. c312ef176399 is only in 5.4 and up if I am not
mistaken. So the patch you sent probably does not apply as-is (I have not
tried though). It will need backporting to 4.19. You will eventually get a
notification about this.

The patch needs

Cc: stable@vger.kernel.org # v4.19+

after the Fixes tag. I will add that.

-- 
Damien Le Moal
Western Digital Research

