Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2997C433EF
	for <linux-ide@archiver.kernel.org>; Sun,  6 Feb 2022 01:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiBFB4Q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Feb 2022 20:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiBFB4Q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2022 20:56:16 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 17:56:15 PST
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BE4C043186
        for <linux-ide@vger.kernel.org>; Sat,  5 Feb 2022 17:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644112575; x=1675648575;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=K1iT2CYv+A8JHniJWZICCtektNAJ5APpJX8MBWR4zDU=;
  b=WPlkxNGdeGPV1JetCW1Pl9vbUO8pYbnUhro1Aoc1JlG9jmuE1eUwLakA
   u8m4EY9UijB4asw7p+fNt2LNIXlhufKb34UdgNDeuVpOl52p63E+P0RtD
   Ybv+DLQq3iZzfh09yY2tQ95klkveJt/SOkIybiyXrJgPBrwbdRTtjj2Pg
   tLvSuw0kk1kFTNIMQ8NTZOcrUdnbKyCVrxmDXyygKaXh7eaa8RWkQJWIe
   IGMYPaeQh2PNcj6HAjcjEPqiLYwZqUBzaBz5+uBJjFl2agXz1PhNGZ9+z
   vPZf+9/xUtUwlY6m7q/S9UmE7Bt/wvMiZqRgsegN42CTyYkBvdTJPaY/7
   g==;
X-IronPort-AV: E=Sophos;i="5.88,346,1635177600"; 
   d="scan'208";a="191185953"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2022 09:55:12 +0800
IronPort-SDR: zXXPzOLTT6DEV42GwSNhOTx7fY9viqM69sxNsqg3TCn9sdCQHGD+Z24EdUi+SRD85/E3KIk9oS
 DZ9MpvWUVZZVMOqf80iED/WtZiphknlZCx6DexMWGNQoo32WPZmzkpzUA/CxXc+2SUlB12Jt/n
 Vsg5Jnw/TYg/Jt2OyRZGOg/JKozHQSV1+4O2h7+NJpr+f7QY1ivSkIUsqKluy5sK4xnCQv9sMT
 rxf1fSQFtH7KRfUVOvj9tsZjvb73WyGqf0HASvFE1ukouAS1jQg9GC2+8Za9sMXBPnhOYd3+qz
 XFhFfohdmQjJQNx0srGlqCzR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 17:27:04 -0800
IronPort-SDR: awjd+eCK3roKjgl68iPaLvpAueJvqxww8m9649bMQW3LVU+rP7R7fBagO8ZhX0QIBJ0tKQdmKt
 cJf1N9b0KJBCwyuL1fUx8B0dxu6xS1Bxqp1YcaSqstXYBcp/YBMacwq8miffWaDlL8Xw8QP6tB
 3DzQvXuLQTZ2FXXYk4IhKDKxlH53PIiTrtr/NdJ4cvLpfuRYA0Cf66ltIRslYok0g4cFOdlA4F
 DDFvEmKfdlHp11LzqFZuDkRfPj70TOJG5NASb4442T6E1EYjKq5Xmt15jVtR0EmNxM7RYeRvXu
 xQU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 17:55:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JrsmJ26qFz1SHwl
        for <linux-ide@vger.kernel.org>; Sat,  5 Feb 2022 17:55:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644112511; x=1646704512; bh=K1iT2CYv+A8JHniJWZICCtektNAJ5APpJX8
        MBWR4zDU=; b=R+AAInlh9FCwW+LHKUe7YaxDip6hG/0zQnWw5u2BuK91idlpvyL
        6Nump2k0IW3SB7pG3BtWgo2I68d5QZmEJ/jlH1RZgYsyQFiUb/I6wooZnpEr7KG1
        +6GOWwbEMkdwiDUkuX9TSudWkefHkffr01JH/MXW3ubQ0Cn/7pyCpi0g8WJ3hgkj
        iLhecKCG4Qn5CHWEndFwRH/wSFZK7F+bSWjPkRBBtfzZLhiZO4wzPVIUULp+yeu+
        Z7lUl4XacQt0HNDhdkRj/hIw5tzJlbDW+Am1epmcHwqieFXYJ7xKSMbK+Tzg4ZRj
        50/OqvQs9pDqX32QMZvcmxMo4bfqvK/kRLg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K_Qq92KhZQne for <linux-ide@vger.kernel.org>;
        Sat,  5 Feb 2022 17:55:11 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JrsmH44Jhz1Rwrw;
        Sat,  5 Feb 2022 17:55:11 -0800 (PST)
Message-ID: <d1432a8d-ac25-d37e-8de3-d60be1670d3b@opensource.wdc.com>
Date:   Sun, 6 Feb 2022 10:55:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/3] pata_artop: use *switch* in artop_init_one()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220205203434.15339-1-s.shtylyov@omp.ru>
 <20220205203434.15339-3-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220205203434.15339-3-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/6/22 05:34, Sergey Shtylyov wrote:
> This driver uses a string of the *if* statements in artop_init_one() where
> the *switch* statement would fit better...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> Changes in version 4:
> - fixed up #define DRV_VERSION;
> - expanded the patch description.
> 
> Changes in version 3:
> - fixed up the patch subject.
> 
> Changes in version 2:
> - updated #define DRV_VERSION.
> 
>  drivers/ata/pata_artop.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index b734cafb8783..d8c388da0c70 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -28,7 +28,7 @@
>  #include <linux/ata.h>
>  
>  #define DRV_NAME	"pata_artop"
> -#define DRV_VERSION	"0.4.7"
> +#define DRV_VERSION	"0.4.8"
>  
>  /*
>   *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
> @@ -394,14 +394,18 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	if (id->driver_data == 0)	/* 6210 variant */
> +	switch (id->driver_data) {
> +	case 0:		/* 6210 variant */
>  		ppi[0] = &info_6210;
> -	else if (id->driver_data == 1)	/* 6260 */
> +		break;
> +	case 1:		/* 6260 */
>  		ppi[0] = &info_626x;
> -	else if (id->driver_data == 2) { /* 6280 or 6280 + fast */
> +		break;
> +	case 2:		/* 6280 or 6280 + fast */
>  		ppi[0] = &info_628x;
>  		if (inb(pci_resource_start(pdev, 4)) & 0x10)
>  			ppi[0] = &info_628x_fast;

Why not use "if () else" here ? And I do not see the point of patch 1.
Since this patch is rewriting this hunk anyway, let's squash patch 1
into this one.

> +		break;
>  	}
>  
>  	BUG_ON(ppi[0] == NULL);


-- 
Damien Le Moal
Western Digital Research
