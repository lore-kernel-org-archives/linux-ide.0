Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858E8CCA47A
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jun 2022 08:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiFNIct (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jun 2022 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiFNIcr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2022 04:32:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45933286E4
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 01:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655195565; x=1686731565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tjdGPEcRSdnZLqy6B+WSAxdgi3miYFwPZpstyD652UY=;
  b=hrPvOR8qkjdkM32wZF6cRuQRTnGTkI4p8K4yR7gAeRch7JwaLolTmsUv
   P/9uCL+HcpvPA/e/TmbYb/WOfUXJRs8EnkBFdM/I2RxivXNZcu3dBL5aX
   O5geb184wL2jRpEtvisSH49eT/tbdPhD8zFiJ29BjfWC6MATK1pZdaTpr
   +G8rMBL7LCG5YsObrj/L1+ddpde/Gky7mkHss8KhjLnX+G+oI8QUs0q9+
   G0LjbKTKj1xwYlzF2t7MVwu49fgZRmfROgoOszDpcnwlSNO5goVj5h0s+
   TYlR6i6dPoUJbvVOunXE7CK2yqGGlVOBaMAIcpl8kaJGUfOXrfWDmHdql
   w==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="203097365"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 16:32:45 +0800
IronPort-SDR: aGdhnKB7/a0WRcCbdbQIoGzKL9tRyYJxpcNVMcTp00Dwef6u06uTr/DcdgfVun3i21l9IABP0e
 s2IwEaUxTKAsbqhh7ah6CvNIzWcL0m5RDY6EmEvCSqFeRWldDYpdQPU/h4bnMgBoaZumatgRZp
 m/NHaFmdCWxjZlL8Ov+JWmF+pPWA2T/IQ0MZmlF6bW/p/79JXLTecwQiWf7QIA/EMluX/NZe7p
 4P184nJYiUFcftI9zm6h4T2+yW7g15NvkxIrRDOdb2adKcuWSBQpYhhgseadLk+oTnSf+PtJ0C
 eS2M+cm5KmJalNAj59CyJ+th
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 00:51:20 -0700
IronPort-SDR: M0RqBDesqnFIejIfepD7Q9JXp32hRU472NGBfEIVpd+FVFJ5dbZ3kZ4JzWTE2aj1gOe31SOrry
 7gXDD+CFoIxYq/bd4APgXp0WwiRp94W1ljG3W1VNQVrKCYOwuk8Tbo9OsnVzmoFqnfFZh/ON45
 z/dzEDsrmEzQc1ga6DDwCUzuXSbAHj/WDdic2mbEDzKD0f3Ol48ih1r4c/3zNDlM1Xw2j4/v18
 /j+g9NDmwNghp46Xbl0K8OFaF1EiyUNO3NrfwYWxBH3D3nrrfmfFp3BtXoi7DXwhelf+1Q6Txy
 g/0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 01:32:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LMhWx37f5z1SVp1
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 01:32:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655195564; x=1657787565; bh=tjdGPEcRSdnZLqy6B+WSAxdgi3miYFwPZps
        tyD652UY=; b=k3YeNMEzcnW65cYyTPPM9eAGBEg7SXhxbXDThNf4HAGhgd+sD6e
        zvGdIfOfKD8+IzjHRj/vKCbBh1Fy9/blMBwLTgV3O7jl5QfrCxTweBH3RwD3881r
        FmnbClQutIzStBiD03C9OyAbby76lyZs7aG4NxM/BQXrq7Ax+abZ5Mkr0LowHRy2
        9oO335fBLKTXdqCuJrW24iGALrMRysguswwig9UgnjPSKb+uEyDwNG85o9ewxzwV
        ti8pvNGZLZuG1uirZ+NN5SAAyX0zShyzf1l/HWSJp50maRGCh6Bb7L2UgMu+jRHS
        XiyuNCgppN/f5MKX94Ij/mOK5l18xxc68Pg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9Fd2tWAsxChR for <linux-ide@vger.kernel.org>;
        Tue, 14 Jun 2022 01:32:44 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LMhWt3sbCz1Rvlc;
        Tue, 14 Jun 2022 01:32:42 -0700 (PDT)
Message-ID: <d06e9910-527e-cfa2-f2df-737fb4799fe5@opensource.wdc.com>
Date:   Tue, 14 Jun 2022 17:32:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 12/23] ata: libahci: Extend port-cmd flags set with
 port capabilities
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-13-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220610081801.11854-13-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/10/22 17:17, Serge Semin wrote:
> Currently not all of the Port-specific capabilities listed in the

s/listed/are listed

> PORT_CMD-enumeration. Let's extend that set with the Cold Presence
> Detection and Mechanical Presence Switch attached to the Port flags [1] so
> to closeup the set of the platform-specific port-capabilities flags.  Note
> these flags are supposed to be set by the platform firmware if there is
> one. Alternatively as we are about to do they can be set by means of the
> OF properties.
> 
> While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DMPS and fix the
> comment there. In accordance with [2] that IRQ flag is supposed to
> indicate the state of the signal coming from the Mechanical Presence
> Switch.
> 
> [1] Serial ATA AHCI 1.3.1 Specification, p.27
> [2] Serial ATA AHCI 1.3.1 Specification, p.24, p.88
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> ---
> 
> Changelog v4:
> - Fix the DMPS macros name in the patch log. (@Sergei Shtylyov)
> ---
>  drivers/ata/ahci.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 7d834deefeb9..f501531bd1b3 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -138,7 +138,7 @@ enum {
>  	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
>  
>  	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
> -	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
> +	PORT_IRQ_DMPS		= (1 << 7), /* mechanical presence status */
>  	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
>  	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
>  	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
> @@ -166,6 +166,8 @@ enum {
>  	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
>  	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
>  	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
> +	PORT_CMD_CPD		= (1 << 20), /* Cold Presence Detection */
> +	PORT_CMD_MPSP		= (1 << 19), /* Mechanical Presence Switch */
>  	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
>  	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
>  	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
> @@ -181,6 +183,9 @@ enum {
>  	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
>  	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
>  
> +	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
> +				  PORT_CMD_CPD | PORT_CMD_ESP | PORT_CMD_FBSCP,

What is this one for ? A comment above it would be nice.

> +
>  	/* PORT_FBS bits */
>  	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
>  	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */


-- 
Damien Le Moal
Western Digital Research
