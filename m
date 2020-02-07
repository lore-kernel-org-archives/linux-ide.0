Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF6C35250
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B3020838
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XRlUW5TA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgBGO2w (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:52 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49568 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgBGO2A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:00 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142759euoutp020e92197576806224189adf16b3152705~xJQxT-b2k2563925639euoutp02R
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142759euoutp020e92197576806224189adf16b3152705~xJQxT-b2k2563925639euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085679;
        bh=aHu8VSvz6Jo5mCNhfIdaPkPjkQbwXXjvZKwXq8fNubM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRlUW5TAlJauAeDgoAWohoawYObW6/YodjbcdYjQV2x8yhOVw1C8+8J7d4hk4CNFX
         EHA/Q4qP9IJZchGzDB4RBC/qxyTjmAbVCFIvxV0zw9jxocG+JWf11XoV50kMoJnMAA
         PpRKpTsQC/+owayyZkUl9dPERrp9PDjQIjvLdsPM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142758eucas1p11eb4939f0cd498ec6e5b8806b5a2a58d~xJQww0rD52844428444eucas1p1j;
        Fri,  7 Feb 2020 14:27:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3F.4D.60679.EE37D3E5; Fri,  7
        Feb 2020 14:27:58 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142758eucas1p2940a7416adac1db3cf63e284ebc23d03~xJQwcSsqF0410804108eucas1p2z;
        Fri,  7 Feb 2020 14:27:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142758eusmtrp297693a27e4a26e1b01b6041c5fa27f0e~xJQwbukrd1102911029eusmtrp2F;
        Fri,  7 Feb 2020 14:27:58 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-7b-5e3d73ee9ccd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E0.D5.07950.EE37D3E5; Fri,  7
        Feb 2020 14:27:58 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142757eusmtip2eb031261a5a9893d53bf6edeed927b15~xJQv_c9ps3155831558eusmtip2H;
        Fri,  7 Feb 2020 14:27:57 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 14/26] ata: let compiler optimize out ata_eh_set_lpm() on
 non-SATA hosts
Date:   Fri,  7 Feb 2020 15:27:22 +0100
Message-Id: <20200207142734.8431-15-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7rvim3jDHbNFLdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk9X2eyFBznrDj7oJulgfEEexcjJ4eE
        gInEzZmTGbsYuTiEBFYwSkxZ1MsO4XxhlFh2so0NwvnMKDHh50egDAdYy+lFMhDx5YwSe5ZP
        Y4LrODfnKthcNgEriYntqxhBbBEBBYme3yvBJjELvGeUWDFpLwtIQlggVuL16WY2EJtFQFXi
        bcc2sDivgK3Eu083WCAOlJfY+u0TK4jNCRT/OOUvG0SNoMTJmU/AapiBapq3zmYGWSAhsIxd
        4lL/WSaIZheJR+eeMkPYwhKvjm+B+lpG4v/O+UwQDesYJf52vIDq3s4osXzyPzaIKmuJO+d+
        sYE8zSygKbF+lz7E/44Sy5fmQJh8EjfeCkLcwCcxadt0Zogwr0RHmxDEDDWJDcs2sMFs7dq5
        EuoaD4nOh9tZJjAqzkLyzSwk38xCWLuAkXkVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZG
        YCI6/e/4lx2Mu/4kHWIU4GBU4uFNcLSJE2JNLCuuzD3EKMHBrCTC26dqGyfEm5JYWZValB9f
        VJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QDo/S3rJrP97UO+hd71T0I1DBU
        LUqcPutoTIrq7IK/D3/F356ffkDkxa2mM2c1J0yaMKvxk9v7T4LuVgt/XDA/mfdc83nRZBk3
        ib7p8mYh3vpn2Bh3pivaHl1ROH1a4yWVBR6bezjWmHesvXlk6YZpUt+/HMvxCI7ew/HhzWuh
        GK5rpWFp774t71diKc5INNRiLipOBAB4UC3QQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7rvim3jDL60slqsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYyerzNZCo5zVpx90M3SwHiCvYuRg0NCwETi9CKZLkYuDiGBpYwSb36t
        ZoOIy0gcX1/WxcgJZApL/LnWxQZR84lRYsrBtewgCTYBK4mJ7asYQWwRAQWJnt8rwYqYBb4y
        Siyd1M0MkhAWiJY48e8NC4jNIqAq8bZjG5jNK2Ar8e7TDRaIDfISW799YgWxOYHiH6f8ZQOx
        hQRsJL6/n8QOUS8ocXLmE7B6ZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xkV5xYm5x
        aV66XnJ+7iZGYLxsO/Zzyw7GrnfBhxgFOBiVeHgTHG3ihFgTy4orcw8xSnAwK4nw9qnaxgnx
        piRWVqUW5ccXleakFh9iNAV6YiKzlGhyPjCW80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQn
        lqRmp6YWpBbB9DFxcEo1MF6U0sjM1FtxNmJFSKz2Ykne0M9b5r83+XA8c3NJTqxqaMMj49Uv
        nf57vBF26+6xac2+LJFu9332Q+euoKmno6L31XwqPq72nYvHeO5mi9VlcT8qXCuWq9//86nv
        OvO7gr96P5JC5ywv4fRa+XPl70bDX8Kbbm5t9FzwWCnZL/uWf0g1/03hJiWW4oxEQy3mouJE
        AEUp4uCtAgAA
X-CMS-MailID: 20200207142758eucas1p2940a7416adac1db3cf63e284ebc23d03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142758eucas1p2940a7416adac1db3cf63e284ebc23d03
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142758eucas1p2940a7416adac1db3cf63e284ebc23d03
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142758eucas1p2940a7416adac1db3cf63e284ebc23d03@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add !IS_ENABLED(CONFIG_SATA_HOST) to ata_eh_set_lpm() to allow
compiler to optimize out the function for non-SATA configs (for
PATA hosts "ap && !ap->ops->set_lpm" condition is always true so
it's sufficient for the function to return zero).

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  17353      18       0   17371    43db drivers/ata/libata-eh.o
after:
  16607      18       0   16625    40f1 drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 04275f4c8d36..8dc33b6832f0 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3443,7 +3443,8 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	int rc;
 
 	/* if the link or host doesn't do LPM, noop */
-	if ((link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
+	if (!IS_ENABLED(CONFIG_SATA_HOST) ||
+	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
 		return 0;
 
 	/*
-- 
2.24.1

