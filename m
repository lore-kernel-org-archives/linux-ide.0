Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803383;
	b=HhIFmk/4rJGxE28VRrFK54nFINXQv6yVDO0l5Jnxdfr1Db4973Hx8egDLn/NUSS3QKKV
	 Wlih/909bPGh49s/mdgYU4fUkkeZgTNtBQSIVVWXsBArVXTyU8kjhtAX/ndNnHVD7c+Lh
	 6J+TWWnEXMKAGfr2gqjvN+xqqgB8/nbQn96qsD6GyE+nsnji0UPUu2mIemZc4V0mvHbsE
	 haKyUbawHlGgLlVsV/e1inhyC6r7hgMDKiwJfDiDWsVlNpb6nS3bwPSSKDi0z3lEU3rPT
	 pQaGjumnVsKD6yCngGqROt5r6iTT2nkJmhcTXEIg5O5O18CIQjpxunFhsIVQbkzretg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KIy7TZZfhfrJECmc3jAKv7NlnAuyqwv9Lb466qTdbJw=;
	b=P40VS9KIf0zgItdWSwKOuKEl6ccsiFRKqWT//fWaqZZ4b65iNpnt/0DSHu/HP4/+ejRo
	 maGF/zYWACcw1Nf+eM98sF96zEJOmZouVTN0u0qiNhkfZL51aewJTf/1BcncxSj8cMN/V
	 JqDJA09vm9hibiZL7fMwSziqX8X8Q6VK6c6UvgPrRlesGO1WWGyzwKsA0XWr3rtOvjvSE
	 /hLMzVwTgLUtU+xBXyyjYydgMtdvYrEaaRLHLEwxE9dh8CwQSxzYYVXvcxtBYfy8q9LNK
	 fOCpX/gfIDqO4xT340DQogFUGdu7u+nEMqFut39I7HC95kyfGiA+JTOrnr/HagRsuCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQDDU42Z;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C51606A31E
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C51606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQDDU42Z
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so3965252a12.0
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795803383; x=1796408183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIy7TZZfhfrJECmc3jAKv7NlnAuyqwv9Lb466qTdbJw=;
        b=PQDDU42ZgVj0QoQ4uepU/7BP4KlD4Nn2+zzFk0PAhAz1Yef2HrqqTHLasU+e0E03L5
         d4EhvDveddYJ3mfG6iYfkMrDqwkcxRoEdMnm8VnEgDxTZHOogSzUIy5jrkxiU2zr8ndy
         PW/29QqdMV/IgOL0+ytSRIL0r01SrWM/vciOyue+nHvGAaDPnHGuaIcOl5YdfI+gPCwd
         4K+mySS/LVXfZxIlUetIT+KT/4vuPf3FD45/9hD1t/NEP3mdfcU7UW+t7/iQH8VKd+bY
         5DUU/eUl+xCvI60fz0PycQmdxyhOV/3AKGuH47glh6yVTn1SV0LzDObblanrCGOVPYH8
         gVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795803383; x=1796408183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIy7TZZfhfrJECmc3jAKv7NlnAuyqwv9Lb466qTdbJw=;
        b=L9mskkb08nEyNKmWBMucoyjJ06c1cHS0wAHOwoQTd/UdUbWZWQ6zdBkkh9YiqpyL6R
         b/ktiuFT0jmoJ4PZ8aJBVXorb8M+L5Xft0ouWHF25pEpgreDQ/5VSwPIwYrYf//IrBB8
         V7g2EyKetiKdtDL82sq1B57H1zwNDWtDfrPX3l33WWl8zi/8IYPsvuqgT1f+Jgw9Mo+6
         KtGubB6Zot2qHJB4woKFfVF/+gpONN4kaOJgSFSTBqrEr6bY6fJnhecwBFe1Mh35ZP0V
         wfrL+gwvrneHHprJXngTpGlIWcSCrYkWhVX8QUassCYM4h6IrFufFMctzqWDJrPx8+F5
         sgSg==
X-Gm-Message-State: APuU4Z/oJD1hUe0zx0tlw9ULtSAzbGy8KASDfafAcEF0IVXXOudgEHVS
	mSsiWAQkhbjupproSoLGExts6DyEXIzuaV8tQq4dBfFb+imDHtLd+4un476XxQm98XM=
X-Gm-Gg: AZFdTZfZI18whe3NicC7wcSQzG2b4v5yjFQ9Gcnb7Ijb1qNHDO2a6jwJXX7C+ed/x76
	WesjOGuFdbtjjUn6HmPUCJneJO2A3MCL6b/O47rwoGf5r/RLH8Qw7vVT8K9kFhAGO5QG4ARolDS
	yZsSpcL+Qqw1xXT3zQMKIBFHFYpP5yDHgsP0MStKNGUXk39dBsz39+Ezfd0HI+6fgTjiT/qT6iH
	0ARGMA40SsCbn047Ihry6fiZaZdBYdi/t1Mc6HypJReOdJdux0uMILyWgvbOS+9tG5PlRjZN3aj
	IKgxyAe/OQaLhceXP3+5UfWOv7cZP8KT3LwGdc/fqO2LQPGf63Le7s5VVHSMn/XdJIZCXHbZaoq
	7oD+3jmI6NsZFRVv8Bium4ef8fnceZmPavylhvIfsgTUr22MUcCk5Dq/t7+/fkEmrO4zDC6/J2R
	2JEEjeJkb8FiDRyCHFj2qy0xS0Q/2iUXcqGDJohjGMyHA+JL8od3SOGVm/Ar/H1zDLsNWqMKVow
	+4MgMS+QybfaGN0bfIYHtrIVHUodIo/ZFn94+ImuJSlnrnmSC5FZuFREwAnqhXBUfoJpXYpiLx1
	TQ/FzKHw9WnQyEsfEa0EVZY4mCShzia24g565tkF5XD8LjdkDQ==
X-Received: by 2002:a17:90b:1dcd:b0:3b0:bd53:8e5d with SMTP id 98e67ed59e1d1-3b41cb3e4b9mr20027678a91.58.1795803382825;
        Fri, 27 Nov 2026 10:16:22 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm39867121a91.13.2026.11.27.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:16:22 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	vireshk@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v4 0/4] ata: add missing newlines to error messages
Date: Fri, 27 Nov 2026 12:16:15 -0600
Message-ID: <20261127181619.183139-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds missing trailing newlines to error and warning messages
in four ATA drivers.

The changes are formatting-only and do not alter driver behaviour.

Changes in v4:
- Rebase on libata for-next (3391ac405dca).
- Resolve the pata_pxa conflict while preserving the updated DMA
  timeout condition from the new base.

Changes in v3:
- Carry Damien's Reviewed-by tag on all four patches; it was
  inadvertently included only on the sata_dwc_460ex patch in v2.

Changes in v2:
- Fix an additional missing newline in sata_dwc_error_intr(), as pointed
  out by Damien Le Moal.
- Add Damien's Reviewed-by tag to the sata_dwc_460ex patch.

Artem Novak (4):
  ata: pata_arasan_cf: add missing newline to warning
  ata: pata_pxa: add missing newline to DMA warning
  ata: sata_dwc_460ex: add missing newlines to error messages
  ata: sata_gemini: add missing newlines to error messages

 drivers/ata/pata_arasan_cf.c | 2 +-
 drivers/ata/pata_pxa.c       | 2 +-
 drivers/ata/sata_dwc_460ex.c | 8 ++++----
 drivers/ata/sata_gemini.c    | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.56.1

