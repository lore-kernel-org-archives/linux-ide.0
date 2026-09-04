Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE7476CC0
	for <linux-ide@vger.kernel.org>; Fri,  4 Sep 2026 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525083; cv=none; b=ese509tLvStF4xDfNVWuGUHFuba76pWkT4nVYmILv5w5JraOSKoAjLDuEYaO+5EuGNqypkmE/tQfZaopMumx4EI7uQvofeJdXgFxFCp47zIHkw94wJq/eyphz8P/wTgOJCSYQu7dypcRN7Q9px9hCj8Qz5NrkKqpUJ75ZhFgD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525083; c=relaxed/simple;
	bh=T5b+d/OS5/eYcnEjmtuH3aLFvdcVAyfOOmY8HX2kPnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dduFluoERUq6lbCTlxGF3542rZ6sBNCFkU6pIbTRLhh66X8nJouynIv/FUkcV9KTIZ9v9+hG9CPVhaqhB15/PHzDgEvg+VnSuaf+bUjMs0iS71YHBi+EPtLMxub04uKW/41Oz3vZZDfiFLYtcBveeHtg8QKAAbGD51hXRe0lpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWP+9G+m; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWP+9G+m"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1091644a91.0
        for <linux-ide@vger.kernel.org>; Fri, 04 Sep 2026 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525081; x=1789129881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0+j20Eu0FfzlcTgOQzGHgkUj59C3DavZTxLbAshT4k=;
        b=nWP+9G+mKQoMiYe6yYTj7f9ct+eH+Q/02ZR4g5n/r9yhuVQL+ajBeOXmvtiPkVhf42
         jAqMVRIGFWFOO632zvzdCKA53JbCv15YVtOZIpom2jZlgxoNe3Q3+yjfBoWizOY/nQF4
         Sl7uIb6G63B+C1e1ngXiaLu3BZruq99j/NcOuv3gWwfkccvZtRlA1fWB18Mm0SWPxCUh
         nTNczUzHVbNC9jOdEdF0AAGj8J5jzgVbRS6ST/ihS+6+6O+elfgx//gtYygXtR3uo1Dn
         yWnLrpp3/o53RbeISbabSpWr+LzKCKI2FWh98nWtu5IFPFEAHEJIA17mNZMKPfFadyz1
         sUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525081; x=1789129881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0+j20Eu0FfzlcTgOQzGHgkUj59C3DavZTxLbAshT4k=;
        b=f7eV9HxIN8D0YxxJIIlA0GYEhcRNyD7l6X6/SfuT5ciycYIe/y2tPzExMyhKvZxtMq
         +GAvWOHjvrsXBzkH7N9y9JvemlEd5eZ/cC/X9jYWh2+qBAip3sFWy5vkVhgywzpRLacu
         N4yR6gQB5YJZ31Q0gVMy9JTtCQofsBo9KBVem2Z7Gxuvj5wpnrJcMDrqIcK3JBa8yDw6
         Keh84hVIwGStcv9ydVIz8KZiQSkCfc35yQxGimhNc2/+ZfjesVEtC12Vj11EClKB74a4
         IfwlQeefVSI/m7yTK3QJvCAxBqugsrA95aBdX6kQu25smei7UxiFG+Atqg5XPMT5ckJK
         Tlbg==
X-Forwarded-Encrypted: i=1; AKwUvBztP/fQTLFUWex/aipxl92i9IHL+n3Mp14O+/8uGF4PXm4MqJbbt8g1RT8ohKsYe4KndJeSV/Wp31Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nUQDV/3knB2eYJk6UUvoMaDlYMzBAhQfDBXtqwk6AoCHia55RZ
	RHX3ej+5y1FggVV6kf5qrmgsKtckh0uE+97d+JeLFOVEGfEivS95h2rb
X-Gm-Gg: AYBFou3HwxJBlhy6YBtms/7L8qupFAEE/UnY+Z1OTi0wxiYXZ2IR4aPDREC1dCFRp31
	ZkkRBVmUe5jpNMB+rTHK824RUQiHfzKNVEhOEzelhWQ0xr1QEWOQnHLc7vzLrciVxEFQ1+1xap7
	xmG7J2ENJneJVgoudA9Kg2hU1BhlySkP35HqC/Tw+h+1fJI1+cCAZQPlI6a2rQAMaU5xxGAp+Wl
	RuNhaQod0Bd6H+U4YASnkDiL5VUp8vXOkL0OEwaVoe/4yKd3u+IExALdRLgAKJAhWCTijer8XKW
	htIdXB8SyJjHRIaUnpDWw8Ejzow6DiLdWz6LkIkmPlurv3jhVTuiNpsrOdvlEtMvpBXL0e63xF0
	4ADIKyBaIX/BVA9ac+sxihLY2htmdVHJsP0ssdbi1A8F7Egu3Wxpuk3yKuu1hcORLYjB4yNI5Yr
	J61KpvMpSVec2xEiwVr6V9h02UaO9aXscRVpvaqRxwCOoChxqdZCKP5Ny4wYBDmRaFa+HZfih2C
	F7EMi6fV2I96+c=
X-Received: by 2002:a17:90b:28ce:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-39b26100cbfmr9757473a91.10.1788525080469;
        Fri, 04 Sep 2026 05:31:20 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3342af0bc08sm4447030eec.17.2026.09.04.05.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:31:20 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/2] ata: fix repeated words in comments
Date: Fri,  4 Sep 2026 18:01:08 +0530
Message-ID: <20260904123110.35532-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904123110.35532-1-hemanth.selam@gmail.com>
References: <20260904123110.35532-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/ata/libata-eh.c      | 2 +-
 drivers/ata/sata_dwc_460ex.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c93c24b22d9c..630e6d44190b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -923,7 +923,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
  *
  *	Set ATA_PFLAG_EH_PENDING and activate fast drain if @fastdrain
  *	is non-zero and EH wasn't pending before.  Fast drain ensures
- *	that EH kicks in in timely manner.
+ *	that EH kicks in timely manner.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8e3fc713891a..b0c069a02cc2 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1071,7 +1071,7 @@ static const struct scsi_host_template sata_dwc_sht = {
 	/*
 	 * test-only: Currently this driver doesn't handle NCQ
 	 * correctly. We enable NCQ but set the queue depth to a
-	 * max of 1. This will get fixed in in a future release.
+	 * max of 1. This will get fixed in a future release.
 	 */
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	/* .can_queue		= ATA_MAX_QUEUE, */
-- 
2.48.1

