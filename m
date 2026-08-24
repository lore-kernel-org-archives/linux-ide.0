Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B2366055
	for <linux-ide@vger.kernel.org>; Mon, 24 Aug 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585625; cv=none; b=IvX+hUsqi7P2L4D4ig5WTkwt49FW0augSVSO4LG2Dsuk0Rs+GE5DOFCbt9sWN+juVxs6L2qEfQkbsE/JsNA1MlEnKmBTL4/PYYViluoWLip5jaOfTz7zb97mVt3h8sEM+lxn0oPlRH91AAxuJ9lfN8ffYDARHj+L7zEa+vvf5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585625; c=relaxed/simple;
	bh=VhDBUJhvBNJVEdSMAovrFntQNlsFXhsF2xwn6w8pvXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTsNDoFuXZ+GvvXJ00h7NCN0ZC0XbWjxDTXs26Yi7Iqgwa4PRTkYAnvPVraL/jGoEDFqTQrys3mZDd54Eh1v0AcDzhYclSY2O6MHFr4sQiRxhFN1SfbE+Ts93vZePbhB7G9WBqfY1LMtZHJ6MhEv8l7PMRVpn84wRG6ZOUuIa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAS8VZnV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAS8VZnV"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so5086455a12.2
        for <linux-ide@vger.kernel.org>; Mon, 24 Aug 2026 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787585621; x=1788190421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lEhGDmtMGKEJbLRXHmselbv50QJfRRAI4IoPTTJVy4I=;
        b=kAS8VZnVH9nB4+96Y7iYMMU5DeE14+gbsk2U1+TbnQbHjm9XhmUd7fTF29b0hLiW0c
         fnAfXzl/F104LsEAcn+wiL9tzStKhKb1sXKovJ1YT/nQ8m1rqLoYZyozajdBdlLxjnrv
         mYeUZRU+qjxnsXhVn4QGc8k2Hyxa1yOfqMdAUtBkN3P3Jt3gNSUhGsscQAMNJ82LGIRK
         hsWFsbK3hQjiFHwFHbP4feW59n+LQP7pSqumt5/42wqlmQzq1a76iXwnftRYppj/vuQr
         wKphSQSpPV8rXolq7qRwJALjIqUb251iUqTmLinChMiVZuRipXRYwrrl9RtFd6SLN7wL
         JAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585621; x=1788190421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lEhGDmtMGKEJbLRXHmselbv50QJfRRAI4IoPTTJVy4I=;
        b=CvmlGuQm7EjFKj/nopBTxJb7A630NFIPeQoa2KfQUTJ8W95d2T4VHt6vWH+75a4FR3
         KobmLQXIh7guLWtXfHfsgKzqeojnhumIjTKKBO84EAq22XcXvYCJiB7EeERBsLUOEyKW
         poLrNVGW8QuFm0uYYRlCG0Bs/70zJtpAcA0lOeWi/IaMz7VAEjBtvbFf1fnkZxwZ/aV6
         CEwaygIgLblqGBeR2Pb5nfqyWsdT+BXg6BWt4J1QM58B84Efhtz33hkWDaqK74igw/dO
         JP1gbHRtVRX2sO6rPQdCLc+Mh12+bx9cglbWHJhnwuVnUYVjLg4D6ZoIvU1vU1ISSRRc
         gDWQ==
X-Gm-Message-State: AFuF++lugTagd5uY2oo9IIdfB4av46aBCAvetlhS01RpFVjdFomyy8mV
	pKVPSHgkCCfOoy9WCFz/nw+tukBoSjYE8jNiDW7HBrctM/LQ9VyTof7Q
X-Gm-Gg: AR+sD10nDSN8DH8a4oQh8Re9YGx/x+Qyeaw57EjuwExXNgtPIwdbR3CGNNP+tQTdFhs
	JEWRYIDjqOvmbdwGTw1Nkuhjp44fRUR9qcH4fm3WuXXWPoPOFcxa+RJ8mEmNdKyuWgVG/OnVRQi
	zmUv6S2VpLMftwUyHcLuMcx2+M7SYfB6r58XNVdRq2EunkJbmXZGVB3IZGMxIFzW/V+nEQH4I4X
	g8r/j+qSur0SaNctKuKF6HfGg/n51IF+q0leJuvu3ErMFtDtqgth+iO6ojWxVZiqGhBTi7t1/pF
	/tCOYx1e2VKUCbghimkCa8HkF+zJh8vpy1XwIcdK8kR0G7bW8pGE1AQxgwhTix0isqT8s5GX9ij
	DgxopYJ8F9YVqmWiUrJRMl5HwyKTsaaZFFQuoIPcxs/MTVzKRcEJKSXXVVUdizkSQpjBGjP+3Yc
	tLn4hUy8cNXrssxfOe8rCiViLQV2Eg6IvPGlsM9bSgl+Y2fFPgjt4rOIXu+FpyC0ANjukllp6uZ
	i4Sz7TF57luPKMzOHNwslbYLysDdiFx+oU2Lj0+Vgs0Zr0=
X-Received: by 2002:a05:6402:52d5:b0:6a3:691a:9d69 with SMTP id 4fb4d7f45d1cf-6a42f16595amr31988863a12.4.1787585620459;
        Mon, 24 Aug 2026 08:33:40 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:5fe:e162:f6c3:e4f5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1cdbe9sm9225812a12.24.2026.08.24.08.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:33:39 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] m68k: pata_cswarp: Add Amiga cslab ata support
Date: Mon, 24 Aug 2026 17:33:37 +0200
Message-ID: <20260824153339.512487-1-p.pisati@gmail.com>
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

This is a respin of v4 addressing Geert's review - apologies for the long delay.

Tested on real Warp hardware.

v4: https://lore.kernel.org/linux-ide/20250325155613.352680-1-p.pisati@gmail.com/

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
 drivers/ata/pata_cswarp.c         | 180 ++++++++++++++++++++++++++++++
 5 files changed, 193 insertions(+)
 create mode 100644 drivers/ata/pata_cswarp.c


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.43.0

