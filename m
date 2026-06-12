Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC7B126BF7
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289167; cv=none; b=Wt8Q2LMMfIfNOwWUFmDhwAVeyfOA9CY0yaqKihvgRQnKePLZfp3g/moLiV1b4yfvUSXcvGRpLnjvbERa5z1Yg0AFKb0RgyGMX0eFwBbocMDirgt8VaOAajMXCsknrVlA+bu5evhYxptdkARPmQIexY0AZoFWoTFfc61WsUpBN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289167; c=relaxed/simple;
	bh=epx1EclZDUKXoGEp/BrPYosT32cPjMDCoAyA9MV0Bck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+Ll/D+SspSpgkokUg9gnhclHNpOd1c0TueLpJx/+V+kqz9wt/M8dKaXFG8hbzRJHFRBFhUIH6YX7sXrusduW1CLHvqIHEMmblhQVMGubc+ETLm5i2JWCUmnk+AYVm/o59V/GasG/idrsoP9h1ZI+jP3hQUQoIMFVOGZ+cl6/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkh4sdQI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkh4sdQI"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423b08b293so719187b3a.3
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289165; x=1781893965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNWmZw1xXe1jGxvW+POZwW4xRJpp6BPX6JcDe5ZLzlk=;
        b=dkh4sdQI3qG5LFqK0HPpTxuRhqG+KDqv/zlOf8gymxV8zRo2ZjvemZHBD0b53+3TqO
         ZdG9mvnVzuKZlPRxeRgnc30VvtTfUPuBIhxgHOfQd67jobvHsmO51JARF9bfDMtWm/CZ
         MUOLrcG7sVgscew77kaBm4ILdav/sFNFB/BLzeR5ZCUYTCF/FOyG0LhKnaGx7sdFW3Cf
         DbiMm5v4PrYcbCMkFOAgyJFM61qO6+rMIYN5uYB4hdSPjjwbLLh6c/ebBR38TO9g0Cej
         ac19WdvLGpH/PTTMX29pYlnaeV1JNfKBk2Jj74AwDiZjkiuulX3DTEWantrgpzQRUkrm
         xF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289165; x=1781893965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNWmZw1xXe1jGxvW+POZwW4xRJpp6BPX6JcDe5ZLzlk=;
        b=SXY58Rgqnk09YPDieBUM542rGHNHsFYV8SHOqYPVSh+t3y5lMvbUlSeJP1EQc90TmF
         TBzEYni6isGmSRvFf0lG7cojW422B9YNZ3cQxlalZQpZXcxTJZjmLw/z7mNO+7oMdbFS
         5Bgf0AKDgo3d2N6QD4KI2El4NpahFndgN8r/JAy2TiewPpN3g6SgPoZJU5vjl44RseMQ
         VWv4Fve+4zPldcs5VepWCPh57v5RI61gvI/xg9xKpSciahEOSNCy6Y/SXQYVdFn7JbFW
         dIp3DMABkFoxWWYdHpu5P3TdspcS/BXgOoSUqBPxcka+M8d7vZpMt/lFpdA9rNYrVeil
         FxWw==
X-Gm-Message-State: AOJu0YzIQHW1JvVYPVgcKkOf3CRtuROdz3Vf1RBOwxW59LjOD+ALuoys
	WCNpl3HqIkbZr8ktWqaGgjfKMA8X4qEwrDDAyZO3jH4d0XlmfZQ1bpBHDflgMA==
X-Gm-Gg: Acq92OEFgu+zTX7BOeas0F/bkJQTYrtUkTa9mcTK4aLjmy5sLt2SWjJ7CEy9yAdsjO3
	E92MSWRsk1upZTcED3l87aMwmGfwNTHqgT3FKUMy0V3mHcjRjADWCWk+4ATbGUAquhLPq8l17oI
	uEImaNGV6897ztM5F3UzwDi4Hzc5H+Ve6XgAXO6NKkunF/CZuLWGhvTnVu4A3RaH4a6v0LUPSEy
	AKcXNZYd61luyvRDm0j74+mF9+VU9d5Pz6YrMcIHvFuyKp0l9oM92cvX9BlpcHswa6qToV4m7QZ
	v01owjSKjSxHn0xmEpVAdeHfLE0kVmEAylJySuYvLZYqp0PnmIydC+WNzRIpw3ztQB0mZglYi3f
	3oG8aDCqCiZvet3W5TODfKs9Y2OahC9kHK7Pb04fHKYHG/7cuAwqxOEQvXHPf1Ym1MlL4UZk1rC
	zZsl+oyZN2UiOGMaIHDU3smARqGUTwrtGsTcoi/ROKaS49/fMACbWgUwVHlRgZa5T+y8i692RrF
	R0Q+OVxIFXrIUUg/kY5laCNO+kKofMTgg==
X-Received: by 2002:a05:6a20:939a:b0:3a2:d68d:9e78 with SMTP id adf61e73a8af0-3b783b30f96mr4974294637.4.1781289165140;
        Fri, 12 Jun 2026 11:32:45 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:a073:5e58:ab5:a167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm2795034a12.5.2026.06.12.11.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:32:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 0/6] ata: pata_mpc52xx: fix cleanup ordering and modernize
Date: Fri, 12 Jun 2026 11:32:21 -0700
Message-ID: <20260612183227.20446-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several lifecycle bugs in the MPC52xx ATA driver:

 - The BestComm task IRQ was managed by devm, creating a use-after-free
   and teardown inversion.  Switch to non-devm request_irq/free_irq so
   the interrupt is unregistered before the task is freed.

 - The error and remove paths called irq_dispose_mapping() explicitly,
   duplicating the one in bcom_task_free().  Remove the redundant calls.

 - Replace irq_of_parse_and_map() with platform_get_irq() for proper
   error handling and integration with the platform device model.

 - Replace the open-coded of_address_to_resource()/devm_request_mem_region()
   /devm_ioremap() sequence with the standard helper.

v3: extra sashiko fix and platform_get_irq moved.
v2: add extra patch from sashiko review.

Rosen Penev (6):
  ata: pata_mpc52xx: fix NULL pointer dereference in IRQ handler
  ata: pata_mpc52xx: synchronize with task IRQ before resetting DMA
    state
  ata: pata_mpc52xx: reset cached DMA direction on resume
  ata: pata_mpc52xx: remove redundant irq_dispose_mapping calls
  ata: pata_mpc52xx: convert to platform_get_irq()
  ata: pata_mpc52xx: convert to full devm resource management

 drivers/ata/pata_mpc52xx.c | 101 ++++++++++++-------------------------
 1 file changed, 33 insertions(+), 68 deletions(-)

--
2.54.0

