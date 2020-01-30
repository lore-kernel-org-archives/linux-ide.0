Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F6AC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFCD2082E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YuMiNfUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgA3Ksy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:48:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50568 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Ksy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:48:54 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130104853euoutp01991b73a5adff069fa2a97f820262d2cc~upHMJjLpb3038730387euoutp01s
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:48:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130104853euoutp01991b73a5adff069fa2a97f820262d2cc~upHMJjLpb3038730387euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381333;
        bh=O6NxsY+ynijgWFfDlXB4VxxygOr0FxT5jeaG8qdotmc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YuMiNfUxeHdlydkhM9RfKjD2ahxsNMfPtpFGI/D1zjtLQ2ZG1LWAowDAyeaYcjqp9
         aXj8JSG0q3ADw5QIHtevGeSWTPBoJswFuf/bPoIw10KhJR3Bvtk+V0I7VhplZNmvJA
         zfgzmUpmN0tNwiRrAu892/9dDr2qyJME1nQ0WRzo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130104853eucas1p20f456e35250d45f5daba6e335625d14f~upHL8IrWW0879208792eucas1p2a;
        Thu, 30 Jan 2020 10:48:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 86.D8.61286.494B23E5; Thu, 30
        Jan 2020 10:48:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130104852eucas1p21e62ee38a80ac08b76d1423d2e8634ff~upHLobli21537115371eucas1p2l;
        Thu, 30 Jan 2020 10:48:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130104852eusmtrp1095f24095a2f82a726b69f699db4d609~upHLn21r01108511085eusmtrp1a;
        Thu, 30 Jan 2020 10:48:52 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-a3-5e32b494e500
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.DD.07950.494B23E5; Thu, 30
        Jan 2020 10:48:52 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130104852eusmtip1d43bb90822b368ccea14705d135c146c~upHLQeMHS1201412014eusmtip1V;
        Thu, 30 Jan 2020 10:48:52 +0000 (GMT)
Subject: Re: [PATCH 06/24] sata_qstor: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a95cf16a-5651-a3b2-d3ab-b529a4902e31@samsung.com>
Date:   Thu, 30 Jan 2020 11:48:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-18-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87pTthjFGexYaWmx+m4/m8WCN3vZ
        LPYsmsRkcWzHIyYHFo/LZ0s91m+5yuKx+XS1x+dNcgEsUVw2Kak5mWWpRfp2CVwZvzf/YizY
        zlHxrHkjWwPjE7YuRk4OCQETib+zfgPZXBxCAisYJY4tf8MO4XxhlNgx4y4jhPOZUaL320ZG
        mJau7e1MEInljBIPLv9ihnDeMkos+f6BBaRKWMBFYtGLNrAOEQEHiae3GsDizAJ2EhevtrKD
        2GwCVhIT21eB1fACxQ+2PgQ6hIODRUBVYu9fXpCwqECExKcHh1khSgQlTs58AjaGU8BY4nLf
        TFaIkeISt57MZ4Kw5SW2v50Ddo+EQD+7xPemHVBXu0i07NrHDGELS7w6voUdwpaROD25hwWi
        YR2jxN+OF1Dd2xkllk/+Bw0ma4k7536BXccsoCmxfpc+RNhRYs233UwgYQkBPokbbwUhjuCT
        mLRtOjNEmFeio00IolpNYsOyDWwwa7t2rmSewKg0C8lrs5C8MwvJO7MQ9i5gZFnFKJ5aWpyb
        nlpsmJdarlecmFtcmpeul5yfu4kRmFhO/zv+aQfj10tJhxgFOBiVeHg1NhjFCbEmlhVX5h5i
        lOBgVhLhFXU1jBPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomD
        U6qBUX/+OrHo3Nupa/cLtaZpXZLrlxCQrFzmoDZ7r14Kp2tVYeOVgwzB2YpJLlfX82/Ycn3V
        7IWHlklaLCwz/reSxeJ9mYKFuvXH9abbd22tn8ESt+bTz3a5dcXHgt+by391r2BYXPW+1f0B
        9+JTv8TqKxl/2l7p6oq5wLWJhWP+LCcFH8P65xMDlFiKMxINtZiLihMBrDhGGigDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7pTthjFGUzarmax+m4/m8WCN3vZ
        LPYsmsRkcWzHIyYHFo/LZ0s91m+5yuKx+XS1x+dNcgEsUXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZvzf/YizYzlHxrHkjWwPjE7YuRk4OCQET
        ia7t7UxdjFwcQgJLGSXu7lzK2MXIAZSQkTi+vgyiRljiz7UuNoia14wSZ090s4AkhAVcJBa9
        aGMEsUUEHCSe3moAizML2ElcvNrKDmILCaxjlDi2zxPEZhOwkpjYvgqsnheo5mDrQzaQXSwC
        qhJ7//KChEUFIiQO75gFVSIocXLmE7CRnALGEpf7ZrJCjFeX+DPvEjOELS5x68l8JghbXmL7
        2znMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjKJtx35u
        2cHY9S74EKMAB6MSD6/GBqM4IdbEsuLK3EOMEhzMSiK8oq6GcUK8KYmVValF+fFFpTmpxYcY
        TYF+m8gsJZqcD4zwvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFIN
        jI6MAbnRzj/OP/8ZkXNyipqh0kp10S9H1u7JTHbeESWrXNU8rX7xjYAnfIuZ2exs5Ca5bp9X
        kT3nxO87ghG/5ZxO6TGdaL34UeqnfnLyj/av+R2dbbV/K987n/0vt+JDU6HbtzqtHLe9L3i9
        n71M8gj+G75XvqVwx95cbpbaC4LXlTTK7x9gV2Ipzkg01GIuKk4EANnjZvK4AgAA
X-CMS-MailID: 20200130104852eucas1p21e62ee38a80ac08b76d1423d2e8634ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104832epcas5p268d10f69ecfa32949f56cae0fed83f90
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104832epcas5p268d10f69ecfa32949f56cae0fed83f90
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104832epcas5p268d10f69ecfa32949f56cae0fed83f90@epcas5p2.samsung.com>
        <20181213104716.31930-18-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:46 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/sata_qstor.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
> index 1fe941688e95..f38f15fe1f79 100644
> --- a/drivers/ata/sata_qstor.c
> +++ b/drivers/ata/sata_qstor.c
> @@ -388,8 +388,9 @@ static inline unsigned int qs_intr_pkt(struct ata_host *host)
>  			struct qs_port_priv *pp = ap->private_data;
>  			struct ata_queued_cmd *qc;
>  
> -			DPRINTK("SFF=%08x%08x: sCHAN=%u sHST=%d sDST=%02x\n",
> -					sff1, sff0, port_no, sHST, sDST);
> +			ata_port_dbg(ap,
> +				"SFF=%08x%08x: sCHAN=%u sHST=%d sDST=%02x\n",
> +				sff1, sff0, port_no, sHST, sDST);

Please preserve __func__ printing in the conversion.

>  			handled = 1;
>  			if (!pp || pp->state != qs_state_pkt)
>  				continue;
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
