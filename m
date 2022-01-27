Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA3AC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 23:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiA0XfW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 18:35:22 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19292 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiA0XfW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 18:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643326487; x=1674862487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lIn9F6tbU5dCL18U1bWkAMrNx14lJRwzgnQRoH+z5lM=;
  b=iGABwD9RwPgKgLUA67dK67x+UtGrOyL3IOb6JzxJ1rmozS2jeoVadnW5
   hal+N+b5eMlXo8LXYq05MWN3RaRuXwBtIJfTVTe+0cUUVJeX7Wpzto5Jc
   ZRlq/iM9OSz9ATZ5rQlUgAKdYmzfFvKjyqUyReTGmu1YC0sgVKL+mIzA/
   gVjEy7C/U5IWr5zCGGXoP5vSMJk9MUzAVEoTNx2C33S9sJftu14kNpZ5P
   ZIzz9tx9TBDJVpkkKXgIwEwYVdxG86Aqcxvh+69fBVFDcs/5kkyhm0ga5
   Jr0ivHv22rYltO3JDnShjfTudRR1nqsDz0WeTxa6KdTz+B+imJmHKV8lD
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,321,1635177600"; 
   d="scan'208";a="196377339"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 07:34:47 +0800
IronPort-SDR: m1cS/RjPhFfnfodsZroKbwa+Uq36nkOOr7tlQKNjI6dQOtz7TvkfnSrgv3FNWyT4DH8VqFl21H
 yKnI7WV4jvC1QD7YJ0VF+hs8fhku+xYns5cQMLSliWzzbHli3aviWGFX7QPdxhw9rL9H121Xgy
 d/ZSYVv6MbwOm5dozV3P5jJij1B5ftOyGhJovngLutfrX9U6D5Qcj7yUTANhfshRbE+UeUHMNR
 a4f7ZgJ3N0lJ6K2nz3Y5e1J6YiF19r51RdZmXW7+H0+z8y9v7uDUnX8l8tG9ktUD/XcuYNSz9l
 Mpuju2CpgkxlR7BJVtLCBc27
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 15:08:39 -0800
IronPort-SDR: YKuGt2X5Ia8ymHM9p4V3gRC3ca/AtFW9ndeNhcQDYXpkTkRBSWR2jqLZXruj27W73MzfrYKQ1v
 e45sKovzLrS73lO1wEyiLd2D673iz5XKwTEOM0gaTMkGeCHk8GW64XA1NGkhaLDx30lxHLzbEz
 DyqrpwuOOM4zbOGYccjlMNm6E5By9hkggQpzIOPsCh7rPcJw0/nV+IkyRna3DXtchRSuiKHJW0
 whlhdHbFvSncZU/51Bi550WbGn5qK/EL6Qg4qvzxQVIFESsQu54a0rp3lMUQIXestlmGO0IHGd
 mrY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 15:35:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JlH5513Mwz1SVnx
        for <linux-ide@vger.kernel.org>; Thu, 27 Jan 2022 15:35:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643326520; x=1645918521; bh=lIn9F6tbU5dCL18U1bWkAMrNx14lJRwzgnQ
        RoH+z5lM=; b=lPB+JmN9H2LqGIWiz6dWXQTL8sxMYqXJBysXCdxv63nlGPdk0tE
        Dbt2enVTwCnTltabzktzOlxRQbF4llCXvfctzgCtyWFuGF8H+C+w5fquGK8Q6+ti
        ONaNOCdjYO+NZqZjjOVhcDtmf21HjQWYJXYpI1ko7OmSFpTwQTmqTDCHdHLdOcoB
        VSlf5w9u61wY5c/OWsg92kUqGy6LOsNfl/64lzVt/qS+bEaHbp90lIy6LFj0YjTS
        K5D3/UElJkm4YAsgZgqTLlreahxcQczwe756V2NbzvpCQO8INpYYi1tel/VUDOWT
        OA8owGFPIU1qT6LowbHX3DVHMWhx4NAeQlQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7kwqvwOpq3Yf for <linux-ide@vger.kernel.org>;
        Thu, 27 Jan 2022 15:35:20 -0800 (PST)
Received: from [10.225.163.58] (unknown [10.225.163.58])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JlH532nmqz1RvlN;
        Thu, 27 Jan 2022 15:35:19 -0800 (PST)
Message-ID: <1f29cbb4-9887-d2e9-20a3-af1ae9c3c599@opensource.wdc.com>
Date:   Fri, 28 Jan 2022 08:35:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_platform: Make use of platform_get_mem_or_io()
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20220117020134.3279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220117020134.3279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/17/22 11:01, Lad Prabhakar wrote:
> Make use of platform_get_mem_or_io() to simplify the code.
> 
> While at it, drop use of unlikely() from pata_platform_probe()
> as it isn't a hotpath.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> Hi All,
> 
> This patch is part of series [1]. Just sending this lone patch
> for now.
> 
> [1] http://patchwork.ozlabs.org/project/linux-ide/list/?series=278349
> 
> Cheers,
> Prabhakar

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
