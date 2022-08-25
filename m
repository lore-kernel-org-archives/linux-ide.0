Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84876ECAAA3
	for <linux-ide@archiver.kernel.org>; Thu, 25 Aug 2022 22:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbiHYWrv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239218AbiHYWru (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2022 18:47:50 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB063C6B78
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661467669; x=1693003669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jmZ4y9zIob46bh2rM8o4F3fEfJ+GVDi8MB3UI98H7jY=;
  b=FwSHvPln3h2qym6TlODFV4jl8km0Snc/lO1+Y5DobTK2ZTjS65fPqyAT
   xieL6TzGT/6qt0ixCCq54pZwJlXVNtaKV4fyr/lzX0hvva7GW1duFCZTz
   zRvw6zMcuooByk0iQUmGe7Rc0OcVXBa3UvU3OAsoTnP9NIjzK2scCpidj
   J4qjV4IQ7o2MCq5/W3B3raoxE4XnhEyJHbyg9lMdvwfELZSZeZnTWAmMd
   oNh1lw0wLDdqONdlGGm3BPg60khmWRge9mhPA7C8EmtHxQ7opL/bFqkqz
   aMEJGIZ8eSasqRJbCYwMdN0vuhWb7NEE7flzdghFtyAtGYYH0TrWjvRo/
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="214834937"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 06:47:48 +0800
IronPort-SDR: URWi30K8hfNT95rh1xFyXvnqlnupeJcK23IPUP3jdLR9oQ/sUoSwqyG2q9LJZkUvd06h0WBwP6
 LMnt+6ptklBrd8PoMb6G72Q63C3BGQ1sVz2/VbDEnorj1TWrvVm/FPOk7meRv/Yy8h9eLQl/c3
 Ej5ftUkTE2hl1c4rEkMdxh6j8u0K7TJufqU74V4qMV9EwGfg6gg54GMqHiEBASW1PEsBMohU74
 eFT7a7qTsh2xRpc3mhAq87JGUrL25m+vlKzoRm055/caf8JBjj4Qrr5H3NrpTWovxpTIfbNAcS
 EYcahrIB8Nz+7Z0lgCbmP781
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:08:25 -0700
IronPort-SDR: 8rSPoIVPBknQQ1OeO4KjaQR8lqRrn9zPp36+Q3N/MJaBmzybfvmhyh3FMtd/DU/ejEdFYA8WFH
 BXIgcnUwqguGAjbyeVWGlzim51PuhOBR4B++PfMLMwh96Y0VcjRFGmKjqhwxuZ4CBwo38YGb+r
 zNTn/rFnyX+wY0pJVW0uCaNczDfuzT8851Bpaasli2jwEIJj5G7tUAlzq61DoNF1xpM6aDqeiT
 4HuoMLTxTrs05Re3cYcZ6veFhC9XxXI1QPkM5rpPwiFmE3k0doHmDMzaWlcB91RFgXdv79Q4ir
 16g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:47:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MDJ5J48PYz1Rw4L
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:47:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661467668; x=1664059669; bh=jmZ4y9zIob46bh2rM8o4F3fEfJ+GVDi8MB3
        UI98H7jY=; b=d9Kzbemw76idps6mCmYdleMG0/8OTWdOd8eBiFkDVrx5DmCI6Nx
        8wLUj+voNOCu2CgkNmcRsf1K+6ZhQM8idEqerXqvsUD9nuMB6ki2e/Oy4+NDh/uU
        skkG7XTiIaBbl5fuqEMts2UjCkLsGd2kKZsl62dW/Be65ST9D5zAzVJ6UJDWWQfG
        WLQjEb3vGxD9oH0kRKEe6Xv7LYBkQzg+zUDq3d8IzVFIYEGENwg9B5nkFOJ02qZ7
        YpIvtoAiO1CI0uua9Aj/fWR6qZJiIRquMG3AHapQpC/m898F2/vXdYrqF82mpefJ
        OqnKFCLExzeGLTXllHjZVaEXkhmRHiY/YQw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tw8grc8I0Cb5 for <linux-ide@vger.kernel.org>;
        Thu, 25 Aug 2022 15:47:48 -0700 (PDT)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MDJ5H3Cjvz1RtVk;
        Thu, 25 Aug 2022 15:47:47 -0700 (PDT)
Message-ID: <b31200c7-4737-a4fe-45dd-83ad70892177@opensource.wdc.com>
Date:   Fri, 26 Aug 2022 07:47:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH linux-next] ata: libata-core: remove redundant err_mask
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220823122914.211355-1-cui.jinpeng2@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220823122914.211355-1-cui.jinpeng2@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/23/22 21:29, cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Return value from ata_exec_internal() directly instead of
> taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Applied to for-6.1. Thanks !

> ---
>  drivers/ata/libata-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 864b26009eae..0ba0e692210f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4340,7 +4340,6 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
>  unsigned int ata_dev_set_feature(struct ata_device *dev, u8 subcmd, u8 action)
>  {
>  	struct ata_taskfile tf;
> -	unsigned int err_mask;
>  	unsigned int timeout = 0;
>  
>  	/* set up set-features taskfile */
> @@ -4356,9 +4355,8 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 subcmd, u8 action)
>  	if (subcmd == SETFEATURES_SPINUP)
>  		timeout = ata_probe_timeout ?
>  			  ata_probe_timeout * 1000 : SETFEATURES_SPINUP_TIMEOUT;
> -	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
>  
> -	return err_mask;
> +	return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
>  }
>  EXPORT_SYMBOL_GPL(ata_dev_set_feature);
>  


-- 
Damien Le Moal
Western Digital Research
