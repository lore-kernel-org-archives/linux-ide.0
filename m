Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BDD1D95A3
	for <linux-ide@vger.kernel.org>; Sat, 30 May 2026 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101407; cv=none; b=Z0LiFGeudqCuMgwKJbMviqwJ/zs2P867SuLVIDt8dP8JI5b6RIHOck2RtDPcWF6gkMRbzJLhoKbtYJJSyMf4/Plg+NdBEhaAig/FHwCBHslhMqWQtn35giqlQ9iFcfiKsdIe1/T/VvzdOyW0b1SyzyJ5bCyWqhOwJ9dH9D1pVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101407; c=relaxed/simple;
	bh=EX7CPFi2wgZ6b4HgpmC+owZgi+uK8/294mB48KhlYQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWlGjk4nobKRYg0/4wurkjx7jjrLojrNcDdAbuNPEq6COg3MItuCEPt7IhooOZHizOBidWetZhLczD62iqCDLIVaKVT9xyQG3V9/KDgxbzAWCVZfLxvWFG0R5L3o11RhM//nHbqp2EFB+ryADsx09Y6wwyyGmojK2eZ7lmJvO5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3SDL3uT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3SDL3uT"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-841882f8f4bso2786221b3a.0
        for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 17:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780101405; x=1780706205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kS5l+doIHqLHkal1S6c+wzj8Dlwm2lkkatu9ikBCus8=;
        b=I3SDL3uTeJfaS6b6KF2CjPG5Gg9X6UezT4EzVcLpX45231BIe0nWEdUh9MmO38emCp
         t+bVmdC6PDmezr0hP6+Mcpa23wOtup9vB4CIILZ0vtl66K2eFXdVhj4KBG4606gvfCfw
         8QYi5WHROCnrKtEYfHN7KBtrgK4kD9N28WnhOheP5QwFH6q77xDizSPa/IrCxxIs9m2w
         M1Uptysb4NHihEd24nRavhn4Rn9bNKYQaxsShTAdGg1p/E0QeeHX3WvPLmdSENnNoDFs
         uMyiSz7XX1UPnnGi9zDsnbwUQ3QanxhWV9g9kPsv9rLUknRwdl9DwUSeKfIpwNIKDyRd
         NzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101405; x=1780706205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS5l+doIHqLHkal1S6c+wzj8Dlwm2lkkatu9ikBCus8=;
        b=QYqXZ/XFQ2FbUY0dPP8g90NATN5GBZLvmP/CkHnUKbE4TGKES/Rz+3/bDdIcCB+4ny
         M7fqgg/Xy/dZN24Ho1VFgtzDMoNDRAAvIQAvm8K3HA0NameHkkuPM+MRb80h2b4Rfj3z
         +z0tu7EJ03NCXlArSmalINklFep5H85UactEGakRnf2U7rS7/ZhYT3wAib/K+K6Nb399
         iIvDqh7xJ3e647Bt7opN5Y7GNstmAg1GczcgZp1sAa056UDHNBRSVBRhfl5N2QTENgHB
         SfXWDUNti+u6vaoMoGXIRwgjciFMj6Ibb/+YUPTAZCNpekPZUaimh2FUrIxp3nkR7WFe
         wvpA==
X-Gm-Message-State: AOJu0Yzfnm/S9hrUQC1785eOzd9ezeZgLu7vx6UudQK8Vc81wZb/WDil
	/Gc85A4BV1xpUkwaeONtSL5BMLi6uyiJ3pN1V4BK85SmtZVViaql4JktfMiqLg==
X-Gm-Gg: Acq92OFGuFCfmaNJY/nd0zf+TAr7o92PDtZZCrToea++NFkboH1YEgWFwZeXKuCGBqc
	iDFSnZmjT7OEgAtao/pMlHfDQ7NH8hDmlNL0UpyaoC+4+VHPyjYAHjEfReOge0/Ju2qHubG8PYA
	QIxrbPKFIh8gjk7w1IHTRVlGoWIQY2sDL7HZfelIdg9ICgGJtL0DIcHS24HlJevcUPjy7R7c/+g
	S3VIhYkgZv2Ws+J2ekX5NCO4iIZs4zP0V5GNHuVmjltpM/fTGC6MZDWvHsswFcLSTKr5rmBpcPE
	7YgOLYygU8e+Zydk4vOSxRpqexwOSjzofCJA+TDbCmsr6K3knLqPYv+TxC7YUoxhJ0AXpyZ2qfe
	9WGwf3Ok2JkxyjeuRsy3TxiO9hkZ4Mwmk6pmtSxkdePZZttkSw3JhrnVbvG7VzgbuLVglncm39R
	J5JZ8XWWRfgb6hv+CKu/fdbiijJlT7PjzLy2U8JNGGkRdgqckRCi17KXvEz4OrIKTiYHg4Kiiz5
	FMVoTs53ki2ohSyF6crmhzwwqiD68iWy3n3YEweZFZji0XwtAoI1UVR
X-Received: by 2002:a05:6a00:4b50:b0:82c:d7c4:4c5c with SMTP id d2e1a72fcca58-842253ce428mr1649521b3a.20.1780101405339;
        Fri, 29 May 2026 17:36:45 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm3705769b3a.13.2026.05.29.17.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:36:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] ata: pata_ep93xx: COMPILE_TEST and ARM fixups
Date: Fri, 29 May 2026 17:36:24 -0700
Message-ID: <20260530003627.42473-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series cleans up pata_ep93xx to allow COMPILE_TEST on
non-ARM platforms. Patch 1 avoids including ARM-specific asm headers,
patch 2 switches to unsigned long for the data variable, and patch 3
enables COMPILE_TEST.

Rosen Penev (3):
  ata: pata_ep93xx: avoid asm on non ARM
  ata: pata_ep93xx: use unsigned long for data
  ata: pata_ep93xx: add COMPILE_TEST support

 drivers/ata/Kconfig       | 2 +-
 drivers/ata/pata_ep93xx.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.54.0

