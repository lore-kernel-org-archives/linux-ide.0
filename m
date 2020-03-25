Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D09FC1975A
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 16:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5350420714
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 16:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o92f4nyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgCYQZb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:25:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35398 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgCYQZa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2020 12:25:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200325162529euoutp01f1f9f216d3fb06ef2191c3a7489ad0f6~-mLx_gVJH2133621336euoutp01P
        for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2020 16:25:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200325162529euoutp01f1f9f216d3fb06ef2191c3a7489ad0f6~-mLx_gVJH2133621336euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585153529;
        bh=KvXXJtDJ/wBN32i5E+GiFYtwOg8fa3F+yhCAoTFrrjo=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=o92f4nyK6Ih0rHfv/LeviqobF33FhnrzilyrncpvfnIxShASiqpY9Cj3EbSzu7cIF
         EuLKU4i4oqG8tQnoIp/Ah4vUsy63biXMEqU4t1bCeLFLl22yTwFyUJUhOLPZI/sXJX
         lHifMfP0s/NkuVEbXi64H7jZ9pHnubeHLtQMM504=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200325162528eucas1p274a596847c7757bc39a6026f048744d8~-mLxqARxA2241122411eucas1p2T;
        Wed, 25 Mar 2020 16:25:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 19.5B.61286.8F58B7E5; Wed, 25
        Mar 2020 16:25:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200325162528eucas1p11d41a3668f28abd648f6c041a5518b83~-mLxPnlqR2154121541eucas1p1y;
        Wed, 25 Mar 2020 16:25:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200325162528eusmtrp283806200cc286b131f1fb5934129f81c~-mLxPEJ7B0314603146eusmtrp2l;
        Wed, 25 Mar 2020 16:25:28 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-22-5e7b85f8bab6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.A5.08375.8F58B7E5; Wed, 25
        Mar 2020 16:25:28 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200325162528eusmtip22fb8ec90a9d8225a322bd6e52c49c89b~-mLw7LjlY1625516255eusmtip2P;
        Wed, 25 Mar 2020 16:25:28 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] sata_fsl: build fix
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Guenter Roeck <linux@roeck-us.net>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Message-ID: <5e52900b-6674-4220-15e4-8156ebd98df5@samsung.com>
Date:   Wed, 25 Mar 2020 17:25:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87a9e403-efd2-5464-9e8c-4d966ed1ab39@kernel.dk>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87o/WqvjDP7+1LdYfbefzWLPoklM
        Fsd2PGKyeLLwDJPFr+VHGR1YPS6fLfXYtKqTzWPn9wZ2j82nqz0+b5ILYI3isklJzcksSy3S
        t0vgyljfsYStoI+t4so9gwbGtyxdjJwcEgImEj0PDjJ1MXJxCAmsYJRY93kRK0hCSOALo8Tc
        nXkQic+MEksXt7F1MXKAdTz8ZwpRs5xR4vg0cYiat4wSf94/BJvKJmAlMbF9FSNIvbCAhsS2
        9VIgYREBBYme3yvZQGxmgTqJNzNXMIHYvAJ2Ems3LGEEsVkEVCX+7bgFViMqECHx6cFhVoga
        QYmTM5+AjecUsJWYufsrK8QccYlbT+YzQdjyEtvfzmGGOHMRu0SbNsSPLhJTLs9mh7CFJV4d
        3wJly0j83zkf7HcJgXWMEn87XjBDONsZJZZP/scGUWUtcefcL7DfmQU0Jdbv0ocIO0os3Xac
        HWIXn8SNt4IQJ/BJTNo2HeoEXomONiGIajWJDcs2sMGs7dq5knkCo9IsJI/NQvLMLCTPzELY
        u4CRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZggjn97/inHYxfLyUdYhTgYFTi4d1g
        WR0nxJpYVlyZe4hRgoNZSYR3c2pFnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNL
        UrNTUwtSi2CyTBycUg2Mc3OPL2pKWmcWIf7y7Pb1S3/zx8SqZDBpz/ZL/LJq9eKQA8GTpX++
        EGNfH79g/vUbc/pmTjPlMzQqydm4xWRe0jfWXmvdXo+TzjJfN9Vzz1/U/VAlLlqzTun5JLe2
        boMDtfWr9K+c9slKX+14vjz3J6+Yx4MzK2r+HDA6za38mE1C4vXRDefTlViKMxINtZiLihMB
        FKRniCwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xe7o/WqvjDD7dFLZYfbefzWLPoklM
        Fsd2PGKyeLLwDJPFr+VHGR1YPS6fLfXYtKqTzWPn9wZ2j82nqz0+b5ILYI3SsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1jfsYStoI+t4so9gwbG
        tyxdjBwcEgImEg//mXYxcnIICSxllNh42AUiLCNxfH0ZSFhCQFjiz7Uuti5GLqCS14wSLT1v
        WEESbAJWEhPbVzGC1AsLaEhsWy8FEhYRUJDo+b2SDcRmFqiT6O94xQTRe5RRYnfvD7AEr4Cd
        xNoNSxhBbBYBVYl/O26BxUUFIiQO75jFCFEjKHFy5hMWEJtTwFZi5u6vrBBD1SX+zLvEDGGL
        S9x6Mp8JwpaX2P52DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS
        83M3MQKjatuxn5t3MF7aGHyIUYCDUYmHd4NldZwQa2JZcWXuIUYJDmYlEd7NqRVxQrwpiZVV
        qUX58UWlOanFhxhNgZ6byCwlmpwPjPi8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Yklqdmp
        qQWpRTB9TBycUg2MjdEC+xuOfTnSX75c+9qGa0uS9Z9WL2Pr0W7lubqD44xbxY57009unxCz
        efYWGYWsm4v9dt8Ok05ctq1l8bZcc6kJhkmC3ZaS/7UivvqfO3q87YAt/9VV2YnP/37t/iV7
        pHVuktiOs1wnmX6p7bXPj23/+LbS/NX25VM6LdP9tYSFJfm0o/NnKrEUZyQaajEXFScCAFRz
        yd3AAgAA
X-CMS-MailID: 20200325162528eucas1p11d41a3668f28abd648f6c041a5518b83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81
References: <CGME20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81@eucas1p1.samsung.com>
        <98bf5f87-3601-efd5-57ce-58e6db308e95@samsung.com>
        <87a9e403-efd2-5464-9e8c-4d966ed1ab39@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 3/25/20 4:17 PM, Jens Axboe wrote:
> On 3/25/20 9:15 AM, Bartlomiej Zolnierkiewicz wrote:
>> Fix incorrect DPRINTK() conversion in sata_fsl_init_controller()
>> (dev_dbg() should be used instead of ata_port_dbg()).
> 
> Thanks Bart, another piece of fallout. Applied.
> 
> With the recent discussion as well, I wonder if we should just kill
> this series entirely.
I hate to admit it but probably yes..

It seems that the one of base concepts needs to be redesigned and
we are at -rc7 so it is a bit too late do it now..

I've also tried to find a way to revert it partially but changes are
inter-dependent and it doesn't seem to be easy way to do it..

Hannes?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
