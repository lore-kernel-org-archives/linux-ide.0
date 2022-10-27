Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB10C38A2D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 07:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiJ0Huf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiJ0Hue (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 03:50:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C443335C
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666857031; x=1698393031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNxYMlDfWto96RzGiMUC9zsWf2BTQGNX6a0n91C7eSY=;
  b=IlparAkmMVjukdGXIp2ty/ioLGq9CVegtbxU4i88fabPB5g8bPAwY4Em
   IlX7TOCY50dwFHxtNe6QNTTlrLzMNmC/EgrR3rbnm35M9SoA8p9Lbi0rx
   2aBKWDIJxbQEIowOWIc2beGya6ENmnbotaRCKCMCdce4dnpov1tJrojq3
   V+75ZPw0yBaXLdzSDupL9H+wRrtrVoKpp+SEtOYovddl0NzhK9uRoIOjk
   pF5cR5Ubh1qdbYs6bQg87y9EjFIizstDJEtKoHCsc4geVHmoRcj1wJ27d
   otfuM6qLEUtpzLY620PAPe4BmdsKmH6pg35KDhGxwseTOkYHRTcrdGwQK
   g==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="214853391"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 15:50:30 +0800
IronPort-SDR: Qzze7v6DcXQP3XN/S9qd16k/aMie8LXmov2aiGuzFFMFw9g0OBZkynY7dJEqX99yOrT4ogcQYd
 +8zpDvgF3PZX1DpH1eTF4mPWOYXY0hyLkFNfsYOsS0xp4lAR0xv1MvU6QBrH6CGG5F/8gtnK7X
 pUS3ap43+SA0GomUIMmwtGQ1WhRDbBbecSMH4SWdjcg+ByN1ZhHibwGsxP/aA1ujVfv5WoqS0U
 KUuqwNVG1C47+N+NSrnlSDvTNWDMHsHH+b8wHaK2cLlDczgCdgVk36xnx+RVWpQrVaQAxgQkKx
 Yi/6Fw+mWc4ae93hZ68h/aa4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 00:09:51 -0700
IronPort-SDR: Wed359sb7xzjA49Pi4AMC0RXM71+XxOtapW0atXXVz5AvhFHioiqNghVgOAYqfWAhkXBPC0SHa
 srInERTE+Tcqu7wo/+eMyzei7Ru1QHY1sryhyztQOpf6c607Y0JeFBpLpU/pKXsUGZRc2MXF/p
 xTLrfUWLqoGIMu7//YbSZ1Kx33183sBCQEu50Ciy1PvQ2OE3dN7IQpndMs4nL3EWoZqZpLA1Ya
 +JzmXxBhUk43Wq3Y9WfI0EjUJnQvEHeROQm8Z8CS8l08hENNfYXJCN+MNOT80piRIVV+rpj968
 l5M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 00:50:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MydBs70KKz1Rwrq
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 00:50:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666857029; x=1669449030; bh=DNxYMlDfWto96RzGiM
        UC9zsWf2BTQGNX6a0n91C7eSY=; b=TQWL/ZQDnJQHnhOjGYpEGTgS7EtSveSIH9
        SqiSGFNNmdEs+C0bjppLSZO6oZGVdhXyiYuX3B6Xc+1uIk6pWkhFgftRJAOKIga7
        BBFcVdBjEm7BPR8FlIi7SoYzx3yG0rNRRIGlxtL9Ea+3ek9xSqWz+BUhvW1dsGZw
        vm9w07N7g4Kw9XaxVvQ62k4EZSrAIoVTFcL9e2D/jaOizTXMq/LWYrhfJSO8T2el
        aD07iQ5yAcf0CBOLYmfPvYfsJfVqNm7o+AjPpNEdM7dy7lYcFSpxYYMhvxl5R58K
        mfQQkIPsKubEVF5s8I9r7uMrboa+k6biyRqurdeY/+3K1xxk+IVg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CxOuJtECUY3o for <linux-ide@vger.kernel.org>;
        Thu, 27 Oct 2022 00:50:29 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MydBr6Xblz1RvTp;
        Thu, 27 Oct 2022 00:50:28 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 1/6] ata: libata: Introduce ata_ncq_supported()
Date:   Thu, 27 Oct 2022 16:50:21 +0900
Message-Id: <20221027075026.240017-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Introduce the inline helper function ata_ncq_supported() to test if a
device supports NCQ commands. The function ata_ncq_enabled() is also
rewritten using this new helper function.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
2.37.3

