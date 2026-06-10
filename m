Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F92F5A13;
	Wed, 10 Jun 2026 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068332; cv=none; b=b95MPOZBWwtMCLHk6wY0eCyIs5RabranIgHUudfFduUaqaRShplUVeTtbcBNSV9jsxfi4gQznBNfAcVOHfGff2FZfFLd4SA3jtARwoJgQiqhb4RV/YKdNsRxoVANrcbMwW00noQcKATdrnyh5jywazH49V5XI3wA5NGt3i1wWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068332; c=relaxed/simple;
	bh=+ZoP16UtvNVV6/LTGr/Ma7qqJAFWBG9Fu5AeebIdX7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+Vtls8eLujUAHTdqsipcEdn88ChoNAmjy8LkNYmqH9hdOhie2cLaqBHSYzf1KWLHMJUgNlOsLCNSRSv6t+FuX5Y408YS4mF4MaPgTTF0vjnPp3akHt+KGdbzToWjX+SmEeIVfoTbmtk+AgWAlDlVfKr5VU2yl6y5IddXLTAJE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EvZitCL2; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EvZitCL2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781068313;
	bh=aI3Ndi9N0AI/fwt+UIsD+wqfvNcfKxj9RwDL5RadIAI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EvZitCL2tAA8mxicT9Mh6p5XT3IvygxDR+T2sxK5cyr+NUti0W8pzaBQcX8X49XYq
	 6WYYFGkvUsLCXsQDsIhEcdC7fgaX1iFc+J1BaHjw9SVr8o8Y91ufFqm/SCANTq2jOv
	 y+m2Kk4Q52RuXGMaOZK/cN+wOAxfQAQPTxX8vMAI=
X-QQ-mid: zesmtpgz6t1781068298t6c664778
X-QQ-Originating-IP: N1rqHAEPmmF6qGXwOZqpYjlCdmTrWzMPwS/5VgO+Px8=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Jun 2026 13:11:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6298518070286857576
EX-QQ-RecipientCnt: 5
From: raoxu <raoxu@uniontech.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH 6/6] ata: libata-pmp: add JMicron JMS562 quirk
Date: Wed, 10 Jun 2026 13:11:35 +0800
Message-ID: <36778346B9606639+20260610051135.1090861-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mutteg8H72qDY5sd/jtmOx77E4KGSF3AHy7vxA14+AgENsleI9LXLW2m
	2h1EN4e0QvYkiIzMq0MdruckA4phyuUrHUPJIaRfncJLJKdTn/NA9NgfF/ZIwXEP3o9WNXG
	OU92KpldS5O23h1E9l2IN5GB9LdNNtAEa5V3ELBzxJxTgSWaa/5M46xjYFGtpSsuiccj2sK
	98CRT617i2rayTNtzV9j0+Obg5rzCnetuKXv+9VLcCd7apVOqMQKwie+JfwRHdsVi5ufvtl
	Lz3H0tR+6JLGu0AD8jHJAZLDSCFXK0Su1ttzZwrsEI8l+IaitFQMzaz90F6KzVUwrCkbn0o
	f8njJwAjezutEwQqoIbJIB0K2BlnIQojHKq2fNPoWVshtUUnOFW+iwUSd68+88aG2NBunc3
	QkgMMGFIt0PkynE3TiKS+UFUHpVW8xkm6FiFnkEvGm4XCTnSvKR/ii2Igqcif1G7fZuBtnC
	Vj/2naO8dpi3S8p60ns2M4oCEQkVHLpZqeFyoC1Pxt7TUKwApByAlegEmG7fmzpwtiBVVGP
	hYqu0CfeRQlLw9E6jhhZOO0pUrcm7+y4ufAazg8RROFFpT3BWWTq5Yx0kZK8iE7Hi/6gG2u
	SBBxJBcR2RbDda6iwXiANO1TwntqSQgIw2wf4PsznexDWW2IRzWKiz5+QiaU0xN8Lk+Dkgy
	T6diWQ99FwlA4gS3qxsInTyCmeeqPBDaAx5lHJyV0OqLboyWTjbc3PKinV6WYEzYE6nm30R
	uRCppbVxTI5FUlQYf6wVYCdqdH9ZUfrX25YgDwLhXbhvKk5wXlyJuOe33NvDxYenzNIUfxo
	lHyrhewtoX8JMSViu8KggKbl/rUUUWzBtAup8DLKfHxHS07yyuo/vPz12rJ8Bhdz6OcYA0m
	Va9NpAFjjwbUY4wXtLlv7EQ3Gt2pUu1HTCQAcy0ZowY84CeT5lejfsYpWADz65hxMatK7Zi
	GPZIlX9mlnxlP1MK0vUilVTY1BD0i0k/SaSA3ITsvEPkantLTRp2jOkpkrlUtuTtxM/xKWE
	rtA61qg4H2E5Aj13YUkx5t3BOIMgfUIgW11mESqg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

JMicron JMS562, as used in QNAP QDA-A2AR RAID1 adapters, may
keep the exported ATA device not ready while the array is rebuilding.

In this state, libata may repeatedly try to softreset and classify
the fan-out link.  On the affected adapter, this can time out, make
PMP/SCR access fail, and eventually disable the fan-out link before
the RAID volume is exported.

A failing boot shows the fan-out link failing SRST, PMP access
timing out, SCR read failing, and the link being disabled:

  ata4.00: softreset failed (device not ready)
  ata4.15: qc timeout after 3000 msecs (cmd 0xe4)
  ata4.00: failed to read SCR 0 (Emask=0x4)
  ata4.00: failed to recover link after 3 tries, disabling

After that, the root filesystem on the exported RAID volume cannot
be found.

Add JMS562 to the existing JMicron PMP quirk that disables LPM,
avoids softreset on fan-out links, and assumes an ATA device.  This
prevents libata from dropping the exported RAID volume during rebuild
recovery.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/ata/libata-pmp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index e3adc008fed1..f4103438ac7d 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -446,8 +446,13 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |= ATA_LFLAG_NO_RETRY;
-	} else if (vendor == 0x197b && (devid == 0x2352 || devid == 0x0325)) {
+	} else if (vendor == 0x197b &&
+		   (devid == 0x0562 || devid == 0x2352 || devid == 0x0325)) {
 		/*
+		 * 0x0562: JMicron JMS562, as used in QNAP QDA-A2AR RAID1
+		 *         adapters.  The exported device may stay not ready
+		 *         while the array is rebuilding, and SRST/classify can
+		 *         time out before the RAID volume is exported.
 		 * 0x2352: found in Thermaltake BlackX Duet, jmicron JMB350?
 		 * 0x0325: jmicron JMB394.
 		 */
-- 
2.50.1

