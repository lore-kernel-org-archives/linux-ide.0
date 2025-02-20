Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781AD1E570A;
	Thu, 20 Feb 2025 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039816; cv=none; b=FJxsZtcvzGHg7iIN+gPROgdkZMg0nIt9e8XvUpiGlUfiAVZ9aUeWSUMba+wpTe/v8HKWx5d0vT+2qzTkOUjqIf+12TJn78LmFDqdAVOk0lxYaOo3CWDlhZ6CyfmvbPqlJkMcIvuraU3xLUCPAYO7wA+hvsE7B0xc2wFDeax/5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039816; c=relaxed/simple;
	bh=Zal7sSH7vt6HSev5mTuNXbbPNHeWf9B6HOqVIxwVQzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VQ3H6JBQ0DEgg9CXNRdOIIMS49V5dEmUHduTemhWHBnAP0FI7skwV4CQXxyWowtXv2v2acVCseL2tcqXfMuYEJtwaABGX2eUy4rd/pwvkQOYj7kEgEyDIYqnee9jEOqKCRWjATcynDgcKIQhF/jtLjEI4tKrkb35dEcGIKZOh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nps1mNmO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nps1mNmO"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab744d5e567so118530066b.1;
        Thu, 20 Feb 2025 00:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740039813; x=1740644613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lg+lU+01D/1Z6849m8b/2G2o41VVf2CedXajMd7Qp7E=;
        b=nps1mNmOVdIxlXk0C47utcGU1zlmvTY2QMZq6vFYvygi45XPfbjOanpWIHT36au0mo
         V7lQZfZKZ6D22eEaLCrCNy61vlHcpo6jv5xHz6gdYFGQJ3vA+Mz13ar9XLDQmeJwt2sJ
         xjvzksUELGE1w54wrYwYjUSg55SZ9P+/h9OuNjaq3LUzM2fwz6XtSv9g7I0HJ/quZg9s
         1n0ruG7ZXgQD++9/MH1wq92ufRiW4uxEGAS6Ro1Zg9VTQTE5NBEIq5A29E7c74nSbf2e
         zBAWoU3izO1mBmr7dC4pLDU96+VLtRUhjsk50HPfQMkc7Dl9wI3o88TuZGXDZO+XFHt7
         eGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039813; x=1740644613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lg+lU+01D/1Z6849m8b/2G2o41VVf2CedXajMd7Qp7E=;
        b=bwcDGeYTQdLn7iOH3oa0To5gspGBIWj7p8zGBJDqRgeSJQMhOGCnFLLBXlVFZ7rUK8
         jHSzhtnxFmenmwYstKsO+T5r1+IAFbGTAGOvyqRcRNNLY7zseC+iz8ehdtP5UuygRcxa
         cwlKPJ1/PYgqwGYbUUw+CZaBviAuXfj3OrVZiNEVZGMZBbHPoGT3siVTFK29rHWM31V9
         0Orf2vJYmNiwC/Txn+m9Tpa8d8MAT88LerxVak/FWjFNOyNBA03hLWV2vobYiuX32flw
         +n9UqfTtzBbmW0kHC2O+jFtdqtgjlYyhBqmzxLX5TwZK2cr4NaoCOJGKHBxgeTiEQKz/
         +RFw==
X-Forwarded-Encrypted: i=1; AJvYcCU7cNpRKR4OOKEN16RHpomzZ4R3Mb8JBqLqjDXRbMTBTAyTcrjomu6pQQZalwV8Xxp+GMAPldIxVjf8Nexw@vger.kernel.org, AJvYcCUOOTNmwl1fNgP8m5o5weH4h2+3oisleoUDBD0gVFG8SdDCm7aAk124rCYbhNJRl8fBZ7zJ9vlwJ94=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvd3TR5PBgK764xzqWGYVvMRmooHRQ1IVoiiZwunKZAs/orZlE
	SzQ4Sv49cgjKnpqkaUX0Z/Rm6aFBaYQfZbFB4kyPWXVJPctso303
X-Gm-Gg: ASbGnctNNUx3msLDws1T6qGR5TEMRNkGZ8VC7lCiTszXUxDN57IYrHj5iRNBFEP8NC1
	8ANHhurBiIcSCE3O5tLhpaDXgY/RML7qwRiCPEsCZUHsKg8NAr6AoUg1QVvDtchNm5M8dTzPHFn
	u9C/ReiMtIc5z+BYrzIgsng6SPbqRQtGBUFKuQLpjxzR9L0a2WWdUE+gcw/tC6lg0CKZtcPoN2b
	zM5cq4YASstWeczuZnWFnfqD4G1MmltkFcGO4V/R+r2B7vZ/EuMHypje8Q+VyVxt2BtF78pzjCF
	OFDp9yo2lkKZl+GEoPZFuLxi0rmG
X-Google-Smtp-Source: AGHT+IGz4hWgtJBF7y4pxprTI62oKBnlEgPDACOZv8YIsxH6F88gimSEUH12Felcu0muF5xaBOvICQ==
X-Received: by 2002:a17:907:6c13:b0:ab9:d282:d42e with SMTP id a640c23a62f3a-abbedeea657mr211300166b.21.1740039812403;
        Thu, 20 Feb 2025 00:23:32 -0800 (PST)
Received: from localhost.localdomain ([165.51.10.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba358ec3asm657523666b.35.2025.02.20.00.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:23:31 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] ata: sata_via: Use str_up_down() helper in vt6420_prereset()
Date: Thu, 20 Feb 2025 09:07:57 +0100
Message-Id: <20250220080757.87278-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove hard-coded strings by using the str_up_down() helper function.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/ata/sata_via.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 57cbf2cef618..4ecd8f33b082 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -25,6 +25,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
+#include <linux/string_choices.h>
 
 #define DRV_NAME	"sata_via"
 #define DRV_VERSION	"2.6"
@@ -359,7 +360,7 @@ static int vt6420_prereset(struct ata_link *link, unsigned long deadline)
 
 	ata_port_info(ap,
 		      "SATA link %s 1.5 Gbps (SStatus %X SControl %X)\n",
-		      online ? "up" : "down", sstatus, scontrol);
+		      str_up_down(online), sstatus, scontrol);
 
 	/* SStatus is read one more time */
 	svia_scr_read(link, SCR_STATUS, &sstatus);
-- 
2.34.1

