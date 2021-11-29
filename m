Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E33C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 29 Nov 2021 07:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbhK2HtN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 29 Nov 2021 02:49:13 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41236 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbhK2HrN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 29 Nov 2021 02:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638171835; x=1669707835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eyoVespazCZvZmlf/odluAdZQbL7d8hO0W+4W0XSC50=;
  b=BrMzlvmDMZqNaa/lopt9fiwiANjilqCPc/tGSjVUb14EmJwHZ9j9y1tV
   nLPPyRSDYINqjCMLFNlTI1WN4YyE5LhLTBYIDKx3MeQ3ILcg/74ch2Lm4
   POsriSR5rHeoXlDDDB0VCuvnFN0YXjIwj6zQW4q8WvKMaamZ/tzJkBwE4
   JMDwur+zJoGdqO5olOJ2OObjS9Ciy9NZH1wutHpABurfXc/5kttmE8Xaz
   +7zDe+dcUJiS3s4r7uYlBPiUbFGEVXju8tDPablNztAMNO8HbDtsFzrzO
   GmRMTKwMaVWNjtRjyFy6Q8HGnv36bcxK+tJspItjHmnAoSYEZn1iPl7MW
   g==;
X-IronPort-AV: E=Sophos;i="5.87,272,1631548800"; 
   d="scan'208";a="186940098"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 15:43:55 +0800
IronPort-SDR: jgAgxD0G1qO+Zf/JUt9xartsDCQtYJgQjsUveDkaiqsjK3tmt8fturUq8Fyzaq0KgzfPYaOgPM
 ZmuNX+jCcJxuyRd8s6EJnt+uk8vsi4CqI/xy/DY5VU0rpJWV44g+v216d3E7VgdA6o33H+4ped
 zVSOIIseVl8JZMzxf5JSEmu/GO8j7K7LAmCImn6KjGojABPvf/Biz/oWCVclrQY5wqkMW8tymc
 T9ZSWQid0tnMJ8wtG4KZAf9VwEsFQIp3zEcD2IJuWkZr3loibXv79uNVLS5E3DhrAU6+BhGhy0
 7c2HO5bvRclDUmFApzarINNg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 23:17:10 -0800
IronPort-SDR: KQLkyYya1V2vsBAwcIW0VX1q90hm1BVHk0PRhePveYPLyfGHmtiu7uVsdLbVYKCttqdqOLf23r
 XGdpn7Nx61CSIjXBnOCaPamXEqN7oOadBwPZSLjs5EFIbiC2yDUVBGsCtCF0Kd54gH4gY9Jrvd
 5nqQHSK7GYMryvZMvVyw6sIZGY+xsGTlnkyuoQebEs81BI/DDXYN62YY1hLXEGMNNfF+U3pumS
 6OxznovFe6unA2XaZuHSb6jNy8a2ynAuIzFpICn9PeprghoGHWqLVrPFcUZLjEuDbX9KDxznmR
 qWw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 23:43:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J2cmW4CNWz1RtVp
        for <linux-ide@vger.kernel.org>; Sun, 28 Nov 2021 23:43:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638171835; x=1640763836; bh=eyoVespazCZvZmlf/odluAdZQbL7d8hO0W+
        4W0XSC50=; b=ib83jI1poupuv4A0CqmzwrSfcEJRL6pBYLoPU8d/Bvj9r28WPYb
        roD5Zs2HvcElpXsn582+PF1nH5j53ijB9pZENGC8ILeG64AvLxLFMpi9Ryruzd6O
        06PpKNOmKyOwLjR9FxAg4VzJQzyPo/kZfl0zw8pn0NlGDFJbdjSA4Y3jdxTzIaSH
        8s1ZaaI42XkR8XChMD31mqeTSA6SCa0FwUwAISmxLZW7e/t88baPTTh8kAwtM+mv
        UusFA7MCSkbneL+E5EXXUz3tYnRTsT81mwE45boBTwjEvpbEI8poNgB2mJ1VooJL
        gQBjPqEPrEdacFy0QHFrhx31Xzp0gtkEO3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ySAopQdAY1xm for <linux-ide@vger.kernel.org>;
        Sun, 28 Nov 2021 23:43:55 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J2cmV0l4gz1RtVl;
        Sun, 28 Nov 2021 23:43:53 -0800 (PST)
Message-ID: <0b5b3826-2989-8d42-4139-5a9d28582f65@opensource.wdc.com>
Date:   Mon, 29 Nov 2021 16:43:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2] pata_falcon: Avoid type warnings from sparse
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8f6a78cf7b60160ef3d22445ee1b8f2c0678f74b.1637879659.git.fthain@linux-m68k.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <8f6a78cf7b60160ef3d22445ee1b8f2c0678f74b.1637879659.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/26 7:34, Finn Thain wrote:
> The zero day bot reported some sparse complaints in pata_falcon.c. E.g.
> 
> drivers/ata/pata_falcon.c:58:41: warning: cast removes address space '__iomem' of expression
> drivers/ata/pata_falcon.c:58:41: warning: incorrect type in argument 1 (different address spaces)
> drivers/ata/pata_falcon.c:58:41:    expected unsigned short volatile [noderef] [usertype] __iomem *port
> drivers/ata/pata_falcon.c:58:41:    got unsigned short [usertype] *
> 
> The same thing shows up in 8 places, all told. Avoid this by removing
> unnecessary type casts.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>  drivers/ata/pata_falcon.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
> index 121635aa8c00..823c88622e34 100644
> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -55,14 +55,14 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>  	/* Transfer multiple of 2 bytes */
>  	if (rw == READ) {
>  		if (swap)
> -			raw_insw_swapw((u16 *)data_addr, (u16 *)buf, words);
> +			raw_insw_swapw(data_addr, (u16 *)buf, words);
>  		else
> -			raw_insw((u16 *)data_addr, (u16 *)buf, words);
> +			raw_insw(data_addr, (u16 *)buf, words);
>  	} else {
>  		if (swap)
> -			raw_outsw_swapw((u16 *)data_addr, (u16 *)buf, words);
> +			raw_outsw_swapw(data_addr, (u16 *)buf, words);
>  		else
> -			raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> +			raw_outsw(data_addr, (u16 *)buf, words);
>  	}
>  
>  	/* Transfer trailing byte, if any. */
> @@ -74,16 +74,16 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>  
>  		if (rw == READ) {
>  			if (swap)
> -				raw_insw_swapw((u16 *)data_addr, (u16 *)pad, 1);
> +				raw_insw_swapw(data_addr, (u16 *)pad, 1);
>  			else
> -				raw_insw((u16 *)data_addr, (u16 *)pad, 1);
> +				raw_insw(data_addr, (u16 *)pad, 1);
>  			*buf = pad[0];
>  		} else {
>  			pad[0] = *buf;
>  			if (swap)
> -				raw_outsw_swapw((u16 *)data_addr, (u16 *)pad, 1);
> +				raw_outsw_swapw(data_addr, (u16 *)pad, 1);
>  			else
> -				raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
> +				raw_outsw(data_addr, (u16 *)pad, 1);
>  		}
>  		words++;
>  	}
> 

Geert,

If your are OK with this version, please send a review tag. Thanks.

-- 
Damien Le Moal
Western Digital Research
