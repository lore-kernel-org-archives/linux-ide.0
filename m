Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB6C11D3D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D3F246A6
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z9ymWR9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgB0SYX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:24:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39715 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbgB0SWo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182243euoutp01228fcdd5c5164c0dfb2d76e50ddcc55a~3VXba_LHL1369313693euoutp01P
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182243euoutp01228fcdd5c5164c0dfb2d76e50ddcc55a~3VXba_LHL1369313693euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827763;
        bh=hw7yWEtngGsf1GND9qtwEFtzy5ehaWqDsy40s9VOM9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9ymWR9/E+3IJvu0Evnc+Q9sPtBz1qfmrzYC5ZjHpKPZzz9NstSA0+m+x5fE84MSJ
         twx+6dBCTLMarNbIc89uqWZ6mIUARZR99+ShG7cjjObAqsjigyhamBgSr3XLbpiyEE
         +kq+wg9gkcsL3zWQX1lVyeYsTgRa8drJLVsjU080=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182242eucas1p1ff4692e0d59d52547b9ccb69f47bf9ba~3VXbNQ6ux1933419334eucas1p1s;
        Thu, 27 Feb 2020 18:22:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 63.5F.61286.2F8085E5; Thu, 27
        Feb 2020 18:22:42 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182242eucas1p16f2af7ee2771f11f21f35c7f80636723~3VXapI1ci0494604946eucas1p1F;
        Thu, 27 Feb 2020 18:22:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182242eusmtrp163faba525ed7b263b3f1c5fe2c8c46c5~3VXaoe3xY0185901859eusmtrp1f;
        Thu, 27 Feb 2020 18:22:42 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-5f-5e5808f23e4c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E2.61.07950.2F8085E5; Thu, 27
        Feb 2020 18:22:42 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182241eusmtip24ab2d24f498bf53929072b0779bd3d28~3VXaHpNT52149421494eusmtip2H;
        Thu, 27 Feb 2020 18:22:41 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 07/27] ata: optimize struct ata_force_param size
Date:   Thu, 27 Feb 2020 19:22:06 +0100
Message-Id: <20200227182226.19188-8-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7qfOCLiDKbt0bJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnv7u5kKfjPU/G98TlrA+Niri5GTg4J
        AROJpjNrmboYuTiEBFYwSty+3AzlfGGUeH94JjuE85lRYt2zvawwLQtPboWqWs4o8fRyNwtI
        Aqzl7GQtEJtNwEpiYvsqRhBbREBBouf3SjaQBmaB94wSKybtBWsQFnCWeNXyHGwqi4CqxIZ/
        Z8AaeAVsJY52PWeC2CYvsfXbJ7AaTgE7iRt929kgagQlTs58AjaHGaimeetsZpAFEgKr2CUW
        t+9khGh2kfg6sxFqkLDEq+Nb2CFsGYnTk3tYIBrWMUr87XgB1b2dUWL55H9sEFXWEnfO/QKy
        OYBWaEqs36UPYkoIOEqseqkGYfJJ3HgrCHEDn8SkbdOZIcK8Eh1tQhAz1CQ2LNvABrO1a+dK
        ZgjbQ+Ly3ItMExgVZyH5ZhaSb2YhrF3AyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMj
        MBGd/nf80w7Gr5eSDjEKcDAq8fAu2BEeJ8SaWFZcmXuIUYKDWUmEd+PX0Dgh3pTEyqrUovz4
        otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbBZJk4OKUaGHdmnXXjuNEp+WQhU3vCKTfu
        9Sei+WdZ8ZXPnbv31L+Y9r6J0303HZGWVz1+YBPDlESezMl9n2qCrv15IMAo9WR9/aqPD/6s
        35pxXurHV7F9iZuzHm/la4iRfPItO9o0VzMpuZHtg+fCbRln1LRVs18KJXTyVvWZrIua+cFi
        6v9VS0x5w3QvvVJiKc5INNRiLipOBACds3B0QAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7qfOCLiDPa1slisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYx3d3eyFPznqfje+Jy1gXExVxcjJ4eEgInEwpNbmboYuTiEBJYySnx5
        cJOti5EDKCEjcXx9GUSNsMSfa11sEDWfGCWmX7rLApJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndzCAJYQFniVctz1lBbBYBVYkN/86ANfAK2Eoc7XrOBLFBXmLrt09gNZwCdhI3+raz
        gdhCQDVdHU+h6gUlTs58AraYGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtc
        mpeul5yfu4kRGDHbjv3csoOx613wIUYBDkYlHl6PbeFxQqyJZcWVuYcYJTiYlUR4N34NjRPi
        TUmsrEotyo8vKs1JLT7EaAr0xERmKdHkfGA055XEG5oamltYGpobmxubWSiJ83YIHIwREkhP
        LEnNTk0tSC2C6WPi4JRqYGz7+zraSTP2qe21wH+P+vI7J/3K2WH7pLyjP+DFvMsMvXPmWgol
        N24xiQhhZzT/nH4rI2R+cKbJpqnX90yaOld6kb/C9Eutj9h+zVY6FPhMf/ZqQTbVyT0TK+8t
        enrcdD6zalTAroTjLK2PBWZXfL70WZ9Pd0FmQ8Jum6prX9yddonunfftnY8SS3FGoqEWc1Fx
        IgCDEm5GrgIAAA==
X-CMS-MailID: 20200227182242eucas1p16f2af7ee2771f11f21f35c7f80636723
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182242eucas1p16f2af7ee2771f11f21f35c7f80636723
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182242eucas1p16f2af7ee2771f11f21f35c7f80636723
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182242eucas1p16f2af7ee2771f11f21f35c7f80636723@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Optimize struct ata_force_param size by:
- using u8 for cbl and spd_limit fields
- using u16 for lflags field

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  41064     573      40   41677    a2cd drivers/ata/libata-core.o
after:
  40654     573      40   41267    a133 drivers/ata/libata-core.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 6 +++---
 include/linux/libata.h    | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a9a8762448aa..a835d2bf243e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -90,12 +90,12 @@ atomic_t ata_print_id = ATOMIC_INIT(0);
 
 struct ata_force_param {
 	const char	*name;
-	unsigned int	cbl;
-	int		spd_limit;
+	u8		cbl;
+	u8		spd_limit;
 	unsigned long	xfer_mask;
 	unsigned int	horkage_on;
 	unsigned int	horkage_off;
-	unsigned int	lflags;
+	u16		lflags;
 };
 
 struct ata_force_ent {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index df8f20a2a305..df7c1b538bb1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -176,6 +176,7 @@ enum {
 	ATA_DEV_NONE		= 11,	/* no device */
 
 	/* struct ata_link flags */
+	/* NOTE: struct ata_force_param currently stores lflags in u16 */
 	ATA_LFLAG_NO_HRST	= (1 << 1), /* avoid hardreset */
 	ATA_LFLAG_NO_SRST	= (1 << 2), /* avoid softreset */
 	ATA_LFLAG_ASSUME_ATA	= (1 << 3), /* assume ATA class */
-- 
2.24.1

