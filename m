Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46454C63797
	for <linux-ide@archiver.kernel.org>; Tue, 31 Jan 2023 02:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjAaCFm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 21:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAaCFl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 21:05:41 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5001C582
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 18:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675130741; x=1706666741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AcsiuLuDwWfVsTzWwmYa8LChhoDmQwERu0vhn8YNug0=;
  b=ckfJkv/OI0DvVfpRmt5iLvNZEwpPXxVj69ceCdUXZ5dCOJlk/Gaf5wMg
   JilAid6beAVWi76jHGoj9NFL+wNE4WOG/DT2rZAdg+U9Yxd2C1TUPsb5o
   Mtd17C7YV/I/UewxtoQNwbisw0GofI+V74Gdf/F9E599ZROe7b3Xez/o8
   KH3ByduaAUgNzG3SrEd4/TZyK4qEu8INrPkuk8FzZoYGA6/e01e1z/gjZ
   9C9MPuR7M0T9ApsYVHQxQxEu9MvKKdqGPJBT9DB2eAVXRrAKWIdVrM6qE
   RWJFzIWxPZuDONeiatgRLGc/0e62fb9otPmYoFCcf16V85xWbVO0NYnR0
   w==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="334094201"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 10:05:39 +0800
IronPort-SDR: FQyNdhocHlQB2QGE94V4lJTvJIRBll5SeS8XCUNPwbXeEyCOBcgMYryfL1KMaiUtLgc1LnSz4e
 5DUiGB58b3IvwLOXDaFaD2VJ2WOw2V7WxGok4JzCY63UMnsqVJYcLx/aGVf3RAenjeIDNDR/Ip
 38gSREubSHCOU2BKY/4J5S97aHQ2LAP0RvNZE75rO+zZIUNIXkr1+IF3Hnl6Yy9uHLiQ6+JrP+
 hytDTlXqNCL5iKac20aBIqbABgOMgu+Iw0ha11LYc4c40bPyjNP230LR+1FVccsLWn2ZTzE5G+
 scI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 17:17:20 -0800
IronPort-SDR: J30pJEnR/BtkytNtRsV/y8wNM8q68Ieu8crtIek05qMHAuK/r0Ay+830UPWxNbc3eVLlhOtRqe
 6W0MzgssslQ52nkROB/C93X7/oX86F7ms3EzctEXuZyhuM40gfkSXpDG0d5N5rVYwMhRlHw7Jh
 2aMjwP5tMcnMifuHEmS6iaTQWWHly3QVOCTmWl/CaWnrd5SB5z+UQM0HrRFBapwId/gw6RV6i0
 K5KE0mJG/gls4q9boHsVpKv6ESNUzVP1DuzJkWL3lvEr3k3pnGfgvZdK5V9bX8K0btikwcvhFr
 658=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 18:05:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5T0g2qWLz1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 18:05:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675130738; x=1677722739; bh=AcsiuLuDwWfVsTzWwmYa8LChhoDmQwERu0v
        hn8YNug0=; b=If7in8ACFpGd9feMG2WQjqjiESkIbI/SSsPJRd0A/fqdyxaPLLO
        EIxXz42KfGgFXxlNtGWxobMWwIx3Ni5oYuYwu7RN2HtB4O4ljNyxJNwXkB5+tV7k
        NEzMfXo2NsMs+OpIbM7l5jcczl1eRMXYCTqqgCwbN/7lbtUeKYf/3taHuZzV4Xqp
        /yPBdjIVEqp5Ho/eckNcS9LedHOrNigrM1Oh93W9pQyaFlwNP/N83Ss6tzsEgaeY
        +egN+bJGJSuAinpgS1jThyxyYxRs3/6c8tU9+qOytZie+44COimoUgdD3sdTccN8
        QvaKLMoxgwPZZE/5mPNdaNMsfPoC0t9U4fg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S3Ma1xgY6jlN for <linux-ide@vger.kernel.org>;
        Mon, 30 Jan 2023 18:05:38 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5T0d0H6Dz1RvLy;
        Mon, 30 Jan 2023 18:05:36 -0800 (PST)
Message-ID: <e6041145-7336-2534-8449-7b9b6a842466@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 11:05:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] drivers/block: Move PARIDE protocol modules to
 drivers/ata/pata_parport
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
 <20230130211050.16753-1-linux@zary.sk> <20230130211050.16753-2-linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230130211050.16753-2-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/31/23 06:10, Ondrej Zary wrote:
> diff --git a/drivers/Makefile b/drivers/Makefile
> index f1365608bc8c..de8aa561c95c 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -98,7 +98,7 @@ obj-$(CONFIG_DIO)		+= dio/
>  obj-$(CONFIG_SBUS)		+= sbus/
>  obj-$(CONFIG_ZORRO)		+= zorro/
>  obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
> -obj-y		 		+= block/paride/
> +obj-$(CONFIG_PATA_PARPORT)	+= ata/pata_parport/

It would be better to have this in drivers/ata/Makefile, not here, so that doing
something like:

make -j64 M=drivers/ata W=1
or
make -j64 M=drivers/ata C=1

actually also checks the parport protocol modules too.

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 23588738cff0..2f85812e16ef 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_PATA_SAMSUNG_CF)       += pata_samsung_cf.o

 obj-$(CONFIG_PATA_PXA)         += pata_pxa.o

+obj-$(CONFIG_PATA_PARPORT)     += pata_parport/
 obj-$(CONFIG_PATA_PARPORT)     += pata_parport.o

And then we could also have drivers/ata/pata_parport.c moved under
drivers/ata/pata_parport/ to tidy things up.

If you agree, I can fix that up, that is easy to do.

-- 
Damien Le Moal
Western Digital Research

