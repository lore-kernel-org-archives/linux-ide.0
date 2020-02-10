Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B05C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8479A20715
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h5EqK1K6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJPk4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:40:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50452 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJPk4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:40:56 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210154054euoutp02384037236717f2deef635b8baf5547cc~yFMTdIIi_2204722047euoutp02K
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:40:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210154054euoutp02384037236717f2deef635b8baf5547cc~yFMTdIIi_2204722047euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581349254;
        bh=X8SrsaJx/FpXDiOZbBIlTqmf6ZUCnfwxaczWG1yYhJs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=h5EqK1K6cIZYlX8q8pKGFRJl1rkl+dcj7OFoPeD/BXla72VvQ48mE4onXzxOfIX1Z
         6BKyHzZbp7/nXcO7I6HA+Xej5tDJnfh4GtZUcej2S0UUk77rIZnh6sepYEx7rRGDvI
         V2F9kA34aARloZ0PEFQ8XQnAlSMbAgKcBLnXfaWI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210154054eucas1p2f7586b86355f6beb1cac6cd83a0cc12d~yFMTQKpBt2043620436eucas1p24;
        Mon, 10 Feb 2020 15:40:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.30.61286.689714E5; Mon, 10
        Feb 2020 15:40:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210154054eucas1p2a38f95cebb22508adc8bb477defd8304~yFMSxCdCY1849318493eucas1p2I;
        Mon, 10 Feb 2020 15:40:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210154054eusmtrp20dcacf520a8d51b5f11b29f9d34f0b40~yFMSwgzfU2781627816eusmtrp2w;
        Mon, 10 Feb 2020 15:40:54 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-9a-5e41798694ff
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 88.51.08375.689714E5; Mon, 10
        Feb 2020 15:40:54 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210154053eusmtip2cad524c69390ae20b5cbf1f0ae333a9e~yFMSg7Z3o2642526425eusmtip2X;
        Mon, 10 Feb 2020 15:40:53 +0000 (GMT)
Subject: Re: [PATCH 28/46] libata-scsi: drop DPRINTK calls for cdb
 translation
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <bfd7ccba-bd26-3295-7fe4-6e68a20e1aae@samsung.com>
Date:   Mon, 10 Feb 2020 16:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-29-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd22Ssc4gw1Nqhar7/azWexZNInJ
        4tiOR0wOzB6Xz5Z6bD5d7fF5k1wAcxSXTUpqTmZZapG+XQJXxpE1B9kK1slWLP7fztTAuFK8
        i5GTQ0LARKJ19hHWLkYuDiGBFYwS3yZPgnK+MEq8uvGVBcL5zCgx7VcnO0zLrTV3oaqWM0o0
        /FzLBOG8ZZQ4+vkRE0iVsECAxKoPM1hBbBEBJYmP7YfAupkFrCVmL14PVsMmYCUxsX0VI4jN
        K2An8XfpKrB6FgFVictP/jOD2KICERKfHhxmhagRlDg58wkLiM0JdMXaJx1QM8Ulbj2ZzwRh
        y0tsfzuHGeQgCYH/bBIL1nxkhTjbReLbz91MELawxKvjW6DekZH4v3M+E0TDOkaJvx0voLq3
        M0osn/yPDaLKWuLOuV9ANgfQCk2J9bv0IcKOEvtnzWYECUsI8EnceCsIcQSfxKRt05khwrwS
        HW1CENVqEhuWbWCDWdu1cyXzBEalWUhem4XknVlI3pmFsHcBI8sqRvHU0uLc9NRiw7zUcr3i
        xNzi0rx0veT83E2MwDRy+t/xTzsYv15KOsQowMGoxMNbEegYJ8SaWFZcmXuIUYKDWUmE11Ia
        KMSbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAOj9Pf5JlfF
        /8+K/P0vM9fz87kIR/M5rlPmFzzK+noqRJf/+7Yw0wurvh0oCEyO+eQtHN0oN4018e3sTHO7
        //sXZj9Tbqx48XvZy2vv9f/48yr4bJqnlfGg4LJd+v6+v09nOcx/zG7FlTdB2u3Laov/8Zf9
        l/bmMEVcSy32PK+07vfKfXuidrjEKbEUZyQaajEXFScCAG1y3xAfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7ptlY5xBofmsFmsvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6GUfWHGQrWCdbsfh/O1MD40rxLkZODgkBE4lba+6ydjFycQgJ
        LGWUOHDqI0sXIwdQQkbi+PoyiBphiT/Xutggal4zSlw9toANpEZYwE9iz2sekBoRASWJj+2H
        2EFsZgFridmL1zNB1G9glJh58i0zSIJNwEpiYvsqRhCbV8BO4u/SVawgNouAqsTlJ//BakQF
        IiQO75gFVSMocXLmExYQmxPo0LVPOqAWqEv8mXeJGcIWl7j1ZD4ThC0vsf3tHOYJjEKzkLTP
        QtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTGzLZjPzfvYLy0MfgQowAH
        oxIPb0WgY5wQa2JZcWXuIUYJDmYlEV5LaaAQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wPj
        Oa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUAyNT7oPzMUJavvuC
        QmdcKFmyzSaxiXOXtbTCQj2Ft1sO/D0e99SwyOmGV6/kpck6VmwiR4TjLS4cT3PaqeBT+d3m
        769eu+pMs9OXazT4N5iJOG0VUeoMDfk8ufhY5Ms1uXkrL4moVbfdUfuzMmFtjEps893ZbS+n
        hulJ2ezWfbwkIz22RVKfU4mlOCPRUIu5qDgRAPYyqAivAgAA
X-CMS-MailID: 20200210154054eucas1p2a38f95cebb22508adc8bb477defd8304
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p2fc2a33b26a586a14a0467b75ab79fcad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p2fc2a33b26a586a14a0467b75ab79fcad
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p2fc2a33b26a586a14a0467b75ab79fcad@eucas1p2.samsung.com>
        <20200204165547.115220-29-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Drop DPRINTK calls for cdb translation as they are already covered
> by other traces, and convert the DPRINTK calls in ata_scsi_hotplug()
> to ata_port_dbg() calls.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-scsi.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index eb2eb599e602..91b69ebef268 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1761,9 +1761,6 @@ static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc)
>  		head  = track % dev->heads;
>  		sect  = (u32)block % dev->sectors + 1;
>  
> -		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
> -			(u32)block, track, cyl, head, sect);
> -
>  		/* Check whether the converted CHS can fit.
>  		   Cylinder: 0-65535
>  		   Head: 0-15
> @@ -1886,7 +1883,6 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
>  			goto invalid_fld;
>  		break;
>  	default:
> -		DPRINTK("no-byte command\n");
>  		fp = 0;
>  		goto invalid_fld;
>  	}
> @@ -2040,7 +2036,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>  early_finish:
>  	ata_qc_free(qc);
>  	cmd->scsi_done(cmd);
> -	DPRINTK("EXIT - early finish (good or error)\n");
>  	return 0;
>  
>  err_did:
> @@ -2048,12 +2043,10 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	cmd->result = (DID_ERROR << 16);
>  	cmd->scsi_done(cmd);
>  err_mem:
> -	DPRINTK("EXIT - internal\n");
>  	return 0;
>  
>  defer:
>  	ata_qc_free(qc);
> -	DPRINTK("EXIT - defer\n");
>  	if (rc == ATA_DEFER_LINK)
>  		return SCSI_MLQUEUE_DEVICE_BUSY;
>  	else
> @@ -2820,8 +2813,6 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
>  	struct ata_port *ap = qc->ap;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  
> -	DPRINTK("ATAPI request sense\n");
> -
>  	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
>  
>  #ifdef CONFIG_ATA_SFF
> @@ -2860,8 +2851,6 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
>  	qc->complete_fn = atapi_sense_complete;
>  
>  	ata_qc_issue(qc);
> -
> -	DPRINTK("EXIT\n");
>  }
>  
>  /*
> @@ -2971,7 +2960,6 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
>  	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>  	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
>  		qc->tf.flags |= ATA_TFLAG_WRITE;
> -		DPRINTK("direction: write\n");
>  	}
>  
>  	qc->tf.command = ATA_CMD_PACKET;
> @@ -4355,8 +4343,6 @@ static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
>  	return rc;
>  
>   bad_cdb_len:
> -	DPRINTK("bad CDB len=%u, scsi_op=0x%02x, max=%u\n",
> -		scmd->cmd_len, scsi_op, dev->cdb_len);
>  	scmd->result = DID_ERROR << 16;
>  	scmd->scsi_done(scmd);
>  	return 0;
> @@ -4796,11 +4782,11 @@ void ata_scsi_hotplug(struct work_struct *work)
>  	int i;
>  
>  	if (ap->pflags & ATA_PFLAG_UNLOADING) {
> -		DPRINTK("ENTER/EXIT - unloading\n");
> +		ata_port_dbg(ap, "unloading\n");
>  		return;
>  	}
>  
> -	DPRINTK("ENTER\n");
> +	ata_port_dbg(ap, "ENTER\n");
>  	mutex_lock(&ap->scsi_scan_mutex);
>  
>  	/* Unplug detached devices.  We cannot use link iterator here
> @@ -4816,7 +4802,7 @@ void ata_scsi_hotplug(struct work_struct *work)
>  	ata_scsi_scan_host(ap, 0);
>  
>  	mutex_unlock(&ap->scsi_scan_mutex);
> -	DPRINTK("EXIT\n");
> +	ata_port_dbg(ap, "EXIT\n");
>  }
>  
>  /**
> 
