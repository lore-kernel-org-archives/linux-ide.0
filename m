Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62C7C35DF9
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93664246AE
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DJQhmWJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgB0SXs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39752 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbgB0SWr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182246euoutp016596cceb039e6a665bab3a38fed64cbf~3VXebZsjN1058810588euoutp01E
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182246euoutp016596cceb039e6a665bab3a38fed64cbf~3VXebZsjN1058810588euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827766;
        bh=+riNWw6gpshC/ioWsjf1Ovv9SoPJ4AcmYMg2jMPB/3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJQhmWJDH+8gR0BjwdpDLfQ8xRFsWsCoXKe5EyiMabaHr/vR4UhhBr1/6Y7yZ2y26
         jc8S1vhxX2TZO+pVYYc8UILZg0ckMn41QSoutSnCp/ruDQFp20xYTxn1Eydq2nc3zj
         9/SxDPNfbs1aiUljvbbbVSMV1Dgq2C4NoC43qXrE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182245eucas1p2ae150f8238c840bf5edd800fa0ea36bb~3VXd0J2q23197531975eucas1p2F;
        Thu, 27 Feb 2020 18:22:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 84.5F.61286.5F8085E5; Thu, 27
        Feb 2020 18:22:45 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182245eucas1p219dee00956358ee0018caf2a07a8d602~3VXdVtLK83194731947eucas1p2H;
        Thu, 27 Feb 2020 18:22:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182245eusmtrp273d4e42df699c54570fef6468840ce95~3VXdVLAeC1813218132eusmtrp2p;
        Thu, 27 Feb 2020 18:22:45 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-63-5e5808f50e01
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 00.C1.08375.4F8085E5; Thu, 27
        Feb 2020 18:22:45 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182244eusmtip2551a63b0a3ac28649bb3857b666c5bce~3VXc4fAIE2149421494eusmtip2J;
        Thu, 27 Feb 2020 18:22:44 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 13/27] ata: add CONFIG_SATA_HOST=n version of
 ata_ncq_enabled()
Date:   Thu, 27 Feb 2020 19:22:12 +0100
Message-Id: <20200227182226.19188-14-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7OxtNjpvgh0bZukBBM7EfRw0pMFhQ0A+jq6uVB5XctB03
        NTJG4j0t7Ye10mmIl4luytR5I5i4eUErB6LmCkq0RpFtTjKbte1M8t/zPu/zfM/7wIcjAgM7
        As9Q5FBKhSxThPHQXuvG9DEPfll6fGg0kmx3PMbIrmcGNrm8MMwi29pHWaTV/IlF2gdeYmTL
        UgdC1hXVck7hkn6tgyOxT6kklpFSIBkvWkclg/MaTFJl0gOJu3vvBc5V3slUKjNDTSmjE2/y
        0sfqrGh2Iy9v0F3N1oBlTjng4pA4AdvLJtFywMMFRCuARkchYIY1AP843BgzuAG0/JrHti3a
        GW/Q0gJgReUOi6tziO1XYUQ8rC7RAz8OI6Lgo822wFMI8QPA1pph1L8QEsnQNvCT5ccocQjq
        vCuBq/hEIjSsmVEmbh/sWXcFHuX6+LmqPozRhMLx50sBDeLTFPa8QPwBkGjmwI6uiWC9JLgw
        /TCIhdBpMwXxHvi3X8diDJ0Aeku/BN19ALY83Qo2TYCL0799GPdFHIGGgWiGPg2n7GVsPw2J
        EDj3PZQ5IgTW9NYiDM2HpcUCRn0YGpuN2HZseX8bwmAJtI1Vok/Afu2OOtoddbT/cxsAogfh
        lIqWp1F0jILKFdMyOa1SpIlvZ8m7ge8bTW7ZXGbgmbllAQQORLv5DeZLUgFbpqbz5RYAcUQU
        xu/yXJQK+Kmy/HuUMuuGUpVJ0RYQiaOicH7sq68pAiJNlkPdoahsSrm9ZeHcCA0ISSj2qB20
        83zWOhc48OQNu3O2/A1fMFvitBKaMd3qRJO36cPb3EautXVX/Qo5+NG0lGgiSt6bq70WcdyZ
        ONuI9bMjlXNAF5XkfNeXnHNudfGa8eDZ6648JyIsiKXmvWL9N1W9sKJgM8MlTRFS4+r7eWbq
        yt0H1tcuEC9C6XRZzFFEScv+AX6H8r1CAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7pfOSLiDH74Wqy+289msXHGelaL
        Z7f2MlmsXH2UyeLYjkdMFpd3zWGzWP5kLbPF3Nbp7A4cHjtn3WX3uHy21OPQ4Q5Gj5Ot31g8
        dt9sYPPo27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
        m5TUnMyy1CJ9uwS9jBNzj7EULOSq2P15ImsD4zP2LkZODgkBE4lZl/6ydDFycQgJLGWUeNe3
        DsjhAErISBxfXwZRIyzx51oXG0TNJ0aJI8ePM4Mk2ASsJCa2r2IEsUUEFCR6fq8EK2IW+Moo
        sXRSN1iRsECQxPrTx1hBbBYBVYn5f5+DbeYVsJNY/2UHC8QGeYmt3z6B1XACxW/0bWcDsYUE
        bCW6Op4yQtQLSpyc+QSsnhmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqX
        rpecn7uJERgv24793LyD8dLG4EOMAhyMSjy8C3aExwmxJpYVV+YeYpTgYFYS4d34NTROiDcl
        sbIqtSg/vqg0J7X4EKMp0BMTmaVEk/OBsZxXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEk
        NTs1tSC1CKaPiYNTqoGRW/W3rQTrAtU1v5ekB6hdrmKynpE4SX1ZxNz3y1KmtW7giFm4sWTT
        58Z5G9plA72Kgi76PY2QERGSUjtff8v00zmvM1c7dzfuT5v0WasuZ1XP84MTytYoHXlwumfy
        fcuDomrtHX0LYic8V1PTiPRIj3iX+3DLrO0xlu4lavZcYUclFrWp/zilxFKckWioxVxUnAgA
        lKpQnq0CAAA=
X-CMS-MailID: 20200227182245eucas1p219dee00956358ee0018caf2a07a8d602
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182245eucas1p219dee00956358ee0018caf2a07a8d602
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182245eucas1p219dee00956358ee0018caf2a07a8d602
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182245eucas1p219dee00956358ee0018caf2a07a8d602@eucas1p2.samsung.com>
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
  21040     105     576   21721    54d9 drivers/ata/libata-scsi.o
  17405      18       0   17423    440f drivers/ata/libata-eh.o
after:
  37582     572      40   38194    9532 drivers/ata/libata-core.o
  20702     105     576   21383    5387 drivers/ata/libata-scsi.o
  17353      18       0   17371    43db drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 include/linux/libata.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6c4f4fe26edb..ce361b15559b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1632,6 +1632,8 @@ extern struct ata_device *ata_dev_next(struct ata_device *dev,
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

