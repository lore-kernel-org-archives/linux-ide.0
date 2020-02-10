Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55010C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8152080C
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OyrujXmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgBJPhi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:37:38 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49373 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgBJPhi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:37:38 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210153736euoutp029f49b482765e176d68a1d0ec1fd85b76~yFJavhoIf1945819458euoutp024
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:37:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210153736euoutp029f49b482765e176d68a1d0ec1fd85b76~yFJavhoIf1945819458euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581349056;
        bh=EaHBPYluHKr5YWKwRUIitOPjR3D6+vZ7WJ2yPoaJ2Wc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OyrujXmET+KzsIgF7YeT1p9g6fZckbrH53vPi5OS8TJ6p5huEH70ISWv01VHTBQ8R
         c1fJ6T3mxmC+m53b4yvqVb9mcJuRCAlCpBDcUaXOszQH79gJQRVs1AHNTfA8f0O/hE
         3rnmpai7Jmzm+qmHGZrKHNYFvTskglX7N/sYMhuM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210153736eucas1p13c95fe4628212c1a13e1bdc4fdf49bdd~yFJaoqC3-1391113911eucas1p19;
        Mon, 10 Feb 2020 15:37:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B3.0C.60679.0C8714E5; Mon, 10
        Feb 2020 15:37:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210153735eucas1p294043d386a986b9b0e0bc882c93950ef~yFJaJ1BxZ1585815858eucas1p2B;
        Mon, 10 Feb 2020 15:37:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210153735eusmtrp180690d5d03796777894ca6cd963887cb~yFJaJTCpo1892818928eusmtrp1q;
        Mon, 10 Feb 2020 15:37:35 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-3d-5e4178c0330b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 72.F0.08375.FB8714E5; Mon, 10
        Feb 2020 15:37:35 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210153735eusmtip2c6d88cd4dcc75c769d8261e2acab8604~yFJZ6gWL02697626976eusmtip2V;
        Mon, 10 Feb 2020 15:37:35 +0000 (GMT)
Subject: Re: [PATCH 27/46] sata_rcar: drop DPRINTK call in
 sata_rcar_exec_command()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <260b8faa-2bcc-48ad-e738-2573fd6e6b20@samsung.com>
Date:   Mon, 10 Feb 2020 16:37:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-28-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzned0DFY5xBu+XSFusvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFFcNimpOZllqUX6dglcGS+v/mUvaOao2HbkH2MD43m2
        LkZODgkBE4ktu1+zdDFycQgJrGCUmP7vGBOE84VRormvnR3C+cwosWbJKiaYln3PDkK1LGeU
        mLFqDwtIQkjgLaPEhoXVILawQKjEnJMNrCC2iICSxMf2Q+wgNrOAtcTsxevBBrEJWElMbF/F
        2MXIwcErYCfReloAJMwioCrx9skPsBJRgQiJTw8Og43hFRCUODnzCdgqTqAb5t/YBjVSXOLW
        k/lMELa8xPa3c5hBbpMQaGeX2Ll5HzPE0S4Sq291MULYwhKvjm9hh7BlJE5P7mGBaFjHKPG3
        4wVU93ZGieWT/0FDyVrizrlfbCCXMgtoSqzfpQ9iSgg4SvQ2i0GYfBI33gpC3MAnMWnbdGaI
        MK9ER5sQxAw1iQ3LNrDBbO3auZJ5AqPSLCSfzULyzSwk38xCWLuAkWUVo3hqaXFuemqxUV5q
        uV5xYm5xaV66XnJ+7iZGYAI5/e/4lx2Mu/4kHWIU4GBU4uGtCHSME2JNLCuuzD3EKMHBrCTC
        aykNFOJNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoFxVmqX
        1YagFRlb3GTSOWcXcDEdZAi8cubplhWbVSZcneH1a87eb+kKKyZOrd8Q7XG60G+V/uI/ck/+
        7Hcv4/j/9/3CwN3/tlYH1Txyco5TF9Hd1iXR/OepxvFVmWzG1VK1CYnucV6tButLk1wNq4W3
        /P7sdVBTc33yho75t9+8jZfLeM590MZaiaU4I9FQi7moOBEArNd3LhwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7r7KxzjDJbfMrdYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0Ml5e/cte0MxRse3IP8YGxvNsXYycHBICJhL7nh1k6WLk4hAS
        WMooca5lFVMXIwdQQkbi+PoyiBphiT/Xutggal4zSmz/+5wFJCEsECox52QDK4gtIqAk8bH9
        EDuIzSxgLTF78XomiIYNjBLbNv1mBkmwCVhJTGxfxQiygFfATqL1tABImEVAVeLtkx9MILao
        QITE4R2zGEFsXgFBiZMzn4Dt4gQ6dP6NbVDz1SX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERqFZ
        SNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJjZtuxn5t3MF7aGHyI
        UYCDUYmHtyLQMU6INbGsuDL3EKMEB7OSCK+lNFCINyWxsiq1KD++qDQntfgQoynQcxOZpUST
        84HxnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTGnkq2gvlRb
        o9jj7MKHHucvbLV5dTPRbW7K42lFy5YtW2F0ZvXp0B2hN3Lj2+97sgrrCR8+2yHhF2+W+qLI
        4HhVgATvg9mMi2adXnbnTfq12zpNX1TX7+vWt+9eYf3S/WefauD7Z7/qRcL/ikQKcCf/tFz7
        YcqjU1k2EYreXYv+7Kpj2iQXc0eJpTgj0VCLuag4EQAQCRz8rwIAAA==
X-CMS-MailID: 20200210153735eucas1p294043d386a986b9b0e0bc882c93950ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165616eucas1p27ad20b4bcbcd2639727e5e3d030c1584
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165616eucas1p27ad20b4bcbcd2639727e5e3d030c1584
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165616eucas1p27ad20b4bcbcd2639727e5e3d030c1584@eucas1p2.samsung.com>
        <20200204165547.115220-28-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Is now logged with the generic tracepoint, so the DPRINTK call
> can be removed.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

However please consider merging this patch with patch #25.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/sata_rcar.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 1b42be234761..0925a0564cc5 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -436,8 +436,6 @@ static void sata_rcar_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
>  static void sata_rcar_exec_command(struct ata_port *ap,
>  				   const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> -
>  	iowrite32(tf->command, ap->ioaddr.command_addr);
>  	ata_sff_pause(ap);
>  }
> 
