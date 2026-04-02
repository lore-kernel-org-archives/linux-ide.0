Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379629B77E
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775092268; cv=none; b=JhA0+b3xUm1yqQzhh/Sy4B7L8HH3LEq9qVfkph5Qjkesx4lTWcTb7JjJ6HpHgO7fDS/2gkl5lGkZ9hu8J8mnifX9isQN6ZDStlSIyA9eQuX2JUKCm59WcORpttjijyg0tyHotpqbwRn75ozkNZDblj207LS41wSkPDbogLLq0G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775092268; c=relaxed/simple;
	bh=LpyxEI2XHeXWT2ODp48J7yCs6+1uKO9aiwq4iFZO5g0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MCZW5HZlJ90mB+fXfYAJC6fAetl8BXMmxLjz758JbkBgTGVstdqqq/k05H5aYwTvfOFUJjOa7NLwNmO4jSwU73ntR6jvh7s3DLgWe596FK40hmFYqkezf/eeutB+23u3bOJeC4CPjGd2DY8+PT8tG5HfhCo9meVYCu+YJrr1i2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cv+gPG9g; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cv+gPG9g"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c63f85c84so189270b3a.2
        for <linux-ide@vger.kernel.org>; Wed, 01 Apr 2026 18:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775092266; x=1775697066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b5vlh7nRu2VO+uZc0moAtUj0d3hwd9HOdLTCGjwE1js=;
        b=cv+gPG9gLjc7HS8bMRNnnj2vEvTOUBMa83yaqH54whWM9tu4I92cO/+t9lP1bp64Tr
         V+dMwBv4Tg4GMsk4HHCsJe8Pv9NKeVGMTtx+tlReza8xPWHgKxka2WkozJMxfak0J1O6
         qqgLUGRNHRDw9NIRialD0pkVGc9uTAeL739pIGNnKjY+8klqhqTrdTUAlMLvReaF21ZK
         UgV+paBXutj8gFhxjdQyoBLxxUiyZXXDxFVwinAXAtF3sLYwI9lD/NrzCF9K1jw4cq61
         h0pf23vHa1i4zyQN4QPv+XV4/FtjfLFka0mQbeYTiCEHlTr49MC8uHqyC8bTLA0fpKTI
         S9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775092266; x=1775697066;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5vlh7nRu2VO+uZc0moAtUj0d3hwd9HOdLTCGjwE1js=;
        b=j5H408rZ82TIr/324HJ6Dr1AgUvPabFQLTltoDl6CMNvFKSD7Hyx5VTYkEk2pRkqhr
         tI3WjSc99zZIzBJvTPVCmyjzvpKmLhleD7+xVYZ+fdf6vL0Lg4oKkn03LlMHKN3zNiZX
         xrPxDgHBQ5ljmFDr+5cNcN5fN5YoLrCgQB4yOQj55eqbCSoq/eQ8mVirm7vO86p57Q+I
         aBKotOTZlHmjgyKsKtlp8ugy7nBhg2vLdaDShnlc5Y9P46NoCI8pTmBlGjB6SM0wSVlL
         didCZGcZJZe1dqMkZ+xPI+ty5bnTGAsCsncAW5SC6STTyhQwDVG4ffGb2SZveAD4vJRv
         u9rg==
X-Gm-Message-State: AOJu0YyHnOteG+UPq5dTuvGyf4XpVb1Ln5ZzAlCbosk4ssM6zvVXhMxk
	6uRuWhWycZHzWX0VDOzZGQVZj1ObZg2qXCy+qSRsP38CUmnqVHR7YpE3s1WdgEtAX53g4En7qU+
	9ovygbF/cPWMC6g==
X-Received: from pfdf3.prod.google.com ([2002:aa7:8b03:0:b0:82c:20b9:f6a6])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:94c9:b0:82a:6d3d:9ba1 with SMTP id d2e1a72fcca58-82ce8909407mr5994631b3a.24.1775092266394;
 Wed, 01 Apr 2026 18:11:06 -0700 (PDT)
Date: Wed,  1 Apr 2026 18:11:01 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260402011101.676267-1-ipylypiv@google.com>
Subject: [PATCH] ata: libata-eh: Do not retry reset if the device is gone
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

If a device is hot-unplugged or otherwise disappears during error handling,
ata_eh_reset() may fail with -ENODEV. Currently, the error handler will
continue to retry the reset operation up to max_tries times.

Prevent unnecessary reset retries by exiting the loop early when
ata_eh_reset() returns -ENODEV.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 23be85418b3b..e97a842005e9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3171,7 +3171,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	    sata_scr_read(link, SCR_STATUS, &sstatus))
 		rc = -ERESTART;
 
-	if (try >= max_tries) {
+	if (try >= max_tries || rc == -ENODEV) {
 		/*
 		 * Thaw host port even if reset failed, so that the port
 		 * can be retried on the next phy event.  This risks
-- 
2.53.0.1185.g05d4b7b318-goog

