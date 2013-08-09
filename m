From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Fri, 09 Aug 2013 18:17:58 +0400
Message-ID: <5204FA16.5000103@cogentembedded.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com> <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:56465 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030208Ab3HIORv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:17:51 -0400
Received: by mail-la0-f45.google.com with SMTP id fj20so3045484lab.4
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:17:49 -0700 (PDT)
In-Reply-To: <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Hello.

On 08/09/2013 08:49 AM, Marc C wrote:

> From: Marc Carino <marc.ceeeee@gmail.com>

> SATA 3.1 added an "auxiliary" field to the host-to-device FIS.

> Since there is no analog between the new field and the ATA
> taskfile, a new element was added to 'struct ata_queued_cmd."

> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>

[...]

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c24354d..9d02c47 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -532,6 +532,34 @@ int atapi_cmd_type(u8 opcode)
>   }
>
>   /**
> + *	ata_qc_to_fis - Convert struct ata_queued_cmd to SATA FIS structure
> + *	@qc: struct ata_queued_cmd to convert
> + *	@pmp: Port multiplier port
> + *	@is_cmd: This FIS is for command
> + *	@fis: Buffer into which data will output
> + *
> + *	Converts a struct ata_queued_cmd to a Serial ATA
> + *	FIS structure (Register - Host to Device).
> + *
> + *	Beginning with SATA 3.1, the ATA taskfile does not completely describe
> + *	all of the fields in a host-to-device FIS. More specifically, the
> + *	'auxiliary' field has no ATA taskfile analog, and thus requires us
> + *	to populate the FIS via the ata_queued_cmd structure.
> + *
> + *	LOCKING:
> + *	Inherited from caller.
> + */
> +void ata_qc_to_fis(const struct ata_queued_cmd *qc, u8 pmp, int is_cmd, u8 *fis)
> +{
> +	ata_tf_to_fis(&qc->tf, pmp, is_cmd, fis);
> +
> +	fis[16] = qc->auxiliary & 0xff;
> +	fis[17] = (qc->auxiliary >> 8) & 0xff;
> +	fis[18] = (qc->auxiliary >> 16) & 0xff;
> +	fis[19] = (qc->auxiliary >> 24) & 0xff;
> +}
> +
> +/**
>    *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
>    *	@tf: Taskfile to convert
>    *	@pmp: Port multiplier port
> @@ -6877,6 +6905,7 @@ EXPORT_SYMBOL_GPL(ata_sg_init);
>   EXPORT_SYMBOL_GPL(ata_qc_complete);
>   EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
>   EXPORT_SYMBOL_GPL(atapi_cmd_type);
> +EXPORT_SYMBOL_GPL(ata_qc_to_fis);
>   EXPORT_SYMBOL_GPL(ata_tf_to_fis);

    I think we should now unexport this function and make it static since it 
would be no longer valid to call it from the drivers...

WBR, Sergei

