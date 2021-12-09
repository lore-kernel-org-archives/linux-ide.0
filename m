Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9DBC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 01:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhLIBRY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:17:24 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:55985 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhLIBRY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639012431; x=1670548431;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gBIEYQ0mI0MTApePCEzTms9S8TbwFbnei4n02o1Wtnk=;
  b=LY7+ONpb3m77DckbFOVNZePlMGXnHTximcZCzcz6rLSTYNgkvwZ8msFl
   Rwy6Gqj9k8vJ5H6ueMguOs5mpKAKi+Ie9/uf2ZCaYUjXytVdHJp0CAwyE
   hO/o14f8y4CKbIqMRIHhEeP/pC1wlbZBs7pWAl/9Jh812dU18LAegWWmM
   93bnUeTyaxqLuqvKwrb8vRO4v9Ur0gycJ96hi0DZk6uJE5qpTnofISx4P
   6zIUd1D30Dk1oUmvyJLXZ1huXc56vFLaxYWcjgGvXxu/eJvF+5HDQFTsH
   FPSYTL64QzSXmiW6H4BESMs0FTyp7Q8Z0E+BMykSSEma22vHNQSI1QFnU
   w==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="299638305"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 09:13:51 +0800
IronPort-SDR: vNEJzJZvp2D33ao/AkQShzW+1P7gt1xydfs2gJrVsl77QOa8uztu1MGpaC01OAPUAw59Xit5xQ
 ooO9ZtTeBAPExzgus4nsr/ivtdGf9EoCOdomjW3HxyKZwJrOdv8+vJ4pewKu7+aa7euHguBdmS
 cjWqyrcFdQaSpgEPhCFebw5KmxnyYpFNaiII2PRQ9D3VZR40/nlDerIeY6MBlN7em9Mh+fKsgz
 MidUnOOEnUOhDbn9IMwZw4+EY/ftIZvjNmIkSOp+sncR9pMfDBPI/yd3GIROz/JLwjxKi6oFj+
 lBHEGGr11Ee54VkUUOOCTKye
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:48:25 -0800
IronPort-SDR: kq8G+nfM2oYr5VL82x53G7udKTTZr8n9qO8ruGuHh9fpvdDMWRvJ6fM3734gmwUTg3scgBTKxF
 ZM6pBbeVpZD3aUT8tcjyoj3KJaiUUt0ZD3z2v8ptaxizoA6lCGOp+W7O1xElHjOLKKAtdhtRvw
 lnSlMt1xjWdhJ6zKVcGAuFBca3UTU1ibS7MoXU78L3sUpjtEJpAItsCY7oz5wP2roEj5I36G0O
 a6vBYsjNFJ6TTo95v6Kot2Q3z7S16qytktfxCRRQuuc8Nzouix1diF1ArZ5rj0DpQ6MvQ+ivBS
 a60=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:13:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8bdq1WV0z1Rvlf
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 17:13:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639012430; x=1641604431; bh=gBIEYQ0mI0MTApePCEzTms9S8TbwFbnei4n
        02o1Wtnk=; b=Lc589AyVmOjjrqVDOSx+txrj9jWyxVSoFzX/APg4Vf8Aj9iPhob
        i+faew8K2bR1GicxjYn4n3syZZSBTllilE9mIw4OyZvk+Kj/ngJX/FpD1qfel39f
        2aeQDB59UbkWfDcQXRkHqolZ5etupCq4hQvUxmG4FGfSG6R/ZKZMSUwZ+/IU+S1M
        YfrrOO3DGStP2TnHBw3z/LRy1CM7nFK1zXQa3enYkJu7UxAKpDwsgQ8RdX1NqLLW
        crnAGPK0WGPBgE9M7tSi8w0GXpNkUwGbr/cnTYBpIrJwBteRVbJu0QUh8lueitcR
        AQl4HKBmXCd5Ac0yfwytpmFcnRQNBPpgK7Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eboU_ApTA2aS for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 17:13:50 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8bdp3pZCz1RtVG;
        Wed,  8 Dec 2021 17:13:50 -0800 (PST)
Message-ID: <b6aa00a3-518e-7b4f-e785-186b03eb9351@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 10:13:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 70/73] pata_hpt3x2n: convert pr_XXX() calls
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-71-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-71-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:32, Hannes Reinecke wrote:
> Convert pr_XXX() calls to structured logging.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/pata_hpt3x2n.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
> index 48eef338e050..60e7d71328f6 100644
> --- a/drivers/ata/pata_hpt3x2n.c
> +++ b/drivers/ata/pata_hpt3x2n.c
> @@ -16,8 +16,6 @@
>   *	Work out best PLL policy
>   */
>  

Remove this blank line too ?

> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -420,7 +418,7 @@ static int hpt3x2n_pci_clock(struct pci_dev *pdev)
>  		u16 sr;
>  		u32 total = 0;
>  
> -		pr_warn("BIOS clock data not set\n");
> +		dev_warn(&pdev->dev, "BIOS clock data not set\n");
>  
>  		/* This is the process the HPT371 BIOS is reported to use */
>  		for (i = 0; i < 128; i++) {
> @@ -530,7 +528,8 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  		ppi[0] = &info_hpt372n;
>  		break;
>  	default:
> -		pr_err("PCI table is bogus, please report (%d)\n", dev->device);
> +		dev_err(&dev->dev,"PCI table is bogus, please report (%d)\n",
> +			dev->device);
>  		return -ENODEV;
>  	}
>  
> @@ -579,11 +578,11 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  		pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low);
>  	}
>  	if (adjust == 8) {
> -		pr_err("DPLL did not stabilize!\n");
> +		dev_err(&dev->dev, "DPLL did not stabilize!\n");
>  		return -ENODEV;
>  	}
>  
> -	pr_info("bus clock %dMHz, using 66MHz DPLL\n", pci_mhz);
> +	dev_info(&dev->dev, "bus clock %dMHz, using 66MHz DPLL\n", pci_mhz);
>  
>  	/*
>  	 * Set our private data up. We only need a few flags
> 


-- 
Damien Le Moal
Western Digital Research
