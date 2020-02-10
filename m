Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BECC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B320920733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D5ZhLqHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgBJNXN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:23:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40275 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgBJMhP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 07:37:15 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210123713euoutp011ca31832132bccdf0bbf1509dc195e65~yCr7KgArP1054510545euoutp01W
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 12:37:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210123713euoutp011ca31832132bccdf0bbf1509dc195e65~yCr7KgArP1054510545euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581338233;
        bh=00P7syuQlLD2pANk27O3Ky7pbXVFLv5a/dxWCo2+gYU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=D5ZhLqHLapxcaXZBDL5/NkngukB9zwHTDJwf3AwWtqIhvmuJIGxFeX0zLbcu5uBTz
         yXVZmhV8S+AxN97g9E8xIazh1Rdnt9Q/Rolzy6jXQ0iEpg00/Ljwg61sXw8hyIpQF7
         xSN1uyOS/Fx1wzRkOQZxzxevBLbFGsE2ikF6RN7I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210123713eucas1p116128d76eba614fb1143db07866b492e~yCr65TL-D0664606646eucas1p1y;
        Mon, 10 Feb 2020 12:37:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A6.D5.60698.97E414E5; Mon, 10
        Feb 2020 12:37:13 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210123713eucas1p2bc0bee18f79a2c1ae38ff9ab62277c4b~yCr6hO2Z51438014380eucas1p2U;
        Mon, 10 Feb 2020 12:37:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210123713eusmtrp243f66b8c1fb229e997018171d1143b94~yCr6gseRd2485724857eusmtrp2O;
        Mon, 10 Feb 2020 12:37:13 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-f4-5e414e790842
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.31.07950.87E414E5; Mon, 10
        Feb 2020 12:37:12 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210123712eusmtip1f1302d32e1e4b3501cbfdf6cd09b0473~yCr6JolG30032600326eusmtip1G;
        Mon, 10 Feb 2020 12:37:12 +0000 (GMT)
Subject: Re: [PATCH 07/46] libata-core: remove pointless debugging messages
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <01b3da5c-d596-b43d-d86c-0990f969354a@samsung.com>
Date:   Mon, 10 Feb 2020 13:37:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-8-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned1KP8c4gzdNYhar7/azWexZNInJ
        4tiOR0wOzB6Xz5Z6bD5d7fF5k1wAcxSXTUpqTmZZapG+XQJXxqyZO5gLJnBX3O2eydrA+JKj
        i5GTQ0LARGL31R+MXYxcHEICKxgl/j1fxArhfGGUuL39MhOE85lRYv7jz2wwLXMfzINqWc4o
        8fLcdDYI5y2jxKFt/ewgVcIC3hInrp5mBLFFBJQkPrYfAoszC1hLzF68ngnEZhOwkpjYvgqs
        hlfATmLvxjdAuzk4WARUJb79qwYJiwpESHx6cJgVokRQ4uTMJywgNqeAscT7K3OYIUaKS9x6
        Mp8JwpaX2P4WJM4FdOh/Nolz86dDXe0isfLaUnYIW1ji1fEtULaMxP+d85kgGtYxSvzteAHV
        vZ1RYvnkf1Dd1hJ3zv1iA7mOWUBTYv0ufYiwo8T/TpBBHEA2n8SNt4IQR/BJTNo2nRkizCvR
        0SYEUa0msWHZBjaYtV07VzJPYFSaheS1WUjemYXknVkIexcwsqxiFE8tLc5NTy02zkst1ytO
        zC0uzUvXS87P3cQITCKn/x3/uoNx35+kQ4wCHIxKPLwzHB3ihFgTy4orcw8xSnAwK4nwWko7
        xgnxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAKJvmWLJr
        3oPp80/yFkbaMFok7NdLXNLy3v7jq29z5RfGhG6Ripz81dWk+q3snG3vWKqjOV1zWE8pPyzK
        Su9d6eR+xePCywsrHRmK8q/+/trTbDt5UtySjFcuZ47PVWfbGJDA+V66itXbRvBnkYyImZu8
        6fTpEw9NuJ14U/X8FOdHfqvV7Z49UGIpzkg01GIuKk4EAB3dEX0eAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7oVfo5xBv3NNhar7/azWexZNInJ
        4tiOR0wOzB6Xz5Z6bD5d7fF5k1wAc5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXms
        lZGpkr6dTUpqTmZZapG+XYJexqyZO5gLJnBX3O2eydrA+JKji5GTQ0LARGLug3mMILaQwFJG
        idX3BLoYOYDiMhLH15dBlAhL/LnWxdbFyAVU8ppR4tOTDWwgCWEBb4kTV0+D9YoIKEl8bD/E
        DmIzC1hLzF68ngmiYT2jxNeTr8ESbAJWEhPbV4E18ArYSezd+IYVZBmLgKrEt3/VIGFRgQiJ
        wztmQZUISpyc+YQFxOYUMJZ4f2UOM8R8dYk/8y5B2eISt57MZ4Kw5SW2v53DPIFRaBaS9llI
        WmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwIjZduznlh2MXe+CDzEKcDAq
        8fA62DvECbEmlhVX5h5ilOBgVhLhtZR2jBPiTUmsrEotyo8vKs1JLT7EaAr020RmKdHkfGA0
        55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYDwU8uj2l/YtkZMj
        zZ4tPfDszltFdat5nWu4tDPefds688sclgsC76WqzpWLPkzm/ZG7OCKqVVr8alJykFFSypOQ
        g+nXrPlTeezupXApRXrMvbyP3138R0q1gu1b54PbGb7c4GLXi8sKeDrLO5WBNfHNZas7v09H
        tP7LOSSulyJ4fKJ6VNo+SyWW4oxEQy3mouJEAOXtqLCuAgAA
X-CMS-MailID: 20200210123713eucas1p2bc0bee18f79a2c1ae38ff9ab62277c4b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204171351eucas1p11bd2f62bb72c860051dfe08e096ae526
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204171351eucas1p11bd2f62bb72c860051dfe08e096ae526
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204171351eucas1p11bd2f62bb72c860051dfe08e096ae526@eucas1p1.samsung.com>
        <20200204165547.115220-8-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> The bus probe is better tracked with the actual calls, and the
> resulting taskfile will be printed with tracepoints anyway.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-core.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index cea065fb6282..0f5715cfa1c4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -825,9 +825,6 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
>  		head  = track % dev->heads;
>  		sect  = (u32)block % dev->sectors + 1;
>  
> -		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
> -			(u32)block, track, cyl, head, sect);
> -
>  		/* Check whether the converted CHS can fit.
>  		   Cylinder: 0-65535
>  		   Head: 0-15
> @@ -6475,11 +6472,8 @@ int ata_port_probe(struct ata_port *ap)
>  	if (ap->ops->error_handler) {
>  		__ata_port_probe(ap);
>  		ata_port_wait_eh(ap);
> -	} else {
> -		DPRINTK("ata%u: bus probe begin\n", ap->print_id);
> +	} else
>  		rc = ata_bus_probe(ap);
> -		DPRINTK("ata%u: bus probe end\n", ap->print_id);
> -	}
>  	return rc;
>  }
>  
