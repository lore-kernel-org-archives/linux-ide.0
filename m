Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1877BC38A2D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 01:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiJ0BS2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 26 Oct 2022 21:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJ0BS1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 26 Oct 2022 21:18:27 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72041558F7
        for <linux-ide@vger.kernel.org>; Wed, 26 Oct 2022 18:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666833506; x=1698369506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j4VTz3xAsPX1ykQZALKZMRU5knt+b8ZaK/+epWQA9oU=;
  b=J+weay5X6YGx7ZakXe22jU7wBErPpwvaqI8FOz/+gayX+A8sxUfXSVUI
   ptkM1pRE+/3EGKkmyLfT172IrvwdN9I6SI3OAzaG/HDGLNpXfjCkNiCe4
   Ib+jIwUjyfjHz7lMvDjFT75Zw/eRrWQ5YtKVDhieI5nvfC5rR2YZOdc7K
   Nkm4pEvDDNaPp/alyvx8KtTS1D2P5en9meWNgm+U0XfEPG9cwcxioVo3n
   KYufda9R8EcVEO4/Yku2YrM2/yvbtnN0XcfCRNShDc4icHQvcNr5HYfUo
   3juybDG+ZSL4/E5zxG4L9Ha5J3zYViMdlE3QsSU8Yljkz42MN+JR2zW58
   g==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="214828248"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 09:18:25 +0800
IronPort-SDR: zkUHM0ewTvXoq6M89vjzzqkYzGLjc/Lm2BUJ/mpJGgszBW6A6iaFG/jmIr5oGVJKbkkU+97Fl1
 zVIjo/ANED0ZbJIP3nr6h3zDFgW4fQULHGLYYZ1nsh31WvR76FdpzhcjOtNPeWHbwS2FxIW01C
 +/BHwPSNcXLqkVhYi/HELBek8+0ic3R1wuy3XNRaKn8yCJzpe1tQMMMOG5pLlPJo+39UwacTdL
 /JL8gsPq0hXZn2C+lzfuJkbJJMHH2dEsx8t919ZMz6aVeSl6x5NaPozp7/j8otbiiR9n6xj13q
 WP3go/I5HvSpM9KLTQGDpUhl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 17:32:04 -0700
IronPort-SDR: BDkbCo//41JB9N8gz10w2gKE/8HvEhYdgviKSA+1pHY+bW5PgwtgYSbJLEaCToLESGWZOU5Gmp
 c0XGr1tfD3ZZkJ7qS/j1R4WEupTXEkAGaka3efJelWenAPv7PhDEjOmU+lV2bYI3WTfiu/M9z3
 krAhlJJArpnWcPtmNZeaV8e6YXTsExXz6tQdODqhGHWdamwlYlgOoTRB1f92SihDeHPlHUR7Eg
 KVMAkdWT6AlJQ9mH9LLc2jhJeCaAMt/tUcORJy++e1novSOPmYHHhIaZ07EtdNX4ajotSDZlrW
 aCs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 18:18:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MySVS6gwNz1Rwrq
        for <linux-ide@vger.kernel.org>; Wed, 26 Oct 2022 18:18:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666833503; x=1669425504; bh=j4VTz3xAsPX1ykQZALKZMRU5knt+b8ZaK/+
        epWQA9oU=; b=AlLTfLAZlMQuunUsaVrTOL6ArW6Bwtsjjj/dCIowQnsGO3Ny7IX
        8fETeWSg45iCdJ8qBnD5z9SzZ/rORSWbNt/6k6fIGNFSbPAqFXciPJsr2KkDWTYs
        4CAskUPPRb9upJ55xdDt6x1lGglffoeITJ/e0Hhgpz7w6fETMh1tf5n9pmIgVc8v
        0F2yXafbOJQOQydVy9vvvCtlzJyv7BxaoC6XYzj+DV/1MRedMmNCBjwu4SNfv/es
        lH9AOj8pyGJ0iSrnx/dhludNfuMK6I+54MpHK7PJNM8/QKrcsZxy+6vbMoml8zi+
        +BodTY/qmKOETxc9ZWmNtOvXjEpqOvOLMfA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TPjKlrQCAZiq for <linux-ide@vger.kernel.org>;
        Wed, 26 Oct 2022 18:18:23 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MySVP4qbZz1RvLy;
        Wed, 26 Oct 2022 18:18:21 -0700 (PDT)
Message-ID: <cd5df8e0-03d1-8f22-0367-eb7c76bc70e7@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 10:18:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 03/22] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-4-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1666693096-180008-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/25/22 19:17, John Garry wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Quite some drivers are using management commands internally, which
> typically use the same hardware tag pool (ie they are being allocated
> from the same hardware resources) as the 'normal' I/O commands.
> These commands are set aside before allocating the block-mq tag bitmap,
> so they'll never show up as busy in the tag map.
> The block-layer, OTOH, already has 'reserved_tags' to handle precisely
> this situation.
> So this patch adds a new field 'nr_reserved_cmds' to the SCSI host
> template to instruct the block layer to set aside a tag space for these
> management commands by using reserved tags.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> #jpg: Set tag_set->queue_depth = shost->can_queue, and not
> = shost->can_queue + shost->nr_reserved_cmds;
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/hosts.c     |  3 +++
>  drivers/scsi/scsi_lib.c  |  2 ++
>  include/scsi/scsi_host.h | 15 ++++++++++++++-
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index 12346e2297fd..db89afc37bc9 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -489,6 +489,9 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>  	if (sht->virt_boundary_mask)
>  		shost->virt_boundary_mask = sht->virt_boundary_mask;
>  
> +	if (sht->nr_reserved_cmds)
> +		shost->nr_reserved_cmds = sht->nr_reserved_cmds;
> +

Nit: the if is not really necessary I think. But it does not hurt.

>  	device_initialize(&shost->shost_gendev);
>  	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
>  	shost->shost_gendev.bus = &scsi_bus_type;
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 39d4fd124375..a8c4e7c037ae 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1978,6 +1978,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>  	tag_set->nr_hw_queues = shost->nr_hw_queues ? : 1;
>  	tag_set->nr_maps = shost->nr_maps ? : 1;
>  	tag_set->queue_depth = shost->can_queue;
> +	tag_set->reserved_tags = shost->nr_reserved_cmds;
> +

Why the blank line ?

>  	tag_set->cmd_size = cmd_size;
>  	tag_set->numa_node = dev_to_node(shost->dma_dev);
>  	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 750ccf126377..91678c77398e 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -360,10 +360,17 @@ struct scsi_host_template {
>  	/*
>  	 * This determines if we will use a non-interrupt driven
>  	 * or an interrupt driven scheme.  It is set to the maximum number
> -	 * of simultaneous commands a single hw queue in HBA will accept.
> +	 * of simultaneous commands a single hw queue in HBA will accept
> +	 * including reserved commands.
>  	 */
>  	int can_queue;
>  
> +	/*
> +	 * This determines how many commands the HBA will set aside
> +	 * for reserved commands.
> +	 */
> +	int nr_reserved_cmds;
> +
>  	/*
>  	 * In many instances, especially where disconnect / reconnect are
>  	 * supported, our host also has an ID on the SCSI bus.  If this is
> @@ -611,6 +618,12 @@ struct Scsi_Host {
>  	 */
>  	unsigned nr_hw_queues;
>  	unsigned nr_maps;
> +
> +	/*
> +	 * Number of reserved commands to allocate, if any.
> +	 */
> +	unsigned int nr_reserved_cmds;
> +
>  	unsigned active_mode:2;
>  
>  	/*

-- 
Damien Le Moal
Western Digital Research

