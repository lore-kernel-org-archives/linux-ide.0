Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAF391E7F;
	Wed, 27 May 2026 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873479; cv=none; b=m3GcdIRXewQFRJVAJiZQr7pmsj4VArE1gjtX/X8h0FCDEWaJSoLVU2qeNgZk4XnilMdVo7CrcaJjVf/nLN29qeu5WV6X7OmPWyn74EhxOpvtu3Fa4xm4vYDjweWo0JOlrEkm5tym361KPV5ohWWgbpNR5XK/k3SDtaAvE3+kBzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873479; c=relaxed/simple;
	bh=eKiJa5SgNaOIBuyetgXHqRTlg5khvkt47VjLifUDtjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oArTXNQNwZZhzhgVlkk2z8cLFQIZPH13q7B6IYwRjfKPR4Oki2DkHdJM7UVjkldQcVzoUiczimwhWfQBSZEEA4yi4MaVWEFuE0uwIiYZBFd1KBjQlPXnByE/zractyDD9Lh1f2j+gqgxFN9UoSgQu5e6foZHN+2SMlhaBmqjLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jZ3KYdvr; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jZ3KYdvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Yx
	kX3OdJGlXGLu1h7eU4lfdefQrW50uPRZC7Qoail8A=; b=jZ3KYdvrziIoiKACZm
	lGfNcGZFrY/VRmMYUOD2ANz0koT8NcrEvG31kc01QzUuQy2AtDRAwqTe5s1ltFZR
	GYFtjVqsAhs0M4fkI+fnJ64Gcq6oeK9Z/NGWzbFEgNZjQIITFWcXQZuHnN3sKrKt
	DClU9qjDXCe3IgTPvmwj+DDkk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAHYsiwthZqoyQdDw--.9093S2;
	Wed, 27 May 2026 17:17:38 +0800 (CST)
From: kensanya@163.com
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: [PATCH] ahci: use hweight_long() to count port_map bits
Date: Wed, 27 May 2026 17:17:29 +0800
Message-Id: <20260527091729.266582-1-kensanya@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHYsiwthZqoyQdDw--.9093S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4fXw47XrWUCw4xCr15Jwb_yoWfKrc_CF
	9xXa1xW345Can3Gw12kF43Gryjk34rurs8ZFsYkrZ3Gry3Xws5W3Z7Z3Zrta1YyFnY9F1r
	AF45J34akw48KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeUl13UUUUU==
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbCwRL51WoWtrLtngAA30

From: TanZheng <tanzheng@kylinos.cn>

Replace the open loop used to calculate the number of set bits
in the port mapping with the `hweight_long()` function, which
simplifies the code without altering its functionality.

Signed-off-by: TanZheng <tanzheng@kylinos.cn>
---
 drivers/ata/libahci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c79abdfcd7a9..15d44266c9df 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -552,11 +552,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 
 	/* cross check port_map and cap.n_ports */
 	if (port_map) {
-		int map_ports = 0;
-
-		for (i = 0; i < AHCI_MAX_PORTS; i++)
-			if (port_map & (1 << i))
-				map_ports++;
+		int map_ports = hweight_long(port_map);
 
 		/* If PI has more ports than n_ports, whine, clear
 		 * port_map and let it be generated from n_ports.
-- 
2.25.1

