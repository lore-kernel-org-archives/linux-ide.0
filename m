Return-Path: <SRS0=gVoV=7O=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3C4C433E0
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jun 2020 13:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9917B20738
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jun 2020 13:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lF8fKTgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgFANd5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:33:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40722 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgFANd4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2020 09:33:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601133354euoutp0192522fc3d6b210671f2fbe983bb66bba~UbtYaDzuS0056500565euoutp01L
        for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2020 13:33:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601133354euoutp0192522fc3d6b210671f2fbe983bb66bba~UbtYaDzuS0056500565euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591018434;
        bh=S/ANr4BP2J/wqUCUflp891nTue09jTyHvLhAPSPWfJs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lF8fKTgT7S2/YMWuxi09tbZ3ylPdCKfIQMmeGasV+r5d5g0HSmuBVx3yE3fYFe9sQ
         ASCL6zy/EiIhuZzbl9N4zD471QLBOOueuDa/ffeZ3+CGc9csgsgj8qWZqNRdlvlc2b
         w/ZaRzwkEpljfQTs9fX1rSB5l/0FFu+bX6xbthOY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601133354eucas1p215113c5d8051f0987d8696e20e05f066~UbtYQMD_80473904739eucas1p2i;
        Mon,  1 Jun 2020 13:33:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.34.60679.1C305DE5; Mon,  1
        Jun 2020 14:33:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601133353eucas1p14b7a0914cb8b4918974f6a334dc06a76~UbtX6t3z72382623826eucas1p1a;
        Mon,  1 Jun 2020 13:33:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601133353eusmtrp1a941ced213d7b78d5d22ca087a7abca6~UbtX6J8982919429194eusmtrp1W;
        Mon,  1 Jun 2020 13:33:53 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-76-5ed503c13d50
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 74.CC.08375.1C305DE5; Mon,  1
        Jun 2020 14:33:53 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200601133353eusmtip1f1d4636c02f0ff8daa80aea0d7de5c56~UbtXk9-GI1178011780eusmtip10;
        Mon,  1 Jun 2020 13:33:53 +0000 (GMT)
Subject: Re: [PATCH] ata: return true in ata_is_host_link()
To:     Jason Yan <yanaijie@huawei.com>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <aceddd6f-0cb1-2fea-039d-767b7e50cf16@samsung.com>
Date:   Mon, 1 Jun 2020 15:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200507110637.37341-1-yanaijie@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd2DzFfjDF48t7FYfbefzeLYjkdM
        Fpd3zWGzWLSnk9mBxaPlyFtWj8tnSz0+b5ILYI7isklJzcksSy3St0vgyph+2r5gHnvFvdk9
        7A2MX1m7GDk5JARMJHa/OM0MYgsJrGCUeLlEuIuRC8j+wijxf9tsVgjnM6PEu/ntLDAdl583
        skN0LGeU6LxiDmG/ZZR4PSUNxBYWsJaYOO8LE4gtIqAs0Xh/Otg2ZgEfiRPzuxlBbDYBK4mJ
        7avAbF4BO4ltjRfArmARUJHoPfwfbJeoQITEpweHWSFqBCVOznwCFucUsJRYuGsmM8RMcYlb
        T+YzQdjyEtvfzmEGOVpCoJ1d4lP3bXaIo10kZm/bxQxhC0u8Or4FKi4jcXpyDwtEwzpGib8d
        L6C6tzNKLJ/8jw2iylrizrlfQDYH0ApNifW79CHCjhKb+h+zgIQlBPgkbrwVhDiCT2LStunM
        EGFeiY42IYhqNYkNyzawwazt2rmSeQKj0iwkr81C8s4sJO/MQti7gJFlFaN4amlxbnpqsVFe
        arlecWJucWleul5yfu4mRmAqOf3v+JcdjLv+JB1iFOBgVOLh5Xh0JU6INbGsuDL3EKMEB7OS
        CK/T2dNxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTAq
        Bm3j4/r6e3aElHvH2ovtGXb9DYf0229wL/nm4yC310Hsc62Ghq3PvhlJ/epH7mZ+Uuo5E+R9
        24bbwSWOsSjjK7u/VFtDnP5Dva3rDHSfpjUUs76Tk8/dFx8iOfv/9B1rOJXK+WZyM2odUOK0
        Z/VT298wxUdg19cZpnOb29+sqaubsZb7mxJLcUaioRZzUXEiAPThLTAhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7oHma/GGcyfr2ax+m4/m8WxHY+Y
        LC7vmsNmsWhPJ7MDi0fLkbesHpfPlnp83iQXwBylZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdk
        YqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzH9tH3BPPaKe7N72BsYv7J2MXJySAiYSFx+3sje
        xcjFISSwlFHi0KRJzF2MHEAJGYnj68sgaoQl/lzrYoOoec0osefmJRaQhLCAtcTEeV+YQGwR
        AWWJxvvTWSGKehglLs78B1bELOAjcWJ+NyOIzSZgJTGxfRWYzStgJ7Gt8QIziM0ioCLRe/g/
        WL2oQITE4R2zoGoEJU7OfAIW5xSwlFi4ayYzxEx1iT/zLkHZ4hK3nsxngrDlJba/ncM8gVFo
        FpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA+Nl27OfmHYyXNgYf
        YhTgYFTi4d1w/0qcEGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xmgI9N5FZ
        SjQ5HxjbeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGKU2KcRM
        ZdMra+n5dSzAYtKf/zIqcrefdInsXFkf8sOhUebkget+pu3WB2qP/pTZm7B68gsr42w53fnH
        NHoYXIxbFAP+BGrukec9meKYtyNp3YfFyROeyOfJbliUOH17oNH/1/PFPyumS6Yu6t53n3G7
        vWCgrtDTPaYHaxcG3fdfOumRZKzKfCWW4oxEQy3mouJEAPjsEoa1AgAA
X-CMS-MailID: 20200601133353eucas1p14b7a0914cb8b4918974f6a334dc06a76
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200507110752eucas1p21e8a1d127642c53440fe64c4a770e3f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200507110752eucas1p21e8a1d127642c53440fe64c4a770e3f7
References: <CGME20200507110752eucas1p21e8a1d127642c53440fe64c4a770e3f7@eucas1p2.samsung.com>
        <20200507110637.37341-1-yanaijie@huawei.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 5/7/20 1:06 PM, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> include/linux/libata.h:1446:8-9: WARNING: return of 0/1 in function
> 'ata_is_host_link' with return type bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  include/linux/libata.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 8bf5e59a7859..e05a8ed2e31e 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1443,7 +1443,7 @@ static inline bool sata_pmp_attached(struct ata_port *ap)
>  
>  static inline bool ata_is_host_link(const struct ata_link *link)
>  {
> -	return 1;
> +	return true;
>  }
>  #endif /* CONFIG_SATA_PMP */
>  

