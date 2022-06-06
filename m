Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E090DC433EF
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jun 2022 02:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349161AbiFFCmJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Jun 2022 22:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbiFFCmH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Jun 2022 22:42:07 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E163CB
        for <linux-ide@vger.kernel.org>; Sun,  5 Jun 2022 19:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654483326; x=1686019326;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=wVZw+lH039ADPETmDQdHaK1lxpc+CC3Nqs4e9zJ/LHg=;
  b=DKGkHgQ/eqUU9iWbNy0MLdQnTI5EtdJSyQh+OI4LwZNrF7RRSpSBgeEy
   vRqt6kWLlni29N+U7ulJv0ppbpeag9EcKjGgwL9LuOQexci0F13ahIkaC
   VIntdtYP5qhZsKhfMn/wY+4kOXKh4qqdunhvkHvIjprj0IAt7G5LtXIg2
   bcFW/wtzR4zlxFOYvzR3pqdGuTb61H7UjrxRt1Kgnsarnu+blrCXYEC+3
   zcQRnNxzjYo0LhMY155FJ6DfiY3Nj4QIaTNUnf+vFPURj7qVIT2PeZUcZ
   DMOqiW859iHcxYMfJnI2PTABj/qDdBk3Jy64ttHihRY8G7ArNaGhNdvU5
   g==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647273600"; 
   d="scan'208";a="314379911"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2022 10:42:05 +0800
IronPort-SDR: f7PgQ0MF1rrOql1vTaKcGughERTDL/4Enmg+i9rRGaJnZO/F2whHtzpcPqGZLPyrTKpbOJCGlI
 Wmrc6FK2MvE4Otwi9c9u0flpkVcly8bxcF1OHIwbEw4mGwCN1wUJ90ierTo0qLkGDTmbySL3qf
 R4xV8lIylWA7TC5+z5SxSEz9jV9uaiyJK8VJzJ779dmq1SOmKkpmSB1Hr8GWb5RlGKFaTCOkMG
 qdZ8fMM1D0xq51jay4W4JsTiVlciiWgp3b2jLAZeGqDkfyNSYPAOxLkwXgoHjZ1YS1+f/KBe5C
 twjMznz7vnOr/m9ZT1eszYc9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2022 19:05:26 -0700
IronPort-SDR: WXlKtqa//PVz2gkYZcL+ni+KFFJagZNnzMyk9Dx0R+gWlrZGFoCcuX5t+N4UcRTZs80mobYhl/
 Z+Tv2SKMlczTzUiMmHRV7kCjTLdzi0W0N9Efqyh3fVMjC4fn47F7PjV0RGKdvRqCM3bkon21xi
 4vgSyqiCdJM2+p9YxryksfLISdRULn/pGfhmS/iMBq81mCIiYZ4Q6gkO/ukb21LbvySpigpoqp
 MiIK2r8Z6Hyq7Cf+sqcI8qAQcEoy4uKo3qpufCayQzMt0SW9U3DzT9bvrFrkJx5i2X6VLcoAxH
 jJM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2022 19:42:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LGd712Pwrz1Rvlx
        for <linux-ide@vger.kernel.org>; Sun,  5 Jun 2022 19:42:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654483324; x=1657075325; bh=wVZw+lH039ADPETmDQdHaK1lxpc+CC3Nqs4
        e9zJ/LHg=; b=bj6CPVihuDtzL8fv0Ix9iRysVN4b9owCjjM4cTlnzivgVL+wpfy
        3KUY01YdAAPWDvIJFdiKCgh6ImEb0ZPtOInIXhfYFQ5HfHy3fbzjFfcp4pCG52/l
        puF9nKxGTjwvEhu1k0Ab2dqnWudU2i7syQEpLO7LmgmgFNU8HjIJjLg2TcYiwWyg
        j++MN7QSy8knjUfMHVr0Zo0hB4RZJQTur3HObZM2iV6UnkaEH41Y8GdwIdUKOUdt
        5FarRiJ/rnQVR5KvXsN6U9X9kaMSRbcm7+yiSkLcoO64AUhYv+InYg3D6EHwWhJ0
        jHmCThwgj2BF+5QR78v0BLCSsZB5mAZJpWg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3-wakoyooFJr for <linux-ide@vger.kernel.org>;
        Sun,  5 Jun 2022 19:42:04 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LGd701mCLz1Rvlc;
        Sun,  5 Jun 2022 19:42:04 -0700 (PDT)
Message-ID: <c9695894-3bc6-e825-8239-ea6aa3e4831e@opensource.wdc.com>
Date:   Mon, 6 Jun 2022 11:42:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-transport: fix {dma|pio|xfer}_mode sysfs
 files
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <b0f8a1d3-2550-31b2-702c-3294d0569187@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b0f8a1d3-2550-31b2-702c-3294d0569187@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/5/22 05:53, Sergey Shtylyov wrote:
> The {dma|pio|xfer}_mode sysfs files are incorrectly handled by the
> ata_bitfield_name_match() macro which leads to reading such kind of
> nonsense from them:
> 
> $ cat /sys/class/ata_device/dev3.0/pio_mode
> XFER_UDMA_7, XFER_UDMA_6, XFER_UDMA_5, XFER_UDMA_4, XFER_MW_DMA_4,
> XFER_PIO_6, XFER_PIO_5, XFER_PIO_4, XFER_PIO_3, XFER_PIO_2, XFER_PIO_1,
> XFER_PIO_0
> 
> Using the correct ata_bitfield_name_search() macro fixes that:
> 
> $ cat /sys/class/ata_device/dev3.0/pio_mode
> XFER_PIO_4

Looks good, but Documentation/ABI/testing/sysfs-ata says:

pio_mode:       (RO) Transfer modes supported by the device when
                in PIO mode. Mostly used by PATA device.

xfer_mode:      (RO) Current transfer mode

dma_mode:       (RO) Transfer modes supported by the device when
                in DMA mode. Mostly used by PATA device.

which seems incorrect/badly worded for pio_mode and dma_mode. Since these
2 sysfs attributes do not actually device the pio mask (list of supported
pio modes) but the pio mode that will be used for that device, we should
reword, no ?

What about:

pio_mode:       (RO) Transfer mode used by the device when
                in PIO mode. Mostly used by PATA device.

xfer_mode:      (RO) Current transfer mode

dma_mode:       (RO) Transfer mode used by the device when
                in DMA mode. Mostly used by PATA device.


> 
> Fixes: d9027470b886 ("[libata] Add ATA transport class")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org
> 
> ---
> This patch is against the 'master' branch of Damien's 'libata.git' repo.
> 
>  drivers/ata/libata-transport.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: libata/drivers/ata/libata-transport.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-transport.c
> +++ libata/drivers/ata/libata-transport.c
> @@ -196,7 +196,7 @@ static struct {
>  	{ XFER_PIO_0,			"XFER_PIO_0" },
>  	{ XFER_PIO_SLOW,		"XFER_PIO_SLOW" }
>  };
> -ata_bitfield_name_match(xfer,ata_xfer_names)
> +ata_bitfield_name_search(xfer, ata_xfer_names)
>  
>  /*
>   * ATA Port attributes


-- 
Damien Le Moal
Western Digital Research
