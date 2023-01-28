Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A9AC38142
	for <linux-ide@archiver.kernel.org>; Sat, 28 Jan 2023 00:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjA1Ayb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjA1Aya (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2023 19:54:30 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6083244
        for <linux-ide@vger.kernel.org>; Fri, 27 Jan 2023 16:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674867267; x=1706403267;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8HroFzcMUn53K8eqs6JLXQhk7cTtRl6khnafxvlvf58=;
  b=VxYkU4vDXDPIoItV0LdNzvoa2RgLFSThBs35YFVjrSgJQAvNuoA0cDFw
   XZnAKKBMz3i9jU1LMWfCxwzWfgGCEK8Nv4WkdVUvLvgqH0YfJw5zl2zH8
   9KXXWR9CvJddHEZmIoFtRGsTjewbWAhnfMYDX4UDlqVe1qyUemBuKHaKe
   kLxd1al4bTvP7uMczZnSRq+2NM97HtKFaJHlgR3m1LV9DQ2fGVFn1Klka
   5WPcExIcQjTGZiONFAq9tgJozuvAVeLI+/N4W0ePTfBTrN+xGD++VY5GA
   o3hAC+NZm1mOA8x/78R5De2XOYf5CYuOXdrdYRNKpXo3iquZu3g70XXoQ
   w==;
X-IronPort-AV: E=Sophos;i="5.97,252,1669046400"; 
   d="scan'208";a="221742366"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2023 08:54:18 +0800
IronPort-SDR: zul8ZT7QaYLvkDPw2gTkgyPDQ+bRZsRYgSsrg+e1yW5NZi7iHVi6D9NWmksdi/QXrrvRDL8NaH
 X4r8QG87pghJQinDoglhWVmBZ8RCbELK88scotmsRphtqz0zvrYeLbLmMCPlU6I8EEmTcHTMlm
 ZkVqleAPRjUP1Zor3LU2LMoGQziUV0Ve9QeXF5bUKUva0Yd7qnFnMJgvrk/XkibJxvlG60Kcns
 lj+kI8QtwWb4EfauXuzCpJ+1ulwqijgKEKH5Eyz1lG5gWY9VYiQLUQUeWZS6TqnUqfCkjVtJLY
 u5E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 16:06:02 -0800
IronPort-SDR: qS+5vUN0l2Q+PFxR5q6NMID1jM4KJNswYMSMMOFW4UZvJPI+xqYo66MvuC6O7H2LM5ecgq13wo
 JZfxm+nOQVh+tnUB2dBu4+iVybPTRQcuQJuQ2Uc+kE7zdRab/UoUnEgD4MBkGgaRpBmXnLK07B
 M4hyOm2KezvL+Zq3R9PufzOiAnRoJWXiOTrEIXBrW+Z810sFQUk87q58xx4SsNnX1TsVt1/Zzz
 f0h3Y2JPArUg7KymYEZTINXdhXmtl6Wy6AasQR+vnIlcMOZ8ydVPicLUOZoqqS4TUOHd+yFM6Y
 PmU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 16:54:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P3bYj5Z5Qz1RwtC
        for <linux-ide@vger.kernel.org>; Fri, 27 Jan 2023 16:54:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674867256; x=1677459257; bh=8HroFzcMUn53K8eqs6JLXQhk7cTtRl6khna
        fxvlvf58=; b=ShftbYmd37Un2N6WXeDLuDn368rIZ7rg0bPyrhOhRV4L+OujvBZ
        9t8qHFpVJ9RP9zP8FBgxqvyARvggZHlQecr5g6REKIL7iS/I5mp/zcILc1CJIDnK
        eNA5e0cb5clxhH30P9AwwNnBnpmc4eCQx23IrsUCGiFiYbpjuCzCe4nihmz/r/pb
        a40GgA7aEk2TxXGdKxBIf7R5q8nNV1GLcsTNR48eKphEVQZb3leRSAv96TRrs2Xi
        HvHLkNGrYeNxQEiJKcsmUXydBaOCiqhmUKI8Wog2rqzVCKrwuTaN1On12FtbYbv5
        aQqi/qfXflV+L3rvEVEDNsMiNU0bzwX0V8Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fu7qCH2Pfo7i for <linux-ide@vger.kernel.org>;
        Fri, 27 Jan 2023 16:54:16 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P3bYd1nCCz1RvLy;
        Fri, 27 Jan 2023 16:54:12 -0800 (PST)
Message-ID: <75aa04c9-e173-6a2d-6b38-d0e16f3800aa@opensource.wdc.com>
Date:   Sat, 28 Jan 2023 09:54:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] dt-bindings: reference MC peripheral properties in
 relevant devices
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org>
 <20230127093217.60818-3-krzysztof.kozlowski@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230127093217.60818-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/27/23 18:32, Krzysztof Kozlowski wrote:
> Several devices can be attached to memory controllers (or memory-mapped
> buses), thus they can come with additional controller-specific
> properties, e.g. devices wired under Intel IXP4XX bus: cfi-flash,
> intel,ixp4xx-compact-flash, NS8250 serial and MAX6369 watchdog.
> 
> Referencing Memory Controller or IXP4XX bus peripheral properties fixes
> few dtbs_check warnings like:
> 
>   intel-ixp42x-gateworks-gw2348.dtb: ide@1,0: Unevaluated properties are not allowed
>     ('intel,ixp4xx-eb-ahb-split-transfers', 'intel,ixp4xx-eb-byte-access', ... ' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

