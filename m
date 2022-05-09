Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F6C433EF
	for <linux-ide@archiver.kernel.org>; Mon,  9 May 2022 11:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiEILsj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 May 2022 07:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiEILsh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 May 2022 07:48:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1F132773
        for <linux-ide@vger.kernel.org>; Mon,  9 May 2022 04:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652096682; x=1683632682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1x+FMxo1b1TQU/wdpcA4rbUnkh/IM34rDwgwBlnHG3M=;
  b=XhSxfVZu+nNhCoNnMwDId6KPH312pSGRTCM0RfbB1OMTJMCcUtZRPVrf
   H95vX2G5sH2nJVdIlj2krXX/8mWDfzdDeAym4chApVhKKxzgcxT5AII1O
   EFuwDVr5qzZnxVdw6Sso08bQ76ZkDS4djzSG4uq1+G1/l4osbqTP4q3Qo
   Oqg35cJWRkFeFU0gjbTaw98FbJ4bIwF2x594dLdjYxVM1nqXOdUw/m9DX
   zx8zk8gx9mAgPsoP3iMWpl82BJyRlUjqbONVWCtKSZwfeOldncsryI6Gv
   C4IaDUHKcTZDM4+2h1w+vfhgiOjpzqCkqZSpUYbAkW6NzRQNrvoWMCg/6
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647273600"; 
   d="scan'208";a="198691008"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2022 19:44:42 +0800
IronPort-SDR: iGcChGb5H6EuAfHm9PPe4+rDNHQtY8a5Qt6Lf/ol/olrIRRXm4Hf75vlRSKRGCzd8cwpTOR/pv
 1FCWMPpp7ImZLV5xPoPFo1dO2TEILTxNEZvgTWQ7dSa3G2F8OoUSfJtY/YwohtQEkiHezNagj6
 yB2mhJrblDTWiibigDXgVyIHsumBHid1W5xg0zRoWLsA0N6YTiVHXYHBFLF5nf9SVZRQK9KM+Y
 1GgURSRLdg/Fsx/VtJV0lNn6+sgvR4SCart2s8u9Vf5xF5qr5DtplJnOu0TPPAhWtRUgEV84y0
 caoOwO/eZRbIMw9TWGG6bg6f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2022 04:14:47 -0700
IronPort-SDR: airI6jyTz0hZ+qow2Y4vgEu6g7bkMoy8TPQwFikUEUFcPlpFRjkyZUOsvM+yz8x4TWzRyghQwM
 +Bnh7b4RbF1Y8SiNrlzBec2UOdm932Sm6Mw7fX3Rhs0rhKsU1jCJlZE+Iz0G7beruRRBLUvNtQ
 bVEyL3t6Qaf4tEpGYWbvdCWQj9oOdweE+SizbvColJLj6UTjRFo13UHa4mB/WeHjXB+ETWO1J8
 vg++cxSB2Rl7v1DF+o1CP7FiM/jMRbiIFxttrgYdC7+KGHAmOVOyiagewcWWcxFMeFvrmj0vcH
 8us=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2022 04:44:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KxfV15VWFz1SVnx
        for <linux-ide@vger.kernel.org>; Mon,  9 May 2022 04:44:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652096681; x=1654688682; bh=1x+FMxo1b1TQU/wdpcA4rbUnkh/IM34rDwg
        wBlnHG3M=; b=T8q8DD3Okj9Vto6TIzr5k7zi1PPmv02jIQOpzmoR4FKPkzCIys8
        Vd3QE3FK6Mf9rhT6WY49FG2c8Yi5foX96AGnQtdfrACKGyEZrLBdeb+BfmQZCFtB
        7l9CSkG3jfq+/K4ia6GvGzd2F4InQuyAbx5aa6PT4xrkkWlJYOHHVtqoUFELsxtM
        uSdmrepugLZkDFpLrQynIzYBvcG8F0ngJdq+yFjoj/3Oq2bITAYjVm/+xGjz2D1d
        /Yxx+Q7scsPhGGhLD0KHZmli7BijM+2q6+PftqxyHyd1oXPp3hxga6jHskgd+KY4
        TNNkiverp7SmIxKi0FRMbCUv+amaUCwlTSg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dT_cQKSrTSpN for <linux-ide@vger.kernel.org>;
        Mon,  9 May 2022 04:44:41 -0700 (PDT)
Received: from [192.168.10.49] (unknown [10.225.164.111])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KxfV01VqRz1Rvlc;
        Mon,  9 May 2022 04:44:39 -0700 (PDT)
Message-ID: <a54d0558-be00-b87b-9238-187978ca06c1@opensource.wdc.com>
Date:   Mon, 9 May 2022 20:44:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] ata: simplify the return expression of brcm_ahci_remove
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220505022133.55852-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220505022133.55852-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/05/05 11:21, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/ata/ahci_brcm.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index ab8552b1ff2a..f61795c546cf 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -549,15 +549,10 @@ static int brcm_ahci_remove(struct platform_device *pdev)
>  	struct ata_host *host = dev_get_drvdata(&pdev->dev);
>  	struct ahci_host_priv *hpriv = host->private_data;
>  	struct brcm_ahci_priv *priv = hpriv->plat_data;
> -	int ret;
>  
>  	brcm_sata_phys_disable(priv);
>  
> -	ret = ata_platform_remove_one(pdev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return ata_platform_remove_one(pdev);
>  }
>  
>  static void brcm_ahci_shutdown(struct platform_device *pdev)

Applied to for-5.19. Thanks !

-- 
Damien Le Moal
Western Digital Research
