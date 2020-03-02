Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70EFC3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61AB22B48
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fkUgvgPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgCBRuc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:50:32 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58032 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCBRuc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 12:50:32 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302175030euoutp0116ea6d8a8e4508b9b4b543ee62210a8c~4jgc3oQzF1289412894euoutp01M
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 17:50:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302175030euoutp0116ea6d8a8e4508b9b4b543ee62210a8c~4jgc3oQzF1289412894euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583171430;
        bh=2QdHPb5u7h+fmQIg+XypGk05X9zO8EvEP+s10Kbjd0g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fkUgvgPh/KPWSf7oiwQPztk/Ib27ngYecYrtx6u+iZg5WoBH/mpQWOw95wlMkyN9w
         he6lwU2KQSCsxo1KvKJBP5tOKAwq1f0VaA4dXU8tQYn5c+XWEH0njSX4t1ad5kN6Ga
         bRRzPwGOzNXvo3qGLvWqTObs8kkb1I0VkAVgjIdE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302175030eucas1p2e55638fa8ef90ea39c012724dffba216~4jgcY1JbC2638426384eucas1p2Z;
        Mon,  2 Mar 2020 17:50:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 16.D9.61286.6674D5E5; Mon,  2
        Mar 2020 17:50:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302175029eucas1p20ae9b854acf0d95d1dff389fa189adae~4jgbbzjB_3104831048eucas1p2B;
        Mon,  2 Mar 2020 17:50:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302175029eusmtrp2442ea7393c4239dc38d3d2f786dadd76~4jgbbQFSp1569915699eusmtrp2E;
        Mon,  2 Mar 2020 17:50:29 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-7f-5e5d4766b34f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 30.1B.07950.4674D5E5; Mon,  2
        Mar 2020 17:50:29 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302175027eusmtip1cff0a596073e4f46e828b6da11ffc5a6~4jgaBEJel0305703057eusmtip12;
        Mon,  2 Mar 2020 17:50:27 +0000 (GMT)
Subject: Re: [PATCH 21/42] sata_dwc_460ex: Use generic tracepoints and drop
 dev_dbg() statements
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7f023c44-d59b-9d7b-b866-ff46e3e2ad41@samsung.com>
Date:   Mon, 2 Mar 2020 18:50:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-22-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7pp7rFxBn/OMFusvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlissmJTUnsyy1SN8ugSvj545bbAXX
        5So6Dq5mbWD8LdHFyMkhIWAiseLXR8YuRi4OIYEVjBKH5i5ggXC+MEocnniaDcL5zCgxb/49
        VpiWD71/oKqWM0r8aXnCDuG8ZZT40PKJHaRKWCBJouvtNbAOEQEliY/th8DizAIREhs3rGUC
        sdkErCQmtq9iBLF5BewkTrTdBKtnEVCReHvlDpgtClT/6cFhVogaQYmTM58Abebg4BQwlliy
        1g5ipLjErSfzmSBseYntb+cwg9wjIdDPLnF8STsjxNUuEgueP4D6QFji1fEt7BC2jMT/nSDN
        IA3rGCX+dryA6t7OKLF88j82iCpriTvnfrGBbGYW0JRYv0sfIuwosX7iGVaQsIQAn8SNt4IQ
        R/BJTNo2nRkizCvR0SYEUa0msWHZBjaYtV07VzJPYFSaheSzWUjemYXknVkIexcwsqxiFE8t
        Lc5NTy02zEst1ytOzC0uzUvXS87P3cQITCyn/x3/tIPx66WkQ4wCHIxKPLwBzLFxQqyJZcWV
        uYcYJTiYlUR4fTmj44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgST
        ZeLglGpgnLJBSU66RcO9p/4LL4/RtoTS48UH070FSp6qvuKdfzX7XrKItuDcmwdNujqX+6va
        60414EyPqZuw/xZ//ZaYFSYCl2V3SGbPFOHeFBnTtu6tuo1nYtYKllU/ws59ej+/d5bMcwGO
        j58TumR99v25tOm67NbNzfvXvrzFIG31tqtPtNo18OAfJZbijERDLeai4kQAN4KWnCgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qp7rFxBiseMFqsvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j545bbAXX5So6Dq5mbWD8LdHFyMkhIWAi
        8aH3D0sXIxeHkMBSRomZFy8xdzFyACVkJI6vL4OoEZb4c62LDaLmNaNEy7suJpCEsECSRNfb
        a6wgtoiAksTH9kPsIDazQIRE96szUA3rGCVWLprAApJgE7CSmNi+ihHE5hWwkzjRdhOsmUVA
        ReLtlTtgtihQ8+Eds6BqBCVOznzCAnIQp4CxxJK1dhDz1SX+zAO5E8QWl7j1ZD4ThC0vsf3t
        HOYJjEKzkHTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG0bZjP7fs
        YOx6F3yIUYCDUYmH9wdDbJwQa2JZcWXuIUYJDmYlEV5fzug4Id6UxMqq1KL8+KLSnNTiQ4ym
        QL9NZJYSTc4HxnheSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG
        /Rrdr9VlM2ucboQ7fW4/eyPb6ERj6c+lvyOObji0+5/E/jlzGhJ3T2ZlUyxYtSIly+EDm27V
        eekHLWenMx4puBVnWtfJ+jX5lX75jvxlz7aYSR8Xi0mrTU5T0V0WFjz9e+KFR0ozsvP1XebX
        L/hSNmuNx3reNw/rOrpyXdZ4/Q1ZGbaAu32SEktxRqKhFnNRcSIAd0LgDLkCAAA=
X-CMS-MailID: 20200302175029eucas1p20ae9b854acf0d95d1dff389fa189adae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095437eucas1p186f1ffec6693f950ecd15ffdf92af41a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095437eucas1p186f1ffec6693f950ecd15ffdf92af41a
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095437eucas1p186f1ffec6693f950ecd15ffdf92af41a@eucas1p1.samsung.com>
        <20200213095412.23773-22-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Add generic tracepoints and drop the now obsolete logging statements.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Please update patch summary line for consistency with other patches
to be just "sata_dwc_460ex: use generic tracepoints" (moreover this
patch removes also dev_vdbg() statements).

With the patch summary line fixed:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/sata_dwc_460ex.c | 39 ++++-----------------------------------
>  1 file changed, 4 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index ef07d4a03627..a29cd81b7811 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -34,6 +34,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/libata.h>
>  #include <linux/slab.h>
> +#include <trace/events/libata.h>
>  
>  #include "libata.h"
>  
> @@ -311,21 +312,6 @@ static const char *get_dma_dir_descript(int dma_dir)
>  	}
>  }
>  
> -static void sata_dwc_tf_dump(struct ata_port *ap, struct ata_taskfile *tf)
> -{
> -	dev_vdbg(ap->dev,
> -		"taskfile cmd: 0x%02x protocol: %s flags: 0x%lx device: %x\n",
> -		tf->command, get_prot_descript(tf->protocol), tf->flags,
> -		tf->device);
> -	dev_vdbg(ap->dev,
> -		"feature: 0x%02x nsect: 0x%x lbal: 0x%x lbam: 0x%x lbah: 0x%x\n",
> -		tf->feature, tf->nsect, tf->lbal, tf->lbam, tf->lbah);
> -	dev_vdbg(ap->dev,
> -		"hob_feature: 0x%02x hob_nsect: 0x%x hob_lbal: 0x%x hob_lbam: 0x%x hob_lbah: 0x%x\n",
> -		tf->hob_feature, tf->hob_nsect, tf->hob_lbal, tf->hob_lbam,
> -		tf->hob_lbah);
> -}
> -
>  static void dma_dwc_xfer_done(void *hsdev_instance)
>  {
>  	unsigned long flags;
> @@ -548,6 +534,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
>  		 * active tag.  It is the tag that matches the command about to
>  		 * be completed.
>  		 */
> +		trace_ata_bmdma_start(ap, &qc->tf, tag);
>  		qc->ap->link.active_tag = tag;
>  		sata_dwc_bmdma_start_by_tag(qc, tag);
>  
> @@ -1021,12 +1008,6 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
>  		start_dma = 0;
>  	}
>  
> -	dev_dbg(ap->dev,
> -		"%s qc=%p tag: %x cmd: 0x%02x dma_dir: %s start_dma? %x\n",
> -		__func__, qc, tag, qc->tf.command,
> -		get_dma_dir_descript(qc->dma_dir), start_dma);
> -	sata_dwc_tf_dump(ap, &qc->tf);
> -
>  	if (start_dma) {
>  		sata_dwc_scr_read(&ap->link, SCR_ERROR, &reg);
>  		if (reg & SATA_DWC_SERROR_ERR_BITS) {
> @@ -1064,16 +1045,6 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
>  	struct ata_port *ap = qc->ap;
>  	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
>  
> -#ifdef DEBUG_NCQ
> -	if (qc->hw_tag > 0 || ap->link.sactive > 1)
> -		dev_info(ap->dev,
> -			 "%s ap id=%d cmd(0x%02x)=%s qc tag=%d prot=%s ap active_tag=0x%08x ap sactive=0x%08x\n",
> -			 __func__, ap->print_id, qc->tf.command,
> -			 ata_get_cmd_descript(qc->tf.command),
> -			 qc->hw_tag, get_prot_descript(qc->tf.protocol),
> -			 ap->link.active_tag, ap->link.sactive);
> -#endif
> -
>  	if (!ata_is_ncq(qc->tf.protocol))
>  		tag = 0;
>  
> @@ -1090,11 +1061,9 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
>  		sactive |= (0x00000001 << tag);
>  		sata_dwc_scr_write(&ap->link, SCR_ACTIVE, sactive);
>  
> -		dev_dbg(qc->ap->dev,
> -			"%s: tag=%d ap->link.sactive = 0x%08x sactive=0x%08x\n",
> -			__func__, tag, qc->ap->link.sactive, sactive);
> -
> +		trace_ata_tf_load(ap, &qc->tf);
>  		ap->ops->sff_tf_load(ap, &qc->tf);
> +		trace_ata_exec_command(qp, &qc->tf, tag);
>  		sata_dwc_exec_command_by_tag(ap, &qc->tf, tag,
>  					     SATA_DWC_CMD_ISSUED_PEND);
>  	} else {
> 
