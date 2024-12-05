Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67947191F9B
	for <linux-ide@vger.kernel.org>; Thu,  5 Dec 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394626; cv=none; b=oHqC3jNooygoaCCd849cyGYNeMQZNP3o/0ViG4ihXHzsN5gxRpOMTArdIiX4h7ahK7dcM406Vt1uE6Fa6VLTqOblLiW8NsHo2xnXadvzKUOVdOETtOLUPmNRLKQ0TxapXCJN/1/tI3HuILfxsoaKXopk89aFmdUSqahWhbjqE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394626; c=relaxed/simple;
	bh=wS0Q19qMihHOOOE3pMGjswD56RvTc5cZkAfKL+jXeY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ing3KjdjbqRD7sbZP96dV+nvlX97MDdHbbNgDi0wwskG+bS1OvP1YJb6jnaybaWBcNYZq98LU+t1JiqUJRZFUZwlUZDfaGSf1moYiB95xLTHMIOdp3GyBE9vRDSsGDAwXiY/17tPt6SecljSM6Wgg/aHU+KA68ZtjQhR5GQjxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=l5gFyTCb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="l5gFyTCb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21145812538so5667645ad.0
        for <linux-ide@vger.kernel.org>; Thu, 05 Dec 2024 02:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733394623; x=1733999423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7d4mBxLm3YD6mtg2na9c8RBlPogDI1edtX7H5lmoREU=;
        b=l5gFyTCb7x7glWftbBEVfui9GBM+0/+72TkaFCWY+NQvH3eYY3Zkae5FJl+A1hKndf
         o0jz7BYi+goPgl/VB9xZXqbyTJ0APmAQU8wq0UqKdDDvRK98Ac1wVA8+jXbAJKR6BMI3
         ozheAn3S09yWxUo33SG2aRg7QAvReEu61rGaBzotX5W5gy1zLAlsfeuRQXnfkAmSf4dw
         IzwWeIl/QpgvVeDD8Gymn2S47wtZN4esWfUiJ82qPOo8X2ZcSL3l5oDN92GJzEJvGuQP
         E1ut7xcvoNp+MX52qRCH2onzpw7EXhKwcH7QcdFRTFaQVr+1/voJfRWgEumBIgAmClei
         vZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394623; x=1733999423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7d4mBxLm3YD6mtg2na9c8RBlPogDI1edtX7H5lmoREU=;
        b=WtpVwDfFa7vwcI6RM4ZG2RRZoL3zsBhHpL4CPiclBihDKTFll1oIFJNWFZ3rTSAAQ4
         dmYPg+nr+mKBvmeSHC/l4XwI0fpqjlgdPnBADqVxmMp9lSp6CBTxqW8YNyuPs8vaXCUT
         WoIHVfXznI5L3JLeDV1dMH9vAJXupbPxV69M4U+AwT9leKzCsrqO5XZCFEb1bMVtqmyL
         jLscnYxKo2K9tLb+zI0fJb/AQ/nohMGr1YA6UhvF4XI5GmTggQ7rd59YjwVAQ23BeJCt
         lZqmKQqH5dPzIuz++vAqn4ZPIJG7BJ7COD7HsMn5vQHAwh+5VtkrqPPfpV56yGEKYXVC
         HMAw==
X-Gm-Message-State: AOJu0YwlF4RXuwQD0+R945NVhXa27tGrQYrmm4Tj0bZtUSrFaeM6Djbw
	cIW+E2aj9dGTPVV9S6AgI0ca5e5X9M6VAjLadCc3DukzBeSbxyW+qUowZpM/pz0=
X-Gm-Gg: ASbGnctTouo38DPE5txi+s4xDqkwNP1y1x1M/Zkrg80GXF68wkLbR2OhzdySYJ9orGa
	ZEbYg/Kagsqw7PGk8qTZhtj4GXggbb40Izl47CzaaPtNNrtXj2Rq0C2w8N5uxLNZB3EI+6Uo+YR
	VMDxepaYkQNOLDhl95WxdC3qOCEg+QNuD2IJ0EnhRb3q13Mtr1lyu8ZKNOdVjoWismk48BUIF3p
	32kwacsPcOcyUAQpjKqMCu93kWOrxizUajh9a1z1mziXFyZSwC4D2WSdKaaeDpC49V8/Tvxbd7b
	H/FbXFfXtnBAcSfEci/5exHoDWFgpWigmGrL
X-Google-Smtp-Source: AGHT+IFrDB7HWAhzg2vNZVN7HXetNvgisaN3voH8oYcpeUpBSzke9C4NZZ2ySguYywPfNCvf2hfsUA==
X-Received: by 2002:a17:902:e810:b0:215:734f:ffe5 with SMTP id d9443c01a7336-215bd128365mr128131335ad.32.1733394623586;
        Thu, 05 Dec 2024 02:30:23 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0922fsm9341225ad.205.2024.12.05.02.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:30:23 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] ata: sata_highbank: fix OF node reference leak in highbank_initialize_phys()
Date: Thu,  5 Dec 2024 19:30:14 +0900
Message-Id: <20241205103014.1625375-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OF node reference obtained by of_parse_phandle_with_args() is not
released on early return. Add a of_node_put() call before returning.

Fixes: 8996b89d6bc9 ("ata: add platform driver for Calxeda AHCI controller")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/ata/sata_highbank.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index b1b40e9551de..c8c817c51230 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -348,6 +348,7 @@ static int highbank_initialize_phys(struct device *dev, void __iomem *addr)
 			phy_nodes[phy] = phy_data.np;
 			cphy_base[phy] = of_iomap(phy_nodes[phy], 0);
 			if (cphy_base[phy] == NULL) {
+				of_node_put(phy_data.np);
 				return 0;
 			}
 			phy_count += 1;
-- 
2.34.1

