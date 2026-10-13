Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3F535FC5
	for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922814; cv=none; b=NM6EY/viQAawdhAaiA+vydFw28Bm+NWo1W5zXK6/56qV6ZLmQpoNVBar3p6R/x6rwf7yPOR31iWcQ3hUPVFndai9FQ4ukYDUVChbWej9i/kJf2d5+2+OG/cYaw9R5niapQrUkXOosNZAV8apqDmZK5ll2IGyMPZkbpS0pjK0Vuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922814; c=relaxed/simple;
	bh=jUqBRhaJTxcr+7TzF8IRS/mZ1XdpsQ62ibJB2jJmET8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXDgJGu9KibcqCFreis0x9Esd3b2RHqy0w7C3uqBi43NTTe14LfUEpLNOF7FnitXDb8/U4EYgKNGGo6YmTchRRC/F/iXMj8mqa0QRUKJ99V6iZXdsegpjk56RHwzSgo1jPsIJxCJppyXPThhNuKcG+gGIY5WpZQFELC+AScpP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU7KlzRH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU7KlzRH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso2004925e9.3
        for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922810; x=1792527610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+LZ13WFPZFq7Jr3so6Rdb541TbNe0blOz7ZG1UNGqV4=;
        b=jU7KlzRH6ilVVd8qPFluajBH3uNDahsDai0sgzVpJHLOzHnHVSbUC/+HNi4r48wRh0
         yVzDSbJ+UvcGxi3/m3m8Za0SwBbH/uAn3PI/S/oFF9LJtzSNM5a1CKZcT5Lw1F7d2XLL
         TEXPjK0qbltPaAOsptjckYN+xnrOaT0xZ6DDY612qTWfXZMIhfIsFljy1QvFhwMNvLC9
         NvQR3c6UMCLDKRfyUjjHmBpBg97wRpfwkab2ckYNU30YiCNu/Do9DjCDXNw7AWLZJ5lO
         IIo0r4PvN+ZOprpUI/E/N7f5EBHEfyHiQ6cOad1GLGmiCJIRUYmTD/ANamWDVFEyg04J
         4dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922810; x=1792527610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+LZ13WFPZFq7Jr3so6Rdb541TbNe0blOz7ZG1UNGqV4=;
        b=hMQSqHGssjfINcgKy4AyWWjuh0bZmV8K9W29vGphWCLAT+XWmPUJwR2TWvoXltWpnu
         NcPgs7/R3bRMGj7262LSeWZFlN2E2yep8lfItPMltZwH3y4suEf3NtacAJAu/beDuK41
         ubEGY3THqebduvt8CV3qB7xZFHnPbtqzL/Gja0RUAoDf/sNwmXer37i6ieqsB4au0ho2
         g559dBd8xTFPX/A/7084ab8vveNHOqVr2L5rAqmAdhg0mw3S2TcewO1uhQBNAQllNSaM
         5xUJCeg6P92bnYDIpK6t4TgKJflLI1ghKI3xnSdssbx0ugL79iB21wsvNixe6vdR1aeY
         wVjg==
X-Gm-Message-State: AFq9FYLXUEdtb0SZNh7s5VLlBmkoWz9XMOaFVVhWeZl8Kpbh62ZiWL5+
	brDSDSWam0E5PUR2xfH1EuYYPrMLt3L/CAfLaDFIpNDW5kID+SlvwXurUTdTO9t9vGQ=
X-Gm-Gg: AYBFou3I6IjMz1Qou9U0vMJ6fo8KYkQG8HspyFjyvuDGe1AEyoMCM89l2YhSp1dAG/J
	hXGCP+mBtyxOgKxAthN5+W3KZcuGvNuDUjZFKZhC0bNpesIqNRt8nvFgxYD4SIiutZXGa2BFkKa
	h6ujxfpuQXjpYuFBAsKfrHqGFqZXYEBHW48ad8q0U85shywCQVdCuFfSfSxK12YCusl1Un5oj3P
	xJc7ukbauw2Q5ybP0IcbeNaETf3i5NA9nSCZC/KrmD8f8NZ3j27Ixb3GUJQJadM2LCQt/MFQtrU
	wEZTq/1mWOBtONh+ECcgebqbSTeS6xjXoGjIaxBKqIHi+VK/Zra/ZjwakmfmYJXOoJb0UtgHgbd
	uhPo1VJ5HdBhlfxd0z/oujVrdfWsW1sQonPXAvxJhFPZ04FSg7w/2xHLXns/Zgi8KjS5gnTKXQm
	X5XzZZ2HW4N7TRplfJMy5IuzrKFtgxu5JDj6eKPXeXFEs7THdvR1cH1zE3NDODcYalg7PjyCSI
X-Received: by 2002:a05:600c:e549:20b0:4a1:9438:719e with SMTP id 5b1f17b1804b1-4a1943872ecmr142374915e9.9.1791922809504;
        Tue, 13 Oct 2026 13:20:09 -0700 (PDT)
Received: from jo-Z6 ([2a02:586:e82e:5000:9782:6ce0:e16d:252e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm351605885e9.3.2026.10.13.13.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:20:09 -0700 (PDT)
From: Ioannis Barkas <jnyb.de@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Ioannis Barkas <jnyb.de@gmail.com>,
	IoannisBarkasjnyb.de@gmail.com,
	NickBarkasnickbgrk@gmail.com
Subject: [PATCH] [PATCH v3] ata: libata-core: Correct HPA horkage
Date: Tue, 13 Oct 2026 23:19:26 +0300
Message-ID: <20261013201926.14456-1-jnyb.de@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Code wrongly detects disks using 2 specific serial numbers
Use their firmware to detect whole family of affected disks

Fixes: 16c55b038033 (libata: implement BROKEN_HPA horkage and apply it to affected drives")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=8888
Signed-off-by: <Ioannis Barkas jnyb.de@gmail.com>
Signed-off-by: <Nick Barkas nickbgrk@gmail.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 59e87b987d..b23e1c3e4c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4248,8 +4248,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_QUIRK_BROKEN_HPA },
-	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
-	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
+	{ "WDC WD3200JD-00KLB0", "08.05J08", ATA_QUIRK_BROKEN_HPA },
+	{ "WDC WD2500JD-00HBB0", "08.02D08", ATA_QUIRK_BROKEN_HPA },
 	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },
 
 	/* this one allows HPA unlocking but fails IOs on the area */
-- 
2.53.0

