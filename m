Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F0BC3F2D1
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C26B21775
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rSJY0Epw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCBRGz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:06:55 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49728 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBRGz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 12:06:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302170653euoutp0193b571ac4c37e4d91a70ce1a146bcb00~4i6XnuLrB1656416564euoutp01P
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 17:06:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302170653euoutp0193b571ac4c37e4d91a70ce1a146bcb00~4i6XnuLrB1656416564euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583168813;
        bh=9rSi6DcLyIZStA7MZzAaliquks3u6LXu9pl+YF9kaMo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rSJY0EpwoHQ2tOx5yiFTjKNKz62mUfJKMI6hRIOGE8tfqhdy+IS8rQ65l3p/l9R+C
         CXIjaze4CVr8TtEXDOeDU88sbHADk9PryfKyYp3OOysuQwHSxQxTYMWp1+vVMRCuxG
         ZrZO9kIx2OGKDo+ALlxxVhGqr3UnDOFd/VSpAUEE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302170653eucas1p1e382a3d5bd33aa5e1db9eafb0ee8c282~4i6XgchYI2919929199eucas1p1r;
        Mon,  2 Mar 2020 17:06:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.F6.61286.D2D3D5E5; Mon,  2
        Mar 2020 17:06:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302170653eucas1p10a162ed3a2b449465cb984c7807bf25b~4i6XMnVZl3275132751eucas1p1n;
        Mon,  2 Mar 2020 17:06:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302170653eusmtrp11c77797b63a493cfc320316a0ede7d44~4i6XMAE1r2044020440eusmtrp1m;
        Mon,  2 Mar 2020 17:06:53 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-f3-5e5d3d2d7071
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E4.B8.08375.D2D3D5E5; Mon,  2
        Mar 2020 17:06:53 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302170652eusmtip2ddb35848a01d9502489d9d5738f3bea4~4i6W7qYXk0149601496eusmtip2L;
        Mon,  2 Mar 2020 17:06:52 +0000 (GMT)
Subject: Re: [PATCH 35/42] sata_nv: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c46bb910-20bd-0405-bd9f-830ecd74f0f2@samsung.com>
Date:   Mon, 2 Mar 2020 18:06:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-36-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87q6trFxBnunyVusvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlissmJTUnsyy1SN8ugSvj9bYetoIL
        whWr75Y0MN7i72Lk5JAQMJF42XePvYuRi0NIYAWjxP4jU1ghnC+MEi8//maGcD4zSrxY38UE
        03Jr6wxGiMRyRolFO34ygySEBN4ySnzdxANiCws4SpzatYkRxBYRUJL42H6IHcRmFoiQ2Lhh
        LdggNgEriYntq4BqODh4Bewk1q2JAQmzCKhI3L/fCtYqClT+6cFhVhCbV0BQ4uTMJywgNqeA
        scTEf6uYIEaKS9x6Mh/KlpfY/nYO2NESAv3sEjvmPWSFONpFYue85cwQtrDEq+Nb2CFsGYnT
        k3tYIBrWMUr87XgB1b2dUWL55H9sEFXWEnfO/WIDuZRZQFNi/S59iLCjxP6Z/9hBwhICfBI3
        3gpCHMEnMWnbdGaIMK9ER5sQRLWaxIZlG9hg1nbtXMk8gVFpFpLXZiF5ZxaSd2Yh7F3AyLKK
        UTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMKmc/nf80w7Gr5eSDjEKcDAq8fAGMMfGCbEm
        lhVX5h5ilOBgVhLh9eWMjhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampB
        ahFMlomDU6qBccnSqq9eKl1M6ikhk9dMP3ZF0O6uzf3j+gbir+YsEperFig5+HnLriXnZoX8
        EN+W4S+ocPmamPtp89KLzbJTJX5arZCMY5346l8B45aDArwVs1gmX2qr5Vq6KXnfrGK/yfIH
        HrxNCDrG9Lvggr23i6vBPQ+DrLsXPcIrhEo3MygfffWO48qXs0osxRmJhlrMRcWJABOEQxAm
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7q6trFxBg9Wc1msvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j9bYetoILwhWr75Y0MN7i72Lk5JAQMJG4
        tXUGI4gtJLCUUWL50+IuRg6guIzE8fVlECXCEn+udbF1MXIBlbxmlOj9vosZJCEs4Chxatcm
        sF4RASWJj+2H2EFsZoEIie5XZ6Aa1jFKLJjziBUkwSZgJTGxfRUjyAJeATuJdWtiQMIsAioS
        9++3gs0RBeo9vGMWmM0rIChxcuYTFhCbU8BYYuK/VUwQ89Ul/sy7xAxhi0vcejIfKi4vsf3t
        HOYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG0LZjPzfv
        YLy0MfgQowAHoxIPbwBzbJwQa2JZcWXuIUYJDmYlEV5fzug4Id6UxMqq1KL8+KLSnNTiQ4ym
        QM9NZJYSTc4HxndeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG
        CYt7mqNvfkgof9fxRNOPafIfU4ab374nOaic/bAtoUzwfVye+K2pnSE8vS93BP/rCpyxNMc+
        IHsLG/uNpMnlDMp7c3LsGIx797+8PL8zUdDrwvHbhX4ed54qnqm4/3V27ET23IcN0xsefZ1U
        8PmZ8Olvn3QP/LLQ/GX+X1lPcBObpcg791UblViKMxINtZiLihMBdix4UrcCAAA=
X-CMS-MailID: 20200302170653eucas1p10a162ed3a2b449465cb984c7807bf25b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095439eucas1p25ca4b1f73de237ab2ae0ce63977b061f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095439eucas1p25ca4b1f73de237ab2ae0ce63977b061f
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095439eucas1p25ca4b1f73de237ab2ae0ce63977b061f@eucas1p2.samsung.com>
        <20200213095412.23773-36-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:54 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/sata_nv.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index f7dd32679c8e..0bdf18625d95 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -2094,7 +2094,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
>  	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
>  
>  	if (!ap->qc_active) {
> -		DPRINTK("over\n");
> +		ata_port_dbg(ap, "over\n");
>  		nv_swncq_pp_reinit(ap);
>  		return 0;
>  	}
> @@ -2109,10 +2109,10 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
>  		 */
>  		lack_dhfis = 1;
>  
> -	DPRINTK("id 0x%x QC: qc_active 0x%x,"
> +	ata_port_dbg(ap, "QC: qc_active 0x%llx,"
>  		"SWNCQ:qc_active 0x%X defer_bits %X "
>  		"dhfis 0x%X dmafis 0x%X last_issue_tag %x\n",
> -		ap->print_id, ap->qc_active, pp->qc_active,
> +		ap->qc_active, pp->qc_active,
>  		pp->defer_queue.defer_bits, pp->dhfis_bits,
>  		pp->dmafis_bits, pp->last_issue_tag);
>  
> @@ -2154,7 +2154,7 @@ static void nv_swncq_dmafis(struct ata_port *ap)
>  	__ata_bmdma_stop(ap);
>  	tag = nv_swncq_tag(ap);
>  
> -	DPRINTK("dma setup tag 0x%x\n", tag);
> +	ata_port_dbg(ap, "dma setup tag 0x%x\n", tag);
>  	qc = ata_qc_from_tag(ap, tag);
>  
>  	if (unlikely(!qc))
> @@ -2222,9 +2222,9 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
>  
>  	if (fis & NV_SWNCQ_IRQ_SDBFIS) {
>  		pp->ncq_flags |= ncq_saw_sdb;
> -		DPRINTK("id 0x%x SWNCQ: qc_active 0x%X "
> +		ata_port_dbg(ap, "SWNCQ: qc_active 0x%X "
>  			"dhfis 0x%X dmafis 0x%X sactive 0x%X\n",
> -			ap->print_id, pp->qc_active, pp->dhfis_bits,
> +			pp->qc_active, pp->dhfis_bits,
>  			pp->dmafis_bits, readl(pp->sactive_block));
>  		if (nv_swncq_sdbfis(ap) < 0)
>  			goto irq_error;
> @@ -2250,7 +2250,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
>  				goto irq_exit;
>  
>  			if (pp->defer_queue.defer_bits) {
> -				DPRINTK("send next command\n");
> +				ata_port_dbg(ap, "send next command\n");
>  				qc = nv_swncq_qc_from_dq(ap);
>  				nv_swncq_issue_atacmd(ap, qc);
>  			}
> 
