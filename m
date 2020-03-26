Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BDFC2D0E5
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D729E2073E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jwpzSn3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgCZP6p (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:58:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58903 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgCZP6o (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:44 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155841euoutp01ad130b69e2acfbcd8c7448e9d127799e~-5drQV7Ti2919829198euoutp01s
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155841euoutp01ad130b69e2acfbcd8c7448e9d127799e~-5drQV7Ti2919829198euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238321;
        bh=ajqcRmGgjpsYjH3cGplsl/xUyok6NtrwDjDeGTmLvlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwpzSn3DjXvzJlNu2pWweNrQqnmE+o49SjaeOov5eCxuM6y+ezliZTuHkI+dWyptA
         Kfv2ew+wwkaWZb+G6Q5Up9TUZLIEGsP5JxvdBFpSlyUhqas7uQaQv5BEC1sFJaV4g3
         aTpZ7S7gnSlNjfMc6AXTxp4pjfMts3lBrzgwCvIQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155841eucas1p1187a7dbf17e95f3cb15d32332ba6bf15~-5dq94qIy2821828218eucas1p1t;
        Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 80.F7.60698.131DC7E5; Thu, 26
        Mar 2020 15:58:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155841eucas1p1b9f0b5feb3d00618fc08d962abc709a9~-5dqsOJlB2822328223eucas1p1w;
        Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155841eusmtrp1156496914f103636034234c893a59c30~-5dqrp6Z-2091520915eusmtrp1D;
        Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-8a-5e7cd1314b34
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 59.CA.07950.131DC7E5; Thu, 26
        Mar 2020 15:58:41 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155840eusmtip188cdf36f63fe41840b4af2e2dbbdb053~-5dqS2gPZ1330613306eusmtip1R;
        Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 07/27] ata: optimize struct ata_force_param size
Date:   Thu, 26 Mar 2020 16:58:02 +0100
Message-Id: <20200326155822.19400-8-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87qGF2viDCZ1yVqsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErozTf7rZC/7zVMxd+pO5gXExVxcjJ4eE
        gInEqpnLGLsYuTiEBFYwSsw+9wbK+cIoMa31OytIlZDAZ0aJHTMUYTqaJm1lgShazijRt3ML
        C1zHm2+HGUGq2ASsJCa2rwKzRQQUJHp+r2QDKWIWeM8osWLSXhaQhLCAs8SMJS1gK1gEVCW2
        rTzBDGLzCthKTLu9mBFinbzE1m+fwGo4Bewklq+bD1UjKHFy5hOwOcxANc1bZzODLJAQWMYu
        8bDpBlMXIweQ4yKx7yUHxBxhiVfHt7BD2DISpyf3sEDUr2OU+NvxAqp5O6PE8sn/2CCqrCXu
        nPvFBjKIWUBTYv0ufYiwo8S9g19YIebzSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ
        27VzJTOE7SGxYtpmpgmMirOQfDMLyTezEPYuYGRexSieWlqcm55abJyXWq5XnJhbXJqXrpec
        n7uJEZiITv87/nUH474/SYcYBTgYlXh4G9pq4oRYE8uKK3MPMUpwMCuJ8D6NBArxpiRWVqUW
        5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAuMxuffDiEA/2mQLHOnw3
        HldTEV6XL1u+o035ldD5zSZt/6Wiz194dKPhe0rVKuFpfn7pV6vzDfQNtB7lpfLJm+hZS32r
        zn/Plvjd0ZqVkb14gg+Pnb6KVkbW0hvGLOvV9j7qaJe0/XVwsfSk6uqKE6d3ns5YE/G5SbBS
        7txTrZMe+49y3yhQYinOSDTUYi4qTgQAsgD3XkADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7qGF2viDJqbuCxW3+1ns9g4Yz2r
        xbNbe5ksVq4+ymRxbMcjJovLu+awWSx/spbZYm7rdHYHDo+ds+6ye1w+W+px6HAHo8fJ1m8s
        HrtvNrB59G1ZxejxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+
        nU1Kak5mWWqRvl2CXsbpP93sBf95KuYu/cncwLiYq4uRk0NCwESiadJWli5GLg4hgaWMEps7
        nzN3MXIAJWQkjq8vg6gRlvhzrYsNouYTo8SlFzOYQRJsAlYSE9tXMYLYIgIKEj2/V4IVMQt8
        ZZRYOqkbrEhYwFlixpIWVhCbRUBVYtvKE2BxXgFbiWm3FzNCbJCX2PrtE1gNp4CdxPJ188Fq
        hIBqFn/5wARRLyhxcuYTFhCbGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtc
        mpeul5yfu4kRGDHbjv3csoOx613wIUYBDkYlHl6Nlpo4IdbEsuLK3EOMEhzMSiK8TyOBQrwp
        iZVVqUX58UWlOanFhxhNgZ6YyCwlmpwPjOa8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Ykl
        qdmpqQWpRTB9TBycUg2M25sLamt/sEdP+lR4YmKi+5NZDZrPnItf3d/+O+7SxRkbJIJiJhzq
        uNsUzuDR/TXo7/5iphlruDhKkmYJsHsfe8Zy/LPEM8+JQX590uFh/5W/Zz912f3vyLELQk3h
        lbUOjx5IVy2W21TN7+vmcbbWnltHRdYvKF6Us3P+ActltjnL5zvWvjypxFKckWioxVxUnAgA
        D/f6UK4CAAA=
X-CMS-MailID: 20200326155841eucas1p1b9f0b5feb3d00618fc08d962abc709a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155841eucas1p1b9f0b5feb3d00618fc08d962abc709a9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155841eucas1p1b9f0b5feb3d00618fc08d962abc709a9
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155841eucas1p1b9f0b5feb3d00618fc08d962abc709a9@eucas1p1.samsung.com>
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
index 350fa584acde..236e4c55be48 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -174,6 +174,7 @@ enum {
 	ATA_DEV_NONE		= 11,	/* no device */
 
 	/* struct ata_link flags */
+	/* NOTE: struct ata_force_param currently stores lflags in u16 */
 	ATA_LFLAG_NO_HRST	= (1 << 1), /* avoid hardreset */
 	ATA_LFLAG_NO_SRST	= (1 << 2), /* avoid softreset */
 	ATA_LFLAG_ASSUME_ATA	= (1 << 3), /* assume ATA class */
-- 
2.24.1

