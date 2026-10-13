Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7302D47F1
	for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 04:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865787; cv=none; b=smjKrdoODkn/0ojpL1ZigQ/FyOyr4pUi3mPyF2hNGc+vQJNyfDVKF87kOlLZoNM7kCNjdjebjm55DyslpQEhU7Sv4iAAbgVxcGzV6tNBw+2AKyLxf7R9wjLSBpYrvckxyxeUJy/AcxKliOoLHZF61VF+OIkyg5A/aT2LDjkdBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865787; c=relaxed/simple;
	bh=lM1LwsDLTDvGBMMBnJN9ZSmxkm8H+5ZX0wZOnHV6WOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wj4n1faMTMy/g5xBlrq/Pv6k2IXT+hPhUt7NScrT57pX/u+6vN34z1j45orCSykaiiIFp4EfMYt7h/Ecv0epyx7YfdcJQ/Up7cIx5SgkO5GahgVwbJV7yyUgYBGofST05WWxSraoXKqS5400eFpQrzTTC2vKOYLNaF2yamXQ8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBVMzTEe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBVMzTEe"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b0d19cf7eso3040661f8f.1
        for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2026 21:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791865784; x=1792470584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MYkfvP02qXS9uLK7EBxCu97yAwHyUsHYZkWtUbhyPlU=;
        b=OBVMzTEeNmK1Hu0h0cCKEDjAqAr7WSxr9AGlz4DNvhaVPk77znuP1AD+Avw21pck8v
         KAy+cNg6XB34a117+3zRtRoIRkrpvAKtt/Di7aOhrBhg7xepXKBTx1FEyNRpCRNkp0g9
         sQBDWShkllQEaydQQUiuHBJU8GZnuXkB62yOAG0SZubLat5lz1iUPZ/6HQdvgLOFWJGp
         eZIu5ZWDDQhcCSkZGl2zeS46rDC0uuj5A9ERq6frwClMYw9JXuWG7L5PzUJY8h2lf5/g
         PM0iGpzoG40j0FlfjtS8J33E6tj0xxXxqYVG/v+/6HGC4vkw9In92QyXPmxSBDR7ei36
         C27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791865784; x=1792470584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MYkfvP02qXS9uLK7EBxCu97yAwHyUsHYZkWtUbhyPlU=;
        b=SDt6va5dTT0+GoHhS7epOgRo7dWp5poJdpVAdT6hnTgdjq0gmxbgk1l9FcILIgKQsj
         tZFwP136QbpIFg26Hjspk0bM+35laIXCoP14rvgcwIcOorZLN2y+WiO98CUlyXtecd6g
         P631f5HZTU3CIVPr516fh2rUoXUe2qwqC58Wdv41E0IZc1PDJn0apdn1ns3aCR9Afiw8
         ROgM94gk8THcIomVAnOV5g2shSq/OrZ1vbWxEVG6XMoHmZeomuY7g41KGeHYx/CyzQ3E
         8CilUcjuw9SatKDGkoKYCIlKDOKVeqT8gDQnhCPH69H6xNhUxMAd3iX8ey8WVeJt83jJ
         9p/Q==
X-Gm-Message-State: AFq9FYJt4/k9hzyKfcafVEBpSexDOmfKyxVGd9EdceP5/o9v3409MwJD
	+zptnC10hUSx14a+HfSlIKZOwQ6weAx8eEJmFlmkv7YVMJRPACgL1ASn8XwFGjuT
X-Gm-Gg: AYBFou3iltCcGHheKmiw26B9Q42RWv1i05FPbW7IDZTsFZSNfDXpPIHi85pzEle1XLd
	aDfPsuDoJM43wKgrRMwAh1RIN0xP2qBo4kB1todbFhcAYM96m/uibGLQUa10AM5MZKsvt/ksSsJ
	4lSh9pZL5+sN5CKif/lqS4CDVLjcsLGZ9SDfETspI+xAPs6xXmi0nngHA0NqqClqzXLnt1mXDUN
	iPA/w0H8cdqADmGlJ0UQn2u+Ejcx3w/s8wUE8VLkk0QHb7pt1lf+7f8pLdEJuLhe/fcBpDik3z5
	4Oqb7pmlOEfYHiL1pKJFZ2E5+peZjySSlgVHerbwePAp1ZJIY+JHZZNP3sBM8n71Ubf3NRg6Yd+
	Njz5/Av4vrvgPEvUA59XKzdk//dvOB4DyWQrZK6UMTyic3Eu3Gj9ZAeW9EEctgZ9shGm8axtuj0
	zWCcBUrKac5cV4lzSyeYx9NRLiiGgxdhKEcF57TuXcegy9XylH/vdD7GRAQ614DVIx53W/9HJw
X-Received: by 2002:a05:600c:4708:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a18e4a6ea5mr224503555e9.13.1791865783690;
        Mon, 12 Oct 2026 21:29:43 -0700 (PDT)
Received: from jo-Z6 ([2a02:586:e82e:5000:7fc2:feac:cb16:51fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm364772485e9.10.2026.10.12.21.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:29:43 -0700 (PDT)
From: Ioannis Barkas <jnyb.de@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Ioannis Barkas <jnyb.de@gmail.com>
Subject: [PATCH] libata: Fix wrong HPA horkage
Date: Tue, 13 Oct 2026 07:21:46 +0300
Message-ID: <20261013042146.76467-1-jnyb.de@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 Code wrongly filters disks by their serial numbers

Fixes: 16c55b038033 (\libata: implement BROKEN_HPA horkage and apply it to affected drives")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=8888
Signed-off-by: Ioannis Barkas jnyb.de@gmail.com
Signed-off-by: Nick Barkas nickbgrk@gmail.com
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 59e87b987d..b23e1c3e4c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4248,8 +4248,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_QUIRK_BROKEN_HPA },
-	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
-	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
+	{ "WDC WD3200JD-00KLB0", "08.05J08", ATA_QUIRK_BROKEN_HPA },
+	{ "WDC WD2500JD-00HBB0", "08.02D08", ATA_QUIRK_BROKEN_HPA },
 	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },
 
 	/* this one allows HPA unlocking but fails IOs on the area */
-- 
2.53.0

