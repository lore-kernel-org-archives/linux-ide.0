Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5330BC433EF
	for <linux-ide@archiver.kernel.org>; Sun,  9 Jan 2022 08:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiAIIxo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 9 Jan 2022 03:53:44 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59075 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiAIIxo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 9 Jan 2022 03:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641718422; x=1673254422;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GSiH/twDmxaano1xqPfNIZ4td3CwYd/sSEPnGPMt4A4=;
  b=EBNb0UiOh0mqzbHh4N3ueu4nN76Ahz5FDMwTlM6oqSIraYTm/mXBbzuz
   jDUziEVJhSU/5nMgc0Mx82XA6IidVqxON7AZYthvrDabjjUnyV15Dvuy/
   huDykdqAN5bx4AhOu8gYOD5XrWibuWXPruMWVp+OBnvbeL3mvlUcni4K/
   EByk0OXmB7fKq3xRq47t02XQHWXKOX9jQnKGtjRKLy3lWrMk5UMl60zcn
   iK1s1EsLtT6rsnm0+4M/fd/rNbd68LXqVyE0RmlKLjihC7vx+fBR4zE46
   Wbteiw5WABr49V208YqzAoDzIwIgRUE4p8R+DEFR9X5y/6kPQtY8ZLeK9
   w==;
X-IronPort-AV: E=Sophos;i="5.88,274,1635177600"; 
   d="scan'208";a="190030267"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2022 16:53:42 +0800
IronPort-SDR: mrmlaQ+MFBKLixnU8aQ0Cgg0Yuw9J2A0o6/wEjlocA5fo5tz2GPOhEYeeaYyz577cIQHfKqI3m
 4ev8BMC7yMixbAQuue+OYJJ/WRGJCV0aXzErA0Dzl5ZzuAi/fa2ErT5RLE1BOQ090fmLGtMcM4
 Jx2PytS6yuKAeDadzoVinHqzuAKqVyvHrgNWWSWksJjN4mM2uxeTmps5PFYQ61RhbX1r2eBJgf
 vI9ho0yvvt/dnYyfbzOuvZ9kFcVwGFwn60lMs/NIN/lhKKAKsdAChzV/mPIdl1RfjxXchA2og8
 3hUDPRBS7ikFw5D/Jz0iPvY1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 00:26:08 -0800
IronPort-SDR: KoW2cWFhcHXuTWuce5QXCJs79/qWdfVnoKz/gC+Y7RjLO/EV4XeZ5CbCsqXg4H8FC3acubzpyZ
 1UjKXMrjon7dUzDaW0afDgTEMQ6YAFS5ZzycelBtxmNzKhWqMdde+sUWrV5WqmorBdCH3I9+0x
 GC5rVo6PodWwCrUeN3BYJtid13XFzBagl289+c0GMHNqUwU1N6oMbb1FTHEq6GN/FALTO61TeY
 iYGQOXFoxl8S4+heUzeFwI3SyOxa15QNKPfeZG2A7uhq6otu0sWBBh/Jj0x7MTQgZFuQ/p0gT3
 3tA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 00:53:44 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JWrN71Czmz1VSkg
        for <linux-ide@vger.kernel.org>; Sun,  9 Jan 2022 00:53:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641718422; x=1644310423; bh=GSiH/twDmxaano1xqPfNIZ4td3CwYd/sSEP
        nGPMt4A4=; b=q7FS87BLwWn4Sz5+cdMOazcLw6xn+l6YYe58Ojv4MKsu+g8PgYD
        oWL43OBZMeJT6TnmS9kYbJppVJxWr0weeRJP9lp9i5y/8de3TBJJsSHgJBilM25H
        tOfB6e/JQ4B0NDWkR419pux6puaasZPcXhvxdewhTkJcCnykATcqXgYXY6MI5Dbm
        iomjSOn2zFZg7f3UVGgSzS5WqPjuUMNnMJpablazHtLWSRaV9b10pubKKfOWFXqe
        BuWMEiWDXNIpzqEjiWZLHtYQKqoxm3zzVi0gDrneJFQQfX6FTp9zBj8wGaVUnyEe
        z2ISTyk2l69GNoy98zqZZLd5GWi/msSPq4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RTuH-RWA2-sm for <linux-ide@vger.kernel.org>;
        Sun,  9 Jan 2022 00:53:42 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JWrN53zGpz1VSkW;
        Sun,  9 Jan 2022 00:53:41 -0800 (PST)
Message-ID: <11d2e187-03eb-9a66-56ad-337fb5996b7b@opensource.wdc.com>
Date:   Sun, 9 Jan 2022 17:53:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3] ide: Check for null pointer after calling devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, David.Laight@ACULAB.COM,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220108035552.4081511-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220108035552.4081511-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/01/08 12:55, Jiasheng Jiang wrote:
> On Sat, Jan 08, 2022 at 10:53:42PM +0800, Damien Le Moal wrote:
>>> Cc: stable@vger.kernel.org#5.10
>>
>> Please keep the space before the #
>>
>> Cc: stable@vger.kernel.org #5.10
> 
> Actually, I added the space before, but the when I use the tool
> 'scripts/checkpatch.pl' to check my format, it told me a warning
> that it should not have space.
> 
> The warning is as follow:
> WARNING: email address 'stable@vger.kernel.org #5.10' might be
> better as 'stable@vger.kernel.org#5.10'
> 
> So I have no idea what is correct.
> Is the tool outdated?
> If so, I will correct my cc and please update the tool.
> 
>> As commented before, what exactly was corrected ? That is what needs to be
>> mentioned here. In any case, I fail to see what code change you added between v2
>> and v3. The code changes are identical in the 2 versions.
> 
> Thanks, I will make the changelog more clear.
> In fact, in the v2 I was careless to write '!!alt_base'.
> So I removed the redundant '!' in v3.
> 
> Please tell me the right cc format, and then I will submit a new v3,
> without the problems above.

Cc: stable@vger.kernel.org # 5.10

Should work.

> 
> Sincerely thanks,
> Jiang
> 


-- 
Damien Le Moal
Western Digital Research
