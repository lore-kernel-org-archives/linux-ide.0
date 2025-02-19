Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5E24E4AD;
	Wed, 19 Feb 2025 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998353; cv=none; b=uWd/fDBK+8rwWHdUGvpX0fkQ0BJ2oB9s+9hobvnS3UFE3AqmEGyXex380vwGo0T1x5V6OXH3l6ErYl5Qw0pbFXGRIuQGTN69cTYIFMCcp3mcWxnMWduRGpFSsz5+D1nNlYA+/sVzHU96dV2yvsi7HIrMJu+8yQhtz/oVnLHGJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998353; c=relaxed/simple;
	bh=Zal7sSH7vt6HSev5mTuNXbbPNHeWf9B6HOqVIxwVQzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PzOiJCtCE2msO/14rACYCwpvJmPQVH79yOplCkNEVmZerfhCgTj2MMrg1a31VYVxQLZhxW02DfXOvnvdDefwvVP0BXvtePbz4vnQwkE3w2gqK4k5eiTHTVmD02dV4cPWytQzrcZKuD5c+VgNo8ngwF0Idewqr9H395xuP2S9l48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkQKTmt+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkQKTmt+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb8d63b447so39640666b.0;
        Wed, 19 Feb 2025 12:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739998350; x=1740603150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lg+lU+01D/1Z6849m8b/2G2o41VVf2CedXajMd7Qp7E=;
        b=DkQKTmt+6sYviuP7H/LHQaS8Uh1D/JZ+2EGY9KYah7BcTfvpbk1cmThIkw+obF2HnY
         dASmDoC4tUYP3lRKFR9FqsRpL5eKeSO67g00gqgM0tBx51ga/+rwzqxRqExLdvRNE5lk
         jL0kyTG9j8gdpCcq1xI+vEA3VTzQ82OKvyLGIHWVeMOUlp5e9ytqCmclHUz0ySvIkY1B
         xGGXmY/utng+u95k0SzRzPk9ceGCBzU7CYNvRYqaGwhmZD2aChG5HCNVQk76eYGBncHD
         NZL9JgOmafQRyZ1+aI9rSMFnijDpPNjWpu0qT/ObgDE7xvLbCPplXre8bz8XIsfuZpaO
         DIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739998350; x=1740603150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lg+lU+01D/1Z6849m8b/2G2o41VVf2CedXajMd7Qp7E=;
        b=IxkXJTn2zckFC4GfbDTn93B+EG4v4BxZeJGDilUNjBJIjmBUco3lQn3PR1NsXZqVnR
         KyDiUUTQV5ajnkzQT4cJ/cdU2VnuMz4L2imT1YlDUBMMfRt+DEvOAZ1M9+NbqSX5e9ZH
         3MehFnsuak48mXF1UVldj0VlKGRwnibjPfUzkJlHkT7KtejmykQAv3c16U2Ozfyr4Qva
         KCoih+vv62ZXtsbnfVnthbmGoXfAySSz3p9Ix8NjjcGVp+6Wi2Je++TNVS+2vZilHMHh
         cncYnakv+f8aLHFG5sUnzZFM+Wj/n3Uw+Gl2MYT+8le8G8c5IolsdFGhJrBokZomnuXY
         1UqA==
X-Forwarded-Encrypted: i=1; AJvYcCUD4y4R5x7ienrO1Pek57rQqCuIo2DWF0aoDJsLkhGOJNQ+3eZjgY1SFNT9295dJxU9z5bmADDgBss=@vger.kernel.org, AJvYcCUvhTX4nHDjZOA58yCJ9LOhKoMi9Mv4ux6CigfqMHTtJ19FoA0jRIFedUPsmQIOadSy6nSwb/TOBqlhsO1u@vger.kernel.org
X-Gm-Message-State: AOJu0YyWe+VnkzbuUVLX+9rZFuSDhEAhDDSiybUW4+VsKRANSo2l7fG2
	jPo3bOmHOhtt2DvAXaXx3UKKPFR/XZvFkpvI04X9EK+j5aEqm8+V
X-Gm-Gg: ASbGncuUQ48889N//V1BaOgB7ArU17DnEYHDm1ctk2SySKOEK/EfhooAlu04T512WxW
	FTIe/GTGl2Mys78lxVz8u3LMkcbGOzJE+21+2M6arXt+/JkwJ3Nvun4Eu/ZXVCt/RMALwMZ15XY
	cUYLdVaBIxVCwVKyIdZfTdnhmSVfBfnyijP3Ob3o2k8WtALN7qKI/a2aWsdzgSyYFCscxNSOIel
	BvOauypwci1S8QKWEFFQdRXPQOlqdDVMFgyugsBML1VDieEhjz9Y5qSxv+9XoLwUGbUg3Muu5QT
	o58b+HHbSZsXOpn8f8cOOk57b2KC
X-Google-Smtp-Source: AGHT+IEJAuDneTYPi7pDmukYt4eTnxekVD0T17lKdbpd2O+SLwgtI3XBzWh35Hdgcrlj4/eV9BvvFg==
X-Received: by 2002:a17:907:7da2:b0:ab7:c284:7245 with SMTP id a640c23a62f3a-abbcccfa40emr539542166b.18.1739998349910;
        Wed, 19 Feb 2025 12:52:29 -0800 (PST)
Received: from localhost.localdomain ([165.51.10.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbeff2a4dsm377990966b.103.2025.02.19.12.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:52:28 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] ata: Use str_up_down() helper in vt6420_prereset()
Date: Wed, 19 Feb 2025 21:35:55 +0100
Message-Id: <20250219203554.42727-1-salah.triki@gmail.com>
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

