Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B7AC636CC
	for <linux-ide@archiver.kernel.org>; Tue, 31 Jan 2023 11:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjAaL1C (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Jan 2023 06:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjAaL1B (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2023 06:27:01 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9339449573
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 03:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675164419; x=1706700419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g+eI0l2eZSsfEyTQaBq+eFb9OwRPKDkyyazrIopi1gU=;
  b=Io/BTtvmL8q7H0WOjYyAJawcZaFXX/hQ6JPv1EC/7uvv5o5EJ67aREEn
   J+1/A/Edgi1Ac8Fe0hN5LXzweCSDnNi6sdxV6Igg9Jn/AzaM1B0yr8aU+
   QzQ54ukfDaSbEriUqPyhHbV3qga7pll57iwKQVM5Iw2puY8MHzI0LtUt+
   D2FEqUEAZnSdKX3e30MF8pmRrD72ScuPJqSOrnRfq7giel6xqUn3iNit1
   ZdBva9kUpiiRoWLTXgrYoMqClqfX/7FPz0CZ+d5NNuHA3cX5p3+snbTMv
   U5YgFCPhSz5lzslEElZxGpaxVs835oqWi5TVx2uYblFycR0aCPGdZq5ON
   g==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669046400"; 
   d="scan'208";a="326459260"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 19:26:58 +0800
IronPort-SDR: 7qP4iqC7pOAlDqRfxeNOtajKyyp/TNyxc/Ax+1YTn2JgrDzHovdJkl/pDyF2GAd9Kw6t0w7XL6
 ogCwYZlFtaf8FwZ2MEXcN36ih+zkR4UsxyiSKotqIZoRd51fsGfRn5qnCvtdTb0OE4MDz/9NSf
 PdhkPAPGOSkkv+F3OAszMcw8ZOXXq/Vnu80PdBgyULgUMtXw//fhlXZzmn2MVgClQGhbaIu3cG
 ClwZaw5zY/mp0UmPj+qW29zciQ+d3o5wIyC8qbBc8++coFxPi+mkIMV5i38QhI3OV2d5xtRYdV
 /Zs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 02:38:39 -0800
IronPort-SDR: FCNvUIADduQjLnsab97VMxavwuWwLA+S1XRLgojXoZQoS1MpT9sp8Ww4rW1CIvYcG8HHJxx1+h
 NvvEaZWEN75KJrVFk+w92BG+SnNZ9jHb7Z21zFUTnvD2BZbAcT0v+sugFLa5eVMNa+VvlcMfVW
 v3qHMiM6U7SplrFu20CmV1Pa2MOanlldqv9onbqDdZAhsd3V2DX4t0/BDQzkuuEgjeXuYHkN+O
 grEDGF8UEhBvctNBpqly3JP7rBJ26fkslPemaBtGNr9UR22AI9O/NyNlCouzhZ/+XOvzizPqcY
 B1w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 03:26:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5jSL2zJRz1RwqL
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 03:26:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675164417; x=1677756418; bh=g+eI0l2eZSsfEyTQaBq+eFb9OwRPKDkyyaz
        rIopi1gU=; b=agLOWiw5u4qVxhUwQ5rYn8trhbdD/klVmt4G0Jk+jEJ6sdDRT9i
        j6yxjJsjNiiRLHBzcP+dYhyJX0x8+M/FR2wQitpO9mTxeCWPQSXYqWBVb7wDU2RV
        U2rmhaGbuLzCwvGcKN0f63OXe5ClkgpmHfdhLKiQ8YfcCPODW39/6HExa1Tv8GDh
        8KdGTsq5Q7DiDz+c9gJTNBUOwpbmolwQSlJEUDNNSLUAcvrgbeTVbyk7aBfoqmEi
        DijpE2BP6e+1r2qgmqVpNYWCWvaMcVJP5ruZCGA/iSAe4Vq+8i7gUO8b3ZxH7SSL
        lxcwyb9KPyEt5G/GWeH4aWgr0HMcmXIBoUw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id odjqdjmMknCs for <linux-ide@vger.kernel.org>;
        Tue, 31 Jan 2023 03:26:57 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5jSJ5Zryz1RvLy;
        Tue, 31 Jan 2023 03:26:56 -0800 (PST)
Message-ID: <d8d117bf-4ab1-3473-85e2-00f1b1a85cba@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 20:26:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] libata: clean up some inconsistent indenting
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230131085431.30549-1-jiapeng.chong@linux.alibaba.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230131085431.30549-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/31/23 17:54, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/ata/pata_serverworks.c:443 serverworks_init_one() warn: inconsistent indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3905
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/ata/pata_serverworks.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
> index c0bc4af0d196..c6bd9e95d4e8 100644
> --- a/drivers/ata/pata_serverworks.c
> +++ b/drivers/ata/pata_serverworks.c
> @@ -434,10 +434,9 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
>  		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
>  		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
>  
> -		 /* If the returned btr is the newer revision then
> -		    select the right info block */
> -		 if (rc == 3)
> -		 	ppi[0] = &info[3];
> +		/* If the returned btr is the newer revision then select the right info block */

Very long line. Please make that a proper multi-line comment.
And the patch title should be:

ata: pata_serverworks: clean up indentation

> +		if (rc == 3)
> +			ppi[0] = &info[3];
>  
>  		/* Is this the 3rd channel CSB6 IDE ? */
>  		if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)

-- 
Damien Le Moal
Western Digital Research

