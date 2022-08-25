Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC3BECAAA2
	for <linux-ide@archiver.kernel.org>; Thu, 25 Aug 2022 22:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244408AbiHYW13 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244440AbiHYW10 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2022 18:27:26 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB001C59EF
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661466444; x=1693002444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5hpw5clYxJvoQGyX7Gfm68NkZgW2078Mw0aCa+jMZ3E=;
  b=W+A3tt/aurG/qyzw/Zucii/qJXirJ/t2HQw99Rw4KxfR6UuHWsffvfOC
   9fPMyCkOrG42c7CyH6KT9+0sXIQtWql5nS3kJ+SEHdaZAF1B2wwTmIqEP
   U7/gMQ1eswG27mIH/ZHF80/R6Dd6+o2/ZqghVl7Zp7cq6c7wgmWuSW+lV
   W1GfFh2w5k+AFPvrD2S7xcN33eZCfiswRY1x6Dpq6EZ0Os+4wMQ08TQCq
   HG/zkXgEF1NYplxqpqHkpiR8MoGPtylr+1lBJ3OWQ5rRJXEFxN3LGT6FH
   TcZgQ1S+qSiLSXp2lLxyEhiNVukhElOm3h64MgvmE9CjqfMPRdpSzUxIw
   w==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="210184915"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 06:27:23 +0800
IronPort-SDR: 0hVaZOv6xbxlkeEaiklJXXa6mP8T7xIqJkR6c+ZT8LjF470rqte1IvQ57LAEE9Wo1YvjixCHE2
 yRkYk7qdmAeIsn/oBIlULhMMss0cb209iFrSONRvRF56FlA7YT3cyVRCUTr16gBTr7DRiG5YH+
 7b2/XfGEe9mpEfLL8DdOMQ7/uFPw3J5/JkmfnpNuTNZux5LCaybwPzcdND4+Kb9FDj3hKh86bd
 sjX4/3jEAV0oYUmlqc3pF6u7yPopNOdn1P8LIxISILAXgpquuBGf0sZgSLH/TVpc+5pJrFQv9c
 9Z3ZUJHpoYUo6UWyirtUOYP0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 14:48:00 -0700
IronPort-SDR: OhJnc9uHuy0sqRaRZUeyBolYWVmMCF1buUMQv90NpCQJCeFSTY7tV5tsy/7ClIR7fn9muL3Yho
 JkADzTC6trWdThHgBWxRPBimqyEBAKU/6jXhoIz75UutedDc3Y+/LJSgT/JBZ2FY2u4fxhQn8F
 bGgpCQij8GYLAaUTA7shsOyddwLcBc4pEHNuo1boYqUKq41xBqXFcOWmDHwRfzrwESwD4OYJLg
 p1hgETX4Hn4035hmZtTuWkLHgOyS+yvK+hyVMPldxPFsdcykF6AMYBLO4gIwn18LI0LyVFKNd1
 SzI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:27:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MDHdl5Tjnz1Rw4L
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:27:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661466443; x=1664058444; bh=5hpw5clYxJvoQGyX7Gfm68NkZgW2078Mw0a
        Ca+jMZ3E=; b=of09kOgZYhdp5kExVXxEF8Z202tHrkWp6/6iM0qZQHUZu+6HRv3
        WhYCBtXjGmdgzccoSFZir3UJfstLkYiSFRpimS9BNQZPNMuaknnNriSkib3n+I1b
        U8TL6+X7qfOoiiB3HYAW/oKwN1mB4O1d54s+YufkK+FjfWmZwp0NiWAOMVJLplra
        sDOfNDPCsl2Vn5to7Ksi3beyn5bhScEfuyVNtlTiy9o8qayFtp+1UVqjTYmaYwhv
        L6rizhy9vxbASP/nYCdYGmKgAGzXnlDDPxR872w2jmT6GXA3XnO8+VLtAnzVFgX/
        htwfRcv5WdMdgDoZBw9hpkGzHaSdzvBRRuw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7f63N1yg8dIm for <linux-ide@vger.kernel.org>;
        Thu, 25 Aug 2022 15:27:23 -0700 (PDT)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MDHdj4z6Jz1RtVk;
        Thu, 25 Aug 2022 15:27:21 -0700 (PDT)
Message-ID: <a4948117-dcb1-a27e-941a-811832e9a7c9@opensource.wdc.com>
Date:   Fri, 26 Aug 2022 07:27:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] drivers/ata: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, s.shtylyov@omp.r
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220825123644.9082-1-yuanjilin@cdjrlc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220825123644.9082-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/25/22 21:36, Jilin Yuan wrote:
>  Delete the redundant word 'in'.
>  Delete the redundant word 'to'.


> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/ata/libata-eh.c      | 2 +-
>  drivers/ata/pata_macio.c     | 2 +-
>  drivers/ata/sata_dwc_460ex.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7c128c89b454..ca865a95cf24 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -863,7 +863,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
>   *
>   *	Set ATA_PFLAG_EH_PENDING and activate fast drain if @fastdrain
>   *	is non-zero and EH wasn't pending before.  Fast drain ensures
> - *	that EH kicks in in timely manner.
> + *	that EH kicks in timely manner.

As already commented, this fix is not correct. The sentence should read:

	that EH kicks-in in a timely manner.

The patch title for this fix should be:

ata: libata-eh: fix repeated words in comment

>   *
>   *	LOCKING:
>   *	spin_lock_irqsave(host lock)
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index bfea2be2959a..076212fdb9d9 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -666,7 +666,7 @@ static u8 pata_macio_bmdma_status(struct ata_port *ap)
>  	 * a multi-block transfer.
>  	 *
>  	 * - The dbdma fifo hasn't yet finished flushing to
> -	 * to system memory when the disk interrupt occurs.
> +	 * system memory when the disk interrupt occurs.
>  	 *

While at it, please remove the above useless extra "*" line.

>  	 */
>  
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index e3263e961045..a4c83a6e5631 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1087,7 +1087,7 @@ static struct scsi_host_template sata_dwc_sht = {
>  	/*
>  	 * test-only: Currently this driver doesn't handle NCQ
>  	 * correctly. We enable NCQ but set the queue depth to a
> -	 * max of 1. This will get fixed in in a future release.
> +	 * max of 1. This will get fixed in a future release.
>  	 */
>  	.sg_tablesize		= LIBATA_MAX_PRD,
>  	/* .can_queue		= ATA_MAX_QUEUE, */

Please move this second hunk to a different patch with the title:

ata: sata_dwc_460ex: fix repeated words in comment

-- 
Damien Le Moal
Western Digital Research
