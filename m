Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6262AC4321E
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 05:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiKHFzx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 00:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiKHFzv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 00:55:51 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A59A2F66F
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667886951; x=1699422951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FRMf2u660Bw8sHzkZ7hdCZ58aBmYZ5UfbTABJ8LEdQ0=;
  b=P3Yf58Q3lEZVOVj1mpN3UEaSTr8L6as305WTleCRsBbxicnY/b23veNP
   QpnC5Qp2wnpyzE8/2BJqWSHqrS0bcItnfJQDgfTsGxm7hoeF4kRlFJM/J
   6YIFp+eZvQs89FKvmbDIVPDIQLcj39/ICpoCcistmWcbnR3AIINzHoK5Z
   sJpGSirbBavWJeKmEDo5hUjkx1zQnohGAJM1btXP+wIIUWrP3tcsw9/A5
   mwQkuiA/eOHnqFJxMAY9LINdm+0ELFQfhFJSkDgQ7SwF/aiASXNOIvXcU
   Pzov15jAX8gfp269IdiaXI4mczhd673oT5H0B7n5luFadkYryi+zSgEam
   A==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="320067447"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 13:55:51 +0800
IronPort-SDR: g3unc3Qadl84dH92q9bStnsGHV2yiTdNSHKpLcQBbBE15GFNEPGP4NwmSXO3KSAa6/HtcRxs9M
 MEQVsMtumgHb07wvIv25jPt2EFCSCh58f6cIzj5LSr/9QODHyAcbHffZsxXthb0+rSeLfDgNe7
 ldyNmg7SOKNqUAWzc37OgNR7ApX5i3+4KIfXKREVsyB5bI34UMb3FJhGydJ1vNG4qIBrWetSJP
 hBLNSd0yDZlGfWJ+krByX/XHfEmCVkRI9ylL9p2txZBkxvzgq08rzfRCVNZNi+yur4PQ4Mc6tE
 XOk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:09:12 -0800
IronPort-SDR: Z7w9JqwZplNWQetF/80uVrUynpvHF/ZOeF01f0UsEvVMFtgFizZBJwLBLKlYo8+Tg1DtVufwfA
 0eziRPLK8D2tBU3htgeOgPCFG0zb91grT02pKxPzMxFY5/BSLRhOu4AzUyQRHg3UBQyI6wOVIc
 bSX1x8L+VxuUFKM4YBlj7XXtOv6Onth9j4KdrSKeD398+sgD5oXa5STMwJCuY0SUwhx87SZVeN
 Q6DV3HHw08AHpFct7YtlEX7jQYiF8LVFuzP1wiirFqI+s27m01Hw8GUmkNk9fXoh6X8HpaWiZl
 uPM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:55:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5y524BTLz1RwtC
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:55:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667886950; x=1670478951; bh=FRMf2u660Bw8sHzkZ7
        hdCZ58aBmYZ5UfbTABJ8LEdQ0=; b=iExdd4xjzzNpE78qmauCzrFzlGq14NfenC
        cQucrxFKK3ZzIy2MBnNhZytHT4RI/uN3UYcwhFcXu9UwhjC8y5QQKBRVL6fNCaop
        a5BIaDanK6jHBAEeztExfpGBz/b8E5gFPTp0LVY/XtvUJF7BB2IO3UNsMwNNYLur
        tBCktXqCeuw2KWyR24W4rEzVBctLxkKkjkyEcQocteypOUs1rWngXXuD3kC27YEf
        9ooleb6VlO7gK/sT8zssaVrM6ebuBcQoJcdC+k5m7/wdAoJnGV4LjyDRr3HoLFXk
        IZ6IN/2AUUXaaQJWgje0l38y/36N17Pzw4Rcf3EoOfqKlF8UgySA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sHdOlLjQMoev for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 21:55:50 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5y510lr5z1RvLy;
        Mon,  7 Nov 2022 21:55:48 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 2/7] ata: libata: Introduce ata_ncq_supported()
Date:   Tue,  8 Nov 2022 14:55:39 +0900
Message-Id: <20221108055544.1481583-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Introduce the inline helper function ata_ncq_supported() to test if a
device supports NCQ commands. The function ata_ncq_enabled() is also
rewritten using this new helper function.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/libata.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index af4953b95f76..58651f565b36 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1690,21 +1690,35 @@ extern struct ata_device *ata_dev_next(struct ata=
_device *dev,
 	     (dev) =3D ata_dev_next((dev), (link), ATA_DITER_##mode))
=20
 /**
- *	ata_ncq_enabled - Test whether NCQ is enabled
- *	@dev: ATA device to test for
+ *	ata_ncq_supported - Test whether NCQ is supported
+ *	@dev: ATA device to test
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  *
  *	RETURNS:
- *	1 if NCQ is enabled for @dev, 0 otherwise.
+ *	true if @dev supports NCQ, false otherwise.
  */
-static inline int ata_ncq_enabled(struct ata_device *dev)
+static inline bool ata_ncq_supported(struct ata_device *dev)
 {
 	if (!IS_ENABLED(CONFIG_SATA_HOST))
 		return 0;
-	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
-			      ATA_DFLAG_NCQ)) =3D=3D ATA_DFLAG_NCQ;
+	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ)) =3D=3D ATA_DFLAG_=
NCQ;
+}
+
+/**
+ *	ata_ncq_enabled - Test whether NCQ is enabled
+ *	@dev: ATA device to test
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	true if NCQ is enabled for @dev, false otherwise.
+ */
+static inline bool ata_ncq_enabled(struct ata_device *dev)
+{
+	return ata_ncq_supported(dev) && !(dev->flags & ATA_DFLAG_NCQ_OFF);
 }
=20
 static inline bool ata_fpdma_dsm_supported(struct ata_device *dev)
--=20
2.38.1

