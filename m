Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998042A169
	for <linux-ide@vger.kernel.org>; Mon,  6 Jul 2026 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371673; cv=none; b=kkTrjPyGu1rNhBagoo1GXmSMutMi7hRdE7joJOpP26kFYHeOptfxxWLqbEzRJqthHXB1ctHm1qpiAz0+1xd0Vt+5Cq7eh7vJDJV5Q059mqehXgMLdbj0PzWrDKPFAj0T2tYZ4hQmfq6tburab7QpoyJFJU+HLTygKj8fts5/tMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371673; c=relaxed/simple;
	bh=AUsdJIwhx/8wVrjpLpGu9bj0SdXuTRaeDaoVf0zlRbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tzIXOliTMC+DWkrvbogkpb6fBuzoAEuFWduaciD5luRzFnUOCSbxivEWN33ZgKSfDr3qiTtCUQjIOtjE9deTUtD5gJfDeXfVGG+4cMbLxUMOEDoS/cX6daG0ba5t3QwRNMAM3hFh60Nqpak0aocEaaz9y+T0FF2tJo5DtA0Ifvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqWpKHE+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqWpKHE+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ccbb61893fso15090755ad.0
        for <linux-ide@vger.kernel.org>; Mon, 06 Jul 2026 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783371669; x=1783976469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7XCOgk7ctBSByIGDwcU0SJLQp5oIbrKOxK4NCnIYMs=;
        b=oqWpKHE+IUx12ZeaHoF2z46O4BI6trqnQp4AkygU0kHr/mq702UVn8JtTr4dQ+wpce
         VJxPNngplB1dYLYfA6SOD+2k6hp42ZufTfzsRzKHvTGTCTTEMR25yQoelHh0WKVx9Pd0
         u2dcMU1J2XnoQ2dlaO9F0MJ8vf3vae52vg3Z/KZg88nRlkKBayu+cLQyd8bZ0piDJyzM
         EpdflKzMW0FKXar4Pw0LCtvuxgs3J9Ozoi4mUHHg3QxcUixX74J2+3BMe3DGU1OIVrZE
         KmI+NkOR5AUyj/yS5eclL0xWG1yB9QtcshLIX1pFqH7bWB4OiGXR+snqNtQvexoChfqI
         Hr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371669; x=1783976469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7XCOgk7ctBSByIGDwcU0SJLQp5oIbrKOxK4NCnIYMs=;
        b=kgB0rZEOY3tkkTK2ehx51DAMWe5Uy5AkI952VsBbni4f4bajGyW48V7bAZ9XMtnzmO
         pZK021bZ6XXfZ2W6SdNb9bgfaD+JV4rPuqxfvcpRyVy2iDKoIUmLNtE9VkF2YvVjrpJY
         G2AvDXhuzEaTgFDYWO2bom5QrkusATf2G+FY29c6syJScr2WcXTEKnEwJv8hPei5XhLL
         H+c/KeT7of/XttYV7BMjxMsGB6r3MCrtInEc06Ey+NF9jYa+Apk60v8ZOE7vYGvCTVlq
         LyWutWl4kZuJpd4eOkCC2jp4KxDFHdQ8553xiTLP8bD4FwZ28wsUIQzMbLlGi+uYBTN7
         M0lQ==
X-Gm-Message-State: AOJu0Yy7vmFkrSU9Xrhx6OSFIQGyH30n1TpqWYGCVhL0B8DNTAAFSAX/
	GJ7QkJDEX27PKvCYIJVrGh9JqR3R8ue+m4tYXT8qfQuhOyLJwhL6xzZPO3vbtxdzC7eSze7Igu6
	hWnPFL54erENI2w==
X-Received: from plw20.prod.google.com ([2002:a17:903:45d4:b0:2cb:97d4:2e28])
 (user=tadamsjr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:15c7:b0:2cc:777e:a878 with SMTP id d9443c01a7336-2ccbee1e07bmr24202235ad.26.1783371669268;
 Mon, 06 Jul 2026 14:01:09 -0700 (PDT)
Date: Mon,  6 Jul 2026 14:00:54 -0700
In-Reply-To: <20260706210054.1336654-1-tadamsjr@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <akaHPScetfl1VbF8@ryzen> <20260706210054.1336654-1-tadamsjr@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706210054.1336654-3-tadamsjr@google.com>
Subject: [PATCH v2 2/2] ata: libata-core: Allow capacity transition to zero
 for locked drives
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

This revalidation failure can occur when doing a reset of the PHY (e.g.
hard reset) for a controller that has I/Os in flight. The timed out
I/Os trigger the SCSI Error Handling (EH) path, which in turn invokes
libata device revalidation. If the drive is locked at runtime (e.g.
it lost power during reset and relocked), revalidation sees the capacity
transition to zero and fails, eventually disabling the device.

Fix this by allowing the capacity transition to zero in
ata_dev_revalidate() if the drive is reported as security locked by
ata_id_is_locked().

Fixes: 91842ed844a0 ("ata: libata-core: Set capacity to zero for a security locked drive")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Terrence Adams <tadamsjr@google.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3c06a15952f8..c43bd28b20b1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3992,7 +3992,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 
 	/* verify n_sectors hasn't changed */
 	if (dev->class != ATA_DEV_ATA || !n_sectors ||
-	    dev->n_sectors == n_sectors)
+	    dev->n_sectors == n_sectors || ata_id_is_locked(dev->id))
 		return 0;
 
 	/* n_sectors has changed */
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

