Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD23C4B79
	for <linux-ide@vger.kernel.org>; Sat, 17 Oct 2026 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210484; cv=none; b=RZyQjMgtffEU1IjoTn8oGtYprvNYrpWGyFVaN3/itXNNiT3Lbmy9nam9oxWwGwe3VO+bMDqY71wvksjUHAvYOdy0CKD8WDMhONT9uvY5Xu29N4tDYPJPF8e/NhisWW4x+reYuEOGfYOC95XWExRhtfdgOOLJdnwYXz60gOQlvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210484; c=relaxed/simple;
	bh=giq9R9eqXmt3OIYtNymBZh0IZK3MauoJ2kjbep0I9gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdhL+u9kLaGMT82NALF7Ssgqru5wvwczmkUplgKyXn/3Uzjh8O55auDnllMRjxO/62c8ojazcDMzX8quh9oRPY2hI7+dXjI16poBBkn+TLCQHdlPp7t8foOvqj2tsjFMF8Vj/tJR30WQuwyesYUad5Lsj7REkpuO2jARt7C5IMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=G2PhdGUc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="G2PhdGUc"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso352494a91.0
        for <linux-ide@vger.kernel.org>; Fri, 16 Oct 2026 21:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792210482; x=1792815282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J4P0SuxHGLACHNAbcWpcrEkq+SWEhLrJUpTGxCsDDCE=;
        b=G2PhdGUciInIpQAIZwk9Sfn7hO7UuFPKU+LpujJRqm97zO/I6aGqWb1vOeJiCZAzcc
         84DnfCG9kmNVbuOa5M2G8sX9U2aJelG2td/e6G6SwC5B7Raygiv/XKToN4XBhqvYkGvv
         42cazovtA/fSvYIadRoHJ+Acxu6wtJb9duumg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792210482; x=1792815282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J4P0SuxHGLACHNAbcWpcrEkq+SWEhLrJUpTGxCsDDCE=;
        b=bp1TCeAmg6mDUO+ugNFzrzNAjM8Uyt83RbDtM5RyNANqDZjg7sk3CzlWATrQBbq7tK
         b4QwdooBSgtXP0V2uAkKyPNOOyeIkfkjIIYHXlpr5hBAkEEwhfpTCkrGSIcWECZJCWdD
         GrgzW1xzinbjxhBrLULaoo5HurPlrfp89EHmQqNLeA3idfiRgwJaTpeSIEJAeMuhKmPl
         kGMWvf4pQxt3g0pH70I+9BlnrwBkDWWlDboJSNhkSp9A4MO4BqJdo+zsrKD7D7l1CG6q
         Sjf8MNvxaEtS3FJQ2RKYEtJdNTzLplLVvpXgzf/CONISiwEhuu6ZqgOZuH3szSI+711g
         jogw==
X-Forwarded-Encrypted: i=1; AKwUvBwyKPED0EHW5HxwFegorJRlCFWGTINaUCDetS7syQBK/0aWb2V4bUz5KV2BDgnfCSdjUPn5R1GQUSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPtEU9IvMml1NHF++MND562P0rju9wrotAo6ZiD9DJ1lGhWJxO
	72HOZdb8JoFaRqZAXql5YCQOK6aWLX4mjfcOd6ERFpTRbuhfC/0UwNYUi9bnUpNtg2M=
X-Gm-Gg: AYBFou1L+csYF+1wghTBvo8IJbtZVnbYgueeeVpRSk2LXlhSQTt6WhUhEojvlh0kJpm
	dV/8yattEDvS31MxeuYMEM9lO6cB6FJzlJ+0XgjDQFnpNKoMiN3FmLHDovwYagNbA2xgniGvzS5
	dgDdWiQVffBb2kYIpmnVjwJnPjxRreUFgEcuiySJtljgY0igrR3nYfqw34GpfoMjJBvZFuoa4BN
	WEwlwdLfWBHVvfUQeeowgSc8p8J4gTWu3BIh+DETSu4IA3/2FHXurQCiGaOZP757gmsnZMhQvNz
	8dcXMzT0CehiNyJN7hJ0yPictEgQVcWwfj8AbnX80ZZJKCe6whLN/FZ8qVcJk9h/O4iWX1yf/Rc
	LSrSdGM1Gy2GiP+1PV2hzN6QVHH3Ji7Oz1GGo0EQfJqiVx8hopa+jJVGwN9K4FAOGUp9xYF9LdN
	hM+JP64WWIMIsF6vvY9LApUHwqHYLHOQHU/V7MCqIrganpfGgKZdtxunZj5RnUzWdqlbOxG+6PL
	n24uV0hzIA5yReixjsN/r8N2jrCZPCcmYvDlH8RWtOtkaIBW7I=
X-Received: by 2002:a17:90b:4ccc:b0:3ab:9f1a:3825 with SMTP id 98e67ed59e1d1-3acee2937ffmr1451115a91.4.1792210482363;
        Fri, 16 Oct 2026 21:14:42 -0700 (PDT)
Received: from shiro (p1722188-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.166.142.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm11609714a91.5.2026.10.16.21.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 21:14:41 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-sh@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: geert@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/2] sh: landisk_defconfig: enable PATA_ARTOP for the ATP865
Date: Sat, 17 Oct 2026 13:14:19 +0900
Message-ID: <20261017041419.311921-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017041419.311921-1-daniel@0x0f.com>
References: <20261017041419.311921-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The landisk defconfig currently has a similar but incorrect IDE
driver selected so IDE doesn't work out of the box.

Select the right one.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/sh/configs/landisk_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
index 2b7e10c9acee..6b5ec1f3ad71 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -28,7 +28,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_ATA=y
 CONFIG_ATA_GENERIC=y
-CONFIG_PATA_ATP867X=y
+CONFIG_PATA_ARTOP=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
-- 
2.55.0

