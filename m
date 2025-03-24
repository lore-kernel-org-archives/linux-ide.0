Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002C18A6C1
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818611; cv=none; b=WsHOwrVsOs7E8dwdz4ErLaNJyALC3gkgpAqW+sauPwry1ijUW2gymkezNn3E7UwjESXavM9/74MseJYqfY/YhVva081IT8Gx1tP6drnk2DZxiWOlXu3NjCdFai9SWiCHN5292B+R8IUcEaS5uOhdYypiiwsvUgBg2cfrVXUUM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818611; c=relaxed/simple;
	bh=Zd9O3wgUBveXcpIkFGnAl7IKOr8i7o+05htXPaF/MPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CPtmyHW7EcgJ9y16Nsw8hZpilcLRAqN42LnelxU9rDeEUMVGwuJfk0JmKDH50gM2Lx5aEHft7DON5KlJtFEGZPqaBRp/C5+CJschQClByU9zz1i0CyvUdVSA3mlLFE1rU+C+8yzt1TrtM+yqPT5bqeS+l+8rlCoJTNyQI5roFJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD2dc4pU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD2dc4pU"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-391342fc148so2911876f8f.2
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742818608; x=1743423408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+H8UDgPvKl0q0KE4YlI6KMrCDjDegTtPX3i53ZqeH7U=;
        b=dD2dc4pUaYueVQcQh818WfMkrKk3lbGjok0C3uMyQhh5WnGXwj4IhFhwoqKsVhEV8T
         qv8ilJbu0nZsEKJDm5H2vpN099qTvRJ/nWlL3mpIrm0IP8hj9225GtV04MlOenUJH4Vh
         0LUxV2P+bY2QGvgauDXjo93adyr2pbAP/aL5q3uy5UlmVtd+G08DIyM2+wJL8PcFakNk
         ZiHmKCkZYwb52J+n/eDr0OvRtYZc5gr3UzL/TcTwcEhoj5O19jBUY4zN3I3pZGTCpr8U
         F3SFUiMii05QtqFv/i1wsgQUy6NOhG6lFqMNXs/gqSprirrrC+PVfmmBRiSj+udGiO80
         7Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742818608; x=1743423408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+H8UDgPvKl0q0KE4YlI6KMrCDjDegTtPX3i53ZqeH7U=;
        b=wpQz8tmzfP9kU3DxFNs6255RJE4DrXcQ0L0KaQWGKnJrAp3P6uK2dAX1Et4mtXXmpL
         Q1XgoZnX04hYIWEQ3EjgnTe9WBeqU4n02OJ8nplXYrG7X/plXDEF1ZeDA+KJFhsBOq/H
         jWCi2MEd/Zx/kOGKugcEuMyHBzJWbGDO+sSBySsxWsRmkEbFYvwDsocLOYsQaD+f42I+
         ZJS/4Q0PeJ6MY1UVhY7OBcTJ8pbebOJfPBRgeC7Htw4Nnmhn6eu4z1K3d7RnWb445puC
         CaSBOx9/dQ3jEsdJ/ezosjEAqEhTMZtPUrGQoUUxTy9OBCT+GITCMju8hnlBrdfz31tA
         fFcg==
X-Gm-Message-State: AOJu0YyGKnH5W6NA7qPy4IfhhAj6V68ITJrNQ9uAOm9NS2S0W2iiYrXj
	X4dIIcNu/Cs20nwc0bvdy4PEQsNBDu3Zb+kw2xc6dXfa8OR+qSVWrE2q0/OQ
X-Gm-Gg: ASbGncvr6+QqXQBAVC0XidmgmK/6/cHGxU+fQhnbhFFx5hygej/M7nekN+ic8SON9zR
	KujSAEuKGyv5LdAC13IsPbs/xHWv2p1/yuE5kUZ6q6RT5v8yx69T3mY1DU1XSvkZ58987Nzo6cA
	CUg5eL5gIkYgr0EZMQmYtRp6Lvs4EhoGVd8oo5d2sZhro3P+DGU7+PDLTVWfLE+KTVWwRqUlAjX
	WI/KL/fmoQKPklN9D8UG2VAsq86uuiAvZv+H574jDWKqkqtk90/FekUDjRnYRrDZ/WZGfWXzcra
	GnWSTc2wLijDJXcYSNZs0vuaJe6xJI6LdPXNMK8x2oE=
X-Google-Smtp-Source: AGHT+IG/6kcJD1oo8dsIlQAJ4NNfzobfsMiNQ9/vxprxO69/IzfHBZ5ZIAbDY3eVWJuy5oV008sXvg==
X-Received: by 2002:a05:6000:4009:b0:391:300f:749e with SMTP id ffacd0b85a97d-3997f8f5d96mr9692105f8f.11.1742818607412;
        Mon, 24 Mar 2025 05:16:47 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:fd58:9303:2c1b:4279])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6651sm10824083f8f.75.2025.03.24.05.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:16:46 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH v3 0/2] m68k: pata_cswarp: Add Amiga cslab ata support
Date: Mon, 24 Mar 2025 13:16:43 +0100
Message-Id: <20250324121645.208368-1-p.pisati@gmail.com>
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

Changes in v3:
 - suppress a comment
 - properly return ata_host_activate() error code

Change in v2:
 - fix style, remove duplicate swap macro, driver version, etc
 - rework the zorro attach mechanism
 - remove the unnecessary zorro ids refactor

Paolo Pisati (2):
  ata: pata_cswarp: Add Amiga cslab ata support
  m68k: amiga_defconfig: enable PATA_CSWARP

 arch/m68k/configs/amiga_defconfig |   1 +
 drivers/ata/Kconfig               |  11 ++
 drivers/ata/Makefile              |   1 +
 drivers/ata/pata_cswarp.c         | 186 ++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 drivers/ata/pata_cswarp.c

-- 
2.34.1

