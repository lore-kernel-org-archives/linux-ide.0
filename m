Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C87C43334
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jun 2022 07:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiFMHMv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jun 2022 03:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbiFMHMu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jun 2022 03:12:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F81A39D
        for <linux-ide@vger.kernel.org>; Mon, 13 Jun 2022 00:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655104370; x=1686640370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mwWtBRJWqJTQqkv9N+KiDQ+C5naTYFLMDpQnieAA+9k=;
  b=M24J5WwehBvfDRaJeNub2kv/16VDgaDuXKqfdX/0//SGXTgmnB22Z5oY
   2J8bDFBanP25fxxhkGyklSnfR7YKFZ3mhhQtgvCD1fy7HF9B3Yg5y5nHu
   Pe8tzyt9AqrRxuo5eV6gZSMqo7O6uZAKS2L/ulF1qQcohXAD4eVCpz6BQ
   1TnZZAyGSkfA8fMMgCl7V4FYaLfoO2JUsSSxn73JCaJFWoKjz5ZcRhV3b
   142YVq5wrrnRVASynr1u9pk0ORkuQ88EDvtXHdW0222lCorsr6odzyiJr
   NA58NeXAGMUQrKkoGg6NAb/p0yGBSAD9hRjQt4PUGXyNWy1dhEC6yEtJo
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="307260568"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 15:12:49 +0800
IronPort-SDR: QIVhj1tKF6It9/gBH4v8hXHWTT5zMcr77q0i3oZdEPR5Dwrqctqw+lW+BoWBT6IBDsOjF0VCzV
 ejVjKesw4YtKhB4ZntOlyhyKmMzOD7FKZpoAS0sCgmu+JXrVjWiTU7z90S7+0I10nNkf0wF9tp
 4VDGswR82wVAII5KgkqEUWGDuo3dstNV3qSrdCC7j2RXUpZFnaTsIbApiq+I/fmfRTMFIYN4e8
 OA0ia/QYQFRF7RVLxXnWoC36NlynIcG4y+ARNvQNInI6cmRvQk9YsNKGWwwg0OA6PJPYjJ8fz4
 4WjlTl8hCgY+T2X7wYOmYarc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 23:31:29 -0700
IronPort-SDR: 1+dTuYGfQOdPk2UoSk9tfXeHl4ZWip8eAKCMdIJm4BeE+hFpYENp3vZNUJQqnGkg5Pf+eV5E7S
 3tEaGIZkTju29l30Dl0UsLIEWpmz6GgsZDXJK+6Y6TjdLi4Nd35Idf0cZDFW7k0hK9Q8GcEEKZ
 0Vk0+qEJihytis3JvAmyVb9ZPdSFPneA0099x/cqTavM+1Ium1InOYA5R+6AJNjWwNC1Xn5quQ
 hO4PMTJP3aRDbxHk4XghJL0KC0p3Fnzx62x1pI97P3hRA+0yXFM1rVc+fq9WrU1SXoKPfthGWu
 8Gs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 00:12:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LM2p85ZbKz1SVp1
        for <linux-ide@vger.kernel.org>; Mon, 13 Jun 2022 00:12:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655104368; x=1657696369; bh=mwWtBRJWqJTQqkv9N+KiDQ+C5naTYFLMDpQ
        nieAA+9k=; b=gO24qBoEkI05WHC2emPW2LkwMhMFNWvB4ifkMFxwRnT4jvGNFUt
        Xtufnd6o7AOSAeu7R8MsOeusuvcbiHbIWvX8ohyV4OR99MVRsAloNUjqyQqonmkv
        FYO9VZGMET5f/ebEloNXrc2TiOsw7MLqX9+dAmJWrYjrd9cW2BG9muaSkTTij+/L
        XsGbYWujcbaf6xzbkozGdhyG/I9ooVIr/SgXohsb1j0zT8nKBv8UVRWO71aBo3kA
        6xO3vwBetpdT4JyiC2sYbtkew58mnF/VQtyDAJGs2JMII6LnbM9nw2J+07HrIshA
        WN1nW+zeqfJwq/6SvjWvdlr/Ba5Kh1KnSxQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ULcAeqyGAl7n for <linux-ide@vger.kernel.org>;
        Mon, 13 Jun 2022 00:12:48 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LM2p55NkMz1Rvlc;
        Mon, 13 Jun 2022 00:12:45 -0700 (PDT)
Message-ID: <5b4d17c2-9ee6-7d44-e4cd-6402b0a61c01@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 16:12:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 06/18] libata-scsi: Add ata_scsi_queue_internal()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-7-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1654770559-101375-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/9/22 19:29, John Garry wrote:
> Add a function to handle queued ATA internal SCSI cmnds - does much the
> same as ata_exec_internal_sg() does (which will be fixed up later to
> actually queue internal cmnds through this function).
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/ata/libata-scsi.c | 47 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/libata.h    |  6 +++++
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 42cecf95a4e5..baac35dd17ca 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3963,6 +3963,49 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
>  	return NULL;
>  }
>  
> +static unsigned int ata_scsi_queue_internal(struct scsi_cmnd *scmd,
> +					    struct ata_device *dev)
> +{
> +	struct ata_link *link = dev->link;
> +	struct ata_port *ap = link->ap;
> +	struct ata_queued_cmd *qc;
> +
> +	/* no internal command while frozen */
> +	if (ap->pflags & ATA_PFLAG_FROZEN)
> +		goto did_err;
> +
> +	/* initialize internal qc */
> +	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
> +	link->preempted_tag = link->active_tag;
> +	link->preempted_sactive = link->sactive;
> +	ap->preempted_qc_active = ap->qc_active;
> +	ap->preempted_nr_active_links = ap->nr_active_links;
> +	link->active_tag = ATA_TAG_POISON;
> +	link->sactive = 0;
> +	ap->qc_active = 0;
> +	ap->nr_active_links = 0;> +
> +	if (qc->dma_dir != DMA_NONE) {
> +		int n_elem;
> +
> +		n_elem = 1;
> +		qc->n_elem = n_elem;
> +		qc->sg = scsi_sglist(scmd);
> +		qc->nbytes = qc->sg->length;
> +		ata_sg_init(qc, qc->sg, n_elem);
> +	}
> +
> +	scmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
> +
> +	ata_qc_issue(qc);
> +
> +	return 0;
> +did_err:
> +	scmd->result = (DID_ERROR << 16);
> +	scsi_done(scmd);
> +	return 0;
> +}
> +
>  int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>  {
>  	u8 scsi_op = scmd->cmnd[0];
> @@ -3971,7 +4014,9 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>  	if (unlikely(!scmd->cmd_len))
>  		goto bad_cdb_len;
>  
> -	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
> +	if (scsi_is_reserved_cmd(scmd)) {
> +		return ata_scsi_queue_internal(scmd, dev);
> +	} else if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {

No need for the else here.

>  		if (unlikely(scmd->cmd_len > dev->cdb_len))
>  			goto bad_cdb_len;
>  
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 732de9014626..43f4bcfe9a5f 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -767,7 +767,9 @@ struct ata_link {
>  
>  	struct device		tdev;
>  	unsigned int		active_tag;	/* active tag on this link */
> +	unsigned int		preempted_tag;
>  	u32			sactive;	/* active NCQ commands */
> +	u32			preempted_sactive;
>  
>  	unsigned int		flags;		/* ATA_LFLAG_xxx */
>  
> @@ -861,6 +863,10 @@ struct ata_port {
>  #ifdef CONFIG_ATA_ACPI
>  	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
>  #endif
> +
> +	u64 preempted_qc_active;
> +	int preempted_nr_active_links;
> +
>  	/* owned by EH */
>  	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
>  };


-- 
Damien Le Moal
Western Digital Research
