Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8BAC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 18 Jan 2022 00:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiARAGr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Jan 2022 19:06:47 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3600 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiARAGr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jan 2022 19:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642464407; x=1674000407;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G9/XuH0BsRgbsASlaOEFXg0OoA0Dsa5hv3WV3skZWWY=;
  b=DU2IV0KJ5OfFcrtvQqd0i3SamTeCDJIq7LhimHEZhyIynjhFIpPKsCIq
   tQJMK1t+xsGM/U5HlgeJ/qrrYWU0t5lBxlubD9a7Rg5kn/6ZScMJwxwQR
   FN6vMz8GB65hNC6kRhdB6XLtN7lEIYVDfURSqIz0mVSvVfoT0zGfCNfKM
   tHYL3IlQEYe3Eec/d373523jvLoDTsMoMcTUz8cry8vxD0V2ZvS+cYPxa
   90V2xyZwY4SsXPsiCLJCzfh8e836VZ/VYTD12DS0/X0ddo4c1VnFDwaIa
   ++wmUc0KJ2W4rpycBOXQkAp8Xed/PBncTgV+nVRMWJg/10xeHP7vtbuS7
   w==;
X-IronPort-AV: E=Sophos;i="5.88,296,1635177600"; 
   d="scan'208";a="189650342"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2022 08:06:46 +0800
IronPort-SDR: xP3k8RaalTbpf3w7Ey0GQtuEEQLdrd9kW6QuRNl/Kk+ZsvPfx9q0nBLY1+22toH6SrBiojMfou
 hjoJvajZ6UdBH4ed3c5rnJMzzOjGoaBh/4IHGjypbvKEIc/8EaVwh1PgnCxy8tVu145pXbBP/B
 j/Hlx0oWQ0BJRT5qQ6F5TLftUAJazXBeeSply64EVayBQdII0//HASnZu34Ne2oOp9J/BJy+yE
 Vtb7rJU0dmPhkMKrkMDSguH5tYtyhSwRnIo5zrt88TaneVPw3BuIvgozZ0p7fo8FCjEIiJixMJ
 PvjJCBKRCRJqCFCgsnqTVai8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:39:01 -0800
IronPort-SDR: DUPAvLApNV5G7c2brrk9Z+f4cqz8NM4Fnqx9ZJH3mAivizqn7wmNHjIBqhfeTTTRTH1uTZTAbD
 xF2Q0UCwDrRxtJRxYWo15ZtPdlKdKzvKxzla59+O8Gl7lpzWT1ogrS30DsTuuNvSWuwzEucA4f
 OeSs7zDFOXECtNeikZGdICJL7LSKn0j2fxzyFgaUoBMXB3S+kKykSeNyV3hD+5nHbpoUFcO3EK
 PIm1ptp+56n1X5fl5xNyD5iJ4edCwzl1YW9L+HLh9Q8Lxj/Tp/KpIJP7Keqe4I1pHAMfbYEWtx
 b1M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 16:06:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jd8Fy1v6zz1SVnx
        for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2022 16:06:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642464406; x=1645056407; bh=G9/XuH0BsRgbsASlaOEFXg0OoA0Dsa5hv3W
        V3skZWWY=; b=h90WKvawEtVigYEhFxXRXXXACqXbIq1osymf3LZFXUUJNV6Mayl
        aGFbDGN9gMXeNXPysqQRgTrONhCI21hXu1G0pCGT64AQHOD4RSZoZqdeFS+UlrD9
        HSerq3lTv9UZLB+UoRCq8X9ww05AX2wRD6wNM3OVRyp1x1Kl5CVm3nGK8+CzgqlN
        9S3pB64V5HbdjbzJ15PG2wEvlUwqSS/6Xkm4fAD3v9CLXHOyFJpHEiWRAArf8nGb
        5iwnsrLGlFZkhSi/qNX2i5yd6Y/7eEjvTrYpWJ0g1WkIaY1QDq9/MmNi3qG6Wk0k
        B7fnRVKGW63p2YuWCOVWbF0mKfiMHlP7ZJA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TMGV8evqwYS4 for <linux-ide@vger.kernel.org>;
        Mon, 17 Jan 2022 16:06:46 -0800 (PST)
Received: from [10.225.163.49] (unknown [10.225.163.49])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jd8Fx4KR8z1Rwrw;
        Mon, 17 Jan 2022 16:06:45 -0800 (PST)
Message-ID: <9ae727e1-e4b1-c4ea-dbb5-5d0fff2f3c5d@opensource.wdc.com>
Date:   Tue, 18 Jan 2022 09:06:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL] ata changes for 5.17-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ide@vger.kernel.org
References: <20220114065906.622181-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wggW9TzY90pB-1Rfpqm0erxbKO++BR7AOMh_E7_o7cdwA@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHk-=wggW9TzY90pB-1Rfpqm0erxbKO++BR7AOMh_E7_o7cdwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/14/22 22:54, Linus Torvalds wrote:
> On Fri, Jan 14, 2022 at 7:59 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> ATA changes for 5.17-rc1
> 
> A number of these commits are not in linux-next. Why?
> 
> It looks like you have rebased things very recently (and looks like
> you did it a week ago too). Or maybe some patch-queue system, or
> whatever. Why? If it hasn't been in linux-next, you should explain
> what's up.
> 
> As it is, I'm traveling, and I'm just throwing this away because I
> don't want things that haven't seen the build testing that linux-next
> does, since on my laptop I cannot do as much build testing as I
> normally do.
> 
>                     Linus

Hi Linus,

Any more concerns about this pull request ? Is there anything I need to
do to get it merged ?

All patches are in linux-next and I did not get any build-bot complaints.

Thanks.

-- 
Damien Le Moal
Western Digital Research
