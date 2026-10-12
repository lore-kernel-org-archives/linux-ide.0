Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926B8370AC1
	for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2026 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801563; cv=none; b=kQSIhdv+faonQX/W36nLsNPOkY8s0C0EL/qsmmakEZ1gmg6POLK09Qi6ykViVLNdVT6fEznDaMyfAmIViqj6JGi3hJRPcm0yoxfEa4A8QOjwg3bYYxfoZl0TEywcwVrEeKtG6fofrH0Kx7rC7tHFUZJU7/SNwPRNbgTuGKa/CvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801563; c=relaxed/simple;
	bh=ojKT/QnfNscPvrLemEPRe2TiO1GTCSEGjpeFjQMiWfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZtWIdzfyf6/Ja1kekP0A61D9G/xtrtOKRDodiq8ytb2h8gkW54Afr/4uLGBKXqcJ94abud8WB0WeSzlfCYU0o/fLrI9bRuaPxZGjv3Dw9l2OnREecfY7T9cnT9j78YahJm0h4yHqXf6wdIq3c6kaYm59NHCM8ugkgNGosqrq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6hXSl6F; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6hXSl6F"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso3695249a12.0
        for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2026 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791801559; x=1792406359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kk8s8KNUkXLkmYTO/LR9mTooGce9WPkeQ97sUNPT/bo=;
        b=O6hXSl6FCYHMkFDof93bUDOgPN03j+tWFem9NwBTp+1HilSOvDkOoLk3karwDxyEPQ
         ibnyzRL5MOKPKuz6ZeKp7F2NW9CisrDtf0KJq1aLlMWAasaN4eKUt9dOI3mlEPhy11We
         gMicWpoEcvv75Xy9rHGhhZdIzeix0CzMD5mJObCOzvqeQxfkFCgeKQE0xMq9TNapcC0S
         L3XVC+HCPHv6Er/PIQ5LXnSKwhDivZVR5uCeSFiajR8bwTOSToyGL4iBiWVGtV3aBGPe
         7H73fKX+0Vq6U2unvmmS8mWimuQnXHqQcQde95vAn2SKeQCvZa1ZZDqnn/I9ML5HYS16
         cXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791801559; x=1792406359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kk8s8KNUkXLkmYTO/LR9mTooGce9WPkeQ97sUNPT/bo=;
        b=X8S380gIU8BqRX+XTZi1CQnPxIEGlGHmTq0h+No8WTSpDdyLEICxOweroXwKbml5Q7
         BQYy+45t/Mwjl519JfOW5Qu5nR0Padwvarm+2NgBOwQSf9dDVv+LJhV4JKOnlqv0Isfc
         jjcZEspW/pA/osKZxB3TtrBZIS13QIhUmkCnwjpFcOcGoK1u1sEhsBLrnCmU6lqb1dwf
         CRtRjly5ha4LpjfyvhM+x4zEDwCZhkI6Kna6RqhuRvkRlmRos2ilNZ8IJusExrYMWbuq
         a5Q50BBJ1WNPKPb0kgo8wgK5uxtaODEtroRf53KX58ls0DG6OToujDbpX4UZv5cDU0b4
         GReA==
X-Gm-Message-State: AFq9FYIVOLoFJISEDF3XGr+CE3sbfsWFChHCY+fQDKi9ko+jGSWnB/Ov
	1Jt58AhWb0/G+t3a0wiSKaiwZrdipvFL8Y0hEWkwy4I2IWxOJlCRJGOYO8Xh/fVc
X-Gm-Gg: AYBFou3GwJZMCrLnECYQnyXoXxmfj7RPfMJYZqAps+8UaoMqPZqAY7AfEOTBpe6ar7b
	rU7cvGDMcelWXB6FD8vu/dktW9KWfaAqRPu3SAl53VJT1ML6h5dnS48Xqf7HNwIMsO4f8WtiNq3
	uHxNXXZLvqrh4fgbBNVnAjq6n3LH7eGkBF53NnPrfrhg6fxjxAR6JucYIf4xbZCIGS+blqJ3KY3
	jFyte6R/byImTV5qfLXg26qFViHFegjhAadxs4WuLBtbfBwVmC1e+2o+1PiPgWOvF9/MBSmZ409
	Kai4ulGcl4jZdUqrmvlphwwuwolRv0dCSmJfrIhtDFU5tkdKirgODoh1Ez219NqCQsCQnmskfOn
	eJ+6p00dDgnHEeqtSzaBJaiFouD/+W7UGpSHQXLVcGk8X1ey1bSYusg1lU6Qu8tzm5SsMqjucSh
	pv2XsDIoIWoRDDtU4o3OuLALRZAJNQ0dJ9AsJ4miyPa5vlIRpUxJ7Ftxq7fc9AqcbmIsb6W9V1s
	o5VtLPtgQtwhJYPQrkiOV/GsfQ=
X-Received: by 2002:a05:6402:a589:20b0:6af:9a8e:56e2 with SMTP id 4fb4d7f45d1cf-6b17ae98ee9mr5814460a12.8.1791801559018;
        Mon, 12 Oct 2026 03:39:19 -0700 (PDT)
Received: from localhost.localdomain (luna.k.pl. [193.239.59.185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179e03428sm4662612a12.37.2026.10.12.03.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:39:18 -0700 (PDT)
From: Kyrylo Biryuk <illofspeed@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] ata: libahci: re-enable FBS after error handling on a port multiplier
Date: Mon, 12 Oct 2026 12:39:17 +0200
Message-ID: <20261012103917.389-1-illofspeed@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ahci_do_softreset() disables FBS before resetting a device behind a port
multiplier, as required by AHCI 1.2 section 9.3.9, and re-enables it only
when that softreset succeeds. If it fails, for example because a
hot-plugged drive is still spinning up ("softreset failed (device not
ready)"), EH escalates to a hardreset of the PMP link, and nothing turns
FBS back on: only ahci_pmp_attach() does, which runs at the next boot.
The port keeps working with command-based switching until then.

Seen on a Marvell 88SE9235 (1b4b:9235) with Marvell 88SM9705 port
multipliers (1b4b:9705, in a Synology DX1222 expansion unit): after
hot-plugging a drive, the kernel logged "FBS is disabled" followed by
"softreset failed (device not ready)" and a PMP hardreset, and never
"FBS is enabled" again (twice, on two different ports).

At the end of ahci_error_handler(), re-enable FBS if a PMP is still
attached and FBS is supported but disabled.

Fixes: 89dafa20f3da ("ahci: disabled FBS prior to issuing software reset")
Assisted-by: LLM
Signed-off-by: Kyrylo Biryuk <illofspeed@gmail.com>
---

Notes:
    Changes in v4 (Niklas Cassel):
    - dropped the ata_port_info() print; ahci_enable_fbs() already logs
      "FBS is enabled"
    - moved the testing details out of the commit message
    Changes in v3: author name only. Changes in v2: author address only.
    
    Tested with the patch built as an out-of-tree libahci module for 7.2.6
    (the stock ahci module binds to it, symbol CRCs unchanged) on the
    88SE9235 + 88SM9705 setup from the commit message, which is passed
    through (VFIO) to a KVM guest. Hot-plugging a drive into a free port of
    the multiplier logged "FBS is disabled", "softreset failed (device not
    ready)" and a PMP hardreset, then "FBS is enabled" from
    ahci_enable_fbs(). Afterwards two other drives behind the same
    multiplier read 259 + 259 MB/s in parallel (O_DIRECT, 4 MiB blocks),
    against 268 MB/s for one drive alone, so their commands overlap again.
    The two earlier occurrences without the patch were on ata8 and ata10 of
    the same controller; this test was on ata7.

 drivers/ata/libahci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 08ab56e9556..5441fbf543c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2233,6 +2233,21 @@ void ahci_error_handler(struct ata_port *ap)
 
 	sata_pmp_error_handler(ap);
 
+	/*
+	 * ahci_do_softreset() turns FBS off before resetting a fan-out link
+	 * and turns it back on only if that reset succeeds. When it fails
+	 * (e.g. a hot-plugged drive is still spinning up), EH escalates to a
+	 * PMP hardreset, which never re-enables FBS, so the port would keep
+	 * command-based switching until the PMP is attached again (reboot).
+	 * Restore FBS once recovery is done and the PMP is still attached.
+	 */
+	if (sata_pmp_attached(ap) && ata_dev_enabled(ap->link.device)) {
+		struct ahci_port_priv *pp = ap->private_data;
+
+		if (pp->fbs_supported && !pp->fbs_enabled)
+			ahci_enable_fbs(ap);
+	}
+
 	if (!ata_dev_enabled(ap->link.device))
 		hpriv->stop_engine(ap);
 }
-- 
2.43.0

