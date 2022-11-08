Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA9C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 05:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiKHFAr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 00:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiKHFAb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 00:00:31 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEB01B1F2
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667883625; x=1699419625;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HTEaAiQT/0sM9OlJyF8YSNMgHbvHRt9juzHymCJh6i4=;
  b=TeFTUbpeGYshL5P2Ail61wfYChFNx48HBT0KDc/DgJKWRsq2VndJMpMH
   Lv/ldbvQxD31CqBlriWX5sTtzmLgM262NqnaW9XhhLOAbBi8pbmOZFvqd
   Q9BlKa5Uhj8FfhYyAZsGLsiLL7azOboOKWluHm2gb/0CVIH3XwQwJM3st
   aN+RwktsjoZjiu35e7ovcbQwKUmql22L2A/t27N24pXX3BBCucNopYOEh
   qcz9D1/SJk38XRv6/KKsQczZC3guU6UL5ZwAD9zJ+uNWh7NkeOwMijy7O
   i4bqyFW+HfLLIgwWhKWEAnzb6MCsXgEbzxIuCCf9KGAexKKncaYtl2ArV
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="327828036"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 13:00:19 +0800
IronPort-SDR: iPuA34jXzTEKCmvDHss6BUX+CGOscSVR+puOYr1Wm8Pgp+oLH3zl2e3FHEjUxE5Q4qDK6DRtBU
 h9Afu5A5tA2IT/AZrSQnK6+Orjpl5cdz4ptGwEgNZCem8f4p3f/vCXAOwUMCseOp7KbRlMvWVP
 rhHYa1WNsUiGk/p/xsBcaqVuU+jDnHW/ZBmK5h9a7lb2yBEMXvQs6i4i/Sjjsz8dFjvsNW2cjD
 94U4MOvzEhElxNkVIcE4kshjUPqMv7hWxx+XvP65uLaw4OW2XHiBD9M9ZPSEUsxB67s99I56Jq
 mf0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 20:19:26 -0800
IronPort-SDR: mbx3qJ2CD6KSwr4qb7VBkfeeshVPKzMlqLWEmLaudq53mZyWKpMD20toBbLqMcQQX18PFn/UTS
 2f1rT1/evCVR4ePSdvA7HeJIuJ+EO4lEApF0IxS2a6q68tiKnUVyDJ0yoVUjud5xnPAn314km0
 Y7T8YB3s36A/CLywqDy+Omd8vGrQ/hzAd59groGQC+s+1rKgnnLRAbER2v6hCAhIz7RJh0cVnU
 t2nQV3WiiWSETWNYfvHkdLfHhTlILA1uj6XPTv/iXjwYlpDdPVqZxoNzF6GeSPf/jP6sM16tKp
 HoM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:00:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5wrz4ZRPz1RwqL
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:00:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667883618; x=1670475619; bh=HTEaAiQT/0sM9OlJyF8YSNMgHbvHRt9juzH
        ymCJh6i4=; b=oVteIAlkGW0DZqrM2ohximDz813sOF5IOOHEtcVKlFOYFM3vn2M
        Yjp9t73ZeUq8mjkozqo8/IvWZRUWF2O3FgZrrPy5xYwe3H/VTPhjvHmn9BG+JVEE
        432ndmk+jL8V2knK8Ynp9SnK8N3j8KK+zNkCkj8FzCbinJSoJyDTGn0B7kpCA1Zs
        FAVUyibs4x7yj55aOMA20K93hC2SZICeKDXM1TUrkXMOnRxhzIX8BI2barFy9CUZ
        0CKhlVociBifVY444+GfgJErjPF7UIQXgAra8RSPfttfyHzoHxTuEkrxb+2WusF3
        IvKSq/bCepT4mS7Au7MlEvvRhGUX4fogiXg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y8jOhmYQ7RcL for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 21:00:18 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5wry25lnz1RvLy;
        Mon,  7 Nov 2022 21:00:18 -0800 (PST)
Message-ID: <b3ececcf-d16a-6ff1-d71d-dfcaec0098a7@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 14:00:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] ata: ahci (gcc13): use U suffix for enum definitions
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        linux-ide@vger.kernel.org
References: <20221031114310.10337-1-jirislaby@kernel.org>
 <20221031114310.10337-2-jirislaby@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221031114310.10337-2-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/31/22 20:43, Jiri Slaby (SUSE) wrote:
> gcc13 now uses the type of the enum for all its members [1]. Given the
> ata enum defines its members using both unsigned and signed ints, the
> type of the enum is promoted to long.
> 
> Make sure the rest of the members are unsigned ints using U suffix.
> 
> The error in question is for example this:
>   drivers/block/mtip32xx/mtip32xx.c:722:25: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long in'

Same comment as for patch 1. Also please add a cover letter for multiple
patches series.

> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113
> 
> Cc: Martin Liska <mliska@suse.cz>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/ata/ahci.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 94b5c81f08dd..14eb6e97f6f7 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -39,7 +39,7 @@
>  enum {
>  	AHCI_MAX_PORTS		= 32,
>  	AHCI_MAX_SG		= 168, /* hardware max is 64K */
> -	AHCI_DMA_BOUNDARY	= 0xffffffff,
> +	AHCI_DMA_BOUNDARY	= ~0U,
>  	AHCI_MAX_CMDS		= 32,
>  	AHCI_CMD_SZ		= 32,
>  	AHCI_CMD_SLOT_SZ	= AHCI_MAX_CMDS * AHCI_CMD_SZ,
> @@ -178,10 +178,10 @@ enum {
>  	PORT_CMD_SPIN_UP	= BIT(1), /* Spin up device */
>  	PORT_CMD_START		= BIT(0), /* Enable port DMA engine */
>  
> -	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
> -	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
> -	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
> -	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
> +	PORT_CMD_ICC_MASK	= (0xfU << 28), /* i/f ICC state mask */
> +	PORT_CMD_ICC_ACTIVE	= (0x1U << 28), /* Put i/f in active state */
> +	PORT_CMD_ICC_PARTIAL	= (0x2U << 28), /* Put i/f in partial state */
> +	PORT_CMD_ICC_SLUMBER	= (0x6U << 28), /* Put i/f in slumber state */
>  
>  	/* PORT_CMD capabilities mask */
>  	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
> @@ -191,14 +191,14 @@ enum {
>  	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
>  	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
>  	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
> -	PORT_FBS_DEV_MASK	= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
> +	PORT_FBS_DEV_MASK	= (0xfU << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
>  	PORT_FBS_SDE		= BIT(2), /* FBS single device error */
>  	PORT_FBS_DEC		= BIT(1), /* FBS device error clear */
>  	PORT_FBS_EN		= BIT(0), /* Enable FBS */
>  
>  	/* PORT_DEVSLP bits */
>  	PORT_DEVSLP_DM_OFFSET	= 25,             /* DITO multiplier offset */
> -	PORT_DEVSLP_DM_MASK	= (0xf << 25),    /* DITO multiplier mask */
> +	PORT_DEVSLP_DM_MASK	= (0xfU << 25),    /* DITO multiplier mask */
>  	PORT_DEVSLP_DITO_OFFSET	= 15,             /* DITO offset */
>  	PORT_DEVSLP_MDAT_OFFSET	= 10,             /* Minimum assertion time */
>  	PORT_DEVSLP_DETO_OFFSET	= 2,              /* DevSlp exit timeout */

-- 
Damien Le Moal
Western Digital Research

