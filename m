Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D49C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 29 Nov 2021 11:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhK2LoP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 29 Nov 2021 06:44:15 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47222 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhK2LmL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 29 Nov 2021 06:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638185933; x=1669721933;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JYH9kkRhUNRml+qYr7T1i+UPuDM6cyqwozhm5/SJTm0=;
  b=F8dX7WIu+67tb/Iu+HehenP/v3NJ6WCNeXDjGHp6wLnuQTnVQ3AQx0ay
   IkKUSuKzlMkMeW4xY1mEIh7Kkshy6Fq9O8qbFXWMU6OmkdcprtkXdo739
   V6XHmBnRjmhlK0WI3EKEGrHym2AQvoalU5n5PIxHtmyC3sIa+EmAMWk94
   mNoTug4IfquiRNrNe5F5O3XhCU1UKIcFmTSt2gKdltY+AxLbsR3rw+oqX
   rKjKFxkgO7E1SWD/SobwZCxyPGurtFE967+UqQ5qi+6RVyNwgBZK59Y3k
   t+7bG7SACGaluAjylrrkZuMaHi4iDZDOMsy7S7PTicVSRM/PC2ZKy34V/
   A==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; 
   d="scan'208";a="185939027"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 19:38:01 +0800
IronPort-SDR: v1cBVU+XI/a4KcFZPPXvBGERB+Vo5sMQZnjTd7V+KZ3Px1PvkqlPl2pg1tzNEp3xv6i4pG6jnj
 +Qhr8EYC5oOSDyfaiuOLLE45uHKjAgaaDHh5bHrxWuT9Pqbq+Gg3KULT1rw22+e72opuuKOCoA
 1U85ZkqLVBb0gX/+CnSVEcFXgk9oJRqNm1TDy1mFWqMAi9lemNr/nhtAkYzrXQs4vhpxf1DyFI
 SeuEKEqCKXdvfe4bLkj30AYK6KlUVtYg7L1Aqwv4GvapqFCwLNsmfJ233/CQ8eazawX0AZ7ByO
 8AEXOPjZqwjDBP1qBa2EYNnp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:11:15 -0800
IronPort-SDR: sb2ytrfVGNYgzlLZRVSMouM0SjrgNiN90raERFrcPI8eeo6njhPl88xVBnFUnaNF6Xv6VnVoKs
 KeNkJhzKLV23HKJatbdHAD99LqA6J8qHA6oGGZ/1qvKUQ11faZ9TujYANlYgYqNzxGMgD+cz7A
 LtMbXIxGQYysGITsZvVH6j/HshJ7ElP9P2nm95hSbvlzjP3Rkw42TWqnJFKJGnliLbu9k1sQwh
 0/ZRqHfc/SO0L67cUKnwViZQ9daaxBocUTvvmO9m49QcFGdOHSmBzyULqUiu5ai/ZjG+XjZZLv
 aN4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:38:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J2jyc5VSMz1RtVt
        for <linux-ide@vger.kernel.org>; Mon, 29 Nov 2021 03:38:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638185880; x=1640777881; bh=JYH9kkRhUNRml+qYr7T1i+UPuDM6cyqwozh
        m5/SJTm0=; b=I4ZhqKpxq/GDokFdwO9J9ULr/RXB2zmkiPEmeA8SIOOsvUPi3m7
        WcTRx4t9kr69NpXARVpkD3tOkTT2xlp8+5p9Y/e0VC29MPt9k6qMxVad+0K6he9k
        YEyMquhBsjvmR0M59aZQijU2q8IqJ2TTZjuadF0omOKfJ/hiMxpeQPkEJyfJq5cl
        lMc6+KposuM9pJDnQI/UYKdiQ+oS9VHFPoaCKtdDDjO5DfoFo3sk2TfUe4UHY5Ps
        mKSB/W+dOLAKAGUNg4i8YoGqaL1gV/R5cRr6iqrm8RWoFCTQji3Ksn+0+EgSUGcN
        oG/dZLS84gE7tiMQad19dpK2tnRCDI9i5jQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 54YgR3tVEiys for <linux-ide@vger.kernel.org>;
        Mon, 29 Nov 2021 03:38:00 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J2jyb3jrBz1RtVl;
        Mon, 29 Nov 2021 03:37:59 -0800 (PST)
Message-ID: <23527f89-d098-ab6b-f3c9-a8a395e32df5@opensource.wdc.com>
Date:   Mon, 29 Nov 2021 20:37:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] sata_fsl: Use struct_group() for memcpy() region
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20211118183807.1283332-1-keescook@chromium.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211118183807.1283332-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/19 3:38, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
> 
> Use struct_group() in struct command_desc around members acmd and fill,
> so they can be referenced together. This will allow memset(), memcpy(),
> and sizeof() to more easily reason about sizes, improve readability,
> and avoid future warnings about writing beyond the end of acmd:
> 
> In function 'fortify_memset_chk',
>     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
> ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>   199 |    __write_overflow_field();
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/ata/sata_fsl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index e5838b23c9e0..fec3c9032606 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -246,8 +246,10 @@ enum {
>  struct command_desc {
>  	u8 cfis[8 * 4];
>  	u8 sfis[8 * 4];
> -	u8 acmd[4 * 4];
> -	u8 fill[4 * 4];
> +	struct_group(cdb,
> +		u8 acmd[4 * 4];
> +		u8 fill[4 * 4];
> +	);
>  	u32 prdt[SATA_FSL_MAX_PRD_DIRECT * 4];
>  	u32 prdt_indirect[(SATA_FSL_MAX_PRD - SATA_FSL_MAX_PRD_DIRECT) * 4];
>  };
> @@ -531,8 +533,8 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
>  	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
>  	if (ata_is_atapi(qc->tf.protocol)) {
>  		desc_info |= ATAPI_CMD;
> -		memset((void *)&cd->acmd, 0, 32);
> -		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
> +		memset(&cd->cdb, 0, sizeof(cd->cdb));
> +		memcpy(&cd->cdb, qc->cdb, qc->dev->cdb_len);
>  	}
>  
>  	if (qc->flags & ATA_QCFLAG_DMAMAP)
> 

Applied to for-5.17. Thanks.


-- 
Damien Le Moal
Western Digital Research
