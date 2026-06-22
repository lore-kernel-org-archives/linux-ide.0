Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155DD344D90
	for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2026 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152930; cv=none; b=qBhZMKWBVv26Uv0V/7T0+xoMPVNnczbrbR4cQ/MiakFiiEO4TrCRSxl8904cvA7LmIkJgHC+c5lzqFzvEsmf7quIarLtrVLMizZ+2SsUdTsdvS4M4n2JnGuNs8bS6vHEQbmN3RJJJ4w3GnqW/7lzWYSh3+WYX35N9fzI2zgEL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152930; c=relaxed/simple;
	bh=Wajygr1xCS88wkbiv/zSCcaFCBJpsJIo8gHJvXgnJM8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZpmXTUd4Rg8GRF1wZRS73PDJcdBRuRicbdPAr99oSd4bNiDeX1JuzFd+v3l0nWgvXDxX+8c34gq36lqRA4gksFA7xzFqxyjLTG5AY5BjBDMxkCX9nJ/WvAcigUMk3Etg8JXHiEjnnF04H1usdxDLwsMmX1whukHTTxJAMIsiwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UR22GiXA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UR22GiXA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c7403e80b0so39821805ad.1
        for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2026 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782152927; x=1782757727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lj/E13CApRr+dPq7lmFxUlfkRFlNtYVmYJyKopNC3jc=;
        b=UR22GiXAC8Ah9ErwIoEu0zrKwL5Mr12ffJkHsNLxBeI9sLYawgh6tyDfGxnQd+Rfq8
         oy0kF+wKBgfpXKLemV7bozRqBdBqJar/J1xFdxNksF5aFc+ClV2BufDYIwKNfhdooYJx
         Kf7YdgGxiLJy56VTusD7S1wkS9r0+S3i162OhYjWu3M0CU6Bp1G7deUyNRU1BcaTFqeo
         rdf8oe5aSImL3zTinvCtXDb956frxxXJKSdCs5dFUXHw8fCiZMq8MqvsWxmGTIqizQsn
         P3JdqWMBQa6jtvtLNVbsJDL71N2FKcntJhYQvm3RoZquIs9Kk4S7nB1sWqoNoksprD/O
         PYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152927; x=1782757727;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj/E13CApRr+dPq7lmFxUlfkRFlNtYVmYJyKopNC3jc=;
        b=LeOC4dXhbaq+4+Lkqk4ol+P+5pz+uPgzTRnRlxCOi37mLOJfgufbc2ojRZsu1Duga7
         /MqivvOM03ybkoU+f9lt0RRHdL8cyhbTuxf8V3Rzs73SAsXBcY6c8/k7jw78NhfB2K1N
         6TE3q525kIrCVbqyxfRihlSHIiRAB+fk1M7nS5h3TUyu4vIJ4q7rlb+ta04ZLoesLSPE
         5mwDPaWTG70pzEbTQ5kf1hwq02Rsk0yKN83it6Vmtvg7D8wclSFNKAqk0buirdZsVklY
         X/w7LmYPclskBmTXrBHTQgbgR2LW/fXiWUsTGzB8XwWw9+USnSaOFlR3pTt16B8pBWPx
         LbLQ==
X-Gm-Message-State: AOJu0YxqOCmEQAAidqoP7IWHbeTpxCZ2Ty9C9xcOwSrU+lq18ak9QJ3g
	DMmlDigCXPU0K3RlMd/W7Amh4GIysvy8debyFbzZkVENPzj82gkO2+xNK5H3+hon0gt2MdTjKnp
	NnA2OjW4yFiUIvQ==
X-Received: from plbkn11.prod.google.com ([2002:a17:903:78b:b0:2bf:b2c:fa1d])
 (user=tadamsjr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec85:b0:2c0:db23:4c1 with SMTP id d9443c01a7336-2c718c77ec9mr165834465ad.5.1782152926903;
 Mon, 22 Jun 2026 11:28:46 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:28:44 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622182844.2795777-1-tadamsjr@google.com>
Subject: [PATCH] ata: libata-core: Allow capacity transition to zero for
 locked drives
From: TJ Adams <tadamsjr@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Salomon Dushimirimana <salomondush@google.com>, 
	TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 91842ed844a0 ("ata: libata-core: Set capacity to zero for a
security locked drive") introduced setting the device capacity (n_sectors)
to zero in ata_dev_configure() if the drive is security locked.

However, during runtime revalidation, ata_dev_revalidate() compares the
new capacity (now 0) with the old capacity (>0) and detects a mismatch.
Since it does not consider the locked status, it returns -ENODEV.

This revalidation failure during Error Handling (EH) causes libata to
eventually disable the device, offlining the SCSI device and resulting
in subsequent accesses returning -ENXIO (No such device or address).

Fix this by allowing the capacity transition to
zero in ata_dev_revalidate() if the drive is reported as security locked by
ata_id_is_locked().

Fixes: 91842ed844a0 ("ata: libata-core: Set capacity to zero for a security locked drive")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Terrence Adams <tadamsjr@google.com>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3b6243f0f91e..d090667979ca 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3974,7 +3974,8 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 
 	/* verify n_sectors hasn't changed */
 	if (dev->class != ATA_DEV_ATA || !n_sectors ||
-	    dev->n_sectors == n_sectors)
+	    dev->n_sectors == n_sectors ||
+	    (dev->n_sectors == 0 && ata_id_is_locked(dev->id)))
 		return 0;
 
 	/* n_sectors has changed */
-- 
2.55.0.rc0.786.g65d90a0328-goog

