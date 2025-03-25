Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD7215060
	for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918182; cv=none; b=dSwyRDJNj1jdWE8no/X0y3bPPTJxodQ5Sa1x7RGwx0mApf7rKZE07LDBM2SQTk9gdygU49D7TmV0BmRe9BLeBsXn4sU5KATSG6ez+FRnnQimAfm8PpQOB3B0J5PRXvY3OmzqPH5EJ7Ezc/lSR+2U960yF8ziXl22vyl1xozQrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918182; c=relaxed/simple;
	bh=6rVGej4LxNS/yfWXL6HmJKas1GTVNHtXRW1FGzezZ1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PS0tJ3O2g1cHgnJnJMYCMsIAgXFmxfCKC+RKi1jQz2KVVt6F0AlSwSx8u/+a/DlWIje+UBUo/V53XokSVrG1HEjAZe3vP6z+5uLH4SHgeXIrxisLAWaH9vhEESGbnYVPi+JYg6ku10dRfBaSGwc4mh7DKnA42M8BIU2veWAR8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwlXKa0D; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwlXKa0D"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so4945372f8f.2
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742918178; x=1743522978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eBOveDld9JNqK6025AQg+gjIAfid8wA7UWw7y3u2J0=;
        b=XwlXKa0DKBBdA9Hde5UL25ezpQpRc4oGxkitrRCeAErB2T/h3h5vLeN3pB2NZmKAL1
         f2PtQCpH31qaQuib5b5BkTpMGz+/QD5pSmQ7FiKsOmzUriQAqgNeFZqPsdXqFgYBP4O+
         WRXBfh/XBTgQ1TFpO7LzLqJ+gdz1sFHmgPJ87SplpULG/ueTcnE8A1Po04dCSe1BxT/d
         Tu1mE5K1jdhUB74KJWQ9DnVoE3jOvVaK3GbWSYRo+sOVNCPAORH3AO+tiaxixTkX7CWD
         7trfpRljp+EOOB6Wy/cDjoq0RLYzPCMUDgeA6mbY6BibMRuO4sP1wFktH2h77iukdyb9
         Jr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918178; x=1743522978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eBOveDld9JNqK6025AQg+gjIAfid8wA7UWw7y3u2J0=;
        b=ixUKgoXxulBDrJlVxEeHaHDHa6iTO0zKQ4VYmJ7mkE+FBBUsqiRiq5CkRjHBi19+8O
         1nsoPPQr1cyolt4aApEqQAKucWT7cCaseKs5nMk2NnKe7Bdza6d9PyoP8w+NLBHi0MsR
         1Dmoa8/U6WH9neAhOOwCaHy+GFgq7O4kRUHhqjzCADgc1BlaLIfuAxNSlyBktVMBi6Ng
         /LSTLURaqdDPDbhPJQ45m22fGFey5YGLzy6ytr8Eta+fRn3ivVKnt1uOg0hn7TeIKs/3
         4p13taLivUJ4bNhZDd2u2GSx7Me4lldYzFRAb/PeufEQicWtumREbjJklKftNSxRN6m+
         fwYQ==
X-Gm-Message-State: AOJu0YySilDwKqlTGaLo5nLYjSHrsliLcOBOy0CW6hQYD7c0jSwXY+sf
	aW2G7ZchuVoIGaBonGRJF7+IX47QwcsQpmDWpUGvYXQlzzVe3SRNc2V9OOSjNEY=
X-Gm-Gg: ASbGncs/ZaZPdxxvfaxRZ+AJaUtK1tqV+GiTgJhdAEaxBOvJl3Bz6zRi9EXEPuh+1FR
	aLumB3aBspqpsaGyN309343kOxY0wOk4V1KppHIHQSbe0APPOj8knajsDGyBcklyLjMNWrV8pMB
	LlkcpvxXMGu4l85QZpqWsmLp6tdgvWpnRYJI6umRhss38/dPnsogG1m5xJAvRwkLQ8bdG3HhmhB
	lBhWyJssxPNZ1+Ks8bCADpZXj1sZa04AqBqxzX0lK9RID7xZuLwMjUPlSchfd3YU2VdCYfm2r+0
	rpjEMUhVezXsXCMjso0dyBwagtkgmW0/aA9RAhxkYIA=
X-Google-Smtp-Source: AGHT+IF5I+gvLifGV0FcJbSatrsUL75o+hnhRe7sO1S1ohKZGdbuTeWHd5XvUHVCV1DnFgTml5KpCg==
X-Received: by 2002:a05:6000:2cd:b0:391:3406:b4e1 with SMTP id ffacd0b85a97d-3997f900ef6mr17182393f8f.15.1742918177906;
        Tue, 25 Mar 2025 08:56:17 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:eead:4845:67bf:e110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efc9bsm13842075f8f.87.2025.03.25.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:56:17 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH v4 2/2] m68k: defconfig: enable PATA_CSWARP
Date: Tue, 25 Mar 2025 16:56:13 +0100
Message-Id: <20250325155613.352680-3-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325155613.352680-1-p.pisati@gmail.com>
References: <20250325155613.352680-1-p.pisati@gmail.com>
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
 arch/m68k/configs/multi_defconfig | 1 +
 2 files changed, 2 insertions(+)

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
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 20d877cb4e30..111900456d04 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -360,6 +360,7 @@ CONFIG_ATA=y
 # CONFIG_ATA_BMDMA is not set
 CONFIG_PATA_FALCON=y
 CONFIG_PATA_GAYLE=y
+CONFIG_PATA_CSWARP=y
 CONFIG_PATA_BUDDHA=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_MD=y
-- 
2.34.1

