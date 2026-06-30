Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874E47A0A5
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851068; cv=none; b=PWYT7fzGFqv8so026i+mHm/hR1kuf6qfo/YsOfa8FYbDI8q/7tdnYRY9EXxmMtynpEt8UBJja7hAEDeivkmWa3Kdw55APMYyhA5YuuR9TBoIv1Qyno9oSGAH5oYvFLYF6bgQxWF6AqtrXwFzUsxD45DoUcxjg/geCTQ+EXqJtug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851068; c=relaxed/simple;
	bh=TSQCt/Wq1JlQd0+NrNz4C5TqKNOnB1aE3ed/vlAkITE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtbARZuqLGRiEpGtBNknD4ZZrNDglzWLcMYbqjMDs4+kriQQ0nM2coVxg36jjh/TnLAhCPydeETVGhxj9KVbUyhnv8AkMaJoBsnjHg8L65cpytnco8XBH/LWALBanUmdbnma+OZeP6PE+YOBtSU/2pfRRmbR2+NFNytPQZED46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwWS5cDh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwWS5cDh"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-847a52edeb2so753937b3a.0
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782851064; x=1783455864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh41xtO7ZDVNZwqULqvpEsQiyFeD6re3CDQ99+L7O0w=;
        b=qwWS5cDhCAfPEdlkPCx240oZhrskZuGodfTAGBp/Hw1vT+ea72aoufaFNHwQeinG1Z
         pLWSxRVA8V/Uh0VgLanhFWdBUmT4TRbFeOeDVWMYvMzc/vuINj57ZLVNSnGsA+HZ4Iuo
         KaFnBHma42pjs0d2/pCH6UA9TJ0YwFkYalsrx4s6UNp99uF+gTlIa8AtGQP/UGlQRvgN
         kFp7QNHHe05m/HQ8P7cxKdmq0TWNUEU93X/w46pKQbnChdgO9TakQ++nI6tMp11uNb1G
         QtYnc+ZegvwZkLcSReMNu9FuzDxVkCLKdGzDHmmW5Hy/zrfTuf4cDwQ305KJyXD1eqVn
         wjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851064; x=1783455864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eh41xtO7ZDVNZwqULqvpEsQiyFeD6re3CDQ99+L7O0w=;
        b=qQAAezbO2OY8/3p6tkWCYDTwLyPbe9NWeEW7quVoEqykOQGVtqIYinaK/1zBnuBzUA
         2uje0/9ojfQsU0aMBfC/O/BymM6z1kjkhFEPk3/nEaKPOVnuRODd3YdGK+PyKagFl4Gl
         p4I2Np7C7hL6I6I3aBaJGsaux8t7kGGWWR0FDmvDgmcGQICmW5t+3xokF3shVioRNOU7
         FeT7l8qyrXMolU5kr6pxkkneVgscepv9YhJBUe/oFceKvXOQvrOagTJHaG6HmjlUAK0t
         Ux6trVLkLp3bU+wPLqaLmYYNmibmXb8EV/F0SFU/mOo9yJxvGcBsVMTgb4P4eVbKSTJm
         XL5Q==
X-Gm-Message-State: AOJu0Yzp3BoRmYZcVvS7YG7R/D41DsdO58ZDQ73p/sXpZVMqDfsV6P9B
	pPFYgcBZ7JUdA9xdtqigkoh67+fnjHCQeDYZttU/AS3uwHVrc8I165SmBJq0esa0
X-Gm-Gg: AfdE7ckfJnhtCqS2KxIg71QRI51wAdNQ/yMBIR+zbUwuvLOnGKQFwlCFk564ZraWVXm
	BH43/Bu4KEDaUj3pENW3n06r2yAo8U6kifIMsOdZzy/v/hH9lg82cSe8pq11/iNjvrZl6ZahKTx
	BiHiyXpRCkpc5vxipSm8pNywALY0HymyGKEW23DqrykHroUqAhUV74pHZKcW8omNmb+gvnhrVrK
	BQqz6KVUcvIGJQz1/Yl2oZ1jWC0E4kA/PDXVIcKuMphpAw1HAWMCTOCDwTQTGiIDuGhq9nAYC4k
	wQECejxrNgQEbOQ9s+YKXaZ6M/I5eDF41Wvt2rm8naTVTnn7fa4ag3c489WXSAzTWF/ZIMUr+JT
	YFDR4L5bC+N7zcp3aN/UMFBqAFkmj5jnBybgd+r6szPfHBsqUK3r24BawuRqXE9K0swFVrVTXu4
	YS+rP42fsQYYmbbYfHdJR2QyvyTIy54zkZ3jneq9rFmZtJL80UqAlLckILCXP39woPNRzwRat1c
	A7ZaLWSBg==
X-Received: by 2002:a05:6a00:814:b0:847:6ff4:da97 with SMTP id d2e1a72fcca58-847adf52f4amr1785958b3a.61.1782851064236;
        Tue, 30 Jun 2026 13:24:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a0337121sm2688854b3a.44.2026.06.30.13.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:24:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] ata: sata_dwc_460ex: drop redundant struct copy of port_info
Date: Tue, 30 Jun 2026 13:24:15 -0700
Message-ID: <20260630202415.234463-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260630202415.234463-1-rosenp@gmail.com>
References: <20260630202415.234463-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sata_dwc_port_info[0] was copied to a local auto variable before being
referenced via a pointer array.  The local copy is never modified, so
drop it and point ppi directly at the static data.  This saves ~104
bytes of stack and makes the const qualification consistent.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index fb6042b9ac27..af00acf155d4 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1133,8 +1133,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	int err = 0;
 	int irq;
 	struct ata_host *host;
-	struct ata_port_info pi = sata_dwc_port_info[0];
-	const struct ata_port_info *ppi[] = { &pi, NULL };
+	const struct ata_port_info *pi = &sata_dwc_port_info[0];
+	const struct ata_port_info *ppi[] = { pi, NULL };
 	struct resource *res;
 
 	/* Allocate DWC SATA device */
-- 
2.55.0

