Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE534A797
	for <linux-ide@vger.kernel.org>; Thu,  6 Nov 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445307; cv=none; b=jKPsIEcbQizmBmw2ieZdhSWY217mzzK/geJp9jYakbFTRJmAot93TjB02cnjjayHXl7nUcNT4a//7QrrB8lnUfrfWesQARHeNb9wtA9O/5SNSx6Ukx+tjlnPiVTsFErK11twwUGEHGBRf7keqYUlm67BLIN7lx9Ukkm1Qyx7SWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445307; c=relaxed/simple;
	bh=xPWclQvY+EnBtUcWHuPqxyG5ICL9eKEa6h1sgDCttAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PjjbUmZY0XggLThdg5Ys/akCAecXcVit5ZR6HKxJO0JJjdmX2mvbaStVKrAfn3Xczb5kI8RSkS9Akis7i5mQcAvZY2v4jVI8BmzYgIvkBn6g0M1kRM4jbvGmJB5T3Ww2uijBtel5JINVf5mXX8qn31EgdYsK5ceOpvSpn1gw39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WzDUul+g; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WzDUul+g"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso1149224f8f.2
        for <linux-ide@vger.kernel.org>; Thu, 06 Nov 2025 08:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762445301; x=1763050101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nx1lPTEbzZHY1qdv26YxvfoI4idRJcQOTqxZM+W3Lcg=;
        b=WzDUul+g+w2wFmZ2zTUAvqAHNkhLnfcbNhVc4GXrKf/IQqyF/M85+h6P0RRdw67+HY
         Q18CaFi//xYtGsGT78VaryIwu+ecbCx14sRB6DNCGVhKtfQodVI8G+5fcpscsecH66eO
         ZHSH2jdWumGPWFmdHSO9y2muY/6T2O9Mer6U44B4Wyxid+uGkL9Ebggbk+69QbvXMqAU
         9D0/0qzkrEzFL5OKGHHljcvoy9EoBgoJ7xgpXh4/PWPpx8K6ZxLDvwN8qlk11gLwLyVx
         r5nn65msZzaxw1yeYHYFBqVfKIdmJj42ft4aX1NAOFa4nNsCII7faY3V2ENDqkl2NDa3
         GdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445301; x=1763050101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nx1lPTEbzZHY1qdv26YxvfoI4idRJcQOTqxZM+W3Lcg=;
        b=U0jqYiK2NeU3MSjOzwrl9/4MXfwZlHDSbxl6tqtr3nVwKxAZcGyj2Q87tkuh2anOlp
         2Yoj1kFBA2Dzz54SEBjrMo7mz7TZWL038z1+tqb5gbOvtsJ/aK3cnLBprV6tL6i4GZ2j
         1QmXCMzeAeF48AduTBhV/HbALPvAjCddPvmQljNyIzxF+0Lw0lcZqC2/erOPbz5XeRxu
         HMZfGLHyEQfhnr58TiNSiU0eyHqz2IES2R5JnqCf7s9JBVkt9xg0T++oPo3B8DOC7sZv
         eEbqB9H9PrCgo0d1wztdrXB6YdwZNfHJg9aRLLwDDwNhCLRSMfP6RtlB2qIR+OqCmrp0
         nGww==
X-Forwarded-Encrypted: i=1; AJvYcCWxvPruBInkMXnD1Ea8Hnbexo3xxx8XxxJTc4J7vsTjX0ED9ofTQTYYNzkV1hEVNH5wZswMxR8mVKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVWpIRb5vN4cxNdL+njw8YVjOmLuOhNaKfXRWcqFAm70r3BkD
	olWYRJrukRlJpvklYFrplGZnQQJQ7CokLbkgdISS6U1EzV83NnUuB9M0dvX3qZ9TyRE=
X-Gm-Gg: ASbGncsND+1xRH09nAJNEgWLR2P2ngyZ1oOBVxL7jBeZZC/yOYXUuvrKNwTvzLFHPB1
	EuQ5jX3c2MbWWtLBHR3nUJbYnYnb6EFL7UmjX+myPMtYSa0zTpPa3PXlmtAuF+gev+nam3I69bH
	MI2M7W+Irk2lzi803xeEEc9MR22raKIz/hbytAcnacfx3OMCGdE4aSzmVezCl4CpGY6Px1N4Apv
	Ajumv+IPHe4HaDtbrRMwNvVxOHDxTrE2yWcbpQUKotKCdAqt96wX++0Wp75taXmskg8sBidb7r0
	uNN67yHx0uiAasBJalATI/NMJHKeXz+hrvrtWKFviF0KWSQaCaYmdWy1MLcgyjwRYkYlswklxV8
	dOdOqutbUujIVfa3ROFtOXOLEiDx84NEORGPrykr3nVBATyfDeXWLHSTuvAqcSpyQTye+XiOhiw
	udmEELWHJuEAzKHQP7A9BJaGu0wAunY3027A==
X-Google-Smtp-Source: AGHT+IHrwHGLgBBhAgtrfyKEpFfxFAA7i3wIf/3/ZalE+AmFaR63fQ6Dh3eaDSrDXVqOyiQRM7ThTQ==
X-Received: by 2002:a05:6000:420b:b0:400:7e60:7ee0 with SMTP id ffacd0b85a97d-429e327888emr5905151f8f.0.1762445300744;
        Thu, 06 Nov 2025 08:08:20 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4037d3sm5893097f8f.6.2025.11.06.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:08:20 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-sff: add WQ_PERCPU to alloc_workqueue users
Date: Thu,  6 Nov 2025 17:08:13 +0100
Message-ID: <20251106160813.314932-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/ata/libata-sff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 1e2a2c33cdc8..785b6e371abf 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -3191,7 +3191,8 @@ void ata_sff_port_init(struct ata_port *ap)
 
 int __init ata_sff_init(void)
 {
-	ata_sff_wq = alloc_workqueue("ata_sff", WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
+	ata_sff_wq = alloc_workqueue("ata_sff", WQ_MEM_RECLAIM | WQ_PERCPU,
+				     WQ_MAX_ACTIVE);
 	if (!ata_sff_wq)
 		return -ENOMEM;
 
-- 
2.51.1

