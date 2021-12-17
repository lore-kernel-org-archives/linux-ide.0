Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A107C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 17 Dec 2021 00:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhLQA4p (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:56:45 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46015 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhLQA4p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Dec 2021 19:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639702605; x=1671238605;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VSUrlNKGkYcfFiPqqT5AR/Q+LuxOulsi8FcOiOwrAVo=;
  b=TNrjY+Iq6Ey45f74P4285N2R1wPVr62yn8tG78EKi0J+iEApbpjXOEhi
   nIYlOVcQ+c2jbZFDqO7t5/8gn5aaeAWiXZcbIwVy3slhD95JPg6WZQp5O
   IFb3IKUazWAjZiPrIL4sxULGSzBqBeJbxzHb6q6w2TTr+86EQ73RDXv8t
   GP9gU19lsVXO4obCdnjJ5VsLlDzRYTxHkNzBcfQhdPlshwLaBlO/biapD
   ++J3YdK9SeJuca834zuDRVm2682ZTvD80l90NnbmHL1LCJfkSTLk9TJEX
   eNC3H9SFrL97gmliugUJc+F2D1rDBfrUrq8o1bAtrI+NX4XDygplViI68
   w==;
X-IronPort-AV: E=Sophos;i="5.88,212,1635177600"; 
   d="scan'208";a="292463220"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 08:56:44 +0800
IronPort-SDR: Hlhr6pg2xULMzRfxytqix6B8VJoshFQJEmsXTmbs0Xu6LhdBVwrzDrm9+Kxzg4NKNpGDc1D7yi
 EUO1JEW57S+Q+3yIXsriD2dxa1tQVL2O5IQSQRdGCBz69NrlBo9Pk+3uqGJteKmzPGyQ4dE6sQ
 ET5rYlbzg9JXzPuPCkvx+Fl41oiVuQDO4Pk5qSpfoVD34+7c3ucbKFpD2jvup0a9w91XBPRKZP
 UzuliK625TGN0orV2PH7wI44b62pr5xUjUP9Yxc17K/7Dgz2csvJpWbiHBPo5TrgBBCGU12/rT
 rXi5NszPzFWje8G0CvTUKM9b
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 16:31:06 -0800
IronPort-SDR: TZLWn0Fps/QMbD6FwgTMAm2G/QgY/39ny4OeM/gS9yVk1ZUFN5PX7j3g7WchETToYoRs8pWpxx
 RWDzHFVk8PyUf2OyYstYiKMC+EDBLymkYKXiQwp8SKUwNf2IBZKwebiXGBa3pcgEourExUsZH1
 fi/roK5ctjv1IQ0HGDysIx9AaSr0slEWfS2LLdfZZivGSI5snWe3kMUg6ZsWGLFoyHAzDs2OCo
 va1AqvmLPqkcJNghnZI2MfTAShBd/TD4xFxs9vksUfs5ZghGOOFNDWb19uZMinybGaJi+SjPgF
 Cco=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 16:56:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JFVtN53NTz1Rvlf
        for <linux-ide@vger.kernel.org>; Thu, 16 Dec 2021 16:56:44 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639702604; x=1642294605; bh=VSUrlNKGkYcfFiPqqT5AR/Q+LuxOulsi8Fc
        OiOwrAVo=; b=TQcBwUsDbrEQmWC43Zzz7YLatOgoodmBSA/7KXMX3Czq6oGfPST
        jyqTQMoSqQpoyMtLwL3RVIsZs1sPCNrP7WUch0MWIzgWmMkwxU1iV6Pkaw+5a8PE
        XEVjiPLIUXLsGt/F8t1DwDl3NTiHxoJrNZRV4rZDsQCKm1CdTltj06JTZ1T1BS6y
        J7dwEfwo/pecPwidU9qBD3/E9OgHHGN1ZibqyU9z52mqsJzgG7YTUUG9kzNsHZc5
        WWecDMGP+e+0YIHujjCl0p8LzSXdUF4OBERDQZ6+n7sfISsz+b8gUDY+TCqXRI74
        9qhiWVZZTZO9aid3bXE73T0CX8lZK0/KO0A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tdwqYJV454tU for <linux-ide@vger.kernel.org>;
        Thu, 16 Dec 2021 16:56:44 -0800 (PST)
Received: from [10.225.163.18] (unknown [10.225.163.18])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JFVtM4SQyz1RtVG;
        Thu, 16 Dec 2021 16:56:43 -0800 (PST)
Message-ID: <1b0efdd4-3abe-50dd-5fb8-ae00cdee30b5@opensource.wdc.com>
Date:   Fri, 17 Dec 2021 09:56:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 RESEND] libata: if T_LENGTH is zero, dma direction
 should be DMA_NONE
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     linux-ide@vger.kernel.org
References: <1639493110-15900-1-git-send-email-george.kennedy@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1639493110-15900-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/14/21 23:45, George Kennedy wrote:
> Avoid data corruption by rejecting pass-through commands where
> T_LENGTH is zero (No data is transferred) and the dma direction
> is not DMA_NONE.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzkaller<syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy<george.kennedy@oracle.com>
> ---
> Used the Maintainers suggested fix.
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
> 

Applied to for-5.16-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
