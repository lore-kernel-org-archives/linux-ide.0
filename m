Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE181CEEBE
	for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570062; cv=none; b=fMiX7Q+7TD2Qs1b8Z67E8vbZRJ/EjalSAWRaYq07CIKra7qbYvBMVTHgB3U4aMvfyF2sX8lQaiY/znL3DQs64UQTRX5QgfqjIyQ4QS5TD12WZanEM47tufZdSrffQAJvHU0CeO+enzVqNIRTwqn/QVLNgnjxQ61n30/em1jMQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570062; c=relaxed/simple;
	bh=LYmRH9Cq4K1QOssewGuoOledSXQRtypRIg8gqFLtk9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FWSeNs9gA/k37eaIo01R+fweG5XtSjXXamtAI+04T3nx1UO7EvHuqBeFJWXXcVYo4PiJyrlz2ZEsSxkq2nyjbY3nwqf3Z/iVOVdfnNRblJxcMamB2JndbYe5qsLTBbfIgDTifWyaYJze96l2FOli6+T5csM3MiD5Ofaz0CGt8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqfvWdVv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqfvWdVv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso14054095e9.3
        for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2025 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742570059; x=1743174859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2hyT5/ovzNQkIlW4tZIGwANWfne1WKXAckGUYStO4A=;
        b=hqfvWdVvO5k+D5SRKwVIbJ8WXXqcH5pJszq6bY++ZaOtEBJTQzasGsv3FYf5eYQGYs
         EW4x8ZOYbtKb+ZDglLpHYgs2iNJTxpy+vYMzNu2TW+TkVm2oDaiTABig4TqKmtuJq2qe
         TkDWUVxBEziVZ7I0v+cn2hJsILoTN4kcbZXFZLh/1G8CuAb1MziBDy5lbRkj4ReHg6dd
         mJdfcg+BWx3Z9D5vbv6wTMwnCF4efaHvhpQ9HMzqbA9u31lt5HCIbeUT7HLbhJqvk27Y
         9ZNhGDTOjqdVpVmppEk6TFbpiTzOujpS57r2C9Eg2/hHxwXgW86+3VUoir/ZfmgfkUSJ
         UmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570059; x=1743174859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2hyT5/ovzNQkIlW4tZIGwANWfne1WKXAckGUYStO4A=;
        b=PrA8r6e6lB/Nl0Et4pnntSIrIw/mst6SOlDvFAtrZ/Ym4abDRTvdu6DHK28sg9h7j/
         KHBcyHWuacZbc5BlDQFumRPMjsKZAAPLXL/JNws+g9kXSDZg/BaL7gBXqZXMxCoqOu8S
         rz67nLqJkxzpty/JvHmW7lsTtyQ68s8ryzcUbDcuaE3CAAPzj1lXB3BFTvU5UommOq8W
         VrBwsfdvQcX4dlWV3U4NACaSvHuushPYNJzUEx0Pp81hiMHgMqBu+1XW09agIgGPznDn
         a4PBDZR3ghMPcfuF0dIhAvMqUTKJoPPtD20AGSSThr/qTQdYNz4n44pmM37W1JObu/af
         6sCg==
X-Gm-Message-State: AOJu0YxJc7CFK527UePqkDvb5R6WHihGwAp7D8VGVH2EvSkXDj08DzwX
	OEVb2hH1mpcbCuziAE1DXtaXOQcDG61Cp24Qn+z7rQ8K1eOtkipdSeIdbOpx
X-Gm-Gg: ASbGnctmAiwPnASp6Bl+1A8t1TKpEP29ITvPZ2u3l4PXReIqCmHInIYRQoNGuUU2rmG
	cR53cI9X8AlVPBqTb1nocuTMmWx6LoMjczxh2WJqPkvdbD9Wy58bFqpfcj2soxmMjptWcsWZaIw
	PHBy8O4eitkucgg6ko2gQXMqUCu8e9aYfkUWTEF9ttg9/dvFF9YkG+L8OqNj9IKipANtW4V+hCl
	c12Cqgn/jmdEr3WTtV605vZCLmEeKsns4GcYKppai3kWJYEA+EZZ3EiuNKyJl2xaHIacnrIZph0
	hZ4alQV+PJ8kxRLGiPXs+S/i/FKheWcT1iJwhfWlTeE=
X-Google-Smtp-Source: AGHT+IE9GCNJDGcMiMyFx90gLrAaHGK2esZea+Di+Tw8SPg76cVdqeh0akv06jz/IJ+Coh87d+ZkEQ==
X-Received: by 2002:a05:600c:5488:b0:43d:cc9:b09d with SMTP id 5b1f17b1804b1-43d50a2123emr38003705e9.20.1742570058384;
        Fri, 21 Mar 2025 08:14:18 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:91ef:3e94:acab:b42b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fcea6ecsm29700585e9.5.2025.03.21.08.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:14:17 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH 0/3] m68k: amiga: CS-Lab Warp ata support (and a small zorro id refactor)
Date: Fri, 21 Mar 2025 16:14:13 +0100
Message-Id: <20250321151416.338756-1-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 01 is a small refactor of the CS-Lab Zorro ids
Patch 02 is the driver for the CS-Lab Warp pata/CF socket
Patch 03 enables the driver in amiga_defconfig

Paolo Pisati (3):
  include/uapi/linux/zorro_ids.h: add more cslab warp id
  amiga: cslab ata support
  m68k: amiga_defconfig: enable PATA_CSWARP

 arch/m68k/amiga/config.c          |   4 +-
 arch/m68k/configs/amiga_defconfig |   1 +
 drivers/ata/Kconfig               |  12 ++
 drivers/ata/Makefile              |   1 +
 drivers/ata/pata_cswarp.c         | 210 ++++++++++++++++++++++++++++++
 drivers/zorro/zorro.ids           |   5 +
 include/uapi/linux/zorro_ids.h    |  11 +-
 7 files changed, 241 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ata/pata_cswarp.c

-- 
2.34.1

