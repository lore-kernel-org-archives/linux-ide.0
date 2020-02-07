Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B8AC2BA83
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710CF214AF
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oLT8OMHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBGO3E (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:29:04 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49631 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgBGO17 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142757euoutp028de215dd1fe0e395ee895a97a598ff8f~xJQwUlpnZ2687426874euoutp02J
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142757euoutp028de215dd1fe0e395ee895a97a598ff8f~xJQwUlpnZ2687426874euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085678;
        bh=PEO31yx7eUSVLqVUS2Knd66nYp/QH1hYbw4VdD8ATDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLT8OMHTgkfVUZC4roQAGkQiA3tGE4GYHi1s1azYDvA+DK9nVWAFuW2IGus6hS7Ai
         JsOvHLNMEjfTLX0Ii9UFn59cWAcw/aBz10PDrYOXyqhJ3bTIYoJUQzCATK70CtC63a
         IcZ+yKOR0imgoTlrttJQbtf4ZWQ/RE0HrbRt9sQw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142757eucas1p16a4d9a1bed65d8b069e4b1344a539f8b~xJQv-j1191683816838eucas1p1W;
        Fri,  7 Feb 2020 14:27:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 60.D8.60698.DE37D3E5; Fri,  7
        Feb 2020 14:27:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142757eucas1p2a6a0f4dfb8cee5313e4a8b4b6214858f~xJQvfvgum2441324413eucas1p2X;
        Fri,  7 Feb 2020 14:27:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142757eusmtrp1ac7766d46e2775fd9390ff76ba2df4f8~xJQvfH1yi0480004800eusmtrp1K;
        Fri,  7 Feb 2020 14:27:57 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-c0-5e3d73ed3b12
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.89.08375.DE37D3E5; Fri,  7
        Feb 2020 14:27:57 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142756eusmtip2a2dc241a5144c5e3109e4d69079c860f~xJQvCUIHT3155831558eusmtip2F;
        Fri,  7 Feb 2020 14:27:56 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 12/26] ata: add CONFIG_SATA_HOST=n version of
 ata_ncq_enabled()
Date:   Fri,  7 Feb 2020 15:27:20 +0100
Message-Id: <20200207142734.8431-13-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7pvi23jDPZ9UbZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkdF+axFizkqlj6ZzNbA+ML9i5GTg4J
        AROJU3v7WboYuTiEBFYwShx6tIQNwvnCKNHx/hEbSJWQwGdGiWfvcmA6HjdcZYIoWs4oceP7
        W2a4jr7te1hAqtgErCQmtq9iBLFFBBQken6vBBvLLPCeUWLFpL1gRcICIRKLVxwASnBwsAio
        Snz7HAMS5hWwlWhq62SG2CYvsfXbJ1YQmxMo/nHKXzaIGkGJkzOfgI1hBqpp3job7AgJgVXs
        EpM/bIRqdpFY+G8nK4QtLPHq+Baop2UkTk/uYYFoWMco8bfjBVT3dkaJ5ZP/sUFUWUvcOfcL
        7DpmAU2J9bv0IcKOEvPu3AILSwjwSdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27Vz
        JdRpHhJdU14xT2BUnIXknVlI3pmFsHcBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2M
        wER0+t/xrzsY9/1JOsQowMGoxMOb4GgTJ8SaWFZcmXuIUYKDWUmEt0/VNk6INyWxsiq1KD++
        qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkGRnPrgn8BfTkqvDuPNzLP+BfZ
        llxkdup52ew5q+P3WyR1x1+1OXT+zU/HPY/+i8nJeurPbU2c1MRuxOz/wkvY4mLMzqpnplN9
        d82V3//xW4nDLvkNj0rzU8VFwmS1fTe+dzl4O/Wx3MJb7nJnX8ZxVz9m8po318JG7o7K+SSx
        2anSWwXTy3eGKrEUZyQaajEXFScCAJn4QddAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7pvi23jDD7+YLZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkdF+axFizkqlj6ZzNbA+ML9i5GTg4JAROJxw1XmboYuTiEBJYySnw6
        8YSti5EDKCEjcXx9GUSNsMSfa11sEDWfGCV62tcwgyTYBKwkJravYgSxRQQUJHp+rwQrYhb4
        yiixdFI3WJGwQJDE/iWnwYayCKhKfPscAxLmFbCVaGrrZIZYIC+x9dsnVhCbEyj+ccpfNhBb
        SMBG4vv7SewQ9YISJ2c+YQGxmYHqm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFhnrFibnF
        pXnpesn5uZsYgfGy7djPzTsYL20MPsQowMGoxMOb4GgTJ8SaWFZcmXuIUYKDWUmEt0/VNk6I
        NyWxsiq1KD++qDQntfgQoynQDxOZpUST84GxnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgdF301OeH/uuPG3pmX5oa8Izl+4NblY7XGZOeiGYv+Dl7t1vXu9+
        tmzfwVSR9pxGhhcN55fFN1TP++tgfe0Ps/mdbmPtVRJZd3LrGpwOO1fEH7FN061880H2Vv9p
        b09vNn4N6X1MWqztsy59W3qMi+uIKE9s6UvVEJb92Xpz1ELZghZt6Nz+9IsSS3FGoqEWc1Fx
        IgAiVN3trQIAAA==
X-CMS-MailID: 20200207142757eucas1p2a6a0f4dfb8cee5313e4a8b4b6214858f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142757eucas1p2a6a0f4dfb8cee5313e4a8b4b6214858f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142757eucas1p2a6a0f4dfb8cee5313e4a8b4b6214858f
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142757eucas1p2a6a0f4dfb8cee5313e4a8b4b6214858f@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When CONFIG_SATA_HOST=n there are no NCQ capable host drivers
built so it is safe to hardwire ata_ncq_enabled() to always
return zero.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  37820     572      40   38432    9620 drivers/ata/libata-core.o
  21040     105    4096   25241    6299 drivers/ata/libata-scsi.o
  17405      18       0   17423    440f drivers/ata/libata-eh.o
after:
  37582     572      40   38194    9532 drivers/ata/libata-core.o
  20702     105    4096   24903    6147 drivers/ata/libata-scsi.o
  17353      18       0   17371    43db drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 include/linux/libata.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0f208df6428e..e461664ee0b9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1631,6 +1631,8 @@ extern struct ata_device *ata_dev_next(struct ata_device *dev,
  */
 static inline int ata_ncq_enabled(struct ata_device *dev)
 {
+	if (!IS_ENABLED(CONFIG_SATA_HOST))
+		return 0;
 	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
 			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
 }
-- 
2.24.1

