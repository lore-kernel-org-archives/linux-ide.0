Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079C37C93C
	for <linux-ide@vger.kernel.org>; Fri, 31 Jul 2026 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531225; cv=none; b=GfDSb1g0AyYlYju66x+y5ZMUaE6LILUMHYYEarqFSlUXOaRG5mLYJucX3yWPOTuRcYOLa4QmzE1SfePsY06HfNrOfZg4vE9cSjVRIC7R/EYXFP73KI/BNMf8Hg1MoY3FzxQjNUvT2XqCDR5Y9udajiak4bXHohGzPPEt2jHHrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531225; c=relaxed/simple;
	bh=4522mCTvgT2yfneBofEbQXuDlkWezOwq6bSe0P2wqq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkKrFuYqSHyk2jyciS37k/4jrG/I0Ix11yZ92mqao12DTGv2ytbEMtAPGLRsrLFx/k/XKSRnDeh/PYyW2ab2zBxxwt/cMvBCuhnPcp4tsurK6eeGn/1WENZHa/uDdinvsA/vuafnrpWr3xgjEAGl5LoBk5RKS2FwGbbZDJPf7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otZ+0zaL; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otZ+0zaL"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6acc88b9c5fso591854eaf.2
        for <linux-ide@vger.kernel.org>; Fri, 31 Jul 2026 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785531221; x=1786136021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SmAY5H801iHfliFhsAjZ9+4GXlwH499qZe6BQlMTr30=;
        b=otZ+0zaLs95/vqNB/LkXHLdii4miM5GZaZoz5omcoBI2Q0q8aw0GBXVlO2SEI3w4+z
         aQG+d91jHWE85TYa5RpK4m7p+ytl0uJNn2lrhIh7vye33q74UeL50izAp5yOxmPfl4+a
         PEnEm7yoFdJ2K3YBB/3C3fX2ofV10RPtyXsyFOE0+fcujorPc6Ni5ijk8cXHGqHyIU6W
         9ZDWrKM1hfFmaMrtMbpFliuJM0cAmUo6397L7xCNv0ucpNuMtePNa1oIkJSwTFQzw+vW
         H7MoSFq/3SZQa90fzCjIo/bMRAug2sVWD55yCFmFf3fl/Px1taUTdo/nxlfMfFsPpcEz
         34/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785531221; x=1786136021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SmAY5H801iHfliFhsAjZ9+4GXlwH499qZe6BQlMTr30=;
        b=FTArll+jC7RqhxBjooBT4Z3c9d3Al5h1nSneHQEGXFFZZqp5PKbfpusw0H+DNmImFG
         Kc+ma6MLf5/ypQGsn77/xfAedHFgmVX48qyZav7q2Oo7ceGW8WRJcieyw6Ce7v+Q4mra
         U/VYooqe3Ag1P6N9krdkMMAZwb5iJv8iDae5Hjlu4Lj6KTaibXnuiJPlxh+TckfI7+8G
         cg+BATZ21IjAl24XfHnl8U+wXRS2r5G7FfeRUSYZWQCMyecHbsPlByTPbiBRrYmQES1w
         ZJKsIK2dEHhDNdoKRykKh74OCBE+POrozx0RmLgp74wqW9v9hrVVX5T5lQk3TyjAnz+e
         5ONg==
X-Gm-Message-State: AOJu0Yx07A2+qniOrtsGJwr+tRNjggVWid88do4cRhSNuMxHimaDutU2
	Q871zc4KBEDGiqLFUf+SDgOy+mA6mC5tnq8Ypl6qTBUF3KF8HZXj/6EJ2dZERA==
X-Gm-Gg: AR+sD11HioWxoy3Jja8OOc0c4cUlLwYSN9UjgZdibNty3lXYoc0O/tgoVurT+yU8Ezo
	fnjoS+X++Ep7r8RUo9T1AK4vy33Po/lETnz529VUY7y4I37+kILGGLQxBAGv6Hw6i+xs/EhNl68
	hoYrzrBiKZv1QjxRtDCDJeHzL3dE4KUDX2Zs+FEhQew+hL10y5pmQHRj+15vsAAa5KKTeXaB0cP
	8Ic/e3sCA8xIx8QbDGjmb2rzAQcUtHvRHTdtw4Hq9U6FbcLFEKMZNNUSQdw2Q6yqH4ouynIK4io
	9MYYtRvUGWuP1zJ4BCh+JKEKBXRkG3LjHrk4MJ7isxk98CPMiunU8qE2IRTenLpRjmSbkcMEQzd
	LnlnNMj+GYbtt+bSjb1utr4jPvz3InsGsGCGvc6Ho5Q+10bHjtSSoATImV6MJpZw60FufdNYsgC
	dGFPpshZp4jYH5HEwE9pKW5uI2Ex4xPq19R+WLHzoOOJyRrIicuMNYrkmw8ABsKz9yN6iHdBOfr
	v7bDuUjUfaIInlWsKOtt+WN7WtrT0b/e64rsxNemlYj+GEzyjo9bGeyxsPTP/x8CJlCuSAZfBc4
	zzvzx9iB9rE1qFVNRI8VtMMj+2lmx2Eem9IzsQ==
X-Received: by 2002:a05:6820:162b:b0:6aa:e5e4:359b with SMTP id 006d021491bc7-6ae4312ae22mr3060818eaf.0.1785531221120;
        Fri, 31 Jul 2026 13:53:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f6064d2esm2218765fac.3.2026.07.31.13.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 13:53:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Rafal Prylowski <prylowski@metasoft.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3] ata: pata_ep93xx: add missing "cc" and "memory" clobbers to inline asm
Date: Fri, 31 Jul 2026 13:53:38 -0700
Message-ID: <20260731205338.8011-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inline assembly in ep93xx_pata_delay() uses a "subs" instruction
which modifies the ARM condition code flags. Add a "cc" clobber so
the compiler knows the flags are altered. Without it, the compiler may
reorder flag-dependent instructions across the asm block when the
function is inlined, potentially causing incorrect control flow.

Additionally, add a "memory" clobber to prevent the compiler from
reordering I/O accesses across this delay loop. On older ARM
architectures like ARMv4T used in EP93xx, __iormb()/__iowmb() may
evaluate to empty when CONFIG_ARM_DMA_MEM_BUFFERABLE is not set,
leaving writel()/readl() without a compiler memory barrier. Without
a "memory" clobber here, the compiler optimizer might reorder
independent I/O accesses across the delay, violating ATA PIO timing
requirements. This also brings the ARM path in line with the non-ARM
fallback which uses cpu_relax() (a compiler barrier).

Fixes: 2fff27512600 ("PATA host controller driver for ep93xx")
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: add memory barrier
 v2: add Fixes tag
 drivers/ata/pata_ep93xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 587caadf78cb..6d948e41bc59 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -211,6 +211,7 @@ static void ep93xx_pata_delay(unsigned long count)
 		"bge 0b\n"
 		: "=r" (count)
 		: "0" (count)
+		: "cc", "memory"
 	);
 #else
 	while (count--)
-- 
2.55.0

