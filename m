Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61B0C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDA720714
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MPODqa6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBJPwv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:52:51 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37136 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgBJPwv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:52:51 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210155249euoutp017980691568bac420822e3ea1f1ef91a9~yFWtH0reG1838018380euoutp01z
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:52:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210155249euoutp017980691568bac420822e3ea1f1ef91a9~yFWtH0reG1838018380euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581349969;
        bh=NTY5a/7Z7VhILeSmiBzstd83oauwZbFybubFMf9OcB0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MPODqa6NG4fIhRGgHJAsMSVXeacVhobd0MU+gyH29S+101uBe49bWG6KVf2RlRu5U
         K2UMdRge5NQfgClMhrMWWiA6qwdBLF1T0cZJh5XCVBkaZ19UqAk2+C62m/KOlY8qyN
         64CB6xuJInw1ewhStwlZIe+QWUqfj3XROFajcOHc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210155249eucas1p16772b42dcacfc3eb386a2dd5d6a3a32c~yFWs5ELK71774217742eucas1p1v;
        Mon, 10 Feb 2020 15:52:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DD.0E.60679.15C714E5; Mon, 10
        Feb 2020 15:52:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210155249eucas1p1394dd1ad58d8586599f225fbc065e7cc~yFWsnogg91106811068eucas1p1P;
        Mon, 10 Feb 2020 15:52:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210155249eusmtrp1f8f477906424400031f6cc900fcad17f~yFWsnE10H2674526745eusmtrp1F;
        Mon, 10 Feb 2020 15:52:49 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-0e-5e417c517628
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 95.DE.07950.15C714E5; Mon, 10
        Feb 2020 15:52:49 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210155248eusmtip2a6eb7b44953b58d4036d102ddeb95f46~yFWsXse6_0532005320eusmtip2u;
        Mon, 10 Feb 2020 15:52:48 +0000 (GMT)
Subject: Re: [PATCH 35/46] sata_rcar: move DPRINTK to VPRINTK
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a65e23ec-35e8-f128-7f00-e28afd76b9c1@samsung.com>
Date:   Mon, 10 Feb 2020 16:52:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-36-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87qBNY5xBluviVusvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGla9iBb0c
        FTvetrI2MF5i62Lk5JAQMJFY+vMuaxcjF4eQwApGiSNvP7NAOF8YJV5t+MoM4XxmlHj0+Tgr
        TMua3s9QLcsZJWadXQDlvGWU6Hx/ixmkSljAVqLt+xUwW0RASeJj+yF2EJtZIE6i6cpdMJtN
        wEpiYvsqRhCbV8BOYu7sv2AbWARUJZY2/WMCsUUFIiQ+PTjMClEjKHFy5hMWEJsT6IqH51tY
        IGaKS9x6Mp8JwpaX2P52DtjZEgL97BLdn5YyQpztInFzbSOULSzx6vgWdghbRuL05B4WiIZ1
        jBJ/O15AdW9nlFg++R80nKwl7pz7BWRzAK3QlFi/Sx8i7ChxrGcmWFhCgE/ixltBiCP4JCZt
        m84MEeaV6GgTgqhWk9iwbAMbzNqunSuZJzAqzULy2iwk78xC8s4shL0LGFlWMYqnlhbnpqcW
        G+WllusVJ+YWl+al6yXn525iBCaW0/+Of9nBuOtP0iFGAQ5GJR7eikDHOCHWxLLiytxDjBIc
        zEoivJbSQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoY
        2Tkdfm6+vK+FW+JsCrNw9alZvyxDFhSdPB0gUJb4d0n1mxP5VfPfH/vyvfyn7/JMlTesDpkT
        irdd1Z6tmv7Hj1O3NWjZ23N51WlaCyUMtv77/3xipmy6/49zDUXb+HJV2RJUA79u3iTvHuXJ
        l88x8XFP7sQDsipvz/232nYh6/2v12enlDTcVGIpzkg01GIuKk4EANoN9JUoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7qBNY5xBnc/slisvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gla9iBb0cFTvetrI2MF5i62Lk5JAQMJFY
        0/uZtYuRi0NIYCmjxOMr69m7GDmAEjISx9eXQdQIS/y51sUGUfOaUeLUjKOsIAlhAVuJtu9X
        mEFsEQEliY/th9hBbGaBOIl/fbuZIBo2MEpMe/KYESTBJmAlMbF9FZjNK2AnMXf2X7BBLAKq
        Ekub/jGB2KICERKHd8yCqhGUODnzCQuIzQl06cPzLSwQC9Ql/sy7xAxhi0vcejKfCcKWl9j+
        dg7zBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC42jbsZ9b
        djB2vQs+xCjAwajEw3sh2DFOiDWxrLgy9xCjBAezkgivpTRQiDclsbIqtSg/vqg0J7X4EKMp
        0HMTmaVEk/OBMZ5XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoGx
        bVrZnpcn/Dw3WWZIhzt/u3xOy5Lbe3GGhDB3udpj7YxIpkVf5m24v3U54/EZ5je1nu5WNJny
        bGXHgnu8uRW/jP2dvW49qa36MPth96fvS80rWBhfPQm8KWZRwnDbZP+5IE2H7k/JP6waG9WT
        xP4GrQtKYsu4tjo5hK97QtpM97l9Lw8Zsu5VYinOSDTUYi4qTgQACYxfGrkCAAA=
X-CMS-MailID: 20200210155249eucas1p1394dd1ad58d8586599f225fbc065e7cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165617eucas1p17607d44b9d721955cb6cf0630aea131a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165617eucas1p17607d44b9d721955cb6cf0630aea131a
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165617eucas1p17607d44b9d721955cb6cf0630aea131a@eucas1p1.samsung.com>
        <20200204165547.115220-36-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Move the remaining DPRINTK statement in the interrupt handler to
> VPRINTK. It'll be converted later with the remaining VPRINTK
> calls.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/sata_rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 0925a0564cc5..f65741b5ca20 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -679,7 +679,7 @@ static void sata_rcar_serr_interrupt(struct ata_port *ap)
>  	if (!serror)
>  		return;
>  
> -	DPRINTK("SError @host_intr: 0x%x\n", serror);
> +	VPRINTK("SError @host_intr: 0x%x\n", serror);
>  
>  	/* first, analyze and record host port events */
>  	ata_ehi_clear_desc(ehi);
> 
