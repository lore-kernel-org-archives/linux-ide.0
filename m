Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB07C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 14 Dec 2021 23:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhLNXmz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Dec 2021 18:42:55 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24012 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbhLNXmz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Dec 2021 18:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639525372; x=1671061372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JqMnR5JDEwVFhzJYd8UbG6LlmRhjhnIL+MAUSeClcjg=;
  b=BJPSHHZvespkbUB/Jj/i2FDSC4PA/1JejHzlAgwy3Gs5JU/tcTat8Fg3
   fXPd/lnCA6TiKE417wg2yhKzPXMEuqBpmq6CL5vNSiVhdVNr2+GyqKYst
   Y910frngT1uHFpFlg/U8vkozjOy2u2DoyRa60YZD4OrcIMXLXFuIPd6ET
   iT5Os6NJiDIM4K8WeqTFBnq7UshJGyvxJIP2//HUglrurU7WPGuZKO6Cd
   Ub0yxH7hXZ3cUZiTobPqXhNSlr1Uj+Z0D4ATwq/GKME8XmxTUF0UOPcrn
   C/TYBGL8ZKwPhw8zNUQsG7sTirRLSyuBRyap/rge/FEwwMLx9zoQ8vOrr
   A==;
X-IronPort-AV: E=Sophos;i="5.88,206,1635177600"; 
   d="scan'208";a="188252925"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2021 07:42:52 +0800
IronPort-SDR: 0APqgwZsL5x/icH8eCmImySiX5vgi6tn4X7fgv2MNTeubP5L1w24kuAqUjg0hxdZDy13b042Vq
 RhAuZ6tg1DneXIWCUPLLUSUOT/2tkEDF8us3gcLofhsn99ZwYipItB/S7F2bJSszk95SkzXkBd
 IYm9mcZfTwSjHOj1sYI88F+vxaZP+hR0eY4J15v74GGQnEk9mIH4ym/ruj/i8ot65hIFn4/QGA
 KJJL6vqO8Z4jeooisHDyKRw7dZCSV4lbw5R8QHyO/qwCOt9UVRe8DYEmqDOs5DatwafCTIA2uU
 8qIXxDCb7uJ3f1aBMe/YlNKJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:15:50 -0800
IronPort-SDR: JsF3V1WYUlD69icEhfpyLZWt64sN3be9bEDfrvwq0tj4gETVu3TI284Y876UPTWVA925dWDStA
 s1jDpvulJwgdIB5LjoL79GCu7E7D7OAI+ctC64gr2dAVVci8oRjaLc5evli+sOUWPeGsGJEhKw
 te3qy9Vjw61gUafQTgFATsJl1Ptk2VXSdelCHrtF+kalzb7X0M0RwJyDlTgW4zx3oKIIqUcuFt
 BA5s+X5qxNoYlmgFib9xOVcQON92mU2T7GTY46YuoZVXnQyHRQl2mN0qaQG5ThZtgthAtHmA+h
 uu4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:42:55 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JDFL56QhLz1RwFN
        for <linux-ide@vger.kernel.org>; Tue, 14 Dec 2021 15:42:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639525373; x=1642117374; bh=JqMnR5JDEwVFhzJYd8UbG6LlmRhjhnIL+MA
        USeClcjg=; b=lqoOl3jpVJmf3sHKq3qwXm/N6K48pIRKj6ClaQW7VAQogC9ona9
        ir56LuYYLklVqJmyuw0ybqEmmsJwfgX9jS38uhnZnZG17VtuZqpdyQz/QcNNgHDE
        fVaIuCFN7RBCjPJvfRobBUNn0wupmHryGngNOkWN58+1eDf45L6MOZSNVSqPPjBr
        +Ya2yd8GI9oQfT5kg1kV+u0NUMBhww1oVJzGT3qQhE+bofm/BAHdfJlaO/XmCUbE
        Hs83VpVSMYYd4yFCrqSBOZA6HI9bdpj58KK5UBfmbL9Bxdwb7LhHKi/rRU6ZIBqF
        mSNBLCXeCX9J9NfJrjIrlh/WqTCeGJ3+Niw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kE3wKAsHBOTg for <linux-ide@vger.kernel.org>;
        Tue, 14 Dec 2021 15:42:53 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JDFL43hl9z1RtVG;
        Tue, 14 Dec 2021 15:42:52 -0800 (PST)
Message-ID: <87d2345c-f878-1884-e344-25ac2b6862cd@opensource.wdc.com>
Date:   Wed, 15 Dec 2021 08:42:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2 RESEND] libata: if T_LENGTH is zero, dma direction
 should be DMA_NONE
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1639493110-15900-1-git-send-email-george.kennedy@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <1639493110-15900-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/14 23:45, George Kennedy wrote:
> Avoid data corruption by rejecting pass-through commands where
> T_LENGTH is zero (No data is transferred) and the dma direction
> is not DMA_NONE.
> 
> Cc: <stable@vger.kernel.org>

George,

FYI, you should not send patches that need backporting to
stable@vger.kernel.org. The above Cc: tag will do that automatically.

> Reported-by: syzkaller<syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy<george.kennedy@oracle.com>
> ---
> Used the Maintainers suggested fix.

The usual way of writing this is something like:

Changes from v1:
* Blah

This way, if you need a v3, v4, etc, you can keep the previous changes
description and add new ones on top.

> 
>  drivers/ata/libata-scsi.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 1b84d55..313e947 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2859,8 +2859,19 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  		goto invalid_fld;
>  	}
>  
> -	if (ata_is_ncq(tf->protocol) && (cdb[2 + cdb_offset] & 0x3) == 0)
> -		tf->protocol = ATA_PROT_NCQ_NODATA;
> +	if ((cdb[2 + cdb_offset] & 0x3) == 0) {
> +		/*
> +		 * When T_LENGTH is zero (No data is transferred), dir should
> +		 * be DMA_NONE.
> +		 */
> +		if (scmd->sc_data_direction != DMA_NONE) {
> +			fp = 2 + cdb_offset;
> +			goto invalid_fld;
> +		}
> +
> +		if (ata_is_ncq(tf->protocol))
> +			tf->protocol = ATA_PROT_NCQ_NODATA;
> +	}
>  
>  	/* enable LBA */
>  	tf->flags |= ATA_TFLAG_LBA;

This look OK to me. Will apply.


-- 
Damien Le Moal
Western Digital Research
