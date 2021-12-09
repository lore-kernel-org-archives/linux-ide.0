Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774A4C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 01:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhLIBQk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:16:40 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47118 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhLIBQk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639012387; x=1670548387;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ftR7myHTna0mCwxGHYuwc5z7Vj8Gf2t/BihYVRg3mPA=;
  b=RsgesMfiMXKAQmKGqERX8H5wsXHao21LCVnEU7YS/A1XRmlTDP9FwuB/
   qY1WYiUfmi/AMTGAXI9Qy1AlpGK/ctDqw4K6U5SyRBc1C6tAC1LId52PL
   PPO5JjZoaMDMXj9ijTPy9yXKgnLBkzeBzp5oTlyOJjfImpeKKQKC3qDZF
   mJ7X6yuxYkNxGiNXklM1yQgZ5QmBwK/9tyf8t0Go73xcGNhyiAig0gZ/f
   Ye2OAQjSnF9QDyqe/Bpri5V2R10x70WYUHFyuTFZaviVVsBQbjozQKt4k
   iJiHgIBNgKJl7V4YfiKsAeIwyhdldsjh1CyzettnlngG65AIp4r7jXkMs
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="186773506"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 09:13:07 +0800
IronPort-SDR: E+qPZlhUSRz+PnD+idNGsVeCOnwgCIT3JEGqwoqOEW8zK7/pjozY3X3LhZ2UEJj8k6WMR2BLXV
 nyWdJwhrPnt+xwX5ckDmmszY4gseZgjZY3ru4gizssgJIzGWEeeg3BjDolDNosTYt5oeCcP26I
 RM2pVGLqDAluEuBnNpjV3QGpJA0WTjG0wSI7CeGeUbko7zPuz9KV9/pV7NaWYa/SswJCvPqyho
 MqSVQsEVlw6EixEKfv1lB9qNGJOfYQ6wJ0B7gdL8nR5nL32I1o27KT3ESXDGbkHoTEDMgUc+QT
 MZ1ESxrc3bDZuM7K1dtVSj2X
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:46:10 -0800
IronPort-SDR: 7PqNkqoNHOuMczu24qB9XCzvtiHNzq3JSdwxKHD8XNrNlxw73w7/6wreO94NmHY5YWYvwBnHA+
 fOcibwb9jlwQpHs0VIZIHXpwKmNQ1vyvTU/IwfDbA55NayktpbOEn/ptRBnparjtrrzUCJ1SNn
 1YVAzm7aBYcbev86mQXtivCLRrm76Q53wvvMPz7WEnyyr/garOOZhR47fslEEJvjQJSJ+Sl+mW
 QSu8Xb6LYlHBRmzfJ75eWed0jFhPTnhVi7b2Wc6BGzuzu0Anv5/IvCwDw6auSQN6fgoRnf7Gd9
 SOU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:13:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8bcz0qSDz1Rvlf
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 17:13:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639012386; x=1641604387; bh=ftR7myHTna0mCwxGHYuwc5z7Vj8Gf2t/Bih
        YVRg3mPA=; b=rkGIUgd5e32oFtA/73XrCY+NqvJoFuaRQB8/AtCcXUvN530qIsz
        a9/Zg4qxtRcWVh9KdIiFmdEH1VJOJNUKHgnj2OREHRRqGH1ibPpDQEUaYkIZJHA0
        NRXD0gMATCkvZACbmgTCqaLHKmVjIWdHls2V5oDzOE5xqvbrzLfJiQ9danBrvSXz
        +gbZL9mWUa+0i+4UcqzIexJjWdo5qPrVh3+HD80vFVBLUM+bzngkh6E1S5apKZBZ
        slIFK/OkmF6IwdlHUhfUQn4j1zzjil+EbaVvZsBV+6S28exBrJKvUrcXghb9a21U
        C89VaU8xoRqjI+MQ8t+tkHfo9jUHYgjhgiw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x89If0mfY_eT for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 17:13:06 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8bcy2VGNz1RtVG;
        Wed,  8 Dec 2021 17:13:06 -0800 (PST)
Message-ID: <05e52034-1638-82a5-18a5-07216309bf04@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 10:13:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 68/73] pata_hpt37x: convert pr_XXX() calls
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-69-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-69-hare@suse.de>
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
>  drivers/ata/pata_hpt37x.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
> index f242157bc81b..47709eb9d135 100644
> --- a/drivers/ata/pata_hpt37x.c
> +++ b/drivers/ata/pata_hpt37x.c
> @@ -15,8 +15,6 @@
>   *	Look into engine reset on timeout errors. Should not be	required.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

I think you can also remove the blank line before this line too.

> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -231,7 +229,8 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
>  
>  	i = match_string(list, -1, model_num);
>  	if (i >= 0) {
> -		pr_warn("%s is not supported for %s\n", modestr, list[i]);
> +		ata_dev_warn(dev, "%s is not supported for %s\n",
> +			     modestr, list[i]);
>  		return 1;
>  	}
>  	return 0;
> @@ -864,7 +863,8 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  			chip_table = &hpt372;
>  			break;
>  		default:
> -			pr_err("Unknown HPT366 subtype, please report (%d)\n",
> +			dev_err(&dev->dev,
> +				"Unknown HPT366 subtype, please report (%d)\n",
>  			       rev);
>  			return -ENODEV;
>  		}
> @@ -905,7 +905,8 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  			*ppi = &info_hpt374_fn1;
>  		break;
>  	default:
> -		pr_err("PCI table is bogus, please report (%d)\n", dev->device);
> +		dev_err(&dev->dev, "PCI table is bogus, please report (%d)\n",
> +			dev->device);
>  		return -ENODEV;
>  	}
>  	/* Ok so this is a chip we support */
> @@ -953,7 +954,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  		u8 sr;
>  		u32 total = 0;
>  
> -		pr_warn("BIOS has not set timing clocks\n");
> +		dev_warn(&dev->dev, "BIOS has not set timing clocks\n");
>  
>  		/* This is the process the HPT371 BIOS is reported to use */
>  		for (i = 0; i < 128; i++) {
> @@ -1009,7 +1010,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  					       (f_high << 16) | f_low | 0x100);
>  		}
>  		if (adjust == 8) {
> -			pr_err("DPLL did not stabilize!\n");
> +			dev_err(&dev->dev, "DPLL did not stabilize!\n");
>  			return -ENODEV;
>  		}
>  		if (dpll == 3)
> @@ -1017,7 +1018,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  		else
>  			private_data = (void *)hpt37x_timings_50;
>  
> -		pr_info("bus clock %dMHz, using %dMHz DPLL\n",
> +		dev_info(&dev->dev, "bus clock %dMHz, using %dMHz DPLL\n",
>  			MHz[clock_slot], MHz[dpll]);
>  	} else {
>  		private_data = (void *)chip_table->clocks[clock_slot];
> @@ -1032,7 +1033,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  		if (clock_slot < 2 && ppi[0] == &info_hpt370a)
>  			ppi[0] = &info_hpt370a_33;
>  
> -		pr_info("%s using %dMHz bus clock\n",
> +		dev_info(&dev->dev, "%s using %dMHz bus clock\n",
>  			chip_table->name, MHz[clock_slot]);
>  	}
>  
> 


-- 
Damien Le Moal
Western Digital Research
