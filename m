Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8CDC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71800206F0
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g+HpksOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgA3KxP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:53:15 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52299 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KxO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:53:14 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130105313euoutp0109bbfcf48cbaa726f4c26cfe962cd0a2~upK_LPmUt0216302163euoutp01X
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:53:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130105313euoutp0109bbfcf48cbaa726f4c26cfe962cd0a2~upK_LPmUt0216302163euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381593;
        bh=D92FGO5X5EnoaBy78eLvQ5PyhiAXxFV+WPZHGaRz87Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=g+HpksOsoQBuwOGREAu5JgmcMbtoaHdCP88Cbf8C8Z5L3HIrvmLrGANhpkNH4mvc6
         Gfn5NmljbRwQzc4kwY4QA/5WyMooYq5sHSITqFSXmzN27SUneJIW6poMxZcdrmeQ89
         m2kbNhXIHKSENe2NRDUHqoKkoNF/s29Ci2cweCGg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130105312eucas1p2e02d875addaa7cd51460bc1f41c4e1f1~upK_DA1hN2353323533eucas1p26;
        Thu, 30 Jan 2020 10:53:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7C.3A.60698.895B23E5; Thu, 30
        Jan 2020 10:53:12 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130105312eucas1p1429dce347deac33e03b211eb35b338b5~upK9wTUAm3130631306eucas1p1m;
        Thu, 30 Jan 2020 10:53:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130105312eusmtrp12f2e0af8b98973715b69d3032291a96a~upK9vss9c1386813868eusmtrp1U;
        Thu, 30 Jan 2020 10:53:12 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-de-5e32b5982c62
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.7E.07950.895B23E5; Thu, 30
        Jan 2020 10:53:12 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130105312eusmtip2473b239c3ce8b6a212ed5e36818c2ff9~upK9hS-xn1041810418eusmtip2a;
        Thu, 30 Jan 2020 10:53:12 +0000 (GMT)
Subject: Re: [PATCH 12/24] ata_piix: Remove DPRINTK usage
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <1cff692d-8eff-df9a-b771-f3dccbd775f6@samsung.com>
Date:   Thu, 30 Jan 2020 11:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-24-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7ozthrFGTxrNbVYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6MpV3BBZO5
        KqYd2MvewNjJ0cXIySEhYCJx8fwNpi5GLg4hgRWMEjt/LWWHcL4wSuxecoQZpEpI4DOjxKop
        NjAdk6YcZ4QoWs4osXTqLWYI5y2jxMR3M9hBqoQFLCX6dr0Es0UElCQ+th8Cs5kF4iSartwF
        s9kErCQmtq9iBLF5BewkTh2cDBZnEVCVmHrvGQuILSoQIfHpwWFWiBpBiZMzn4DFOQWMJa5O
        XccCMVNc4taT+UwQtrzE9rdzwA6SEOhnl1j46BQrxNkuEhevvWOGsIUlXh3fwg5hy0icntzD
        AtGwjlHib8cLqO7tjBLLJ/9jg6iylrhz7heQzQG0QlNi/S59iLCjRMPZs6wgYQkBPokbbwUh
        juCTmLRtOjNEmFeio00IolpNYsOyDWwwa7t2rmSewKg0C8lrs5C8MwvJO7MQ9i5gZFnFKJ5a
        WpybnlpsnJdarlecmFtcmpeul5yfu4kRmFZO/zv+dQfjvj9JhxgFOBiVeHg1NhjFCbEmlhVX
        5h5ilOBgVhLhFXU1jBPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFM
        lomDU6qBcanGZcXlE5qrQs6s2G/Bszbi6cqvvfUXmMynR21J8Xj3zTBGJrO3p/Gl4Kv/fT0/
        Xx3gNGJ9vaNc1IuzZqnossl7f14xO9pa5KV1pEFHWiI6S5y1i7V3BYeEp/9en3kTAmTEhK0v
        MX0JKnIr67i87d8aq6s+GncObOC/va2vdpV4xlz7HJllSizFGYmGWsxFxYkAyOkCaCcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7ozthrFGbycqGax+m4/m8WCN3vZ
        LPYsmsRkcWzHIyYHFo/LZ0s91m+5yuKx+XS1x+dNcgEsUXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZS7uCCyZzVUw7sJe9gbGTo4uRk0NCwERi
        0pTjjF2MXBxCAksZJd71NLB2MXIAJWQkjq8vg6gRlvhzrYsNouY1o8SURX9YQRLCApYSfbte
        soPYIgJKEh/bD4HZzAJxEv/6djNBNKxjlNjfdAUswSZgJTGxfRUjiM0rYCdx6uBksDiLgKrE
        1HvPWEBsUYEIicM7ZkHVCEqcnPkELM4pYCxxdeo6FogF6hJ/5l1ihrDFJW49mc8EYctLbH87
        h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFxtO3Yzy07
        GLveBR9iFOBgVOLh1dhgFCfEmlhWXJl7iFGCg1lJhFfU1TBOiDclsbIqtSg/vqg0J7X4EKMp
        0HMTmaVEk/OBMZ5XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFx
        /2KdKTP/W8k0NQYtdK8Mzufwd98s21Sb1JPtbjRvTcLpQpNW561VU1esVUttW7tg1b8Pv7iV
        IudG3Zt6dM7UqK237llNdlyt84Lt9ZXyv5+4PV6sX2Hz4gaP3tzySJ7XmzYGFq6taE/pzT1y
        8KW/4bNrCre2tO3QlE9XVly9rO7TY6/r37YcU2Ipzkg01GIuKk4EAAAEeYG5AgAA
X-CMS-MailID: 20200130105312eucas1p1429dce347deac33e03b211eb35b338b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104821epcas1p232acb49869e54a322a48109bb43eeacc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104821epcas1p232acb49869e54a322a48109bb43eeacc
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104821epcas1p232acb49869e54a322a48109bb43eeacc@epcas1p2.samsung.com>
        <20181213104716.31930-24-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Drop pointless DPRINTK calls around pci_register_driver() and move the
> remaining call over to dev_dbg().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/ata_piix.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 7ecb1322a514..f757ff8d0248 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1362,7 +1362,8 @@ static void piix_init_pcs(struct ata_host *host,
>  	new_pcs = pcs | map_db->port_enable;
>  
>  	if (new_pcs != pcs) {
> -		DPRINTK("updating PCS from 0x%x to 0x%x\n", pcs, new_pcs);
> +		dev_dbg(&pdev->dev,
> +			"updating PCS from 0x%x to 0x%x\n", pcs, new_pcs);

Please preserve __func__ printing in the conversion.

>  		pci_write_config_word(pdev, ICH5_PCS, new_pcs);
>  		msleep(150);
>  	}
> @@ -1786,14 +1787,12 @@ static int __init piix_init(void)
>  {
>  	int rc;
>  
> -	DPRINTK("pci_register_driver\n");
>  	rc = pci_register_driver(&piix_pci_driver);
>  	if (rc)
>  		return rc;
>  
>  	in_module_init = 0;
>  
> -	DPRINTK("done\n");
>  	return 0;
>  }

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
