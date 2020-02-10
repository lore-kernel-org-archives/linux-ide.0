Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C90C352A5
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D5220715
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aKt6qIMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBJPgI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:36:08 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59703 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgBJPgI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:36:08 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210153606euoutp01249ba8455d361acff5e1a8a1ba6c016a~yFIGzzIjv0380003800euoutp01V
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:36:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210153606euoutp01249ba8455d361acff5e1a8a1ba6c016a~yFIGzzIjv0380003800euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581348966;
        bh=M+cjIVHfW5EoZZfSPPGw/3e9SoGJrXtfU9XOYd2irOE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aKt6qIMwxRkJ7KzpYdK9Xoqt4lKMUjnkLrAvvajqmKi3hgfch2Yk0lDdOtEkzjCbt
         w4AArw0Y5xroZHZh69i3bEzdH+X6urDlUATVYS8pZXzI+K5ZMUHEVCWKQHxTmErzHJ
         KuTQQlc4AZeAJHi1shMIMDMxn3vdFQYz/fMU0A8s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210153606eucas1p1aab530ef43723214f4c3ad9fb51a7244~yFIGaKY_u1391013910eucas1p1w;
        Mon, 10 Feb 2020 15:36:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C6.63.60698.568714E5; Mon, 10
        Feb 2020 15:36:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210153605eucas1p2a202ac94c89129c338aec392298942d6~yFIGHYuaT0711607116eucas1p2N;
        Mon, 10 Feb 2020 15:36:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210153605eusmtrp24009c84b17c85cfb8dc06ab72633dc1e~yFIGG2XFj2530125301eusmtrp27;
        Mon, 10 Feb 2020 15:36:05 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-7e-5e4178659134
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.B0.08375.568714E5; Mon, 10
        Feb 2020 15:36:05 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210153605eusmtip1612140d9cab698f790809fc938d00139~yFIF4Af293061630616eusmtip1V;
        Mon, 10 Feb 2020 15:36:05 +0000 (GMT)
Subject: Re: [PATCH 26/46] pata_octeon_cf: add bmdma tracepoints and drop
 DPRINTK()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <80c7545b-e222-60fb-dbb5-cea58e5d8dc0@samsung.com>
Date:   Mon, 10 Feb 2020 16:36:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-27-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOd3UCsc4gznPbCxW3+1ns9izaBKT
        xbEdj5gcmD0uny312Hy62uPzJrkA5igum5TUnMyy1CJ9uwSujOZvoQVXBCu279/F0sDYy9fF
        yMkhIWAisWbHReYuRi4OIYEVjBIdnbcZIZwvjBKbj76Ecj4zSjx9cJWpi5EDrOXHyUKI+HJG
        iU8rv0IVvWWUOPjsMDPIXGGBUInHZ2axgdgiAkoSH9sPsYPYzALWErMXr2cCsdkErCQmtq9i
        BLF5Bewkrm1qBbNZBFQlTlyYDdYrKhAh8enBYVaIGkGJkzOfsIDYnEBHzF7zkQliprjErSfz
        oWx5ie1v54D9IyHwn01iettWFohHXSR2rJjBDmELS7w6vgXKlpH4vxOkGaRhHaPE344XUN3b
        GSWWT/7HBlFlLXHn3C82kP+ZBTQl1u/Shwg7SjQduckGCRY+iRtvBSGO4JOYtG06M0SYV6Kj
        TQiiWk1iw7INbDBru3auZJ7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpanJueWmycl1quV5yY
        W1yal66XnJ+7iRGYQk7/O/51B+O+P0mHGAU4GJV4eC8EO8YJsSaWFVfmHmKU4GBWEuG1lAYK
        8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwDg3/D1Hcei5
        vKkZu6ocbmR+0p6nbTbxQM8BqUUPZau0O/ce43h59d+DnPXMVbKyXT1ce4SKFb/WVTJvbnn3
        7HffpTOStjFtXcWLlwauvB3EvYlPLveg9REGf2GH1a/kZnJej9ugYyJ1YM7czw9u7Wr+N3ce
        X2TU65NLAg/FNC/8YjtzU9D3xlAlluKMREMt5qLiRAB5n0MIHQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7qpFY5xBvfbNC1W3+1ns9izaBKT
        xbEdj5gcmD0uny312Hy62uPzJrkA5ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NY
        KyNTJX07m5TUnMyy1CJ9uwS9jOZvoQVXBCu279/F0sDYy9fFyMEhIWAi8eNkYRcjF4eQwFJG
        iTeL/jBBxGUkjq8v62LkBDKFJf5c62KDqHnNKLHx1EZWkISwQKjE4zOz2EBsEQEliY/th9hB
        bGYBa4nZi9czgdhCAhsYJTrOK4DYbAJWEhPbVzGC2LwCdhLXNrWC2SwCqhInLswGmyMqECFx
        eMcsqBpBiZMzn7CA2JxAd85e85EJYr66xJ95l5ghbHGJW0/mQ8XlJba/ncM8gVFoFpL2WUha
        ZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAeNl27OfmHYyXNgYfYhTgYFTi
        4a0IdIwTYk0sK67MPcQowcGsJMJrKQ0U4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgLOeV
        xBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamCsVLf/sN/v+LfHNYtq
        di8qYvu44hKbXK03H3cC936fB5MFGoIY4kLYJgccvJ51MPT973knE5hvJIUoHFnlN9fu3svf
        p6JZvP/uWLPkq8STxM2TKkwVijf773Czr4p8dnhDxqPtF6ZWtU3dJTB9v3dD7JbTLodZubtE
        Nu7p7tWLEj3HXWv/jf2GEktxRqKhFnNRcSIAcNuVR60CAAA=
X-CMS-MailID: 20200210153605eucas1p2a202ac94c89129c338aec392298942d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p21ede0031dae9dc53c18887c40e07ce9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p21ede0031dae9dc53c18887c40e07ce9b
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p21ede0031dae9dc53c18887c40e07ce9b@eucas1p2.samsung.com>
        <20200204165547.115220-27-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Add missing bmdma tracepoints and drop the now pointless
> DPRINTK() calls.

Actually it should be: DPRINTK()/VPRINTK().

Please also consider merging this patch with patch #25.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/pata_octeon_cf.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index f5cd89173028..9527216e59b9 100644
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
> @@ -517,17 +517,14 @@ static void octeon_cf_exec_command16(struct ata_port *ap,
>  	u16 blob;
>  
>  	if (tf->flags & ATA_TFLAG_DEVICE) {
> -		VPRINTK("device 0x%X\n", tf->device);
>  		blob = tf->device;
>  	} else {
>  		blob = 0;
>  	}
>  
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
>  	blob |= (tf->command << 8);
>  	__raw_writew(blob, base + 6);
>  
> -
>  	ata_wait_idle(ap);
>  }
>  
> @@ -541,12 +538,10 @@ static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
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
> @@ -798,8 +793,11 @@ static unsigned int octeon_cf_qc_issue(struct ata_queued_cmd *qc)
>  	case ATA_PROT_DMA:
>  		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
>  
> +		trace_ata_tf_load(ap, &qc->tf, qc->tag);
>  		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
> +		trace_ata_bmdma_setup(qp, &qc->tf, qc->tag);
>  		octeon_cf_dma_setup(qc);	    /* set up dma */
> +		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
>  		octeon_cf_dma_start(qc);	    /* initiate dma */
>  		ap->hsm_task_state = HSM_ST_LAST;
>  		break;
> 
