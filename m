Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991133939AC
	for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2026 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777541399; cv=none; b=sL3FsmNxqxrEHWg71fE65ay6QGHyqd4H6+XecIvOSw+8Q0VVRbVLTr9Vh6HhmNQrGKa7biTmcV7JvNjtte3DZk0FuA38kJoCw4JTxGidXOZ2p48aGSb1iey9AsOF1RoNhl2h+yfTH2ryK36wTTl3eKT4tNmL/V6EcwUNCX3WejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777541399; c=relaxed/simple;
	bh=n1Q30ixYOtqZ55oYud2pMjhUZtd6AeiJEslV7LVNqRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6XBGMxFWvPkin2KalirJUduM3++95WNetrP9ZNZ6xFytNPSUiOOJujllcJ5J5YP1x6NSWfhXBW+A69ed5YfYWpUJwJC851qwY11dmOeg9bAJpic2sirZPvdIA/DJ2/574fYJl+0rj7Rvnoq1e6/s6dJnusfrlT5DooS2FhZYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CgJnBKEf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CgJnBKEf"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-448528f4e69so423833f8f.3
        for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2026 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777541394; x=1778146194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=old5jyYu22W6jYV0qg4x4mp+/GqT2/HXZ0E6OdCIxiw=;
        b=CgJnBKEfSiuhdvUIVBjGJZKvm3B6sEvJUi6R+xCwdZuIzkl8p0nqG8NjJ6gyPlKDG5
         c2f+YlPwxSWbdKHAIyNOvskIyXjjXb8sta4fRTwtGlkTxOU0h4YcCEtpY4RkdjRjbtSJ
         uDurdfYnQUn/EHbJsKMfjcDR+y+ntzfbeCV2/TyBzpQevhedqiawC5CuDH3fjnASnN6F
         7dpBV8xqhsrzVijXVI+lYMBy7/HE+Q+Vg6bmo5sfy0g40k6oULuEfiwoZfQ3agv2NMyC
         ecyngnTbkBwaS93/4NezeeUnY3TReFRasuQAjQcHD3/cGxauzdxkCu2ee2XU3RD7fSNf
         1hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777541394; x=1778146194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=old5jyYu22W6jYV0qg4x4mp+/GqT2/HXZ0E6OdCIxiw=;
        b=OlfGjYWf9UmtyNyadYHkkB4zgQdRip2FS9sfMdMiCBk85MmkN4bSKGRaJkTY0F+DG1
         JYGTktOIYk9KGUQNsx7hVvcijcBsvO4G5Obg/Xvw7kfibUVTdg9x4p5kvayoEpNmC20B
         Ll8Kg7+ZQ1JOoU9HS9ikBn9jN7lwwkNVjmouSGSk5dUuZLs4wyRfEtr1HnAVueRkV3f6
         R2urwdBtN5D1A8lp5JRj1sbcizLZrnuaA211JegDojlGJ00toNoW9TvOpslVvZOMZGcm
         5sPJb6JlT+tpl2GmEGZvHosXMvTlFn6VS+0bCmM08A69HgnZNPJCtGdRFtNAaGuTHL3H
         +xVg==
X-Forwarded-Encrypted: i=1; AFNElJ906lhlP+OS8Iu00qDFo7aKw1MMvaTeksgVVFQOfAieLF6EuRgxHSHcjcRpX1Htca33rDMwtCbA5q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0L+vshG3OilaAXfBwM4TKV+rz57xfiJ8slGsys5gMpU78WbN
	xbvp/UuIBIyRNOa7SljLRGV90GSmtfPupjiY8iXJFc3n9sqBASIJqhFas0SnKDNZFYk=
X-Gm-Gg: AeBDietCemXgtla8zxtnlxLWGgA5iSZlJqicUNHovBQlP13mGIvIO2ri+qoOT2HuhxG
	BNGY8PWeac6q59MacO8w9wxe8BzKsrAK8Fq0HiUJnjVSx0RfIspkFFpnaSEgoYu6+uQarh7/weT
	DF5pwMBfFaTOs7wH/TwX13bcKu8YuYiLQ0+IT4UWHOvQcqRd7tMYbXo0DR6fOCvZmyXedOU0Ct7
	3gQdLJsuR3/T3236mqGDyXAyC4X5GexvBtUPpWpHHRfvuTKd0OXzH3J6ZO5wLV7kszd8X9RrYJy
	pN1IvRKBnLJUBEH/5x7p/5HnuhVTrAHWkZk8QdpOVQ+ZxY9gMvCXjsCqaY0msikkXoRjt/On/Jn
	zoIbXTZa+yHRzr8z3ARucp7U68qmK9LyOAS5DZUf6bBSSjb2+/lFshuFgUMeMVxH0y/TJKU30l9
	3r/7CEeZIsNtomRDP3CrdVKiGnfzEB1g+qZ+7ieGlNw7IeHHmpTSqB/bCQn9GjIgT9XeSE
X-Received: by 2002:a5d:5d05:0:b0:43d:76ec:91f6 with SMTP id ffacd0b85a97d-4493ee4c9bfmr3226097f8f.41.1777541394306;
        Thu, 30 Apr 2026 02:29:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5bf2sm12318654f8f.27.2026.04.30.02.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:29:54 -0700 (PDT)
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
Subject: [RFC PATCH] ata: libata-scsi: Move long delayed work on system_dfl_long_wq
Date: Thu, 30 Apr 2026 11:29:47 +0200
Message-ID: <20260430092947.128647-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected, but it is a per-cpu workqueue.

This is important because queue_delayed_work() queue the work using:

   queue_delayed_work_on(WORK_CPU_UNBOUND, ...);

Note that WORK_CPU_UNBOUND = NR_CPUS.

This would end up calling __queue_delayed_work() that does:

    if (housekeeping_enabled(HK_TYPE_TIMER)) {
    //      [....]
    } else {
            if (likely(cpu == WORK_CPU_UNBOUND))
                    add_timer_global(timer);
            else
                    add_timer_on(timer, cpu);
    }

So when cpu == WORK_CPU_UNBOUND the timer is global and is
not using a specific CPU. Later, when __queue_work() is called:

    if (req_cpu == WORK_CPU_UNBOUND) {
            if (wq->flags & WQ_UNBOUND)
                    cpu = wq_select_unbound_cpu(raw_smp_processor_id());
            else
                    cpu = raw_smp_processor_id();
    }

Because the wq is not unbound, it takes the CPU where the timer
fired and enqueue the work on that CPU.
The consequence of all of this is that the work can run anywhere,
depending on where the timer fired.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

So change system_long_wq with system_dfl_long_wq so that the work may
benefit from scheduler task placement.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f44612e269a4..6733f2b14521 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4753,7 +4753,7 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 			     "WARNING: synchronous SCSI scan failed without making any progress, switching to async\n");
 	}
 
-	queue_delayed_work(system_long_wq, &ap->hotplug_task,
+	queue_delayed_work(system_dfl_long_wq, &ap->hotplug_task,
 			   round_jiffies_relative(HZ));
 }
 
-- 
2.53.0

