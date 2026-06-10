Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9613023393E;
	Wed, 10 Jun 2026 05:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069351; cv=none; b=ry/6GvonlMTzuRHZT8JNXEG8gXAY7QTElOe8NqcnSviY3W5Op3G+ht2VPidHJhsYeA1wbhPaHeCicUWowErOMd6Xh86dsyDfifYz6JzKvmm0+KMzClxK3XkUXpt5+x8/ne9rkF8YqAaU1MqA5NglsL/BX1sINMIV+6engMYlf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069351; c=relaxed/simple;
	bh=/fYK+z6hcVz/jfBxDLmRAWzVlsqKxE431O2KrUM+U/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgEysJV9ACY4vDIo1s7eN/aFoKwrW/W2e4lWDjh6AfniVD4k95+tx0JDT5A0SonXpSF2FuqfixPMAiBZcpx9rszm2CYgKw21Z/jk5c7M/ka4GFg1DOQQTUOPougOY+FFx/lfjvfRPW0Oj8ZI3yko0PuAe8KVgy5jW/KWtje5mAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ROXi9Xgw; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ROXi9Xgw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781069332;
	bh=UZx1rvuAxKvdMM2VWqpPoZjV9Y70UNLv8999OcpLA5Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ROXi9XgwvzCFk/BCfpZHRbkwlW7xmJs9utbgI+mju1mUaRVOQHE4egrrtwA0s2hm9
	 Ae0bmUY2Ch+sr09onvk+gZ93jHDsRKs3ouS77rRao04Byo1io9p1Om5cMaX1zv52vj
	 wsNiGeG/TBUvsytVRXTpAsJW1W8OETYNTjXS/H3k=
X-QQ-mid: esmtpgz15t1781069318tcd428808
X-QQ-Originating-IP: vLtlpk080OCEjYjNvJHYHoBHsUZiMgwiU1sSbLE7SK8=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Jun 2026 13:28:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1920330270598300247
EX-QQ-RecipientCnt: 5
From: raoxu <raoxu@uniontech.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH v2] ata: libata-pmp: add JMicron JMS562 quirk
Date: Wed, 10 Jun 2026 13:28:35 +0800
Message-ID: <71B4D0BBEC4F886F+20260610052835.1111181-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NQDSFSrlZSaigABYnT2wkiz7ewHDqOIiQozFdSmObqWCFsV44p6ZjcD+
	64/lBoilqXFNkRte9anA2t6MvHW7yjzH+4c6Uf2YhzR+JcsCD3LCYyYAO5hRog/8Bfb1or8
	QTWGgdiKOjMoYacVZVQshrebE1nPbLjrtqCccaTxP+NDsGPP7ise6JoYFEvQRb2DTZwtvZu
	sUrLXMLhKz3BnXeeXHhoKUgFtiJ8cFdBx4TtLw2SvTE1DewzWtRFYKHbC2qRkHUxhUA9TuD
	/aMPt3CRLEQCopJdKtUKrQj2NdnhwmK6h8YPsoN2fBZ+HGh5SFTbkQ2fHQyDgwJRRaNsd5w
	2DI5xM5QEBwU03iGfkO/Lokrj2fnwQsYeOOx1fD3YNH+091vBNTzhGZ/jNV1Mp4fgPf04WZ
	wdzzlffOyFwXBh7vV+2S+PQX7S2kt+BgXNmt2fI8C3EQRRqWaPBGrr1vHoip/Jjp5CefURz
	yLFKZtGls+vCXGhX5RTaHAOj54+uJfkqWGjntMsBqHsnIneAsfRDnL021iIHUh5hr4fuioH
	FOQcldHxMilLh5+f2FThvDOxevvmwpnAHZTOiojkHakCH6tqUKjVpOIDT5aDMPElvX0/o73
	FIJxFuec1JnyVWJsDnGxoLuEVb2e7Ie3ts3l3rD170DFsGDlJ2z5Vfru2xDlB7mcuPqsj3G
	sDoPNWemkaJIi3P/cgV1NDVj/tA8Jvihg7AraDcfiq/8VFToZcHEUiRpLaZqdokQN9BcXO+
	syUTYwOEGtUpgKxBaWdh3YVpoWb41TSNDq3D5ttwocHNUhUi2ThPvbCE7oNDYf52SiCgf6l
	lBimddz+FvjQEF9p4SclHKVIirruoB7dWFOPm0CLXv7bT8w3nJDLGfUk8wkkAeHEtYdi24U
	0MdIo8U4XqsQ3C/rCTInCaWHupvOJPMaR/cas2j/hjziZYNeaJHBLyuJZEuqKUbKi20krmB
	99mVKNBpx8tfrjHb+5IBuA+piqkEqIqf4ndZ/P34X0YV8KlyD8BBx+CJduqKfDo1CZ7UHqf
	xjL9Y7w7sAp+p/Unz10HOkmxRIoYgricfRcHqR2v102SKpyQxqBBlwBhiXd6wx1fYDaneAG
	c1r3AMIenApVb1mTDqEGRk=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
v2:
- Fix the subject prefix.  The previous submission was incorrectly
  sent as [PATCH 6/6], but this is a standalone patch.
- No code changes.

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

