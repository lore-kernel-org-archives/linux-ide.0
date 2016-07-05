From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 2/2] libata-scsi: do not respond with "invalid field"
 for FORMAT UNIT
Date: Tue, 5 Jul 2016 14:08:25 +0300
Message-ID: <77f27e3b-afe6-2aa9-7d42-e054a7f65bb0@cogentembedded.com>
References: <20160705064556.909-1-me>
 <577b57b3.5b4c620a.37648.6c91@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33297 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867AbcGELI2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jul 2016 07:08:28 -0400
Received: by mail-lf0-f47.google.com with SMTP id f6so132285764lfg.0
        for <linux-ide@vger.kernel.org>; Tue, 05 Jul 2016 04:08:27 -0700 (PDT)
In-Reply-To: <577b57b3.5b4c620a.37648.6c91@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tom.ty89@gmail.com, tj@kernel.org, martin.petersen@oracle.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On 7/5/2016 9:45 AM, tom.ty89@gmail.com wrote:

> From: Tom Yan <tom.ty89@gmail.com>
>
> It does not make sense and is confusing to respond with "Invalid
> field in CDB" while we have no support at all implemented for
> FORMAT UNIT. It is decent to let it go to the default, which
> will respond with "Invalid command operation code" instead.
>
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 029e738..ac5676e 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -307,7 +307,7 @@ static void ata_scsi_set_invalid_field(struct ata_device *dev,
>  				       struct scsi_cmnd *cmd, u16 field, u8 bit)
>  {
>  	ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, 0x24, 0x0);
> -	/* "Invalid field in cbd" */
> +	/* "Invalid field in CDB" */

    Don't do 2 things in one patch please> This change wasn't even documented 
in the patch description.

[...]

MBR, Sergei

