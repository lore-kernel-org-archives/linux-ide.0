Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F085C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 20 May 2022 23:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiETXpe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 May 2022 19:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350444AbiETXpd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 May 2022 19:45:33 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F191A812F
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2022 16:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653090327; x=1684626327;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=hfi3E7kDBJLJx4Zxu9TcWPvFF1PaSwgi6GrImvpsk9Q=;
  b=nOoR7sviqKpQDDXz3capOW+QMNlbQl+974lzMqqVJvylV83PX2fETFNk
   5SvGNfLZM+rAeCrhNlbQhTAJ89L0nVABWDLOE+NSstahfDxGLxX9Y3HYx
   9ahqLR3hozkeMR80dngbTF5bJ2zoZKDckmT26g1ccyuUzfiEFvTiZcKqs
   5GVJ84fb4D8EcUb3T2uDUMljwBy30EswSCcyjsnI2a0I2uPbLpmF9Q+iN
   ciBkVqIykzAzt9/Ytyk0gSQIyjcBV3BQtRabS6HpdAiacplFJeGQSQuKe
   fdffGj8XBUEJaa3MtAySW8X4Z4ZqVlyPwGpK9Nbk9ai2/r3mvTVBPEMFP
   A==;
X-IronPort-AV: E=Sophos;i="5.91,240,1647273600"; 
   d="scan'208";a="312942317"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2022 07:45:16 +0800
IronPort-SDR: +Hdxa22aiaHcJwqUrGwRfrYHcTnc9rhGLYl92diokaQlDD+W5tfyf0HoCt8/hm6SI9ON0ahVE8
 A4U8NBFTnci3jfeaGKNl1IiGYzxvfNM5u+ns+P+i8UCV02mSWMrR584/Kmn2t6TrWflR2Igboy
 p6b4Kx1wiHFYy9BEUvHHu0flI79sR50odeWUtw6dyUo2BXYWAyzsy480qcucbVWtsSK3cRSNnr
 EvywM2hQ4P86PCo4IxbKIPKXoYSndxwDKhMOXI+FOZu2grZiFaYiUMZ/eX35RykUorVr5My28M
 4g/M2qdc7FKPxyojpmN/jSod
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 16:07:59 -0700
IronPort-SDR: 6ovL9C13Qdth7PRmV75UySp/k2TMnork1Y9ITr21dMEw0WwOLY8pWzVvHmva/JUmF9v5R1ZFGu
 wM7qtBX1p2ZkFeLMD+ozFwNu7wIK//ti3Wc6Qu/xY9JWI2m/M08oUP3MJwk6rkpWPinPegyXY7
 NAuQ78RgFeaMKRbud14waRbMxt+55tLGpoOHDiG8Tu8crsLjP6ejHqD6Np3oPnUh975DqY3Gtp
 lTxZDQkqZxGMNJf4jraerUmzgREcf3bFamnBbCk02ghiCH/zieZ6zG0WcSB0ppc++0OWFbocKh
 Ikc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 16:45:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4jyM5dXtz1Rvlx
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2022 16:45:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653090315; x=1655682316; bh=hfi3E7kDBJLJx4Zxu9TcWPvFF1PaSwgi6Gr
        Imvpsk9Q=; b=EaVdwYvw8ZiM3c5Q8J5VqfNc/48WVudoYF62SEZ5g5qzr+Yjuco
        xqZuSMFUT6bhZYX1hPp9KPJduFOmsdtAXNijCL7BhEXeRSZ/j1lDQ17cAHQBYdJ2
        Ha1Aox6ko8xCmcUkWP9WEPY/6jTr236FW+tn7CtfykHL0z+KnruMD9h+Adw3Ryvb
        6gP2lOzzGequwMpRSsxJlg9zZW6dfXEAAMGeCmrmv1Dd+tSnnOZt2zsuuFHL7daN
        oDlkVKlTqYAGcmCDKKovSOqVq/wZQpU5tbrR35W80aQDGGPhy/gNfQuhOkwQdyj5
        AX73w40O0MQ19NKWZ/ZC89DUbCKKdKA2Ymw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bCBTccjCfpXe for <linux-ide@vger.kernel.org>;
        Fri, 20 May 2022 16:45:15 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4jyL60DZz1Rvlc;
        Fri, 20 May 2022 16:45:14 -0700 (PDT)
Message-ID: <d2d4a222-b3d3-b3a6-41a4-db2fc4c11038@opensource.wdc.com>
Date:   Sat, 21 May 2022 08:45:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ata: libata-core: fix NULL pointer deref in
 ata_host_alloc_pinfo()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <3727e0b4-3958-283f-c0cf-6b8b898ab018@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3727e0b4-3958-283f-c0cf-6b8b898ab018@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/21/22 05:53, Sergey Shtylyov wrote:
> In an unlikely (and probably wrong?) case that the 'ppi' parameter of
> ata_host_alloc_pinfo() points to an array starting with a NULL pointer,
> there's going to be a kernel oops as the 'pi' local variable won't get
> reassigned from the initial value of NULL.  Assign &ata_dummy_port_info
> to 'pi' at the start of the *for* loop instead to fix this kernel oops
> for good...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
> 
>  drivers/ata/libata-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: libata/drivers/ata/libata-core.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-core.c
> +++ libata/drivers/ata/libata-core.c
> @@ -5470,7 +5470,7 @@ struct ata_host *ata_host_alloc_pinfo(st
>  	if (!host)
>  		return NULL;
>  
> -	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
> +	for (i = 0, j = 0, pi = &ata_dummy_port_info; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
>  
>  		if (ppi[j])

I had a fight with this one a while back as the build bot was complaining
about this a while back. pi cannot be null in this case, but silencing
warnings is good. So OK.

Just one nit: please move the initialization of pi to its declaration to
avoid the overly long for line.

-- 
Damien Le Moal
Western Digital Research
