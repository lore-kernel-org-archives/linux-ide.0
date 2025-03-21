Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917C1D90AD
	for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570067; cv=none; b=jdde5sIMM+teLQZhNFGd9VD4gwmKK72KuAnuDDeIeHTUQACJ/zbqPJOP5t8d7YcNvz8uL/zNbsIQQ5rnSV/opuxm27uyosZ2AcrPd3ymm75ArEhjBcfo+5MfCnf5dC3REFYr3G+LDVWA7ZB5Du6sXiFvgjLRE+nz3UGn6ciQsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570067; c=relaxed/simple;
	bh=kuvEtbfkl6Ezkk+GzK431w6+dJv4gwMnjWAsjS7JUro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7mQ78kzeVQUfFwfZ3wHmsL1+RYBexf/SQz+J/u0aR14bniKcj7pLSq5pMwiAuuEuUNfHX3uTZ2dPxuYPKsqS9UTzgPoPseumD11GXQKdmceRyHO6pfpan1fiFLweiMN7I7Eym1L9Dnp6QCZq7k1CDHXcL8xL6d/oYUEKz0bfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0LjXgRL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0LjXgRL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf848528aso17640395e9.2
        for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2025 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742570064; x=1743174864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6YiPFHtVVCD1GlwrwHfTYc90+3I8KRnjgLcn6s+bxU=;
        b=I0LjXgRLS60w2ugV7N2OatXd0B1YfLvhtJ8z2VPUfan+A1NYf0LfKlPEGHi3Ifk0Gv
         8r6x8fe32VGomrNFEP7suaqLt6Ug3dsbn8k3NsvivXqyMQWK42g+nSCfzIHqRFUDYWth
         yT/1AwBU5qlL7+l3kqjyztAXEps2LZFOceT5Yg5jiOYxWDU6Y9ZQjY8U4264lCk7QWbn
         KeNmSN/iQNYEL8CBidNCjOf4qWRJmhEqZaqWkPZcaq38Fm1uZnQHp9Wzo/tFnHtrs1R4
         8FOj+gtJNtJqbeoCapE+xClQ7eHv+VMVtLOon7+Sq5tZM7YwVaG67VI/Au2VUWNhl4kU
         92Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570064; x=1743174864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6YiPFHtVVCD1GlwrwHfTYc90+3I8KRnjgLcn6s+bxU=;
        b=Twc692y2MSMH0Jj4rTNmy0rVswCA2lt2gebqw+s/lFB06r9vR+D2Np6AP2C6yJr9YT
         wQXFYMs1gbZTOEpydVzH59Sdv4GH9wGLuP4chiz5gRXFGMpKva/a8dj9lRFFhOicpTdd
         fc+Tjsko5/zIuX1uYXJe5PRgyAPv4cYd5WzJG7wbMyyi8WEQ3BLPl3FgmGAiUEbQB+rW
         DsRE9qdKYiROzx6Vxyj9R6PRR+5wSpK+/x2ONeVygz8BTGt0xVU/sPXV0h4rhKtgYsCl
         tT4B4fBBwE19Df+wWkPfBXtnjQZ2Frqvlsnaj1QGw4dpx4GdOUeVDTYZhf29GYD0anK+
         al3A==
X-Gm-Message-State: AOJu0Yw1Vr30yiIacT56Y/SselyVpOuUC07jjnlx0doq5Jx5zu8Y7Vu9
	E2z80VwIJaQzFcQAkmZdRTv7rjFyk9tP6jw0xxwBcwBTpYasPCHl
X-Gm-Gg: ASbGncvEOvY+mYOkKwj/dgBpBEiW6Wjsq2bTlhVHHnDg5Yu2WUEGtCJFgacVreZffpg
	yuAfalUm8WH/l26XAfdHGNd/God1zKxBVspjsGZEoo2jBQY6BzWqg43sF0BMFFQpbIb2zjJO5JE
	8Wit9ptaYLKq8yC5NTD79zrbo8D7wdBzvedTqXKdcYNXgIlxOnChUut3m7JXObmkBcAjNRvugYn
	FLrY/+uW+9HRGoHRS+L3em0LeWIhUweqzklO/DY5c0cUc1gxCWGe9Sm72od4UFZ+SovF9gIBf1O
	coMY0/T4ixquBHMG/bdwEZxIkkonNrYHWTr53pVKGnM=
X-Google-Smtp-Source: AGHT+IGOnA72EMWiLJnk3OI/h9+00m+QOLFr3tMyj9VDy/GHy/XYPkY/kMjfp+tQ9cibKqNnqfbKdA==
X-Received: by 2002:a05:600c:4512:b0:43c:f470:7605 with SMTP id 5b1f17b1804b1-43d509ed936mr38219125e9.12.1742570063653;
        Fri, 21 Mar 2025 08:14:23 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:91ef:3e94:acab:b42b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9decbsm29300305e9.27.2025.03.21.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:14:22 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH 3/3] m68k: amiga_defconfig: enable PATA_CSWARP
Date: Fri, 21 Mar 2025 16:14:16 +0100
Message-Id: <20250321151416.338756-4-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321151416.338756-1-p.pisati@gmail.com>
References: <20250321151416.338756-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 arch/m68k/configs/amiga_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index c705247e7b5b..feed92c95394 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -334,6 +334,7 @@ CONFIG_ATA=y
 # CONFIG_ATA_VERBOSE_ERROR is not set
 # CONFIG_ATA_BMDMA is not set
 CONFIG_PATA_GAYLE=y
+CONFIG_PATA_CSWARP=y
 CONFIG_PATA_BUDDHA=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_DM=m
-- 
2.34.1

