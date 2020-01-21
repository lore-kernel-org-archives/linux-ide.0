Return-Path: <SRS0=H5qQ=3K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97639C2D0CE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 11:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687342253D
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 11:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tSohFTuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAULSS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:18:18 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33832 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgAULSR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jan 2020 06:18:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200121111816euoutp0179ede7c9406108f9956778d9c035c79c~r4tSEHHio0513205132euoutp01N
        for <linux-ide@vger.kernel.org>; Tue, 21 Jan 2020 11:18:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200121111816euoutp0179ede7c9406108f9956778d9c035c79c~r4tSEHHio0513205132euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579605496;
        bh=Lti8w08unzpYfu2jI6irMhwsIqh9qj48eYDGuQF9Cqo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tSohFTukUf18K4K03e3emiXdFu3yyPL9RuxbaexfZKm2tjfsglXYoAWfzUmcsW3DW
         /jrkZksn4uuEtCHdBv+zCTiq14+lu1RXyYkXxTE2rRYUEJFucAnImhovkEOHubuHAW
         JFzfIV2+YozyXD2YHnqXAOIz3+kRqzFlNWjr8vSo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200121111816eucas1p20f57d91c416387b25397bf869894e274~r4tR9eCZx0070000700eucas1p2k;
        Tue, 21 Jan 2020 11:18:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E8.2A.61286.8FDD62E5; Tue, 21
        Jan 2020 11:18:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200121111816eucas1p246ca07e30a984c51d8281a161978d3ea~r4tRoqm5L1192811928eucas1p2C;
        Tue, 21 Jan 2020 11:18:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200121111816eusmtrp22653992bb30eb1e5ac325858c592bf6f~r4tRoE0xW0925309253eusmtrp2k;
        Tue, 21 Jan 2020 11:18:16 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-88-5e26ddf8c26e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 03.F9.07950.8FDD62E5; Tue, 21
        Jan 2020 11:18:16 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200121111815eusmtip14fbff51d1e3b0c5b6ba50bd0f67b2b3d~r4tRUjtUy0248902489eusmtip1K;
        Tue, 21 Jan 2020 11:18:15 +0000 (GMT)
Subject: Re: Re: [PATCH 2/2] ide: serverworks: potential overflow in
 svwks_set_pio_mode()
To:     David Miller <davem@davemloft.net>, dan.carpenter@oracle.com
Cc:     linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <6c4a2070-043f-d26c-69dc-0a294d5f6768@samsung.com>
Date:   Tue, 21 Jan 2020 12:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200120.144047.202754056310659523.davem@davemloft.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7o/7qrFGbxbpWjx+t90Fos551tY
        LLbekrY4tuMRkwOLx5aVN5k8Pj69xeLxeZNcAHMUl01Kak5mWWqRvl0CV8bs21NYCy6wVOyY
        94yxgfEWcxcjJ4eEgInE/dUP2LsYuTiEBFYwSkw4eYYZwvnCKPHw0zxGCOczo8Sle9dYYVoe
        NLVAVS1nlJgyfy4ThPOWUeLTm3VgVcIC0RKTP54DquLgEBFwkDg9xR8kzCxgJ7Hn1iuwEjYB
        K4mJ7asYQWxeoPjFtstgN7EIqEps+TGBCcQWFYiQ+PTgMCtEjaDEyZlPWEBsTgFXial7ulkg
        ZopL3HoynwnClpfY/nYO1G/t7BJNd/whbBeJFb+eskHYwhKvjm9hh7BlJP7vnA92v4TAOkaJ
        vx0vmCGc7YwSyyf/g+qwlrhz7hcbyDPMApoS63fpQ4QdJX4e6AL7UUKAT+LGW0GIG/gkJm2b
        DhXmlehoE4KoVpPYsGwDG8zarp0rmScwKs1C8tksJN/MQvLNLIS9CxhZVjGKp5YW56anFhvm
        pZbrFSfmFpfmpesl5+duYgSmk9P/jn/awfj1UtIhRgEORiUeXodpqnFCrIllxZW5hxglOJiV
        RHgXNAGFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi4JRqYPS/
        ftTJuT/p4YIg24/2/1d2GUqan96xavJBvqwZPy08xC8Z/tn7Y9v8075zK3NPVZQ0u++4KrtH
        p9PnwuoYHb3nqx9cWxn3nGvKfIGFs9g4F6zSKNs5d3qT9iL/sx7K9ZIJ/je/CDxfHZinJGd1
        Vmq5ZJzTyd49h45LKh47uujZiluMVjqvm18rsRRnJBpqMRcVJwIAreHNhyMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7o/7qrFGfzZyWHx+t90Fos551tY
        LLbekrY4tuMRkwOLx5aVN5k8Pj69xeLxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6R
        iaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbs21NYCy6wVOyY94yxgfEWcxcjJ4eEgInEg6YW
        IJuLQ0hgKaPE1R39rF2MHEAJGYnj68sgaoQl/lzrYoOoec0oMfvpTBaQhLBAtMTkj+eYQepF
        BBwkTk/xBwkzC9hJ7Ln1ihWifgWjxJ5FG8GWsQlYSUxsX8UIYvMCFV1suwwWZxFQldjyYwIT
        iC0qECFxeMcsqBpBiZMzn4Dt4hRwlZi6p5sFYoG6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAo
        NAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYPxsO/Zzyw7GrnfB
        hxgFOBiVeHgdpqnGCbEmlhVX5h5ilOBgVhLhXdAEFOJNSaysSi3Kjy8qzUktPsRoCvTcRGYp
        0eR8YGznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgPLSzlW3y
        a+8HEw/yx9ZeNQ6u6FRiT7yeZP3uE5/Mr77VGzUz5a6ul7qjavak7NW9sLDwHqE1m7YUPrd8
        zTLzk/Wv/GVMM8/qHzBpE1ZlaNzyZ7Vb5+vtkXfmsrqFec4Lf/m75Vrr4z3ir1Yvf1zoW7Lp
        zsWa+Ptzmgv2nnx6U67CPDk6XmLOYSWW4oxEQy3mouJEAOTubzm1AgAA
X-CMS-MailID: 20200121111816eucas1p246ca07e30a984c51d8281a161978d3ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200121111816eucas1p246ca07e30a984c51d8281a161978d3ea
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200121111816eucas1p246ca07e30a984c51d8281a161978d3ea
References: <20200107130441.y3owvcnxdljailt5@kili.mountain>
        <20200107130607.tv3uosduwkw3yka6@kili.mountain>
        <20200120.144047.202754056310659523.davem@davemloft.net>
        <CGME20200121111816eucas1p246ca07e30a984c51d8281a161978d3ea@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/20/20 2:40 PM, David Miller wrote:
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Date: Tue, 7 Jan 2020 16:06:07 +0300
> 
>> The "drive->dn" variable is a u8 controlled by root.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

drive->dn should not be root controllable, please point me where it
happens as this may need fixing instead of serverworks driver.

[ IDE core makes sure that drive->dn is never > 3 and a lot of code
  assumes it. ]

> Applied.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
