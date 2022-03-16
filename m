Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E343FC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 16 Mar 2022 03:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiCPDWz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Mar 2022 23:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiCPDWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Mar 2022 23:22:54 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7775C856
        for <linux-ide@vger.kernel.org>; Tue, 15 Mar 2022 20:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647400900; x=1678936900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0tMGg/mjHRA0kNh/9cBNcvbCDCHUiiq3kSLRADxKok0=;
  b=YVS/T8ystqYO6EjFHZM90HOeB51xJ5PuJAS2O4t7TsbgQvzTvpwuSy27
   VvASMjsfDtLV8RCMUlj9sQ2fiIOBCS8ATizywDzIGbNriQyzMO6sucuFh
   G9Eh9bp+mwYaW8j/QwlnFvABI49MPgE6QF6Ss0TjXSSHq+oFpuCbNYB6W
   Rb4/RqXPpFgYZxKiLhdFxNR5kK9e7dJCwwy1s4ewBCbTkWzNiNYtyQW4k
   uy3Z2kP5b7IAGhI9FfCVJmurnpcbN5NaEa4H2K4aXnm8nH70iM82SiI+l
   A2QT5sQ/lkJq5rMOzjWqrTbm/UP/twDlHYeQfG9FpTadSz7ue5CuaeXfq
   g==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; 
   d="scan'208";a="195467710"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 11:21:39 +0800
IronPort-SDR: Nda3y8InDkEKyoc2LyGU7v/h7oUIUzsfa7m4CCEeUY6hbO1ysn4vptOzMjgU5w37t42tNpBIvz
 UHEQZH/w39zh2s8FZqSRKm1dR1r6Dv3dhZWDbV8p8oeJIeaiOCLmA+7bwXPtwUhJFAxfgN1mHy
 9Qq8pUFecdevspKFqayVpwrCiYYRc1cVdFSHqw8o2Hg1lfMIGNmEhPuQavmmhLHmOxu677QuIi
 24kAgcXlExN4FtC72gDPLYbyU4gwBEf2Py9hY5Mi3f9K8SwQh5Xe57MrPBFqInwj4sVy1r5Lay
 Qcbm1n9vujwaubLCWY8XnJ2e
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:52:47 -0700
IronPort-SDR: 37zEfZbpcpdo4Owh5ZzdmlsTArXC1qZXi6BeM0oeJyly6Cogpm4gh7WVYFjwJ8xPtiKNCoRiUO
 U4Vvn3owmBONtODbNYj34C1dIvvY81QJtwVOeZvi6+wZz9fGC/uK+pMf0t8AMkcaJbGY6Mm/co
 C9nvsfG/MRTfwP+W9QWBXQP91d0s2bTLxuqBUnsi/iT3Ib/QyXit7tNKf3X22jGy1WBStBYIzZ
 yeXlYirGZBe3kabJ0cRMgYSgGe2DIX32V9uLwel1Wh2FCeJZDaT0XhzA1s9veNMHB349rzRLh8
 xF4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 20:21:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJFtW6TSdz1SVnx
        for <linux-ide@vger.kernel.org>; Tue, 15 Mar 2022 20:21:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647400898; x=1649992899; bh=0tMGg/mjHRA0kNh/9cBNcvbCDCHUiiq3kSL
        RADxKok0=; b=swKyVfuDFLQdDO41BgJH5XNlxGTp+eIFr7RkK2oXzk57OGUaGdh
        HV2Yq3eg3mIJPgAeW9h66IkY/T3IwYh5MPZOr4nVv3jinBKJxUiQY2D6R3KQc7CG
        OXPBeWmqqk+oW9sFNYfG7vrIx4XBHhCzFOkZEoeMHRyOTF746meewlgSGyMfSxX0
        r1/dr41SgwT7P8GrpRu+XmJpicrcrFnirYhbpQKxPZeB0iFUsggk/1HoLTPbR1+q
        EIzSQWWmVcolekE/zd+SuwSQXOdORtK61ovZxyclfaSjR5R+idNkCiOd048RlsOX
        xXSAp7hIAQ4qCMg87e0UoyMoUXA3Jo/9I+A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UgU2Dk4GNPzb for <linux-ide@vger.kernel.org>;
        Tue, 15 Mar 2022 20:21:38 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJFtT0d3pz1Rvlx;
        Tue, 15 Mar 2022 20:21:36 -0700 (PDT)
Message-ID: <99541f2d-2aea-6bd7-e3b6-21dbc355875d@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 12:21:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH RFC 2/2] libata: Use scsi cmnd budget token for qc tag for
 SAS host
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, bvanassche@acm.org,
        ming.lei@redhat.com, hch@lst.de, hare@suse.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.wilck@suse.com
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
 <1647340746-17600-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1647340746-17600-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/15/22 19:39, John Garry wrote:
> For attaining a qc tag for a SAS host we need to allocate a bit in
> ata_port.sas_tag_allocated bitmap.
> 
> However we already have a unique tag per device in range
> [0, ATA_MAX_QUEUE) in the scsi cmnd budget token, so just use that
> instead.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/ata/libata-core.c |  5 +++--
>  drivers/ata/libata-sata.c | 21 ++++-----------------
>  drivers/ata/libata-scsi.c |  2 +-
>  drivers/ata/libata.h      |  4 ++--
>  include/linux/libata.h    |  1 -
>  5 files changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0c854aebfe0b..2c0a550d3ecd 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4572,8 +4572,9 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
>   *	None.
>   */
>  
> -struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
> +struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd)
>  {
> +	int tag = scsi_cmd_to_rq(scmd)->tag;
>  	struct ata_port *ap = dev->link->ap;
>  	struct ata_queued_cmd *qc;
>  
> @@ -4583,7 +4584,7 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
>  
>  	/* libsas case */
>  	if (ap->flags & ATA_FLAG_SAS_HOST) {
> -		tag = ata_sas_allocate_tag(ap);
> +		tag = ata_sas_allocate_tag(ap, scmd);
>  		if (tag < 0)
>  			return NULL;
>  	}
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 071158c0c44c..a4374fdffc43 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1268,29 +1268,16 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
>  }
>  EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
>  
> -int ata_sas_allocate_tag(struct ata_port *ap)
> +int ata_sas_allocate_tag(struct ata_port *ap, struct scsi_cmnd *scmd)
>  {
> -	unsigned int max_queue = ap->host->n_tags;
> -	unsigned int i, tag;
> +	if (scmd->budget_token >= ATA_MAX_QUEUE)
> +		return -1;
>  
> -	for (i = 0, tag = ap->sas_last_tag + 1; i < max_queue; i++, tag++) {
> -		tag = tag < max_queue ? tag : 0;
> -
> -		/* the last tag is reserved for internal command. */
> -		if (ata_tag_internal(tag))
> -			continue;
> -
> -		if (!test_and_set_bit(tag, &ap->sas_tag_allocated)) {
> -			ap->sas_last_tag = tag;
> -			return tag;
> -		}
> -	}
> -	return -1;
> +	return scmd->budget_token;
>  }

Since this is now not actually allocating a tag, I would rename this
something like ata_sas_get_tag(). Or even better, simply open code this
in ata_qc_new_init() since that is the only caller.

>  
>  void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
>  {
> -	clear_bit(tag, &ap->sas_tag_allocated);
>  }

This is called only in ata_qc_free(). With this change, the function is
empty, so let's completely remove it.

>  
>  /**
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index ed8be585a98f..45d63a2ba3ee 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -640,7 +640,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>  {
>  	struct ata_queued_cmd *qc;
>  
> -	qc = ata_qc_new_init(dev, scsi_cmd_to_rq(cmd)->tag);
> +	qc = ata_qc_new_init(dev, cmd);
>  	if (qc) {
>  		qc->scsicmd = cmd;
>  		qc->scsidone = scsi_done;
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 51e01acdd241..65302d7829fe 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -44,7 +44,7 @@ static inline void ata_force_cbl(struct ata_port *ap) { }
>  #endif
>  extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
>  extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
> -extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag);
> +extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd);
>  extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
>  			   u64 block, u32 n_block, unsigned int tf_flags,
>  			   unsigned int tag, int class);
> @@ -93,7 +93,7 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>  
>  /* libata-sata.c */
>  #ifdef CONFIG_SATA_HOST
> -int ata_sas_allocate_tag(struct ata_port *ap);
> +int ata_sas_allocate_tag(struct ata_port *ap, struct scsi_cmnd *scmd);
>  void ata_sas_free_tag(unsigned int tag, struct ata_port *ap);
>  #else
>  static inline int ata_sas_allocate_tag(struct ata_port *ap)
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 7f99b4d78822..3b9399f67b39 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -814,7 +814,6 @@ struct ata_port {
>  	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
>  
>  	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE + 1];
> -	unsigned long		sas_tag_allocated; /* for sas tag allocation only */
>  	u64			qc_active;
>  	int			nr_active_links; /* #links with active qcs */
>  	unsigned int		sas_last_tag;	/* track next tag hw expects */


-- 
Damien Le Moal
Western Digital Research
