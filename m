Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8618FC80
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808253; cv=none; b=Kkmyec2C5cTCfrHLg3/gy2MR+nhiyTlHTvmvtBOXkyDZmByAsCIRUoJRWZ8o/J52aPPoVq5akdwlW4FecJatTLZY/AcGxiiZ8hSUZXNPsfKouq6TZwfM4+U1/aVCE865sHvjVAVShyNKm2murEdNn8jwX0VpRAyqN6RmhHqrnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808253; c=relaxed/simple;
	bh=/5DkWOtlh5PExKlDAqKCsmgVBbScymR7T9AWiQdu7No=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T3L09mudcrtPABIkRKUVNq1wmiHf/kSeyedyLLNHGw9D+90zNUjARNbF1HHSOXcFxLETuy0NR6v77EvD2e/k+CjZHOMq795qTiF9U2NIfOnMYHzH1sJnETLmgMLuUVU0I93/t+xclrQrVRp6I/+f0NS5aFcLfGBZ+cijXr5n+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTc3lV64; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTc3lV64"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so30665015e9.1
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742808250; x=1743413050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ0wnKYbV487dq+b+o1/rxjti8vI/jxBBD/gFZexICs=;
        b=cTc3lV6464kooe2CQyayhdvhJdMg4BO2M666LceyqY7dd2zaXd36hHUmzUC6+sIMla
         cOOOOufNTLORPO9Jj7yIzHEudo9RB9o51sdtrKT7+8vATwEEo7gPaXS+6/DdnrOUuObF
         TjkpZNSiwPYzKlYTEX9YBmIu6hBM7tKLmrW3LgLjzVEtlbxWFrq0OSDAU57qx+qlMXl4
         uEjm2pKWh++TBPIU/erKZEY6eXPqaFvKVxYSFywFMVAuFoZrI3/krH0hTVV7OuSn16P5
         BEubuoA6RjRJniI55k9VKe8xOIl09iwdGf/5SrzTI2LW+AGm76izIbSlUST+oHlsddH6
         9i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742808250; x=1743413050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQ0wnKYbV487dq+b+o1/rxjti8vI/jxBBD/gFZexICs=;
        b=imKJMj6GcobhNBDUiaVOY8AYYot6Xw10uF3NGi0n7b5R8m4AncH49U7AVrpcLqfS19
         ST1ExFX+klOWk1WFgrMfRnmso8QNz9/ooa7sjztdiVK5A5c8ox526+xMUSi0zPLZV846
         /iQJfZxk6rGlcpAeOMSoCsne8i+qHXCqg7g9nnOe1KL+GaWpGLErV9io1jS2on4DoKeH
         hgpT/psW944FxIzmTsikOzCq8kNdNxv1QtXxx9C1mrYTWrt2suxIl3324cGIThEooXc5
         SMEKG2YyRojYHeWsLwQrfHq3UG6Qm4cmnPHYW8PZZ5sQfOzM/asyDLMfbw6END9g0jk3
         W2ig==
X-Gm-Message-State: AOJu0Yys7I0uX8klMXO2Wzqnvu5wvMQbiAjCxBcdDhTwGbdyRNie3l8x
	A4xFPRKQBYfJXPhkDnQM/IooqTzszIQNudRlNBW3MJyHI1OAH+eE
X-Gm-Gg: ASbGncuSGXKrhY1RzD49NS92UbK3cchRsiftBLV76bQNqFAWKlcSc27u/wczqmJWif9
	i5CERF3N0cu28xz1o+U7Ct1ZAjClWanNZpHnFE6PdFp/rjOy1r6Gwp9FQfsgyAKLdShyDMLdsgf
	gMalInLSEJvVoxEXAhYzrHGkukOVB3ZgSI+VZA2FxGpZdKfHf5Kc/Qd4ihw1YxH8u1G9RNVau1f
	rqoIOV6xB/vnbkE5vc2/63bEmf+Em5XaGB3IcGOx0Na7/n6cYVLlruBa2kYIsIsJeXVumw7sC65
	jIMCjr9RO0O3UoZSM9BYwrDwVJPgc5xgxYFIAeAxKWU=
X-Google-Smtp-Source: AGHT+IGj6NFz2IizfSUALMk8pF3LBDcOaRaMhYM9d3l4Vt/DzpUttY0gjbOxHsxLsHP1hGgJnUT4KA==
X-Received: by 2002:a5d:59ab:0:b0:391:43cb:43e6 with SMTP id ffacd0b85a97d-3997f937c30mr10944042f8f.51.1742808250368;
        Mon, 24 Mar 2025 02:24:10 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:fd58:9303:2c1b:4279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd27980sm115645745e9.21.2025.03.24.02.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 02:24:09 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH v2 0/2] m68k: pata_cswarp: Add Amiga cslab ata support
Date: Mon, 24 Mar 2025 10:24:07 +0100
Message-Id: <20250324092409.99430-1-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a driver (and the subsequent defconfig change) for the pata/CF socket in
the CS-Lab Warp series of Amiga boards.

Change in v2:
 - fix style, remove duplicate swap macro, driver version, etc
 - rework the zorro attach mechanism
 - remove the unnecessary zorro ids refactor

Paolo Pisati (2):
  m68k: amiga_defconfig: enable PATA_CSWARP
  ata: pata_cswarp: Add Amiga cslab ata support

 arch/m68k/configs/amiga_defconfig |   1 +
 drivers/ata/Kconfig               |  11 ++
 drivers/ata/Makefile              |   1 +
 drivers/ata/pata_cswarp.c         | 189 ++++++++++++++++++++++++++++++
 4 files changed, 202 insertions(+)
 create mode 100644 drivers/ata/pata_cswarp.c

-- 
2.34.1

