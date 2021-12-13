Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193BEC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 13 Dec 2021 21:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbhLMVhd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:37:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41262 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242808AbhLMVhc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Dec 2021 16:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639431452; x=1670967452;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p/GI6FNIzJRnBbEtJSRLeyRNy8FgPpkgoZ+66ISYfIE=;
  b=fHPyXY59ADEKkjPAm/TAF53D31xhYD0nEDbJdEtG7iP9KG11EltAMGiw
   +zEpf2XppvlGrHakPVPN3nHmoflhOhIqWcCxM6stFRugZhgtyubeo5K3C
   Xs+HU4GhnUY2YKmAVKfiX4b5kh+3IPM7I72VfBKuheFjruba3MP87A4VE
   /01cDXs1Y8dOq3LKJ2Udwjo5hmEq6winOsg00XgM3jfJBTPSJerZcgIVC
   IEqk9xyngCZ1LMioYahiDy0XndgockJErWZZqC9XtKnfCaurqIqU+YKPi
   6NIhBGw49KHu3b5hpN4WAo5q3Ad2ESt8Sq5eEVjYgAnWCLgHp8NqC4jpd
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,203,1635177600"; 
   d="scan'208";a="292142886"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2021 05:37:31 +0800
IronPort-SDR: TTmWeBZ7ykYI1fJDU4CtJtzWu5Lw5Apl614CdGj0bcxXpS1Gl10SOkVmL0W2KQISzfgr0xh0Ve
 kgNqKl9bvnjR0Kj5UO8Hf6pK0YMNXB9aDVep98XNe4a1vrja0/JfgUKsR1+Val0x2Hz2zVcQnW
 bxwtdn7LMLv4xfA6Qm0AHKHrDq8iSdI4tOyxQ7LWu/AKbni38a+/CN4bOX7ygvzidRAbEDHqth
 rPvXNaN4NPInzBNSSfDGooiiXpIw32cCKlN3sjJ7U95xx9gWJ9nL6Bj4ewpuLYc8pyopoSb7y1
 34ePMwTHm0YT30oLTdFle6bH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 13:10:29 -0800
IronPort-SDR: ZTpp0b0lw7iPWCKuKS74BV4af5LKBvp0PVeq7x+8pJ2ioGXC3RUuCWQjMNILVe6bnz5c1rNJQZ
 LTvs+rEQvCud644f2gn4nmx3B24Zkml2IxaIuM83XRoJuxbMwELugqOgU8YBgU/3fomzNzMAxG
 1RYqende20IcYfrO3jSeTGiteo+SZPRKRrsd7SbGrhihnkhjKFnTVnQMy8eLqLEo9u2KG/pJNF
 3JhkY2d06KMgDSHg+adqZdEGAwk/PUsF2ZB9BqVyJFrS3DrUOWA8ekPTKfayXCmLhp3A2PAA9z
 wus=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 13:37:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JCZbv1cRfz1Rvlf
        for <linux-ide@vger.kernel.org>; Mon, 13 Dec 2021 13:37:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639431450; x=1642023451; bh=p/GI6FNIzJRnBbEtJSRLeyRNy8FgPpkgoZ+
        66ISYfIE=; b=csGrzl4Ef2XD6pS33qD7pGUEvzgkysLbTbjE3JYTfBgH+vdAvPx
        Jfg7L8CtIQ3eNEAlLScyr51YZETgO+W7aNt1epC/GiBCe/1GrKw3+Cuqqus1h4yQ
        2LYO20AoTaXCAl8bz541MSJ2aZPgocEHJRdyU+ipapCF0VtAha4ivKLNCmYFTGXW
        OWZ1OwAKTFI3BbewQB32L2wU81A6SnA3otTOws7LUDFonEWpiE6OLuMei88vrSbP
        KTnbULMUQJnPqcznvqVZAx+k6QjVRclM0ttssMnWfezY0FGGOpfeO4+jmzXCH6lN
        SZNAOP2T1hCH2Raub3qb24unix2uC5I74Iw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bLJsP6rrjJeo for <linux-ide@vger.kernel.org>;
        Mon, 13 Dec 2021 13:37:30 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JCZbt39Nnz1RtVG;
        Mon, 13 Dec 2021 13:37:30 -0800 (PST)
Message-ID: <c6212443-e40a-2813-1920-905e89884204@opensource.wdc.com>
Date:   Tue, 14 Dec 2021 06:37:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH RESEND 2] libata: if T_LENGTH is zero, dma direction
 should be DMA_NONE
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1f57bc3d-d125-7e09-4699-0338ddcc50f1@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <1f57bc3d-d125-7e09-4699-0338ddcc50f1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/14 0:33, George Kennedy wrote:
> Avoid data corruption by rejecting pass-through commands where
> T_LENGTH is zero (No data is transferred) and the dma direction
> is not DMA_NONE.
> 
> Cc:<stable@vger.kernel.org>  # 5.4.y

5.4 only ? What about other LTS versions ? They do not have that bug ?

> Reported-by: syzkaller<syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy<george.kennedy@oracle.com>
> ---
>   drivers/ata/libata-scsi.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 1b84d55..d428392 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2859,6 +2859,12 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>   		goto invalid_fld;
>   	}
>   
> +	/* if T_LENGTH is zero (No data is transferred), then dir should be DMA_NONE */
> +	if ((cdb[2 + cdb_offset] & 3) == 0 && scmd->sc_data_direction != DMA_NONE) {
> +		fp = 2 + cdb_offset;
> +		goto invalid_fld;
> +	}
> +
>   	if (ata_is_ncq(tf->protocol) && (cdb[2 + cdb_offset] & 0x3) == 0)
>   		tf->protocol = ATA_PROT_NCQ_NODATA;
>   
> -- 1.8.3.1
> 


-- 
Damien Le Moal
Western Digital Research
