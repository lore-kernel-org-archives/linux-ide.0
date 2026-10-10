Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A839281D;
	Sat, 10 Oct 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619152; cv=none; b=XjcA5lDO8Lb85OSwbQROYRISDpJeKylhEfqH/oAlo/DNs3/c2oTYjZxNi85Xbvvi8fRDHAhrPyr674QwvPuAxwIz510J9Jp5zVs11i/PxBm4/T8QG+J6MnoLyXJwg76h4ap6a+Rarrtv8Gjl/XFey4vHrBqWuix12cSJP/FVm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619152; c=relaxed/simple;
	bh=PSSaeWVCQQXj8aMblYpi4nx2Sj61cCXqOT4FifyBVzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zgy2iYruMdtpk47uBA9fwGAqH1AC//eVB9QL5TKE2P9MkvLOmp+icCfXZd0xygPAfGF3MMt/C6UszhF4O/4mS7XrJiN1pd9gLXSwBclbc7CYgwcfvWfAVsriU2BhYKUODYbI6fxUBOUjLeEb6jyrx7dIwjXph2Izprt4P1Eo1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=X6aexB5T; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="X6aexB5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=X6aexB5T7k20bFgjb0AN9FOD3iCay+WRKR+7khomMqEvw+EIxqFzOwuLz2U65AKB6LSwf0UGrRtgs
	 00Go9F+1wAGoZv7J9KcPGw4ScSMCn2s5O7+zBlpPf8c3sHN5YQ2td4wAhQGPeEzyu20XS5qonBsksX
	 Lb7yzmAWDTqclz7o=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ac9f0487b0-94b57;
	Sat, 10 Oct 2026 15:59:05 +0800 (CST)
X-RM-TRANSID:2ee66ac9f0487b0-94b57
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56ac9f047631-6b3c0;
	Sat, 10 Oct 2026 15:59:04 +0800 (CST)
X-RM-TRANSID:2ee56ac9f047631-6b3c0
From: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: tongzhiwei <tongzhiwei@cmss.chinamobile.com>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ata: libata: preserve sata_spd link cache across ata_dev_init
Date: Sat, 10 Oct 2026 15:54:54 +0800
Message-ID: <20261010075457.882-1-tongzhiwei@cmss.chinamobile.com>
X-Mailer: git-send-email 2.45.0.windows.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

a hot-unplug goes through
ata_eh_schedule_probe() -> ata_dev_init() -> sata_spd = 0.
After commit 69f2c9346313 ("ata: libata: Fix sata_down_spd_limit() when no
link speed is reported"), when
the device is unplugged, every probe lowers sata_spd_limit, which breaks
commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if
driver has not recorded sstatus speed"). The harm is, when the device
is plugged back, it is limited to low speed which will never be recovered.

This patch stops zeroing sata_spd in ata_dev_init (sata_spd was
introduced in commit 008a78961ec7 ("libata: improve SATA PHY speed down
logic")).  sata_spd is then written only on a successful reset.  At
struct ata_port's init time the sata_spd field is zeroed by kzalloc.

Fixes: 69f2c9346313 ("ata: libata: Fix sata_down_spd_limit() when no link speed is reported")
Assisted-by: LLM
Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f482c0a6d7e9..2ddad2e6ebd2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5659,7 +5659,7 @@ void ata_dev_init(struct ata_device *dev)
 
 	/* SATA spd limit is bound to the attached device, reset together */
 	link->sata_spd_limit = link->hw_sata_spd_limit;
-	link->sata_spd = 0;
+	/* link->sata_spd caches last negotiated link speed; not zeroed here */
 
 	/* High bits of dev->flags are used to record warm plug
 	 * requests which occur asynchronously.  Synchronize using
-- 
2.43.0



