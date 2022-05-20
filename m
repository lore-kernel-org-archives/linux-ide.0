Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325E8C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 20 May 2022 23:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354099AbiETXak (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 May 2022 19:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354097AbiETXaj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 May 2022 19:30:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F4E1A8111
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2022 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653089438; x=1684625438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mC23Js+fgQ42aR1x1h3Crwa5qeNduvEcgjySjZ6gkSE=;
  b=U3sDWZqd/8gvCA8HuTyb9VYieWrrNXoxdpnwp/da+rOsLdO57Ah/0wST
   JoIbV7sXHphQJQ49DQLlLG6PlGR+yG/A9Hem8xNzbCX705GKCsLQKZOsL
   JneUfUS98THlGiQecsa+UPfbl5zQGau2DKTZlvLSGB9bwLf/NwedO3rVQ
   9rxDfcCas75iBjnHnDReqF5kle7TEWrmKq55tzD0Y/ZOnozReFTuEPzBg
   06EzvKmSmjVsT424YXcKx1jaWte9p9RvEUJQTsb4UvRxqnxm2csqZDFXc
   TbkuPm8RNXNclmZiyBzzlQiE+z0O/uyTrQ+YaGOtoc1kaYlIdMr9geWKL
   g==;
X-IronPort-AV: E=Sophos;i="5.91,240,1647273600"; 
   d="scan'208";a="199759569"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2022 07:30:35 +0800
IronPort-SDR: 9J0hOnZvNMttGLeWQZd9QMNwcDipHMHgw0xeunKrC3tf0R3015uyzFfNAs0EHPxAthk5RX3rU4
 wu9o/bV3qPhj1IA0vCByKz9BaJUKhQCnVXwM6bZdkowPbiYZZUStt0QgUYy7wN/BfjzY4Ezx7+
 +c3HbkzapDol1vQJ8gSBA/XlrLveYxWy0jsCanahsFKpt8tSZynME0QfzQcINCGnuzCb9N+2jX
 q6CH3tftdIM083TuEHtpgLsb+UtY1ttxAKz0SHxfIj88kIX2Me1lNZ/kx0KwmP7tenvaAGSFpK
 tfn6N1/UmxNaBKTv2cmQR8wE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 15:53:19 -0700
IronPort-SDR: 0DwGf0OKtWRhGGiLYO7qfgDlST3Cvm26sUE14P7GJhIvEfJODNWoQruoGixsJReqA0lCQ9B/SR
 JcVvjI2r4YQc/kgQq2dUUEK7XFxDJXKTCeE8vhGMzFCRORp8poq9On0RVE5qVWxuimuqyFA6q1
 Opc6VNaKKZexmwBJp29PY1aIJ7Ue1GUWcY5BbR666U/95r322BUHj0hKP9Z+EMRYhZhJCQm5Uk
 s510ZaW34nZPQoUoS7WWjxf/aGYrr3KpjzZi37szNkYzFy8KjQbGWClFyXefkelBduToOelN0L
 QtU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 16:30:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4jdR3RBNz1SVp1
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2022 16:30:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653089434; x=1655681435; bh=mC23Js+fgQ42aR1x1h3Crwa5qeNduvEcgjy
        SjZ6gkSE=; b=Nk8Hxo8+XR7/VqUuVjQ5LqiJPLj5h7vTFa/tWJg11fe3HCm13hn
        b70LJIxRTW43v6GNhZEwLiDvFaFUAxs5i/nG5e8PxJF5WO463aNgJ+xmnTYRjBd7
        RySZ5jWJQqmIkDz+LEeoz6rIgGGNzuDQvDMbRxWGmyyV/cFJpPkw7DHXKHdH+Lft
        6PpNvvml7iiRSpRAP8MLMUrxTHuF/uloCDy+a6pQuQj/F8pwNU+gx8m5uBoht8hf
        0vnnpYuYTOx/aDHe1k3AR1MO/x4gSoAgX7Cjl4VgQeD74fncW/Y75z2TrB7/CZMp
        nZEBM0HcRilBjsU7QQ79PFhTR/8WUDihf0A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8IeC6RUdWjKo for <linux-ide@vger.kernel.org>;
        Fri, 20 May 2022 16:30:34 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4jdM62rXz1Rvlc;
        Fri, 20 May 2022 16:30:31 -0700 (PDT)
Message-ID: <e65e7329-67e3-016f-e213-86e51b8021d6@opensource.wdc.com>
Date:   Sat, 21 May 2022 08:30:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-4-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1653035003-70312-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/20/22 17:23, John Garry wrote:
> Streaming DMA mappings may be considerably slower when mappings go through
> an IOMMU and the total mapping length is somewhat long. This is because the
> IOMMU IOVA code allocates and free an IOVA for each mapping, which may
> affect performance.
> 
> For performance reasons set the request_queue max_sectors from
> dma_opt_mapping_size(), which knows this mapping limit.
> 
> In addition, the shost->max_sectors is repeatedly set for each sdev in
> __scsi_init_queue(). This is unnecessary, so set once when adding the
> host.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/hosts.c    | 5 +++++
>  drivers/scsi/scsi_lib.c | 4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index f69b77cbf538..a3ae6345473b 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -225,6 +225,11 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>  	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
>  				   shost->can_queue);
>  
> +	if (dma_dev->dma_mask) {
> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +	}

Nit: you could drop the curly brackets here.

> +
>  	error = scsi_init_sense_cache(shost);
>  	if (error)
>  		goto fail;
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 8d18cc7e510e..2d43bb8799bd 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1884,10 +1884,6 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>  		blk_queue_max_integrity_segments(q, shost->sg_prot_tablesize);
>  	}
>  
> -	if (dev->dma_mask) {
> -		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> -				dma_max_mapping_size(dev) >> SECTOR_SHIFT);
> -	}
>  	blk_queue_max_hw_sectors(q, shost->max_sectors);
>  	blk_queue_segment_boundary(q, shost->dma_boundary);
>  	dma_set_seg_boundary(dev, shost->dma_boundary);

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
