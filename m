Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A46238150;
	Thu, 28 May 2026 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948076; cv=none; b=M6zMD9kvUcrv6ZnbIHM1IVpSQJiJRVgnKMik6/taJtUKYoNIh+0MJ/fwAlCCpuUF67Cv93BZziQwF2xYjk8tsMDN5JKLUWgOJ3YOOY6cXHq8DSwutqKk0R4Orb3Awcnvx7+VlB1K/3a1NPAoccaV5FCW3SeADCxGqiMgJIe9Y00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948076; c=relaxed/simple;
	bh=6ZdYvGGo7dkpXJexiPRObrVxRoNaV6NkFEYvUj6oACw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eQKXUPQHVklduT4UhSqVNtSahcjV8kX9YVOvad7W0wCkodbtOn4xM+64J/j+l5OhPvtIUZfzb4sJwdoCr+pOGq6CEiFUfTZ7219qeH4v5HzuEHWm5aGDLpsGZdfmcIqyhb8x96wfBh5y4UxAKH0Fwwj8Ok1cnEWPW8hi1kyT1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EFJZtn0e; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EFJZtn0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Kn
	d9ItpHPFwk6gNUVHcf+8PWYR3N2Reae1ckHzH/Ajo=; b=EFJZtn0e+5JN8VXyCJ
	9T8FjdEEYpOOKhLhv9dDq5l6AKZInkvEUzhEEEOBdw3DixSDzc8RPc1uC3AZxo9B
	lFxwMUK38+55p5n7TkF95u7tF1/Pm9VBKYq2WwZ3RocUSDqPmhW9qr3hAediCNV7
	qrIZTA7hHEjUzVdq86Y2w6BRw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3n0EV2hdqcrSPGg--.35007S2;
	Thu, 28 May 2026 14:00:53 +0800 (CST)
From: kensanya@163.com
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: [PATCH v2] ata: ahci: use hweight_long() to count port_map bits
Date: Thu, 28 May 2026 14:00:50 +0800
Message-Id: <20260528060050.743599-1-kensanya@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3n0EV2hdqcrSPGg--.35007S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4fXw47XrWUCw4xCr15Jwb_yoWDuFc_CF
	47Xan7W345Can3tw1IkF47Cr1jk34rurn8ZFsYkrZ3Gry3X3s8X3Z7Z3ZFqa1Yv3ZYvFn5
	AFn8J3yayr48KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnP5r7UUUUU==
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbC6RUc92oX2hVcUAAA3p

From: TanZheng <tanzheng@kylinos.cn>

Replace the open loop used to calculate the number of set bits
in the port mapping with the `hweight_long()` function, which
simplifies the code without altering its functionality.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: TanZheng <tanzheng@kylinos.cn>
---
v2:
- Add the prefix "ata:" to the patch title

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

