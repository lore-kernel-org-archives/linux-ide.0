Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD89C352A4
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1B720714
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RQKdfpS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBJNcS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:32:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53899 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731561AbgBJNcS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:32:18 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210133216euoutp02f310a673fc40b005d72f4723123aff11~yDb-CKxIk3147831478euoutp025
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:32:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210133216euoutp02f310a673fc40b005d72f4723123aff11~yDb-CKxIk3147831478euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581341536;
        bh=bWa66tCbTZg3qn8V21Qps7wngf9dmIHS+0ThhNADf+A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RQKdfpS/mRPxN+ny0Om1FJ15NHDP0atAIwTe8cFmh/IwZd5WQi5eo8mq0u17mn1PB
         xxFHieupGS1PqGdlWRwcDug8Yq0rHn0rLvq/ZHCYmEEYPDP6clVFHdcSYClz2xKyUs
         uTe8PrMgFOZaMCap29VzKi0kh8exf/ClGEURMpfs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210133216eucas1p1102cbfe893d83495f178410b64faac1c~yDb_36m8l1989019890eucas1p10;
        Mon, 10 Feb 2020 13:32:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 20.47.60679.06B514E5; Mon, 10
        Feb 2020 13:32:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210133216eucas1p2ff4c1c5dec185b4600c9f8ba89766ee3~yDb_q1V9q2137821378eucas1p2a;
        Mon, 10 Feb 2020 13:32:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210133216eusmtrp262db43ca58ef0b1ffb8e2fb896385651~yDb_qROoK2244422444eusmtrp2Z;
        Mon, 10 Feb 2020 13:32:16 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-26-5e415b601984
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C8.C9.07950.F5B514E5; Mon, 10
        Feb 2020 13:32:15 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210133215eusmtip1030c66f59b9ccf225921995682878589~yDb_P7PMN2753027530eusmtip1f;
        Mon, 10 Feb 2020 13:32:15 +0000 (GMT)
Subject: Re: [PATCH 13/46] ata_piix: Drop DPRINTK() statement
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <031d38b2-8508-235f-02db-891b1a853273@samsung.com>
Date:   Mon, 10 Feb 2020 14:32:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-14-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7oJ0Y5xBr+W81qsvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGhtXlBX/Z
        KzYsPcvawLibrYuRk0NCwERiw45VjF2MXBxCAisYJfZPOskIkhAS+MIo8fxCLUTiM6PE0X0v
        mGE6bpw4BdWxnFHiwNleFgjnLaPEvOVbwaqEBWwlDj04zAJiiwgoSXxsP8QOYjMLxEk0XbkL
        ZrMJWElMbF8Fto5XwE6iq78L7CYWAVWJX7dvg8VFBSIkPj04zApRIyhxcuYTsJmcQFdcfvCX
        GWKmuMStJ/OZIGx5ie1v50Bd2s0u8XtFOoTtInH27nMmCFtY4tXxLewQtozE/50gvVxA9jpG
        ib8dIG+CONsZJZZP/gcNJWuJO+d+AdkcQBs0Jdbv0ocIO0psbvnEAhKWEOCTuPFWEOIGPolJ
        26YzQ4R5JTrahCCq1SQ2LNvABrO2a+dK5gmMSrOQfDYLyTezkHwzC2HvAkaWVYziqaXFuemp
        xUZ5qeV6xYm5xaV56XrJ+bmbGIFJ5fS/4192MO76k3SIUYCDUYmHtyLQMU6INbGsuDL3EKME
        B7OSCK+lNFCINyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkG
        xiKRzoZFVzddD2dTMHWLuMhzZXtt5CWmnZ4d562iA1KnlgKTkLuWYa3CiYyudReqGfekbK+a
        Ms3d8lSsyNFCx/mS8dFVdnqX1q+Y9EUqeffef7MCGlM8JRfmxcQsW7Ey7VV39+VFN7T55+3I
        L7r3dxvLGX/N+A2C+z4u2NXzk/Wc/p2PDAYrlViKMxINtZiLihMBSJbhsiYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7rx0Y5xBuuWWFusvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GhtXlBX/ZKzYsPcvawLibrYuRk0NCwETi
        xolTjF2MXBxCAksZJe62nWfvYuQASshIHF9fBlEjLPHnWhcbRM1rRon1Oy+zgySEBWwlDj04
        zAJiiwgoSXxsPwQWZxaIk/jXt5sJomEDo8TVbS1gRWwCVhIT21cxgti8AnYSXf1dYFewCKhK
        /Lp9GywuKhAhcXjHLKgaQYmTM5+A9XICXXr5wV9miAXqEn/mXYKyxSVuPZnPBGHLS2x/O4d5
        AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBcbTt2M8tOxi7
        3gUfYhTgYFTi4b0Q7BgnxJpYVlyZe4hRgoNZSYTXUhooxJuSWFmVWpQfX1Sak1p8iNEU6LmJ
        zFKiyfnAGM8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cAoHnxG
        Nns6y3/nBfNDHI7Ltl8oXHN0kk/f4faoowbZVzluXDvHdmlq913N42GBh9LE/HZV8V0/fu//
        2mnVi4XXzuYrDXSekPeR4dz8xtPCkyZn/18nlqXS/Ty6/H17xgrliyxvQlat/c96y/DVCV0x
        ncb9FkwH61ONH8fY33+lflvzqGkCU+0qJZbijERDLeai4kQADI7FFrkCAAA=
X-CMS-MailID: 20200210133216eucas1p2ff4c1c5dec185b4600c9f8ba89766ee3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165612eucas1p166656eeb4943186116c86ea8fe77bf29
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165612eucas1p166656eeb4943186116c86ea8fe77bf29
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165612eucas1p166656eeb4943186116c86ea8fe77bf29@eucas1p1.samsung.com>
        <20200204165547.115220-14-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Drop a pointless DPRINTK() statement about PCI setup.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Please fix From: and S-o-B: to match (some other patches also
have this issue).

With that resolved:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/ata_piix.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index f940ecf72aaa..10ebe8daf1a5 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1343,7 +1343,6 @@ static void piix_init_pcs(struct ata_host *host,
>  	new_pcs = pcs | map_db->port_enable;
>  
>  	if (new_pcs != pcs) {
> -		DPRINTK("updating PCS from 0x%x to 0x%x\n", pcs, new_pcs);
>  		pci_write_config_word(pdev, ICH5_PCS, new_pcs);
>  		msleep(150);
>  	}
> 
