Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C4DC3F2D1
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242ED222C4
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ohr9tTvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCBRiw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:38:52 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47385 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgCBRiw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 12:38:52 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302173849euoutp028f5b4e5b8b6af2698887a86350a3d51a~4jWQQmCnw1703417034euoutp02e
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 17:38:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302173849euoutp028f5b4e5b8b6af2698887a86350a3d51a~4jWQQmCnw1703417034euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583170729;
        bh=oqtQLiOwR+a3J7sW3oA5STIR1Q3PnC24sa0bAhhZYpw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ohr9tTvOdEmZRWbCHXcAY+LpX4IRxJWdfZULeirU9RoGI36f3V62DxpUu08EPcfiA
         pLJCOAP1rEbjVEGpnEmdgNpKCxcaKuy6qxLvsV7r2Mb9hlAr99WkYxHDFLNSX85PfE
         C0jNEhM8IjSs1UfhWdvPgfkb01GXmZi2YzGiy+MQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302173849eucas1p157628ed535ba9e030f891ef4133abfba~4jWQI6A7w0333403334eucas1p1h;
        Mon,  2 Mar 2020 17:38:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 60.FB.60679.9A44D5E5; Mon,  2
        Mar 2020 17:38:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302173849eucas1p20c9f107a5906b21b61a55b032b30d821~4jWP4mz4v0594505945eucas1p2P;
        Mon,  2 Mar 2020 17:38:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302173849eusmtrp22dc0f97ff2b02b60601b515d1ff4357a~4jWP4DoLz0794807948eusmtrp2s;
        Mon,  2 Mar 2020 17:38:49 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-c1-5e5d44a95bac
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.7A.07950.9A44D5E5; Mon,  2
        Mar 2020 17:38:49 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302173849eusmtip268b5c6c4d18a919f43ffb63faae5e401~4jWPpvib42113821138eusmtip2Q;
        Mon,  2 Mar 2020 17:38:48 +0000 (GMT)
Subject: Re: [PATCH 19/42] pata_octeon_cf: add bmdma tracepoints and drop
 DPRINTK() calls
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c6485215-1c4d-9807-e8dc-c6476acb4b2b@samsung.com>
Date:   Mon, 2 Mar 2020 18:38:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-20-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7orXWLjDPYf1rVYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfG2UmXGQt+
        8VbM2PSGtYFxA3cXIyeHhICJxP0Z35i7GLk4hARWMErs6u5mhHC+MEq0dr5gg3A+M0o8u7OS
        Dabl4ayvUC3LGSXaG76wQzhvGSXm3DvNBFIlLBAtsb/jBAuILSKgJPGx/RA7iM0sECGxccNa
        sBo2ASuJie2rGEFsXgE7ib5j11lBbBYBFYnDZxrA4qJA9Z8eHGaFqBGUODnzCdhMTgFjiYfX
        djJBzBSXuPVkPpQtL7H97RxmiEu72SUuzheBsF0kZky/CvWBsMSr41vYIWwZif87QXq5gOx1
        jBJ/O14wQzjbGSWWT/4H1WEtcefcLyCbA2iDpsT6XfogpoSAo8T3LXIQJp/EjbeCECfwSUza
        Np0ZIswr0dEmBDFDTWLDsg1sMFu7dq5knsCoNAvJY7OQPDMLyTOzENYuYGRZxSieWlqcm55a
        bJSXWq5XnJhbXJqXrpecn7uJEZhWTv87/mUH464/SYcYBTgYlXh4A5hj44RYE8uKK3MPMUpw
        MCuJ8PpyRscJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSkF
        TDVmkW3eu4O3sHcyZB9dqVRyPY9f5b/6iTvH1Xq3Pdi1O7m878AEs5X7OI/IVUjk9hR3qUx9
        1FD3oDUsay7TgrNrTp1w/6aUsi1gyuU1EW38h7zrhSxaPjDs2LB9RoR8spbSk5rJ1cuKWkNL
        +UQPXg85sX1CQP3MHUxHRF/NTJgxeYfIHAmVKCWW4oxEQy3mouJEAGk6YCwnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7orXWLjDDZMlbNYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G2UmXGQt+8VbM2PSGtYFxA3cXIyeHhICJ
        xMNZX5m7GLk4hASWMkqcPLaeqYuRAyghI3F8fRlEjbDEn2tdbBA1rxklJp25yA6SEBaIltjf
        cYIFxBYRUJL42H4ILM4sECHR/eoMVMM6Rol1PxeDFbEJWElMbF/FCGLzCthJ9B27zgpiswio
        SBw+0wAWFwVqPrxjFlSNoMTJmU/AejkFjCUeXtvJBLFAXeLPvEvMELa4xK0n86Hi8hLb385h
        nsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYCRtO/Zzyw7G
        rnfBhxgFOBiVeHh/MMTGCbEmlhVX5h5ilOBgVhLh9eWMjhPiTUmsrEotyo8vKs1JLT7EaAr0
        3ERmKdHkfGCU55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYBRJ
        XtHc2M4vLfif+cDaHUe2PXyoWG7cF8zokdVV9e49p8gPhw1TCjTmveKzW73dOm1n9WyrBbn3
        j3fs2TqzvDTfM6kvMm+6seBF5txF7x7wM/lP/xH7yrtjqlhf78pum+B57ZNPK/mkFrZrHj0n
        4HOv5ruDSYWnu4Wdj+Qy/tMK7ycb+nD+U2Ipzkg01GIuKk4EAPGLlhC6AgAA
X-CMS-MailID: 20200302173849eucas1p20c9f107a5906b21b61a55b032b30d821
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095439eucas1p13ff7a11e24fa7ad5ad8f5188cd25d970
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095439eucas1p13ff7a11e24fa7ad5ad8f5188cd25d970
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095439eucas1p13ff7a11e24fa7ad5ad8f5188cd25d970@eucas1p1.samsung.com>
        <20200213095412.23773-20-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Add missing bmdma tracepoints and drop the now pointless
> DPRINTK() calls.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pata_octeon_cf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 9b66552efbd2..62646dbc9d71 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -19,7 +19,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <scsi/scsi_host.h>
> -
> +#include <trace/events/libata.h>
>  #include <asm/byteorder.h>
>  #include <asm/octeon/octeon.h>
>  
> @@ -535,12 +535,10 @@ static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
>  	struct octeon_cf_port *cf_port;
>  
>  	cf_port = ap->private_data;
> -	DPRINTK("ENTER\n");
>  	/* issue r/w command */
>  	qc->cursg = qc->sg;
>  	cf_port->dma_finished = 0;
>  	ap->ops->sff_exec_command(ap, &qc->tf);
> -	DPRINTK("EXIT\n");
>  }
>  
>  /**
> @@ -792,8 +790,11 @@ static unsigned int octeon_cf_qc_issue(struct ata_queued_cmd *qc)
>  	case ATA_PROT_DMA:
>  		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
>  
> +		trace_ata_tf_load(ap, &qc->tf);
>  		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
> +		trace_ata_bmdma_setup(ap, &qc->tf, qc->tag);
>  		octeon_cf_dma_setup(qc);	    /* set up dma */
> +		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
>  		octeon_cf_dma_start(qc);	    /* initiate dma */
>  		ap->hsm_task_state = HSM_ST_LAST;
>  		break;
> 
