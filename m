Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FB9C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 06:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiKHGLm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiKHGLd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 01:11:33 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859C240462
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667887892; x=1699423892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jseMqPJWNiWBF4rM0E/F4EXcH+Q+uKiSrNvDQDUghks=;
  b=duq2bg1+BPhlJikr4oTsHG/2DXnLD+4MS0FzI12IBnliRfukFYRo5b/j
   3A9WjzwmAzYUOJpxVeq69EmyAM6H5BPCvpVdPcJI2wp3RvWuNhKlEm/Rq
   cVs9LCNlsl0YMaMrxDjXWQdejaKu2ji6mgwj6+ZVN7nXCcT2BNgGbo1Po
   xcu2gUDVDUDpngYviTYYycjeRPt3JbHkUMdpRP8gcmN6SKZJbVXAATj/J
   PtwgEBd5btEXOPvDCf5oHmXc01pQA6ZHyNGoGsRuXTNDF1w7f3aTwxvP6
   snBryttocb7l6OYJbRDSW/ihXgXe7qeZecnVd3NRJAMYHVFjVlcbRNsn6
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="327832628"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 14:11:31 +0800
IronPort-SDR: hw7PpFwFAVwMN/rRvpd/aMxDpb/FBLlc11YtqTMdz7AuLbnkObqNPuSI5aFZT9SdfEdlN4VTa/
 G9P97ANpouJsWVddRrZIlzl5EzKavB5t7uP6CuVh2+xTCiAy6e2WR/oHMe084cAv30ADStX2Z3
 miLHrv6zoLNMCUFjSbH5ID4v/sUFMgD0WFLUsTwVy7cfXZDvha8X7Hmd6zodQs0eiuEp6QpF3x
 i1aKA7fPZnIgM031ndrL/YOkPepv97I1R+fQ1X5nyoeEtX9KaECUW12OiB3mdmY5LpLxzFJEmn
 Qnw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:30:38 -0800
IronPort-SDR: HkdBlPLs2VEaa5qKl62i8XYJtK3v7ONlO9CQZrYgpHCqHQsnyHwwi8NJZr8i/YEo1KbtUhwjDq
 puAOcIx/Q0y9hzgzcVOEer59wpLO/d1iICGqrWASF2N45OWY8WhkW3twRn3k1e6l3MVKz7KSJK
 5Oq7I4DN+5SeMk9kmUQacvYudbOpm9LVXmAwAZB6jMt7X6x7Pc2t7yl/H2fO6sgqASV2FujK90
 xC7NSF6kg5YWfVkHHuEjOno8nf0kvSJhYx4qHZ1htrjGOeib0S8PNa8xs2BwfAT1tGRnBPfciR
 /rs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:11:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5yR73DDyz1RvTp
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:11:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667887891; x=1670479892; bh=jseMqPJWNiWBF4rM0E/F4EXcH+Q+uKiSrNv
        DQDUghks=; b=mgp7rHPjVhZhDr7EvJo+x9HCUvf6LMRPIkb/XIgLqUXoh0q8BmX
        +g4HsExtgBjdALgQAerOgjRX93KkZbdwKuyH5PLd0to+k4CtZFhV9ncWEQAMF65k
        H93UwjPRV0bcznmpN/7wE6iv4Ah2W9QCHol0ywd+8iIYqMW2KAnMVZmTJia6syzj
        qYNouclzf/NNE1DlTQtUibwJp8344wnhUFyf+xCox0jkAFyNMcMQOpzFL2I++f2x
        /+HyqCcoG8+0PkxTdCIXW1w0VB6pi1KnS6BWb714exsJAorf7mhFVF6oPK7sjBBu
        kWzYUJd9DzNBlkqkSKFRnDE0SaNG18nQlaA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Wk9Cd7eoaHfV for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 22:11:31 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5yR64SCBz1RvLy;
        Mon,  7 Nov 2022 22:11:30 -0800 (PST)
Message-ID: <9c48b2ec-7cca-e95a-4dbe-0de94676a4dc@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 15:11:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command
 failure
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
References: <20221107040229.1548793-1-shinichiro.kawasaki@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107040229.1548793-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 13:02, Shin'ichiro Kawasaki wrote:
> SAT SCSI/ATA Translation specification requires SCSI SYNCHRONIZE CACHE
> (10) and (16) commands both shall be translated to ATA flush command.
> Also, ZBC Zoned Block Commands specification mandates SYNCHRONIZE CACHE
> (16) command support. However, libata translates only SYNCHRONIZE CACHE
> (10). This results in SYNCHRONIZE CACHE (16) command failures on SATA
> drives and then libata translation does not conform to ZBC. To avoid the
> failure, add support for SYNCHRONIZE CACHE (16).
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org

Applied to for-6.1-fixes. Thanks !

> ---
> Changes from v1:
> * Improved commit message per comments on the list
> 
>  drivers/ata/libata-scsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index e2ebb0b065e2..61cd4e90e4e7 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3264,6 +3264,7 @@ static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
>  	case REPORT_LUNS:
>  	case REQUEST_SENSE:
>  	case SYNCHRONIZE_CACHE:
> +	case SYNCHRONIZE_CACHE_16:
>  	case REZERO_UNIT:
>  	case SEEK_6:
>  	case SEEK_10:
> @@ -3922,6 +3923,7 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
>  		return ata_scsi_write_same_xlat;
>  
>  	case SYNCHRONIZE_CACHE:
> +	case SYNCHRONIZE_CACHE_16:
>  		if (ata_try_flush_cache(dev))
>  			return ata_scsi_flush_xlat;
>  		break;
> @@ -4145,6 +4147,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
>  	 * turning this into a no-op.
>  	 */
>  	case SYNCHRONIZE_CACHE:
> +	case SYNCHRONIZE_CACHE_16:
>  		fallthrough;
>  
>  	/* no-op's, complete with success */

-- 
Damien Le Moal
Western Digital Research

