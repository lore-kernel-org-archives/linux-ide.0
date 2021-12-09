Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C03EC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 01:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhLIBFN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:05:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44826 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbhLIBFM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639011700; x=1670547700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q2D8MJpNF7AAteOpfw0AsHK5Ysj0f3zaLjyotxeRiiU=;
  b=DBpI37/1aTDBttfTiw+SAZa/nk3/FM2gZLWpvHpFGRtAUmuFKVtumJpq
   tlVs0xv3QCKGsCSnaQNFpXfhQPcxVmF3JZ82gtnqx+oVAyYIMrViE6xdR
   QpxuOMHxBvvU72NgsvXdjf3YACA51S/dgAwiFjYY0+pjBmx8zMikDNnCT
   J2/sBdVTUgFH0b4dOiJ1sA+HpIHL12CPISRpHjn0DGvDNN31tIVKaao6L
   XCs43MAgnhyBVIE/DriZDML1Qn+HR/ws+tMrwsfGYXwMIwkE1LpnjAPJH
   6Wv0ZCsE+kEcqT0NFUhyBeBDxeXitXxhOI4IDh8Mn5VgYHrZ/lp8chaSU
   w==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="291772891"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 09:01:39 +0800
IronPort-SDR: fZ5XyXiTxZzPKCJB0wDHr0nagfISQq8E6h8fcnHB6fnKMUGOxSN29EEW1MI2SVhEUx4MW50PMM
 fx2XY0ToBGvFomeBBLRbtgjSSwOL1IrMQlt25EdcjiUlWOGSD65ra8haWBKaMT9a9XHQgcYsOi
 D8UrPSxhwYdvJE3DJc2fs616Te2ONj/4JLHHzdcwgs6GvEYAU4/zxdpXkEisLsxyjwsm5e1JG6
 kPQIvqZ6/S8jlQrKMPArj9BubRVWTwby29WYE2tVZwR4ZoATNh5hy87tgeYS4tYQzqXbDPHPHm
 c8/D1QNr6p6n0k2wHTeu6OVV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:36:13 -0800
IronPort-SDR: ZTpy7cxE+FvWOw821zQrlaS5IR9sK7dpCKyjiAAiFWx5BUZ3PSD6RCDXNOtgdf8+L3EDoaA3We
 RxLSjQ9UWu2IPwXn5jItb9L6e77NBXvejJcB2LWE6xt4w9/9J6d58Up9LXBN5xWtIA8Aq/ARFi
 37YGaMh8S9jKHB35oUPHsJNiuQ+UKHOewA2swwnDqVfITHC2KbRPH5KGSXSutOHDig3WgIrxPQ
 zYHOcvwp2bL5ndmElL8sQNwqGNYo7A0MRSvVWSzQuaCQ8OWUF4hVUq742UxjWDPaBBjOuZ97AX
 9k8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:01:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8bMl5Zclz1Rvlf
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 17:01:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639011699; x=1641603700; bh=q2D8MJpNF7AAteOpfw0AsHK5Ysj0f3zaLjy
        otxeRiiU=; b=pc9Nxgiu0VYQ4PvFsc0x/tRw97VC3b10gWpW+l3/pCwaM/dZLef
        ruBS2PTYRXs9KLos39ng9UkEMKnpKHNynJ5C1+Axr2FUI7JhgCFswcWBRhJJyXWk
        KixVsN/JPtP7HwB3ebYObx+yfdnYCkClAVIaJGcgmaEyaQE/v1gjDf2kUFMseZ9r
        615zv+iKjANHEizIYwkiy27Fmhpgt10voAvOaJ74h/m/IsKiye6ibF+KdvpUZXRu
        QVKtIC09s4tEUrC0IldyHRs6/TWVrdX30ascm18pXcSa1MH9JW93nxNnWMJJkPOW
        IxOWKXEZ5Ind0yj0nKZmhv8w7DboEwK+nBw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F1sBxeXWh6es for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 17:01:39 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8bMl0jBDz1RtVG;
        Wed,  8 Dec 2021 17:01:38 -0800 (PST)
Message-ID: <36ea9118-26d3-ea8c-9ac1-8a818e87eadd@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 10:01:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 32/73] pdc_adma: Drop pointless VPRINTK() calls and
 convert the remaining ones
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-33-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-33-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:32, Hannes Reinecke wrote:
> Drop pointless VPRINTK() calls for entering and existing interrupt
> routines and convert the remaining calls to dev_dbg().

There are no remaining calls here :)

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/pdc_adma.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
> index 2c910c4cd4de..5d6f460b2356 100644
> --- a/drivers/ata/pdc_adma.c
> +++ b/drivers/ata/pdc_adma.c
> @@ -284,9 +284,6 @@ static int adma_fill_sg(struct ata_queued_cmd *qc)
>  		*(__le32 *)(buf + i) =
>  			(pFLAGS & pEND) ? 0 : cpu_to_le32(pp->pkt_dma + i + 4);
>  		i += 4;
> -
> -		VPRINTK("PRD[%u] = (0x%lX, 0x%X)\n", i/4,
> -					(unsigned long)addr, len);
>  	}
>  
>  	if (likely(last_buf))
> @@ -302,8 +299,6 @@ static enum ata_completion_errors adma_qc_prep(struct ata_queued_cmd *qc)
>  	u32 pkt_dma = (u32)pp->pkt_dma;
>  	int i = 0;
>  
> -	VPRINTK("ENTER\n");
> -
>  	adma_enter_reg_mode(qc->ap);
>  	if (qc->tf.protocol != ATA_PROT_DMA)
>  		return AC_ERR_OK;
> @@ -379,8 +374,6 @@ static inline void adma_packet_start(struct ata_queued_cmd *qc)
>  	struct ata_port *ap = qc->ap;
>  	void __iomem *chan = ADMA_PORT_REGS(ap);
>  
> -	VPRINTK("ENTER, ap %p\n", ap);
> -
>  	/* fire up the ADMA engine */
>  	writew(aPIOMD4 | aGO, chan + ADMA_CONTROL);
>  }
> @@ -502,14 +495,10 @@ static irqreturn_t adma_intr(int irq, void *dev_instance)
>  	struct ata_host *host = dev_instance;
>  	unsigned int handled = 0;
>  
> -	VPRINTK("ENTER\n");
> -
>  	spin_lock(&host->lock);
>  	handled  = adma_intr_pkt(host) | adma_intr_mmio(host);
>  	spin_unlock(&host->lock);
>  
> -	VPRINTK("EXIT\n");
> -
>  	return IRQ_RETVAL(handled);
>  }
>  
> 


-- 
Damien Le Moal
Western Digital Research
