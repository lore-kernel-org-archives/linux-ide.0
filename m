Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13C37B03F
	for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760556; cv=none; b=NLfjWHzoacEqPw2AfWeRzSpTYENTbzqTD5zg2mIXdeO4ge5D8cFXg6oj6vOlxW5yOOMm68Bl1qNaE2HQNxPSAcuZGypzZXcsA6sI957aI81HtiaOphqhBK8VJB2jLjGiFaeJLFTPZ+qg4IJMAfTFLeFiLPArL5mztTvSMdlEeMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760556; c=relaxed/simple;
	bh=VdYiVlAaEz21Hi+q/JsnUD7U1RNcR3aPRlDlKQ3I68g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3Fc7pZRxTlhGlJxJ7MRCjT+irTLR7Syi+skFdhBnsTcUdDBxPBAOhdvO1ix7bAL9ceyNjB63D82P0pKNjFEaJK7xLDCF0pSuRdCIB0u3Ab8i5o9M3eOoS8qHfhwxnqaZ5CCkZ/Ef7DeOSxp+2/u8/V6ASPD1wxRry6IAJ4yeRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am+xWD6s; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am+xWD6s"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c252e703fa3so85708866b.3
        for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787760553; x=1788365353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zVZDnx8w1K3i56E12CadQZF3S/QBfdgckzz9SPQi62o=;
        b=am+xWD6sMaQ/1o+4R6V8ERC0x3PueG4ZAXsxL3Gz8G7wl806hH+2oPJO6as9DGphlP
         aghPtJFudU5QGiWk/PbfCqgJTUL6MY6DZ/zP7GRZm6PAlfzMqgX7rUAHVD7xy86n6VhF
         oxlQNuGw8KKyph6EMpBNsBE/F1POCuYr34tsM1oAsZlGC7WMLpqyvomEZYTj10JlHYXU
         ld7B9KI0Xc1H7M/CVkzk3eISvPE5nHGvzORYUQai8U47c68N18dMl12b+N/jER4AAf55
         UVVzHz92Wik0iNS640RCwVxNlkcxVlTtIwBVa3DwPx9qITKGEGP8Kh1YqpWhIiiawrhZ
         ANaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787760553; x=1788365353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zVZDnx8w1K3i56E12CadQZF3S/QBfdgckzz9SPQi62o=;
        b=H7Nd4tkkExI6Tlyx2Bnj/mzDbm+tcAS1k4OTd0z2aNSGOnKWqNmIKxXjq9eeWNFHIk
         8FvotuB/vpyJ5hkN5hpeXDKupOUvLhBFQ5z5lzcfR23Lp1gt8o1C5s4VCwbkUbjKzbtq
         RGwwxuaKOxge89zplGGA2Lb04KDuot1OweXcGwENP9GRrGoOM2BvftGUDEnPBOruHrLP
         uASJFFJhZi6se0GR3oNpniXb1SsZZPwV6c54x5K0gVsJDopVfs97wUBxeZjinRZNTU3p
         duHbFOys7xt+z7jHyZxiN05trpQcgn3irtbpV6aB9o4t6AFfon/Bk4vBNyH2jSPja1Ny
         oDww==
X-Gm-Message-State: AFuF++kZ9tY/CQlmyVA90VVtx3m12kT/6GsoekMvKiKhHXIhI/UcPh5G
	dc4l3lc+5ngwNW7HQCFPO+cxnwRga8wbC8hP1WLYF3Z34qUS6LfcD1cM
X-Gm-Gg: AR+sD113kcucGTqeDp0zyKRBM9i2xu3K/aiM1gG5dJq4OD7jzkC2vs16nRXhb4GQXeR
	sGT2Ug2rFZOmJVSTxYH2YLgRT2CcJoojWdF1Q7jPs4IRWV9GpCKMXBpAiVxNjw52w2lLC9nNenS
	pSWHbfoyTTJQZOFsWfumOSOb9ocOCjV4hzUYT7ibkYC+GpeHqqdaBq9e587pm0Ow1WdztadHUrd
	nEk05CnOM/qccIBYDQI2FSRcSPn7Vx2mmLr8UEVWB3cTpkToefnB3c6WAAg/XxFISngKELm1Us0
	4DFoHkA3orTFDUUbK5jZZH+ij6p/q17z2IQxx7f+Om6Oc5RnwESo860/iv4eIc6dkPT6toaLI9o
	TqcDVlR7OKocI/7dPf1Ozri+ghLwuYmmYcAu+l0Bkmreu0R+Hb1Z+CNKmoqZOzhaPjA0IegB07W
	iT1PTAXU+W8mLaxNGfizeZYrQHjf48JWvSFgWBQ4VYe3oS3L03SVctNjDkI37ttO/AndMB5kV5+
	5bg186zPOg1FugmE2uniW0L7km/SaNqBOO/c1xinnWl/PU=
X-Received: by 2002:a17:907:e1c4:20b0:c25:1b4f:6d95 with SMTP id a640c23a62f3a-c251b4f7a1fmr632539166b.6.1787760552958;
        Wed, 26 Aug 2026 09:09:12 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:78ce:12f6:160d:28db])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25271e4cbcsm386050366b.18.2026.08.26.09.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 09:09:12 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] m68k: pata_cswarp: Add Amiga cslab ata support
Date: Wed, 26 Aug 2026 18:09:09 +0200
Message-ID: <20260826160911.460165-1-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a driver (and the subsequent defconfig change) for the pata/CF socket in
the CS-Lab Warp series of Amiga boards.

This is a respin of v5 addressing Geert's and sashiko-bot's review.

Tested on real Warp hardware.

v5: https://lore.kernel.org/linux-ide/20260824153339.512487-1-p.pisati@gmail.com/

Changes in v6:
 - fix 7.3 FTBFS (include <linux/device-id/zorro.h>, and use named initializers in
   the zorro_device_id table)
 - use devm_ioremap()
 - print the register window with %pR in ata_port_desc()

Changes in v5:
 - return the number of bytes actually consumed on the bus
 - fix the trailing byte in pata_cswarp_data_xfer()
 - drop a blank line in Kconfig
 - fix the remaining checkpatch complaints

Changes in v4:
 - refactor pata_cswarp_data_xfer()
 - ioremap WARP_OFFSET_ATA region

Changes in v3:
 - suppress a comment
 - properly return ata_host_activate() error code

Change in v2:
 - fix style, remove duplicate swap macro, driver version, etc
 - rework the zorro attach mechanism
 - remove the unnecessary zorro ids refactor

Paolo Pisati (2):
  ata: pata_cswarp: Add Amiga cslab ata support
  m68k: defconfig: enable PATA_CSWARP

 arch/m68k/configs/amiga_defconfig |   1 +
 arch/m68k/configs/multi_defconfig |   1 +
 drivers/ata/Kconfig               |  10 ++
 drivers/ata/Makefile              |   1 +
 drivers/ata/pata_cswarp.c         | 183 ++++++++++++++++++++++++++++++
 5 files changed, 196 insertions(+)
 create mode 100644 drivers/ata/pata_cswarp.c


base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
-- 
2.43.0

