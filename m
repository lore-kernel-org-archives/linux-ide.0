Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8254C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 20 May 2022 23:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbiETXdw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 May 2022 19:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354134AbiETXdv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 May 2022 19:33:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1421A8E14
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2022 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653089629; x=1684625629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KysS6TGl8Pc7oX51Xw7igXQNpZmTRMOUskNztCAEee0=;
  b=fTDVX/V7Z/UYHdIOShLg92y2y9POyPaEvSiLmDStk6txVuns7uGjoSBv
   GBT2+3NJ1kAv+7t3Pdhoup8AYzP8kMB7xmYR1kkGigPCUzxELiKy5m5Zv
   gbKlkE3JDcCUbiCAXRYDH/HfTgnKWUjnXo0t5YU1Jfun5EUmalaRo5Bfg
   7A+XBpEOFHZDQAbJ8pnwL1v41y7z3kQUipvAs/3m7Uy/R33+C7YIyD2Fu
   grUrH/cvyt0LnP2eX9ld74zyl4usI2X/U31suKJMJKiGKQllBYUrJDDIH
   AAJf8QYR6sLJnCtudRB6knvdyumMsB4jiisAxhzJ8wfBrMTN4SOzvc5kg
   g==;
X-IronPort-AV: E=Sophos;i="5.91,240,1647273600"; 
   d="scan'208";a="312941537"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2022 07:33:34 +0800
IronPort-SDR: tN7Vm3HuXjgOXrarutP34n0xKFoN/SWJ8yBbJalfAYnCRp/MlCNpFSL2VLfolmOclEizDotaH0
 8/DlVnQeOtnJ3KJjuEOwikMB087nS4NORMwVxbajO9AVnbP3mQ6n6D/6HEZ8/S5lsrdkcEYaTF
 jTqcIS3lnaJWdYFfV024apAOeiIsPZwWSARqvt/N9yi3EraFuI41s9kevqV87UkdcydIIFdK/v
 rSjPuAyezTfORAL+ZMDtLSpbVYPgUU1EuZdi4hmLUG4fvmBieLat1Bwk5THfjV6Cyj/X8ekWhg
 4LcP/3enkcoQ6J+RpGkOJOe2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 15:56:17 -0700
IronPort-SDR: N0ZIVj4NGoUarXbEVWp0u1m/iknkw1Tp8omc0dT5827C6354jbZCJ8IMWDLEW3ikN1jGAUZ5Bg
 6wYbP1iNi9EQ2cRitfQLvyPAHd7gHD7XjM8EpfmqHyAW50ExgsAw1YPSt8alUWBPVo/0uFR6oR
 +qkav5c7XhMK76stQtv25PP28oHas8BNWvIm+zDS367IydoKuIaBpY64P2CFFmqmYWNHa5owdr
 LIXwEg5srF3f1oS+0t09V31JChDQuJMKZVWx0dL1GcxKH40grEH4JPmVvaMo1a+pZ6Mshm7mV0
 Tvg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 16:33:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4jhs2chsz1SVp6
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2022 16:33:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653089612; x=1655681613; bh=KysS6TGl8Pc7oX51Xw7igXQNpZmTRMOUskN
        ztCAEee0=; b=uDGNOQIsh48inaoun4AJwCUgoJIBlCt2pvcG1/RPSae5nO73YFv
        dTjg1WJbEhrRrJrL6FBx9wI2n5x3PtQ3g7JxNREFUo1z0h8Wcsk+WF5izoeuwNqH
        5jS0Kz3SYNDbFExwLsgoDjZJgb/Ucoy9tTCeI+mAppQxcV5PuqkSjRGCglCLQalS
        pw67JD9iyU/mfxiU94bNsf6CnzD81OkVdHhRpUGqWsj20ClGWM7ej9elGn21cVjq
        H/bA5J78ULBEWq2jSPrlOwkLJrJ/Xjr1tQ4Qm9Sphuo/ih9Be4N1Cwlc2JTqAIlw
        bvuzzI1ozKNOCj8qIPICikHcZQLCqaxHFzA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ssvVadn-9Ewt for <linux-ide@vger.kernel.org>;
        Fri, 20 May 2022 16:33:32 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4jhn73qjz1Rvlc;
        Fri, 20 May 2022 16:33:29 -0700 (PDT)
Message-ID: <250a10e6-40ae-e4e8-ae01-4f7144b089f8@opensource.wdc.com>
Date:   Sat, 21 May 2022 08:33:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1653035003-70312-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/20/22 17:23, John Garry wrote:
> Add the IOMMU callback for DMA mapping API dma_opt_mapping_size(), which
> allows the drivers to know the optimal mapping limit and thus limit the
> requested IOVA lengths.
> 
> This value is based on the IOVA rcache range limit, as IOVAs allocated
> above this limit must always be newly allocated, which may be quite slow.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/dma-iommu.c | 6 ++++++
>  drivers/iommu/iova.c      | 5 +++++
>  include/linux/iova.h      | 2 ++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..f619e41b9172 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1442,6 +1442,11 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>  	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>  }
>  
> +static size_t iommu_dma_opt_mapping_size(void)
> +{
> +	return iova_rcache_range();
> +}
> +
>  static const struct dma_map_ops iommu_dma_ops = {
>  	.alloc			= iommu_dma_alloc,
>  	.free			= iommu_dma_free,
> @@ -1462,6 +1467,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>  	.map_resource		= iommu_dma_map_resource,
>  	.unmap_resource		= iommu_dma_unmap_resource,
>  	.get_merge_boundary	= iommu_dma_get_merge_boundary,
> +	.opt_mapping_size	= iommu_dma_opt_mapping_size,
>  };
>  
>  /*
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index db77aa675145..9f00b58d546e 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -26,6 +26,11 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>  static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>  static void free_iova_rcaches(struct iova_domain *iovad);
>  
> +unsigned long iova_rcache_range(void)

Why not a size_t return type ?

> +{
> +	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
> +}
> +
>  static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct iova_domain *iovad;
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 320a70e40233..c6ba6d95d79c 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -79,6 +79,8 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
>  int iova_cache_get(void);
>  void iova_cache_put(void);
>  
> +unsigned long iova_rcache_range(void);
> +
>  void free_iova(struct iova_domain *iovad, unsigned long pfn);
>  void __free_iova(struct iova_domain *iovad, struct iova *iova);
>  struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,


-- 
Damien Le Moal
Western Digital Research
