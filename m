Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63BC433EF
	for <linux-ide@archiver.kernel.org>; Fri,  4 Feb 2022 23:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbiBDXkQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:40:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5040 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378331AbiBDXje (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2022 18:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644017974; x=1675553974;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=w9nbV279oSsEjeUxptnVg/pCnCGTQrf60QL0UePvK2k=;
  b=dtbBMwJX1h6YjE1SY7uUpW+4I9f1qnXgGxXUV+uU7VEjxYoaPv/jr65P
   /3/R9IIBjpcVwd3FjswAOyry2pRcEn7y5MhyWRiJkzkd1RuiiBkvcVY0t
   j0uu5dvd4NKqX9jEBpwSATpSDMpKwwF+tvWckY7JwGQqV7KCtDpgjUP9M
   FYl08g/TOarizSdvg3Svc1M8k++49afrgGVZsGSrs5fe3Fyop0Qlku+HF
   1SXyP3L3UhhlbDXVfePQhqGqeG52CWkLfWCYy1q1PXhmwBkWnsl8imQOC
   vDr+LovR+08OmL4reKL2kzfc4SX0dyzfsJrVDZ4WOC9HTRCtcz9Cmxv7z
   w==;
X-IronPort-AV: E=Sophos;i="5.88,344,1635177600"; 
   d="scan'208";a="304105887"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2022 07:39:34 +0800
IronPort-SDR: qdCguZ/Zh72jyAGK+0m//YvanqZj59UcD+Us+3rnF8jVnWWlX9Sq50XT5u37LAPRnXSIjfEoCD
 tLz+HJMi1fpPOsWso59RYSVrgi2aC0KR/0gDmTIavt1zEuMTEueGRM1N/7NzpfhOcXaCi5KiGj
 vjKxONEkz70e4X+mHUVp8kKFvdQB1egX7+d0HF4dJtZXia0eUoGyu+M8p3Byo3agK4w8MXzf+N
 2Ux6tvHbwRkLGJxdnQBIk2aJn7k7h6bm5Q/zTyassyi4l06mknaQI+/r3edDep6FG9vbn2366Y
 Ka7f2egWomQAwFW30/Zwzl1v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:12:39 -0800
IronPort-SDR: dQyx7/icGIXTpeocxWvjBuPMyaN074WTNMnmkM6dr8YIyo7noQyQO3pmvuDl81dUzlOTCch6YQ
 3WxAh00kYZvrqnBsZpRREDOMr05vaWZ+BkRh8DyjLd/pwV1pDBgukn5e046DmoEKuNzU+fpjLX
 Ogk73Y5aSa1916qP+FTZm5IqSURgoKaNwcBZqWfuaG5uPNXy0+1zJpJe0hPN6SiaTCWyf4DaPg
 TWjbySl2IHbMHAYBwCCEiVVwMJOoeiSeaNwJvpk+8nuGsl074cLZVoBBgW/m5tNuLgCaHgwRNW
 9vU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:39:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JrBpF4WKMz1SHwl
        for <linux-ide@vger.kernel.org>; Fri,  4 Feb 2022 15:39:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644017973; x=1646609974; bh=w9nbV279oSsEjeUxptnVg/pCnCGTQrf60QL
        0UePvK2k=; b=STkwTB8pOmLDlf2sOR//6mtboLdYfkKT7H8QHh/QotWdf2N6SyP
        vhF7b3t9YW0cXWJBxfIVGKdO/Cn52kX2uujA9iEf41nPHhGcGgWUeNmJ+NanOQVT
        numTWHmrTUD33z0oRSdeKzg8BTFSNdSp+3LJE6f1nih33QeUf75C8RhH5D3zZZuQ
        tmxEGD/DoEwTW31Ew70dAI4hAHpfsnj9yxhDkOWtXCaFU8PO+xSukh7Drm7Jttnw
        F7M6sZ3E3iYIGYvjOTIa9BP6IKRi+7WBgR2kTEwcWmdv5v2dipmloxFiX7UWozQx
        3b6NLkacJjoOdqdlHGvBxhmti1GB9ZxWy9w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FAnX6L8QR8RO for <linux-ide@vger.kernel.org>;
        Fri,  4 Feb 2022 15:39:33 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JrBpD6fwHz1Rwrw;
        Fri,  4 Feb 2022 15:39:32 -0800 (PST)
Message-ID: <03fec07b-4a87-7ec2-ae7b-575e4d91d012@opensource.wdc.com>
Date:   Sat, 5 Feb 2022 08:39:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] pata_artop: use *switch* in artop_init_one()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <dbb4010a-e466-d7f5-e926-72577a96a22d@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <dbb4010a-e466-d7f5-e926-72577a96a22d@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/5/22 04:09, Sergey Shtylyov wrote:
> This driver uses a string of the *if* statements where a *switch* statement
> fits better...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
> Changes in version 3:
> - fixed up the patch subject.
> 
> Changes in version 2:
> - updated #define DRV_VERSION.
> 
>  drivers/ata/pata_artop.c |   24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> Index: libata/drivers/ata/pata_artop.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_artop.c
> +++ libata/drivers/ata/pata_artop.c
> @@ -28,7 +28,7 @@
>  #include <linux/ata.h>
>  
>  #define DRV_NAME	"pata_artop"
> -#define DRV_VERSION	"0.4.6"
> +#define DRV_VERSION	"0.4.7"
>  
>  /*
>   *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
> @@ -394,16 +394,22 @@ static int artop_init_one (struct pci_de
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
> -	else if (id->driver_data == 2)	{ /* 6280 or 6280 + fast */
> -		unsigned long io = pci_resource_start(pdev, 4);
> -
> -		ppi[0] = &info_628x;
> -		if (inb(io) & 0x10)
> -			ppi[0] = &info_628x_fast;
> +		break;
> +	case 2:		/* 6280 or 6280 + fast */
> +		{
> +			unsigned long io = pci_resource_start(pdev, 4);
> +
> +			ppi[0] = &info_628x;
> +			if (inb(io) & 0x10)
> +				ppi[0] = &info_628x_fast;
> +		}


Do you really need the local variable ?
I would make this:

		if (pci_resource_start(pdev, 4) & 0x10)
			ppi[0] = &info_628x_fast;
		else
			ppi[0] = &info_628x;

simpler :)

> +		break;
>  	}
>  
>  	BUG_ON(ppi[0] == NULL);


-- 
Damien Le Moal
Western Digital Research
