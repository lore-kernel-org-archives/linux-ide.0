Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D643C43217
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 05:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKHFCI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 00:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiKHFBa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 00:01:30 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48968272E
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667883688; x=1699419688;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HwggHoQfuva0EHxrxsa0iScKJ5Q+Jys9IWgVhrFPor0=;
  b=jWtoWj0tjwxAuBfeC479F/xFwmfZxhc1FsNuSbx8YObSEAdn95w5H346
   ax/PelsJpsSmz90wWUY6fvDtDlqy2G66nqJG5Jx9JE6zmVVgQTe8ue3Gk
   cr9Ekc7XHpBShxvOASkyU4pWj00O+KNlN2VquuNsgtQ2kLllhbNbagWdk
   6g1IG1zHhkQymX+SZeVYu6o+tqsWFpFBLsjpry5eGgiSBQ5N5gAuypiU2
   LLu3wKVYSQG9cEmvqpswHaB4YAiosMK81qkag+NcqORmRxSslwLoFaK9c
   oi6e6cqlTlCmC2eQtc5fvZeh+Rsst2n7CsQaZ4IiWcp34+xTQj0ObyKK6
   A==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="220886213"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 13:01:27 +0800
IronPort-SDR: gJyUFdiQvwMx9Bwmg7eY3AHMNOKthY3c9BKxuMEXQohiAGizNuYoR6xo89y8CnMYGBgsDlTZYd
 nHoDNl/eKFgZeTcZCGYJ5P+Epkr9uVdGXl5V6HXUpWOBlMywzXV9xq9LjNW9ngxevUhnIl1t+o
 p0o4/us75If7VfBU73OB6eRId2kmQ2B6eY9yGN7ySbTgMj1mEf3mPWXxqQMEJQCkIgUp40G7hw
 25VvX7KqfO02ziRqT2ke27x3Nii/k1WCDzbLIeEq1k3d6E/Wi7qXh4uIV03mQpBuwnFZ2UzM0V
 xFc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 20:20:33 -0800
IronPort-SDR: 63OAPfAmUZCyF/UWbgMwzf4p9b0vr6+UJJlkPeCZqGkEQgNjL5PzzWLVWEgrTLWMeGtkMD9PMH
 FVgikTulFyWJZsNgcHjC11sF3dyDhPnjP6QgtYtGJ+hKmEcNO+gJ6VOX/o9zrAm7fmuHOnpPNb
 QkpS7dgkuIyGKa99xfygOrji6/OD106XU3s3U7KamiZmgWeFtPw2Cj/bEvekjgs0lJnxAbM+p7
 Q9LWu1IpqkdaQlu+w6rRogqaN0Ni1Xy9cBOIoTcWeM50kdD7A4Ob4UVK2Ndb868GR1kS945a5L
 +54=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:01:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5wtG63t9z1Rwrq
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:01:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667883686; x=1670475687; bh=HwggHoQfuva0EHxrxsa0iScKJ5Q+Jys9IWg
        VhrFPor0=; b=F1NO0UL0nWY/meUtIBMKWB/2A6jfp81X7Wv9I9PJbSP2A22Rnrh
        LSqNBKQ3JrEZmk3b2+GIpjKh3n94cZvbeuIS2dDNdDEgO0MlQ5FJZefcj+Fr2OMt
        feVEQaIVQ3BSbWnQNzGaPcRohQ6sOogXYpfnJfTyvO3YE4dvwskY5ykIL951kf1/
        lQWflmtVzyeFOoBTCg9zcpdGaOsWJwn+yo+IAvK3Cf7Wg4swHuYLpWNkPF0Qj3vi
        LQa+HsopZosVkqjwMxofnKzOoLf/E8KWuYNzRVZeU/7oLMWXBaLcSZeFdSRS4TKm
        13yXavclrdbKbTJ12YZs67WgLTjixYulO8A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ENDo9KcEfZ-n for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 21:01:26 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5wtF3rFcz1RvLy;
        Mon,  7 Nov 2022 21:01:25 -0800 (PST)
Message-ID: <0b5aaeec-682d-9f9d-50e9-4a66f589e592@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 14:01:24 +0900
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

UINT_MAX ?

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

