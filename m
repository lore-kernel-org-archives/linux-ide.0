Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C12C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Feb 2022 00:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiBWAnq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Feb 2022 19:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiBWAnq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2022 19:43:46 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057571EC53
        for <linux-ide@vger.kernel.org>; Tue, 22 Feb 2022 16:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645576999; x=1677112999;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=frd5ZN6JOh8vQwzCCJoDYIr0rwfDn25vMteSLlage8A=;
  b=rHYbOAFuuAbnllWazK3ZjfBYUuI4tsO218NV6F39qvamUStweDXOINQf
   wxYTE7DSYCs4CEomgZJLGfhp7X2e6Q8qHc6N9IC8QpYMEU2k2HknNAWAH
   oB/oGfGmJ5ZfDmLXu1MBJ2L+673n8rWF1AMB362C1detfq/IDm33DeeOU
   U6z+SA7rr6I+fIxik07dua5/Q+veXMQ8Pzxx1Uju4ijaH0UeoK0sCarwW
   IJ6ehJJSb18Pw4GbYaugl6YNeYLEUvfB6jtR8MIlOEh1CQYW4gFHyzKOY
   z9jaRuvgv7IRtbuJjfFO1b3Y9dpcxtkpzoKnSOKLApz3pXWmiZ0RHafrF
   g==;
X-IronPort-AV: E=Sophos;i="5.88,389,1635177600"; 
   d="scan'208";a="198543361"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2022 08:43:18 +0800
IronPort-SDR: oHlNQ6GXux2+8GJoejkQ7jANVD2GTC/59CaiEhQ33tWeRrcv7oIb+qf/HnUcmppo/zdL5hrbyk
 cqlvW2I6DNPVNV+4a3/g/HRHlYzQjYobwWRNdIKCSrKaoJVcx3Xvod59s8oVTVFmMueE/9x+9i
 BgQ5GtNqKeAM7iZ/4w94lLPuYJimc5KgXILYZ2nHJIr5dTU5AVRSfoW4K6CBLqRcn8Kgcc9KL4
 qQZwShaIyFdkkag6IZaUuQQgyG/2yjSD5Y8ZHHheK38vUTQqQIwtstUpAl2vJGooVbhPQUE8E7
 duk7rTt/5BWTOGUoDBPms7Pe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:14:51 -0800
IronPort-SDR: Oxcc5yQIQfVymoaoKYWse9u1yT+VCxOEzufzDEJpQloWbx0xeko5cfNcdKYXMZe8EwUi1GrAm0
 Cxo2YkeV+GsxCYtw3Yk/rVX1o4TP/rYWeyUIYJd121y/bpBsA4jKHos2a5mJbKbhiepO1FTIgu
 3sg6TburwyaZblWP5M8JYW0Wb3VEkg7Xa77ITHJq4ByEbeCPiLYvDswpXWBzR5//AMyg/08J1y
 i4AgUU8hYXtDToyXqeIyLkPZiT5uNpdTYOpy4DRZ9m/YiatpVlPg7Vsia/Q6HjaPyj81m6u+4Z
 HgE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:43:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K3HMW0yyHz1SHwl
        for <linux-ide@vger.kernel.org>; Tue, 22 Feb 2022 16:43:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645576998; x=1648168999; bh=frd5ZN6JOh8vQwzCCJoDYIr0rwfDn25vMte
        SLlage8A=; b=LkR3urTX0eWMz6rLtJmJDCWH/JBnkReDObMaJdtNeXq15yGRCJs
        uXQEXGF+2HaSi17EiiuJenec71fAwhuoZzlvCSBl2NRH4eD1slK7UDGb1o3qyCR6
        0OyGYg+pzd9gj29oPoUkksZnqe5rGNvWWKRazTqJhpy1J8rBW3oUZWCj7ZPvttiv
        hUSg9R0+kANZmztdv29tMlDaIWQXGlgxNMz3IUagOfFVYE3Z3dSE9/C+TdFVUb93
        fdLNRxOuYNUvRKZj72CAYzjEtbgve819OyTVkRIMWQDIX6/LYuZoc4mCf+SDrYY5
        cN8WnoKyEOyFGAOIf0r4hue9ZOq7kvuj0BQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nWwK_3kwPxCu for <linux-ide@vger.kernel.org>;
        Tue, 22 Feb 2022 16:43:18 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K3HMV26Hjz1Rvlx;
        Tue, 22 Feb 2022 16:43:18 -0800 (PST)
Message-ID: <02e567df-6670-f9d9-f186-f027369784d0@opensource.wdc.com>
Date:   Wed, 23 Feb 2022 09:43:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_hpt37x: disable primary channel on HPT371
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <e398d6e3-05f2-409f-6818-812f24e325eb@omp.ru>
 <feb0d6ba-baa2-6482-e6b4-eb5baed2a728@opensource.wdc.com>
 <6604b1f6-adcf-96f6-f736-4ade3642f6f7@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <6604b1f6-adcf-96f6-f736-4ade3642f6f7@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/22/22 18:48, Sergey Shtylyov wrote:
> On 2/22/22 3:37 AM, Damien Le Moal wrote:
> 
>>> HPT371 chips physically have only one channel, the secondary one, however
>>> the primary channel registers do exist!  Thus we have to manually disable
>>> the non-existing channel (if the BIOS hasn't done this already).  Alan Cox
>>> has only added such code to the 'pata_hpt3x2n' driver, forgetting about
>>> this one... :-/
>>
>> No need to assign blame by name :) Something more neutral like:
>>
>> "Similarly to the pata_hpt3x2n driver, always disable the primary channel."
> 
>    Should I now repost?
> 
>> will do. Also, do you have a fixes tag for this one ? Is it again:
>>
>> Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")> ?
> 
>    Yes.

Applied to for-5.17-fixes with the commit message fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research
