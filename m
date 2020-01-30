Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE74C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2075206D3
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b5EULypb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgA3Kqn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:46:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49699 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Kqn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:46:43 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130104642euoutp01d8522233d79a65c0f733456eabb981a4~upFR95ba42797027970euoutp01N
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:46:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130104642euoutp01d8522233d79a65c0f733456eabb981a4~upFR95ba42797027970euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381202;
        bh=rjzpQYrrqEZriaUPtgm2XsUzjDMwAnPPSbRqrstU9Ic=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=b5EULypbkMdP/uMOePDA/od/w4cWzCRugzqIpKBjrQB22hap9NQfAJ6Rk6mgRCAUD
         qdAdXvmOUCDIzL2Fd+0VT8Z1A03feFO1JdbWDC2PSrW32SHPUHGRDtFDOGiQuCAWeF
         FsrPCQ7pIZxMdNMzAf/Kgd9IUYLajRAuh01plscs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130104641eucas1p1668019a56996af411fa88467f8e68204~upFR306Hm3168731687eucas1p1G;
        Thu, 30 Jan 2020 10:46:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C8.29.60698.114B23E5; Thu, 30
        Jan 2020 10:46:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130104641eucas1p2252db39549a1b90cb1175ba636e4fbcf~upFRWO9ds1916419164eucas1p23;
        Thu, 30 Jan 2020 10:46:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130104641eusmtrp12b62402e45364a89daa8c0803c0cb309~upFRVp0ih0999509995eusmtrp1c;
        Thu, 30 Jan 2020 10:46:41 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-cf-5e32b4113627
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 94.4E.08375.114B23E5; Thu, 30
        Jan 2020 10:46:41 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130104641eusmtip29fb4aa060684dfc0596b531133b11362~upFRBIoYa0604806048eusmtip2g;
        Thu, 30 Jan 2020 10:46:40 +0000 (GMT)
Subject: Re: [PATCH 03/24] sata_sx4: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <14338ab8-537c-4ff3-b0f9-1500524b88b3@samsung.com>
Date:   Thu, 30 Jan 2020 11:46:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-15-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7qCW4ziDLqaTSxW3+1ns1jwZi+b
        xZ5Fk5gsju14xOTA4nH5bKnH+i1XWTw2n672+LxJLoAlissmJTUnsyy1SN8ugSvj6/OYgrfs
        FbM+L2VvYNzN1sXIySEhYCJxb+VPpi5GLg4hgRWMEjtfNbJCOF8YJeaeOs0G4XxmlLj0Zj07
        TMvUxSdYQGwhgeWMEv97wiCK3jJKNEyeyQSSEBZwkrhx+gYriC0ioCTxsf0QWDOzQJxE05W7
        YDabgJXExPZVjCA2r4CdxMKdJ8HiLAKqEtuOrAGzRQUiJD49OMwKUSMocXLmE7DFnALGEuc/
        L2eEmCkucevJfCYIW15i+9s5zCAHSQhMZpf4MfU2M8TVLhKdP/dD2cISr45vgfpGRuL05B4W
        iIZ1jBJ/O15AdW9nlFg++R80mKwl7pz7BWRzAK3QlFi/Sx8i7CjReQzkUg4gm0/ixltBiCP4
        JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqunSuZJzAqzULy2iwk78xC8s4shL0LGFlWMYqnlhbn
        pqcWG+ellusVJ+YWl+al6yXn525iBKaV0/+Of93BuO9P0iFGAQ5GJR5ejQ1GcUKsiWXFlbmH
        GCU4mJVEeEVdDeOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi
        4JRqYJzp4nDl+JFNrS6Xr6pnF5W6/FJ1Ofgn68jE/1+4xY7JTNBTnJDfrHFcPPJKyov5tw9q
        9bOHrprzP+UZ5wXXia8aHir+OZL5b/0aLb4cxRvtrhLcnvKv5n78lS20MPuq3Bobr4lqd886
        N5iuPj/htLX40/C6L3c3XV5rULRourjEygiry7VCe9YosRRnJBpqMRcVJwIAHtOMeicDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7qCW4ziDHreC1isvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G1+cxBW/ZK2Z9XsrewLibrYuRk0NCwERi
        6uITLF2MXBxCAksZJWZ83M7YxcgBlJCROL6+DKJGWOLPtS42iJrXjBIXDl9jBEkICzhJ3Dh9
        gxXEFhFQkvjYfogdxGYWiJP417ebCaJhHaPE79/TwbaxCVhJTGxfBdbMK2AnsXDnSbAGFgFV
        iW1H1oDZogIREod3zIKqEZQ4OfMJC4jNKWAscf7zckaIBeoSf+ZdYoawxSVuPZnPBGHLS2x/
        O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBcbTt2M/N
        OxgvbQw+xCjAwajEw6uxwShOiDWxrLgy9xCjBAezkgivqKthnBBvSmJlVWpRfnxRaU5q8SFG
        U6DnJjJLiSbnA2M8ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD
        YyrTph6v58cnLNz3SLpSd+2JPTYHgpfIalwWt1B1Zj+QJbovJ3VJd7q1dRtz5I9T5i9870xi
        +nN4068bGx/dali/wtYuofXmrjubt91k/1PLO/tIy/bvJu8Vvk290cvq47auZtqbddNXGZsU
        htfG3D0qEZ6zm7NDSK5wuuOnyNNT3qcEv2U+6KrEUpyRaKjFXFScCABZde6muQIAAA==
X-CMS-MailID: 20200130104641eucas1p2252db39549a1b90cb1175ba636e4fbcf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104742epcas5p487aa32d0bacabb467af45fcab65c7096
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104742epcas5p487aa32d0bacabb467af45fcab65c7096
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104742epcas5p487aa32d0bacabb467af45fcab65c7096@epcas5p4.samsung.com>
        <20181213104716.31930-15-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:46 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/sata_sx4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index 405e606a234d..88a0058ba7a5 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -769,7 +769,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
>  	} else if (qc->tf.protocol == ATA_PROT_NODATA) {
>  
>  		status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
> -		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
> +		ata_port_dbg(ap, "BUS_NODATA (drv_stat 0x%X)\n", status);

Please preserve __func__ printing in the conversion.

>  		qc->err_mask |= ac_err_mask(status);
>  		ata_qc_complete(qc);
>  		handled = 1;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
