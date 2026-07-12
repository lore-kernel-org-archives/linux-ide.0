Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D53438A7
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892252; cv=none; b=RjVcivlU/JSPV4edPhb/dx1bmagAu5Ye9ICVbXZbYEdKhfoRpPY1udR0b6OxZGmgDqTqC1bxPolQeBSPBnKlNuSgHX4xQoETqCexV8I+2sKmVvRHALxOcQid9WjpGW9wZw0SEeR9SFpp96ylq+0+KNk+PYTp9UCWrb3fwVXNei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892252; c=relaxed/simple;
	bh=whnJig0H8hhy2NPuQ5AcNZFvNyqBmE5EnYK2umEYPRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvvGBY9H21mm8jgFasJidJFl9p4IALn8JlS4c5m9LGZEokNucrbfQj95Em66xG/Qb69HRCx88CHMRytXhleNfcYaLlWDGRTqcpElxuQyP2CNd8COt9GzMRggZFiM6zm/H9BHvCCgLt6pu2GzsLAQQZxAtlF+6osxOwPtwDM1GPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phhdizXh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phhdizXh"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso24652495ad.1
        for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783892250; x=1784497050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hve8rc8/uhAP5tnw5Cy053MuYhImyFXXSM86paHl2bk=;
        b=phhdizXhbYGKg1QPxd638P6i7KpxU1t9kEbqBQ2dTYlTiEdZKFj3Jq30GIbkW2Ww02
         OD6aVSaSW86321acXRlEQQyPK4g8G6uFFrjNf7cPiA9AV2ViHaDPBp6jjzoLPzkXJCPB
         9xtuwkP7m0r1tLP4FTTF1iY2MpzR67ZoPVWQONbwmeNdYtWsI9qlWOl07joUYVf1Pd6V
         PvjhqT+ZN5pp1w062Xt/0BDu5ceJLpMoPo6Md7q4aPGzGRmQhPdvIAZKym5uurpl9/YF
         CoK3teeBQQsDyYYJxZejhqQpqmKdBtvplJ7TeNGgO5XONzbzCSZ0Y17lcxl0hxQdsmxS
         pnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783892250; x=1784497050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hve8rc8/uhAP5tnw5Cy053MuYhImyFXXSM86paHl2bk=;
        b=N5/8Zw1DYsxkIHRUjh/k/52iISkhyC5zdxGX/awqAHfcgkoEe/9LzMiDIX3QijrsWL
         /PQAITt0N/BPwEoCgE/zQSqYQViDW7NuV/vfPuQ9kHldd4TiMbgfGmaBD3/Rp5iqgzJJ
         Js2Ra7+ckKlJSfB9x8B8ud+lTc0xe1l0hcDDazXqoGvPPUkqgg9obTk1XnJ2UNXNcmv3
         4moj9A+Nzj+LazhybYQ81sXlJlUlk3cCH8o8bmQURg4iZwkebUiGP7llwjsuDuIA+0Ap
         vLbeiWR+9WxkKqfQfw28f2CpUfMeGHMvy5YfU9GGdB/SXilm8zNMLOXbGsFZpSXL+Rvt
         DCPw==
X-Gm-Message-State: AOJu0Yz4HhFTCC3VrJn+9j31V8OZ1HcjtwXah2WjVrIEAPnipir/91Hj
	mTQx+R0D5Az35CDPA3LZXONNGIoOCiAiIUTGfq/b9AGC6v9V7JL+7wpBkJyp5A==
X-Gm-Gg: AfdE7cm+NCtN+yJ93nxSJ0ASjzYdiKtQcter6PATA1P9jhv/jdGaQoZlpjmFS7VaKoX
	EXCV0hMhSW+5u9p/gtZGHke8U+QNlLeissp2UMjkLMeS8jKdX1C3zt0smBPqKBtSDvjpCLo2cpc
	og1CV4030wdVEFa3fs1xSciWKC+sU99jU7XAly12rWNGtXzXQPEmUwA9tXziOF3KYmdQ4KSlHfX
	1Da4lN6o9ToaDQRx+F3cX7+y1jEdrnfRb3GqrBw2PhvB/TXyijVWDN5RnjzJ+/RC0tZOp/3DZy8
	lOJiYHvYOYBvXgCAvlk3dL5/1qsDBryBx1nJfa6HqBW4ksUC/bux4dmeerbrL/rMHdKt6kXGTS6
	tg8czE3r7UyDEoG+PO4g1anYPqvI9pK2BjWLyU0VAAPaeDFdNUuZB0W5bSyAkpK1tn3BpWvFDIq
	4xxYhrFc3gc1jEVLBR0E0THua6i4p0IAAMaXdp5Q8OVZ8z0tT7D6KyFmh87Cg9ou0N74mP2CV4p
	hKI4jw3f0v4Gp9jpFu67Y0E2A9+5ZwvbB18SgMYkwS4saYkul2UXtmc2bS3f3Rntw==
X-Received: by 2002:a17:902:e844:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2ce9e795bfemr70143875ad.1.1783892250530;
        Sun, 12 Jul 2026 14:37:30 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfb7aesm89082605ad.29.2026.07.12.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:37:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 0/4] ata: sata_dwc_460ex: cleanups
Date: Sun, 12 Jul 2026 14:37:24 -0700
Message-ID: <20260712213728.824420-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various issues flagged by Sashiko against the original submission of this driver.

v4: remove interrupt fix
v3: Shrink series to Fixes on the initial commit.
v2: sashiko fixes.

Rosen Penev (4):
  ata: sata_dwc_460ex: use platform_get_irq()
  ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is
    registered
  ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending
    interrupts
  ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion
    bit-scanning

 drivers/ata/sata_dwc_460ex.c | 38 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

-- 
2.55.0

