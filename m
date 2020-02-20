Return-Path: <SRS0=dJ96=4I=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A96C11D04
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 13:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B5B208C4
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 13:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k9S0o+Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBTNaH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:30:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48711 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgBTNaH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Feb 2020 08:30:07 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200220133006euoutp01c13abf2c376aef3a527f00eb3abbe8ef~1H28UrWVg3202732027euoutp01_
        for <linux-ide@vger.kernel.org>; Thu, 20 Feb 2020 13:30:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200220133006euoutp01c13abf2c376aef3a527f00eb3abbe8ef~1H28UrWVg3202732027euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582205406;
        bh=cGD/GyX9sEQXtXq7CzbZUtvx2En/EcYW11DHg+0QRDM=;
        h=Subject:To:From:Cc:Date:In-Reply-To:References:From;
        b=k9S0o+CfOPDLerFSFq8p8E5t7DdaToEEVYvtoPdgXzWQSmjB8qKxG0OjNxKAvGW2k
         3JCQWBssjlTDE9SE8pl88sdHm/rnoKHnSG44Vu3HUPPSjiAx2ND0OGuwrTOesnYROf
         j8OweLocuOSXa8p+Do5KmTbWhva4J1gQuJLHVJCM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200220133005eucas1p1a858bcc7e93249cb17a136fbefcfe475~1H28OlG1C2600526005eucas1p1k;
        Thu, 20 Feb 2020 13:30:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F7.FF.60698.DD98E4E5; Thu, 20
        Feb 2020 13:30:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200220133005eucas1p2e28507407434ce211b71980fd82f921a~1H2749Io82158021580eucas1p2x;
        Thu, 20 Feb 2020 13:30:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200220133005eusmtrp1121a6d09d35c71aaecb780dbd56cdc41~1H27y4z513090930909eusmtrp1e;
        Thu, 20 Feb 2020 13:30:05 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-d0-5e4e89ddf38b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.DB.07950.DD98E4E5; Thu, 20
        Feb 2020 13:30:05 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200220133005eusmtip1ca9aff79fc9ef3dfb66e7b68aadd6538~1H27lvU5n2869128691eusmtip1V;
        Thu, 20 Feb 2020 13:30:05 +0000 (GMT)
Subject: Re: [Bug 206405] kernel crash during boot debian server on qemu+kvm
To:     bugzilla-daemon@bugzilla.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org
Message-ID: <401155b9-e8d6-b70c-4c16-7a8d2e15f842@samsung.com>
Date:   Thu, 20 Feb 2020 14:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bug-206405-11633-Dt7buLdEpp@https.bugzilla.kernel.org/>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzned27nX5xBst7zSx6LzQxWxzb8YjJ
        gcnj1ZQ3zB6fN8kFMEVx2aSk5mSWpRbp2yVwZSw//5m1YBdrxekTy1kaGI+wdDFyckgImEjs
        fr+YuYuRi0NIYAWjxMXeF0wQzhdGidOPJrJDOJ8ZJZbP38zaxcgB1vL9uT1EfDmjxIPO76wQ
        zltGiYZVZ5hB5goL+EhMP/qDDcQWEVCXuHVnH9g+NgEriYntqxhBbGYBWYnGW0vZQWxeATuJ
        RQ9mM4HYLAKqElPun2AFsUUFIiQ+PTjMClEjKHFy5hOwOZwCrhKTG26zQswRl7j1ZD4ThC0v
        sf3tHLB/JAQ+s0mc63zECPGoi8S89qdQtrDEq+Nb2CFsGYnTk3tYIBrWMUr87XgB1b0d6OfJ
        /9ggqqwl7pz7xQbyP7OApsT6XfoQYUeJ63cfs0GChU/ixltBiCP4JCZtm84MEeaV6GgTgqhW
        k9iwbAMbzNqunSuZJzAqzULy2iwk78xC8s4shL0LGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al
        6yXn525iBCaN0/+Of93BuO9P0iFGAQ5GJR7eiga/OCHWxLLiytxDjBIczEoivGo8QCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYFx7b9vuvhO0sdeF1
        RkLLdJgiuhZf1XhwYHnN8k3PbnYyP7Gat/5yr5/4FQv+q/sj5gl7ft+9s2JnoZZvV7/Nn+++
        ga2LFt+oZDy3sMt3d9K5GdOs7y7x0Mmwmff8W5soLzNve4bimctGttPmlMdFyR32c2NpfTP3
        n3fJtbWNJ+r3z3yy4bjnXyWW4oxEQy3mouJEABTCW5EWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7p3O/3iDA7tlrTovdDEbHFsxyMm
        ByaPV1PeMHt83iQXwBSlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OS
        mpNZllqkb5egl7H8/GfWgl2sFadPLGdpYDzC0sXIwSEhYCLx/bl9FyMXh5DAUkaJRwuaGSHi
        MhLH15d1MXICmcISf651sUHUvGaU+PV+OQtIQljAR2L60R9sILaIgLrErTv7wGYKCZRItB0C
        K2ETsJKY2L6KEcRmFpCVaLy1lB3E5hWwk1j0YDYTiM0ioCox5f4JVhBbVCBC4vCOWYwQNYIS
        J2c+AZvDKeAqMbnhNivEHHWJP/MuMUPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWk
        ZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzA+Nh27OeWHYxd74IPMQpwMCrx8FY0+MUJ
        sSaWFVfmHmKU4GBWEuFV4wEK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wdvNK4g1NDc0t
        LA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTC29b+Y2Bi/9pt6UfP2jXcuqKbK
        6Zk8W+1976bpHOGA/LwLP237I6QFIj3CttmF95Z7n/zWFrAuWLg18pBO/LvSKImOn9pro7bL
        xDa/4pNPsrsboVowvTYjZ/W795ky4tNyfljMu21Qv+qB5qrKcGYG7aJ/4lflldcGrJw6KSvw
        t/K2tzFGdUosxRmJhlrMRcWJAPMZZg6lAgAA
X-CMS-MailID: 20200220133005eucas1p2e28507407434ce211b71980fd82f921a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200220133005eucas1p2e28507407434ce211b71980fd82f921a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200220133005eucas1p2e28507407434ce211b71980fd82f921a
References: <bug-206405-11633@https.bugzilla.kernel.org/>
        <bug-206405-11633-Dt7buLdEpp@https.bugzilla.kernel.org/>
        <CGME20200220133005eucas1p2e28507407434ce211b71980fd82f921a@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/19/20 10:25 PM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=206405
> 
> --- Comment #3 from anthony (antdev66@gmail.com) ---
> same problem in version 5.5.5

Hi,

Please check v5.6-rc2 and if it doesn't help please try to do
bisection between v5.4 and v5.5 kernel versions as described in:

	Documentation/admin-guide/bug-bisect.rst

Also could you please explain what prevents you from migration to
libata drivers (CONFIG_ATA) from the IDE subsystem (CONFIG_IDE, it
has been deprecated many years ago and is scheduled for removal)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
