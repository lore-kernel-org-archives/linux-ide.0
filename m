Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC7C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  8 Feb 2022 06:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347704AbiBHGqK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Feb 2022 01:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiBHGqJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2022 01:46:09 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07492C0401EF
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 22:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644302765; x=1675838765;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rJGVm7SxByO0hYyrFlA5OoRBekUIz5jTYQl12AVf8Bg=;
  b=WB6cHvbZ3+dQEn+2ooTSqrR14PrRb4GuPPpCaWRnj7fEqfpOCg+GlEuK
   gnADhQuU/K8iqgLaAqzlC2iPULuaMnujeGJN1/CdsS3XyhhHG6H3MLBja
   fDKra6NrGWAnwBShXN+FDqaKGHovMntto0eooKG7u31OH6mh4eeOSBxOc
   eFH9cIQDCFEOR+/U5W0+n0bvuj7bLPV73SQTPPRR9BXn9aGpMakuXImaW
   ZzeHw5hc9QqPC77yFetIbwDRX91HcDAa/uQ+B5+Qvb8lzRQaMf8FOkpM1
   QTVEIW/0B6UAl8DO1CBzNgqEnhGh7RE8RY0lTgvYMunVXy7s14rYHChMu
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,352,1635177600"; 
   d="scan'208";a="197210232"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2022 14:46:05 +0800
IronPort-SDR: fyT4amJMbsRMv6cR4UoS8BUFuOLzJWUcaK+u5RnfihhVJ2sxT7/5P2rP/iy8mCj1yRZZgAEbra
 wb0BaN5+xx9vXeLrSFR0obN7Rt1JHrExD/mN9THEFG0YxwyPrNecMJuk8dPmIMHy5YdsWA24eX
 y7Jjow701rbf4EtrGyyJwwnVeTy5FaoytD+d3y5wQXNkWH2b5OTJ28rDIWHwRzaq3ALt6boSY+
 B9AFn4q3eC3K/MM7KKj4FBPhH0tlq8JmrHQHJZre5XKbPLAdM5Ay60f7HJsO/KhnDkV9EUq8QF
 HRQom3CvlA+mBLCoHbJzhKgK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:17:56 -0800
IronPort-SDR: B92IYT754cp+FBuUbwL8rBQihJ6RXhQNt9RdXz9y0gjSKdat6jRYzDRn5xHA1+8Q80/KmDB5ZL
 WgzUagJlvB8kcbRaoTzgcaKrqj+5hr1JWt9Nqs2Tv9CxWpqIbUZwRM1wm+T2vOrwAzYyWJeBjz
 j8XBLl1ZO6MyiBXQdqaaGMvTWr/qn5Ux0jz1E7pwT7OBlE5NSSp/sxDtTl9Y0hCsWv5mDwOndX
 F5StC3ofWY/A1gqZxceysvKhnabPhS36pKlUmsGoXIVxx5u1/5+pn4th9HlJ2hrGbsUPOwBhTi
 AKk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:46:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JtD720Rj0z1SHwl
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 22:46:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1644302765;
         x=1646894766; bh=rJGVm7SxByO0hYyrFlA5OoRBekUIz5jTYQl12AVf8Bg=; b=
        FHuq79vD0/KFd0II3hNIIdtv08XjWDkeVikRoCgSjKrLEPyx26Cy0Yccqezd9MNC
        RujSCBsYpfW9aBHXhMk79mVxfhh0bUd6kbIsJQUWOMLL1RLt98QYitNrDJ8Bwa5J
        0MvYd1MPYDxdU1I6JPSCcJfALf+otgxMbisbDETew6ZFqooUTlfXCua+iaadPQKp
        +lqiWiC2PgNYuKZyu+HH0uR7whgmRZnAyEB4ERhmXtYKU1CwRqaOOZvxDVdhNOV+
        i/7DPDtgZEIwyZZPFaI6rhaRsno7RUNTF3ysbq4xVTBu4DxCHp7FeNuFadx0mjaG
        WOEHIa5b9TnMI55l+77B+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3xTh9JIOYc9X for <linux-ide@vger.kernel.org>;
        Mon,  7 Feb 2022 22:46:05 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JtD705hWbz1Rwrw;
        Mon,  7 Feb 2022 22:46:04 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-ide@vger.kernel.org
Subject: [PATCH] ata: sata_fsl: fix sscanf() and sysfs_emit() format strings
Date:   Tue,  8 Feb 2022 15:46:01 +0900
Message-Id: <20220208064601.237582-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use the %u format for unsigned int parameters handling with sscanf() and
sysfs_emit() to avoid compilation warnings. In
fsl_sata_rx_watermark_store(), the call to sscanf() to parse a single
argument is replaced with a call to kstrtouint().

While at it, also replace the printk(KERN_ERR) calls with dev_err()
calls and fix blank lines in fsl_sata_rx_watermark_store().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/sata_fsl.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index da0152116d9f..556034a15430 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -322,7 +322,7 @@ static void fsl_sata_set_irq_coalescing(struct ata_ho=
st *host,
 static ssize_t fsl_sata_intr_coalescing_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d	%d\n",
+	return sysfs_emit(buf, "%u	%u\n",
 			intr_coalescing_count, intr_coalescing_ticks);
 }
=20
@@ -332,10 +332,8 @@ static ssize_t fsl_sata_intr_coalescing_store(struct=
 device *dev,
 {
 	unsigned int coalescing_count,	coalescing_ticks;
=20
-	if (sscanf(buf, "%d%d",
-				&coalescing_count,
-				&coalescing_ticks) !=3D 2) {
-		printk(KERN_ERR "fsl-sata: wrong parameter format.\n");
+	if (sscanf(buf, "%u%u", &coalescing_count, &coalescing_ticks) !=3D 2) {
+		dev_err(dev, "fsl-sata: wrong parameter format.\n");
 		return -EINVAL;
 	}
=20
@@ -359,7 +357,7 @@ static ssize_t fsl_sata_rx_watermark_show(struct devi=
ce *dev,
 	rx_watermark &=3D 0x1f;
 	spin_unlock_irqrestore(&host->lock, flags);
=20
-	return sysfs_emit(buf, "%d\n", rx_watermark);
+	return sysfs_emit(buf, "%u\n", rx_watermark);
 }
=20
 static ssize_t fsl_sata_rx_watermark_store(struct device *dev,
@@ -373,8 +371,8 @@ static ssize_t fsl_sata_rx_watermark_store(struct dev=
ice *dev,
 	void __iomem *csr_base =3D host_priv->csr_base;
 	u32 temp;
=20
-	if (sscanf(buf, "%d", &rx_watermark) !=3D 1) {
-		printk(KERN_ERR "fsl-sata: wrong parameter format.\n");
+	if (kstrtouint(buf, 10, &rx_watermark) < 0) {
+		dev_err(dev, "fsl-sata: wrong parameter format.\n");
 		return -EINVAL;
 	}
=20
@@ -382,8 +380,8 @@ static ssize_t fsl_sata_rx_watermark_store(struct dev=
ice *dev,
 	temp =3D ioread32(csr_base + TRANSCFG);
 	temp &=3D 0xffffffe0;
 	iowrite32(temp | rx_watermark, csr_base + TRANSCFG);
-
 	spin_unlock_irqrestore(&host->lock, flags);
+
 	return strlen(buf);
 }
=20
--=20
2.34.1

