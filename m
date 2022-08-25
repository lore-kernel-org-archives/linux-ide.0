Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F2EECAAA2
	for <linux-ide@archiver.kernel.org>; Thu, 25 Aug 2022 22:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244448AbiHYW3E (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbiHYW3D (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2022 18:29:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6119F9DF90
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661466542; x=1693002542;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zPA1nUPaxINk2WQfO66Pwc3UH8TCpssUnfgvdoBacWI=;
  b=J7BTmpQ3aZG9JHRSj5+pu/1aqDlgb8I0FOhghO1q1YgKCFjfGpZ5STOz
   /H4BzvgpKNi4A30bcUqB59S0yCqFCzvo2x1WPjG+irxoEaEY6jQkAe4LZ
   UKe9qSRvk94pdyKKC6MGniJYbW6sLZOOnnZHC7HHZd3KwFSeZvsLDmHvm
   xuk5dmFbaLSsY3jLGglrfwoumtdDtJCb4qjJhHyaht5qqjGryEla0aJhJ
   hYzAjMTy1W5p9edyNAcEn3RYk5ydUOar9fgDtyM4Lc4a+lvF4tWeHkXKb
   e3fLE51rIs/s7K5ePYY7lr95JJ5lwntRVcdFXR37vu4nZgHd+TbFEvGwj
   A==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="208129983"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 06:29:01 +0800
IronPort-SDR: ncvuOH8ejZYTzn/DLbvGetG3oSan1ToiDExomrFymoQH5vorhVPrMay0SA2td2vK48HTblaiD8
 JB1A9xNpV016GI84/P5SzfkNf38rXAgKJHew6V4iBpIwS2n+CD4JKIkn/Eyy9kPgCoeNAog5Zt
 KtE++kC2793Nds9s0wRq72aNp5KuuN8CkwNII49RHyaaEQDoOsix1eRnERRweaVMxUGSq4czWR
 f6mcOdJCyinoOil6zuAqimC/Qtx1XkQB7xeAeozwIWONnmIZsbV8y2kpRGk8X1VslBuwkj+raA
 NVjkBiZb+BEvLQrGthT/5//0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 14:49:38 -0700
IronPort-SDR: 4zBhJjPHz8srzVNeBLEeTGHb0rZppW+K4R4uGA0UJCJbMSwVYVPgOeDBbkcAGLquWRmSWkzhRD
 fx39EjCJ8YUNPtYYwRtJ7Whh4hZg0404foQkkIzbphUfnuiEHe6draorHD3OP/KtvUgSm76tyl
 uz3MtWzJ/0+DffVunpBmt+sjlR7dT4OEkX/233ZhZBV/iQ0iXO2+U0uXR6apMM4BbQHeytGckO
 JUIltvRJH+//frKOPwTJX4kx5xAL+6r/ugnvvE2J6KgmcGAn7YTmo5Bg+2ep30waRzjuyCssCf
 cmw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:29:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MDHgd25fwz1Rw4L
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:29:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661466540; x=1664058541; bh=zPA1nUPaxINk2WQfO66Pwc3UH8TCpssUnfg
        vdoBacWI=; b=GxPFvru5KanAu+h+vMijaldyJ+N58ykeD6mbb8gWt64bI2kTOeB
        NPkdTHxLV0M7JUWsjiM9iyaQV4NA4hepibbz+1IfR/TfKvIPddkbIfyATL6+IXeq
        Dzf3dKEPPIYCXBIczOloC137sv7rR9kIJSj9yGqUr1vOJ8VLkzO62OEZEnuxPxIa
        2oH7KmiLOoPROPz32/zXgnHCFsZU53iVkooQ6nJqhjm9XtYgYytjNyWw5G+nyuti
        OHVE/naQi+sXX2e0LIK2PlYoaXmezl0jrmCZwsAj/SNLTHOHbdg0c4HWl2u0syLK
        9+yqkfQ1XzZ0vk+Ho5uoUmgggeHFEzYR9vQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BLConoLFdu16 for <linux-ide@vger.kernel.org>;
        Thu, 25 Aug 2022 15:29:00 -0700 (PDT)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MDHgc3Nfpz1RtVk;
        Thu, 25 Aug 2022 15:29:00 -0700 (PDT)
Message-ID: <8137cbbf-443a-af3f-544d-884d20253bcf@opensource.wdc.com>
Date:   Fri, 26 Aug 2022 07:28:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] ata: pata_macio: Remove unneeded word in comments
Content-Language: en-US
To:     Shaomin Deng <dengshaomin@cdjrlc.com>, linux-ide@vger.kernel.org
Cc:     s.shtylyov@omp.ru
References: <20220825145215.5542-1-dengshaomin@cdjrlc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220825145215.5542-1-dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/25/22 23:52, Shaomin Deng wrote:
> There is unneeded word "to" in line 669, so remove it.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  drivers/ata/pata_macio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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

While at it, please delete the above "*" empty comment line.

>  	 */
>  


-- 
Damien Le Moal
Western Digital Research
