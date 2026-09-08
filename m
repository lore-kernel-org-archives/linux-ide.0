Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C774A2A55
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903738; cv=none; b=MmmquKtcYojcSZnnHcoAPT9SeuiJqxpexcJkkJOSrAxazjT2wNpxTtIjlkzCwT9tPOSL+6++/T808GIepoRjWe5nCb6tIRKZbDvoM1doLS4s9gGvdR5SLKSQdYPqr00+/X5ME27xQTEul6xQgiTSIixAWWvvl+ILAMYbzOrj3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903738; c=relaxed/simple;
	bh=B3RlepYw+gz7j/lHhtDy+Q356KPKjQOJnndOnA4AUCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEHUoanj1EPIYNI8Ae1X6pmhATCdRBGifQiNPczaV+Up0kLtnOS6NJo9wWeb7GmC2XHGoTZqR4jB/tLZFGfvGw9+8mKPkUzB7UzynG9kmYD6Oy/mz3w6DoWdFhT+AdBtmzl5+kgTyQjTr/p//OFV4+jfWBQb/Lbb4k2/zc69jGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0CvCtLh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0CvCtLh"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so651795a91.0
        for <linux-ide@vger.kernel.org>; Tue, 08 Sep 2026 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788903734; x=1789508534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UHrD1W/xUh8N3eKgAHmZMqC6W7o0uzrtTZ6P6CfRVxQ=;
        b=s0CvCtLhGK0KihJ+6z5+msKxL6UdhziavUMMVU0NoXn6rJk9MLJYooxSNThz02K80L
         o5ft5G6TOA6/wTO7a/brDlf7ve82ciQOpB3XwRMLa30yni8H4ntN5OK8A7J5xSxT/0+C
         12rDj5ewVTqe9dfJeNkyWQCbAtxa+DlTs8rSpzRTEl28UwKyp4IZpME764ycMhmr19zp
         ATAi70Cibn1GmFXTqCkitLkmcHA2WMkfvgAQlNTZVSrAB7bIUqLoLmld3ASdKcvD27Jt
         dR8v2xvMtoheY0JUZIQgoy/iOdW6+xLQgHtA8skEkXmkh44CSI2p602rBav601lgIsEs
         rSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903734; x=1789508534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UHrD1W/xUh8N3eKgAHmZMqC6W7o0uzrtTZ6P6CfRVxQ=;
        b=GatZqfL9jV7C+/8DtV+eaxORD4ZzZUiaE7alCKCxVI6bph/2sgQbVxEyreEBkEiT9M
         OatCXt+0Yc7al+3iDmRcR5YQj4HAEh5L1z9d7S0NjG/A2WGX+bjO69vkgO4cnmDTq8se
         /oWDe2IPwz4sRaxNnoowFKg1rCred8lMgb6X+qm5pY+tJKWeSlwOLwWkGmGCHPZWQ8ps
         9xOjdcWfIIwO45FQAnigmypw3T+z73a9IxwUjr4p4FG5bvpt5JWsWLWNpJYYixqRn+Am
         PR1BQLdASLwenqP2RJNUUbTeE6V1c5zrZmLyi4qDlqMZhb/5b+0egPhZry6SfDoSOcg8
         7u/w==
X-Gm-Message-State: AFuF++mdh5z5a9ukmrOlok0DxgoO28De4AzpEkashSVbeK7+4S9p6Ec5
	LlJGcJ6LNcO4/Ha2u1CP4qfKBREAz03t4N0SM51J9cTQfqm5K5GWaBRrVJmGng==
X-Gm-Gg: AYBFou0rUNs9Rws4+1R/gZwzYfWZ3vQit22p/c7/QSWNPLElkNDzTghMobE+Nopvu7n
	rC+Kffx8Vfh7TTsE3fdq1SWD2HGjpojrHIN0jQxE1YtSq/nZep1v46qooaJuaSkC77n9K7nD2fT
	9IHcaxm1DKxBNLafHyTkkvGlqTcZ2FRqU4GUVUmBQ7T0aIovIx3tjHm15++P84EdqZXeUtwfzEr
	J8iPa1DHFmkYU+LnHe43sH0ZCYQw85oq91Z/1NWOl5imeL4CcKGpst8e9bdtOiABPIIXmtWNzCS
	jk3Ghhw/nNLQxs6RFp9XRXIPsQOH1Qreb/UeA+hxNkwO3nV2Ao8SvUpiY9F/BLb9Fz4NDSaxek6
	J2A1Uw8mW/LdDRqP0nPcoku+sGOP6nHI7mvnqoP0BU5z+cw55Yfjy5+mbmZNogQroZLKTlGkoxj
	OGoqOz6ecG6Xk8aHBRqNx8qLfycFo/dglxUqXVIYd/PUm0/wtvZUXDFctMWh6IbiOrxlDYDZSTO
	4fya7JNF3YsH3yauGuMTMUy3XZ20sp1Fn6VluQ+eZR4ixuI8P3HpdK5tHjLhk7ZA4ulevHWdcox
	IRx47Izv/pGtAMQ89dGRbEEc1FsPSrK4urUx0w==
X-Received: by 2002:a17:90b:58eb:b0:398:ceef:edde with SMTP id 98e67ed59e1d1-39b8bf497edmr7045541a91.15.1788903734330;
        Tue, 08 Sep 2026 14:42:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b3312f9a8sm25576005a91.2.2026.09.08.14.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:42:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Mans Rullgard <mans@mansr.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: sata_dwc_460ex: fix data race on hsdev->sactive_issued in interrupt handler
Date: Tue,  8 Sep 2026 14:42:12 -0700
Message-ID: <20260908214212.597139-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsdev->sactive_issued is written locklessly in sata_dwc_isr() before
acquiring host->lock, while sata_dwc_qc_complete() performs a
read-modify-write on the same field under the lock.  This creates a
data race that can corrupt NCQ tag tracking state.

Move the zero assignment inside the critical section so all accesses
to sactive_issued are serialized by host->lock.

Fixes: 2d20da00c324b ("ata: sata_dwc_460ex: get rid of global data")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: resend as standalone patch
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8a1d80ac906a..73bacdfd0bd3 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -465,9 +465,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	int handled, port = 0;
 	uint intpr, sactive, sactive2, tag_mask;
 	struct sata_dwc_device_port *hsdevp;
-	hsdev->sactive_issued = 0;
 
 	spin_lock_irqsave(&host->lock, flags);
+	hsdev->sactive_issued = 0;
 
 	/* Read the interrupt register */
 	intpr = sata_dwc_readl(&hsdev->sata_dwc_regs->intpr);
-- 
2.55.0

