Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADC6CE79A9
	for <linux-ide@archiver.kernel.org>; Tue, 19 Sep 2023 17:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjISR1W (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 19 Sep 2023 13:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjISR1U (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2023 13:27:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9913C133
        for <linux-ide@vger.kernel.org>; Tue, 19 Sep 2023 10:27:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0548C433C7;
        Tue, 19 Sep 2023 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695144433;
        bh=shV2Xm80eFeLXxUHIZgqa3zdcZIZuSDcqN/m8P3HQlU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hIpSHO9TUrvpffV8QnT3hcxJTVpDgvkmenL9Wcxme29P9PJqmsaLfFwp6cAAZioWh
         k3Itsb0ti+1OM1tzlGLt8BlWNTejyPoSutVL6zKew/5No6blGn7VudA8OIHyqxBcuS
         yhetAmry/XGmVcE++y7ixXR5QMHvc8DVk2vx0qPd0CJsiuc//yCdk+r8facb3wtJbu
         qNzSX/2nXDMhucvOev1Baa41XRKI6ocZevXlvUHyUovOLM1Cme/g7nxard9EjFO9GO
         jki37n5AuaffB3GbfnWZHn/9wBZaDNy4C/26EihduZdQN8mcv3a2AzcsH/gBk+vimK
         BXzbYoNgnsOSg==
Message-ID: <78532355-e4a4-f07e-d544-436b63b60153@kernel.org>
Date:   Tue, 19 Sep 2023 10:27:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] ata: libata-scsi: ignore reserved bits for REPORT
 SUPPORTED OPERATION CODES
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>
Cc:     linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230918202450.19635-1-nks@flawful.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230918202450.19635-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/09/18 13:24, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> For REPORT SUPPORTED OPERATION CODES command, the service action field is
> defined as bits 0-4 in the second byte in the CDB. Bits 5-7 in the second
> byte are reserved.
> 
> Only look at the service action field in the second byte when determining
> if the MAINTENANCE IN opcode is a REPORT SUPPORTED OPERATION CODES command.
> 
> This matches how we only look at the service action field in the second
> byte when determining if the SERVICE ACTION IN(16) opcode is a READ
> CAPACITY(16) command (reserved bits 5-7 in the second byte are ignored).
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Applied to for-6.6-fixes with the Fixes tag added. Thanks !

> ---
>  drivers/ata/libata-scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d3f28b82c97b..fb73c145b49a 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4312,7 +4312,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
>  		break;
>  
>  	case MAINTENANCE_IN:
> -		if (scsicmd[1] == MI_REPORT_SUPPORTED_OPERATION_CODES)
> +		if ((scsicmd[1] & 0x1f) == MI_REPORT_SUPPORTED_OPERATION_CODES)
>  			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
>  		else
>  			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);

-- 
Damien Le Moal
Western Digital Research

