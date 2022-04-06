Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA468C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  6 Apr 2022 14:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiDFOyL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiDFOyE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Apr 2022 10:54:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E0141D69F
        for <linux-ide@vger.kernel.org>; Tue,  5 Apr 2022 18:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649209652; x=1680745652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y4QNGhCVjyn8LK6USs8COB4Sf+wqXGaxVxcHDk7fwkI=;
  b=RwbGPY+PmFyeuWgKuHtlaxN8kJRzPqVeQsM/0cRfvdV65GRt4Opcupo9
   P/pEz2N8eJ8qmGAmOmdAsMK3OTZw2FkzPJnktJzwsa03iXCE1D5gVxjZ2
   gcKmOYi//WO/9y2IM+TM/za0rTWpE+3NDniyhiAkinhZXp+Gz+5oj8A2K
   wO/7rPcM3LA31HjYHYtNuVikwf9O/f+C389LROLIm7tpukT0t1QAlhOTd
   7LF6l1lobY/SxmOfdUKhF/+CTSjP9O/OV/qz+Cx8Djgsf5Fd3CzJO3jY+
   NTLdMJx2r4rdtCuX/LfiJE1CSntSwVIVpNczp+e+s9Ntszsnw1/PaVk0x
   g==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="202037175"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 09:47:30 +0800
IronPort-SDR: j0jOerH5UWbO6D0X/rzE1Aqc7RwhDhfS/75Jywyb3adQlEcY7aNPB0gUU5hWGQuyALXTGJfcSc
 9j75NuHCVEvaQm1ZgvzrtB6+p8x5jNfcyYNJBy1oSlxqepP17uGiYGuFIDDEBfUJm+CfpKtdMv
 lNrvPnwh+FqmbSyzZAuv43LYu+pHrxcVnQ8GbFUYNa3yXFWQBsFfLHlMBtIPmwiGy3ZOX+Iu6U
 nLUs0jHjZI5HjmV0jJv97FlYRhP8irX1v9p0R5bqW9+7hgovZyCni5yyN//29LiMDn+tloE/kD
 ZanE1y9W37pHIaaQmqXFpLVX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:18:13 -0700
IronPort-SDR: fUl7rFpYwB6z/rx54zYmNwX4DbkUbmRGUuCz+l3FoxGtGvuYzXSNW9rB2LjCDZyfm/fYZTsUGe
 MF4dL8gCsLn6y6Qqfanlx6wh86EQU+pXT6Wg316x7E7I5xoCJiiNBKsulJH4gebk/tQGJF4Fqx
 jz2SaF3ETv/p1K3wUVYEofoCsex78AOxyjVBXhEUwkgHZ0N+Xt92A7t5Sv1byEkihro18dGB2a
 7/xdS1wfG6i7Lc+CBYMRWi8t+aBPC8rWnbME05390aTqhvyP0M3Jt2qnzA/eJ7hxUoVO+Jxx9B
 uZU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:47:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KY6pB3lWnz1SVp0
        for <linux-ide@vger.kernel.org>; Tue,  5 Apr 2022 18:47:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649209649; x=1651801650; bh=y4QNGhCVjyn8LK6USs8COB4Sf+wqXGaxVxc
        HDk7fwkI=; b=Why92KATSaTWDTRdXay89bhrCfE+1JZ8pl0W5gEX0tMou80PTaH
        +cKUGzGsZCK6oc3VuDa8Xhh/tvyH6TebYFLsblvcOBGCaf+ggmkdIMaN7BNdjVj5
        i5cWlDtI0X190r1EGVdNK39W/3Lo11pBsdSrHaZB8CWuwtnZ0KEJylov7/z02FCL
        ErgJX4RoTpQPSzWVVjQEtHuTaS3tEPVrQdVxTOm9/eJtkgQlZoewFbAPFVqIfhRH
        2A04PTkig8CZ55is1S++NeHTWd9A74rs6gSyNyel9IdCFHA6DRSNt8Tn/aE5Ux4l
        h1lX45PHMXe4PMN7ZcKqV4fdn93iv2GXc1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KMUiBZ29-y36 for <linux-ide@vger.kernel.org>;
        Tue,  5 Apr 2022 18:47:29 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KY6p83wbmz1Rvlx;
        Tue,  5 Apr 2022 18:47:28 -0700 (PDT)
Message-ID: <06820834-409e-5a53-b7b2-e3787a16d329@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 10:47:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] libata: Inline ata_qc_new_init() in
 ata_scsi_qc_new()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
 <1649083990-207133-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1649083990-207133-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/4/22 23:53, John Garry wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> It is a bit pointless to have ata_qc_new_init() in libata-core.c since it
> pokes scsi internals, so inline it in ata_scsi_qc_new() (in libata-scsi.c).
> 
> <Christoph, please provide signed-off-by>
> [jpg, Take Christoph's change from list and form into a patch]
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   Documentation/driver-api/libata.rst | 11 -------
>   drivers/ata/libata-core.c           | 44 +---------------------------
>   drivers/ata/libata-sata.c           |  8 -----
>   drivers/ata/libata-scsi.c           | 45 ++++++++++++++++++++++-------
>   drivers/ata/libata.h                | 12 --------
>   5 files changed, 35 insertions(+), 85 deletions(-)
> 
> diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
> index d477e296bda5..311af516a3fd 100644
> --- a/Documentation/driver-api/libata.rst
> +++ b/Documentation/driver-api/libata.rst
> @@ -424,12 +424,6 @@ How commands are issued
>   -----------------------
>   
>   Internal commands
> -    First, qc is allocated and initialized using :c:func:`ata_qc_new_init`.
> -    Although :c:func:`ata_qc_new_init` doesn't implement any wait or retry
> -    mechanism when qc is not available, internal commands are currently
> -    issued only during initialization and error recovery, so no other
> -    command is active and allocation is guaranteed to succeed.
> -
>       Once allocated qc's taskfile is initialized for the command to be
>       executed. qc currently has two mechanisms to notify completion. One
>       is via ``qc->complete_fn()`` callback and the other is completion
> @@ -447,11 +441,6 @@ SCSI commands
>       translated. No qc is involved in processing a simulated scmd. The
>       result is computed right away and the scmd is completed.
>   
> -    For a translated scmd, :c:func:`ata_qc_new_init` is invoked to allocate a
> -    qc and the scmd is translated into the qc. SCSI midlayer's
> -    completion notification function pointer is stored into
> -    ``qc->scsidone``.
> -
>       ``qc->complete_fn()`` callback is used for completion notification. ATA
>       commands use :c:func:`ata_scsi_qc_complete` while ATAPI commands use
>       :c:func:`atapi_qc_complete`. Both functions end up calling ``qc->scsidone``
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 1067b2e2be28..5e7d6ccad5da 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4563,43 +4563,6 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
>   #endif /* __BIG_ENDIAN */
>   }
>   
> -/**
> - *	ata_qc_new_init - Request an available ATA command, and initialize it
> - *	@dev: Device from whom we request an available command structure
> - *	@scmd: scmd for which to get qc
> - *
> - *	LOCKING:
> - *	None.
> - */
> -
> -struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd)
> -{
> -	int tag = scsi_cmd_to_rq(scmd)->tag;
> -	struct ata_port *ap = dev->link->ap;
> -	struct ata_queued_cmd *qc;
> -
> -	/* no command while frozen */
> -	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
> -		return NULL;
> -
> -	/* libsas case */
> -	if (ap->flags & ATA_FLAG_SAS_HOST) {
> -		tag = ata_sas_get_tag(scmd);
> -		if (tag < 0)
> -			return NULL;
> -	}
> -
> -	qc = __ata_qc_from_tag(ap, tag);
> -	qc->tag = qc->hw_tag = tag;
> -	qc->scsicmd = NULL;
> -	qc->ap = ap;
> -	qc->dev = dev;
> -
> -	ata_qc_reinit(qc);
> -
> -	return qc;
> -}
> -
>   /**
>    *	ata_qc_free - free unused ata_queued_cmd
>    *	@qc: Command to complete
> @@ -4612,13 +4575,8 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd
>    */
>   void ata_qc_free(struct ata_queued_cmd *qc)
>   {
> -	unsigned int tag;
> -
> -	WARN_ON_ONCE(qc == NULL); /* ata_qc_from_tag _might_ return NULL */
> -
>   	qc->flags = 0;
> -	tag = qc->tag;
> -	if (ata_tag_valid(tag))
> +	if (ata_tag_valid(qc->tag))
>   		qc->tag = ATA_TAG_POISON;
>   }
>   
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index c3e9fd7d920c..7a5fe41aa5ae 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1268,14 +1268,6 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
>   }
>   EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
>   
> -int ata_sas_get_tag(struct scsi_cmnd *scmd)
> -{
> -	if (WARN_ON_ONCE(scmd->budget_token >= ATA_MAX_QUEUE))
> -		return -1;
> -
> -	return scmd->budget_token;
> -}
> -
>   /**
>    *	sata_async_notification - SATA async notification handler
>    *	@ap: ATA port where async notification is received
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 61dd7f7c7743..50ef132ec48c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -638,24 +638,47 @@ EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
>   static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>   					      struct scsi_cmnd *cmd)
>   {
> +	struct ata_port *ap = dev->link->ap;
>   	struct ata_queued_cmd *qc;
> +	int tag;
>   
> -	qc = ata_qc_new_init(dev, cmd);
> -	if (qc) {
> -		qc->scsicmd = cmd;
> -		qc->scsidone = scsi_done;
> -
> -		qc->sg = scsi_sglist(cmd);
> -		qc->n_elem = scsi_sg_count(cmd);
> +	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
> +		goto fail;
>   
> -		if (scsi_cmd_to_rq(cmd)->rq_flags & RQF_QUIET)
> -			qc->flags |= ATA_QCFLAG_QUIET;
> +	if (ap->flags & ATA_FLAG_SAS_HOST) {
> +		/*
> +		 * SAS hosts may queue > ATA_MAX_QUEUE commands so use
> +		 * unique per-device budget token as a tag.
> +		 */
> +		if (WARN_ON_ONCE(cmd->budget_token >= ATA_MAX_QUEUE))
> +			goto fail;
> +		tag = cmd->budget_token;
>   	} else {
> -		cmd->result = (DID_OK << 16) | SAM_STAT_TASK_SET_FULL;
> -		scsi_done(cmd);
> +		tag = scsi_cmd_to_rq(cmd)->tag;
>   	}
>   
> +	qc = __ata_qc_from_tag(ap, tag);
> +	qc->tag = qc->hw_tag = tag;
> +	qc->scsicmd = NULL;
> +	qc->ap = ap;
> +	qc->dev = dev;
> +
> +	ata_qc_reinit(qc);
> +
> +	qc->scsicmd = cmd;
> +	qc->scsidone = scsi_done;
> +
> +	qc->sg = scsi_sglist(cmd);
> +	qc->n_elem = scsi_sg_count(cmd);
> +
> +	if (scsi_cmd_to_rq(cmd)->rq_flags & RQF_QUIET)
> +		qc->flags |= ATA_QCFLAG_QUIET;

Please add a blank line here.
I like to have return statements stand out :)

>   	return qc;
> +
> +fail:
> +	cmd->result = (DID_OK << 16) | SAM_STAT_TASK_SET_FULL;

While at it, it may be better to use:

	set_host_byte(cmd, DID_OK);
	set_status_byte(cmd, SAM_STAT_TASK_SET_FULL);

> +	scsi_done(cmd);
> +	return NULL;
>   }
>   
>   static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 92e52090165b..926a7f41303d 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -44,7 +44,6 @@ static inline void ata_force_cbl(struct ata_port *ap) { }
>   #endif
>   extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
>   extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
> -extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd);
>   extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
>   			   u64 block, u32 n_block, unsigned int tf_flags,
>   			   unsigned int tag, int class);
> @@ -91,17 +90,6 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>   
>   #define to_ata_port(d) container_of(d, struct ata_port, tdev)
>   
> -/* libata-sata.c */
> -#ifdef CONFIG_SATA_HOST
> -int ata_sas_get_tag(struct scsi_cmnd *scmd);
> -#else
> -static inline int ata_sas_get_tag(struct scsi_cmnd *scmd)
> -{
> -	return -EOPNOTSUPP;
> -}
> -static inline void ata_sas_free_tag(unsigned int tag, struct ata_port *ap) { }
> -#endif
> -
>   /* libata-acpi.c */
>   #ifdef CONFIG_ATA_ACPI
>   extern unsigned int ata_acpi_gtf_filter;


-- 
Damien Le Moal
Western Digital Research
