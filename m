Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7F35F17B
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765293; cv=none; b=EkmZwts6T7PVTtKxu1S4CXU+1t4bfssw26TgWzk0rkSA37qvsGwTD1a2z1dOxynkaYNZX1HmwlBYQF0ZdjSx0jXHZaGHQDZjUogcIZgrS7XMREbzQ7w+uNxf542GRzoCt7LinSVrRu0HRfDQPntRRUNaVRqB6LMij/ycSkslARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765293; c=relaxed/simple;
	bh=MZ94Gzex02Jy1JLi10KCAdvW3FLEFCePVRR6Ggg34Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvC+M1GqyUwSo70n58UrgN4rAisiQcXpM47fcTmaU0vXwaoSCWMwM1dMdkTLVCWLKIHSVcBO5Dk5aDRni6mdrID0Cqbj4cJtllRapmibqR9kgm5xYOr4rRgCuZ3JutlF4KDgidbWQN/cZsQTsgMYk5cKTiOIP/trbjSFzsOnBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik6euCoj; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik6euCoj"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-127380532eeso1980559c88.1
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 18:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772765291; x=1773370091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CByE5Wxban3jbJS31rm9GTroSUFqouuJozzUiQuEg8A=;
        b=ik6euCojSJCVgXrAKvmajv4Qn+ATmbsAKuu2KuGG4FHqmNWUMkZ2Akbk9YqG12AloF
         uZKofM0Yo6DvvwbU2BkQzczzWC043JWlNBR+iZcRV/jqy6y59zCdxC0yJai+lyvhUGxE
         9Adl1erXB+FZtFHoNjwgky2iF85wX89Pgus7rdw+ERM/jWsdXMWNaW8mb/NYVXB5Yw8S
         U0u6A5au1sy3pazb9Fgv7JGeVPUePI9t+OgqqM8mLnvy2SGjoQSBmmSoEMz/Egt4Z/+k
         Sfps7Rme8BsM6xsxVIvezPm6JnsNgftvDxf5+HeoS8oQJecY5whKFJ2TtfVxRL6DsLV4
         /tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765291; x=1773370091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CByE5Wxban3jbJS31rm9GTroSUFqouuJozzUiQuEg8A=;
        b=Bd9tgcU5rg9pGT8zFll1kneBIZWRw+32TgMYQkckjaKm2S2t7TwgVn/dmga7YMbsOw
         3YEi6dQxH4CmMhBHIrdnqiSLIZBQ9Fd6zOK+MA/ksgfoN/pWcX2hf61nINkdeY4ndooJ
         1MJKn3mZwyKTIe09rXKnEDITFc5uMpdUcIiKApcvbIZ8ma/dJINS5plGS3lSpWKDkpW7
         6pPgfoE2ZzwII8ImXpxSURxmQ4wuAj6MzXpZJDUvW3uKfdTDqy0mduMMx4yUu2WxyPve
         Hf1B2yxv9uiw9aMBT321b09lGwdWj7jX8nSttzvPK5DjpoSnyoRgVTot7cq20rAcpQD6
         Ptew==
X-Forwarded-Encrypted: i=1; AJvYcCVg1c8GJQAGxb6SaIHUbOfu+iMsSrk/P4csR2U+HVO5upN2C5EhBccqC2HoBVZ4m9FunoD7poUtyy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQgH6J838YNOp45Ey6uBy7hhhuZzt7CAGxVGFH+wsQGoQSTe2
	KDBwqfi8kZac6qrYEdjRkWZRv2mxo68Z7icr0Sr8z3NtvC4rH3RFb86h
X-Gm-Gg: ATEYQzzXOp/wvVKbMSmLevM3wLmVIhtBx//yTJQaHnMcBUNOPRVHI3nrAkNUdGFOLWf
	3vViG4vAsZFOkqn47xoljD0+2NpgY2K08JmmNVm01/Rrt/DLZ8yCdEc8ru2aQWGKEgvtSoyTqct
	aOxYfeF5NS76Fyp31EjElrhHR0Ge32d8UW7WmH/A7RjwTGoBz36i7vntebMjAlQbRISpTaVkugl
	LcrycuY2ZbBFX2BVo+pSeXoeKcN7CjfuNqdsqm/ObrX4SLcNRETfZYb5d2blbg7NjiMsfxbZMtk
	8+0CQ79+jmTDjnEI1RGSgBUcLGi3VhSqa0gWB1lAB7oVxe33X9ieZiSi1/mmwHROGkLA4B6VoVK
	txkhADJE4l5MYdmlmpgnpWNckRmtlzBR79JOLBGppyHg8q67slOw+bE9sK8+05T1zq4z3EUi3Qn
	6bF8y8Tr/bJgqDRCVdFAqooIhOOc6ArAMyTsjq
X-Received: by 2002:a05:7022:217:b0:123:3309:1af2 with SMTP id a92af1059eb24-128c2ed35c8mr306488c88.46.1772765290941;
        Thu, 05 Mar 2026 18:48:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c4065933sm125376c88.16.2026.03.05.18.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:48:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ata: libata-eh: Fix detection of deferred qc timeouts
Date: Thu,  5 Mar 2026 18:48:05 -0800
Message-ID: <20260306024805.2877513-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the `ata_qc_for_each_raw()` loop finishes without finding a matching
`scmd`, `qc` will hold a pointer to the last element examined, which is
accociated with `i == ATA_MAX_QUEUE - 1`. This element can match
`ap->deferred_qc`. If that happens, the condition `qc == ap->deferred_qc`
evaluates to true despite the loop not breaking on a scmd match.
In that case, the error handler mistakenly intercepts a command that
completed normally after an unrelated SCSI timeout, returning a timeout
error instead of success.

Fix the problem by checking for i < ATA_MAX_QUEUE in addition to
qc == ap->deferred_qc.

The problem was found by an experimental code review agent based on
gemini-3.1-pro while reviewing backports into v6.18.y.

Assisted-by: Gemini:gemini-3.1-pro
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Fixes: eddb98ad9364 ("ata: libata-eh: correctly handle deferred qc timeouts")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b373cceb95d2..44fddfbb7629 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -647,7 +647,7 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 				break;
 		}
 
-		if (qc == ap->deferred_qc) {
+		if (i < ATA_MAX_QUEUE && qc == ap->deferred_qc) {
 			/*
 			 * This is a deferred command that timed out while
 			 * waiting for the command queue to drain. Since the qc
-- 
2.45.2

