Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5973806C6
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252526; cv=none; b=LWB3H1m1+XQBjPwQ4uQ52lcIMMciNTKaaSzQkQZtGJhmXyqd9LNLjMa3Q3RJwAk87z3sM6V5lRJBNUCT4sWLlUUju1zoKax/M+LsTwL2B2lhfTM+zgLeiQeoH09wiTJ7lrYhPUcWTx6oSQPEUsRzBk7px7Jk4ykVPGxY5ZjtJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252526; c=relaxed/simple;
	bh=P1CT7zq1J4RmNWF+rK7a4RYDe7VjAmxalfl2JAziOx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HYWtX+V5obr6apXkKkiEL73Zp5I5KhHwqit3CEg6KNumzilyEOA5E811bU512SbLMZHle3MeUW+wn0yTXrKsJTAPTLuWy1mv0Dhq105hKsFRc3gv9ZmDqNiAu1w0NQ44OZgwARrTceyZWVKU1bk5GXaGLUw1kzSB3yCgykjgzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QSEbPT1X; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QSEbPT1X"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so7019685e9.1
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781252520; x=1781857320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPwosn57ATiHe2XtXqUnl7i2e/9f9XjRRgDnoBZziDI=;
        b=QSEbPT1X/hdA7ssma5XdfZ2LN+4ujGpGghgCurSWQ/FCtj8aRiVPyZaOuE06/W51sF
         AbX2eclibIAkKpCp03j50lBtnIMxntv0OUB6EYW+NBA/P54/5LJlRaDClk4hn6Xsl3N7
         oLiOtdPK8/QTI8NxRHv34SJxuuxJu/iolvuTMSE/qI6b3+t/zABp1I5KmCtKQVRVL8N8
         ujN4RDkcbZx2qxLR9lo92Gt9NMAdimeDsaRI/dEYAoWLkv9eVxjL5oXdb9m2wRIc1m4a
         iRwe1ZQrrFxNVHJAmbznxmpIJA3atus/XAAvCusq0yyHK6pmb9fWWJI+sGDVagVZ1cUR
         6fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252520; x=1781857320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPwosn57ATiHe2XtXqUnl7i2e/9f9XjRRgDnoBZziDI=;
        b=XxkEKWw5bAzjXSyPKqMQexUaWjK0C8CiZ27cAdsylftZ8GyzR6bXvitt0Yw1n+rpsH
         gkpksl+J5OygnmxrhWriEfSPh9icZL3na/DCmH/TxKR0tdfSH1odLjjCrwue2sNv34UY
         tVEUeGw6ZaqDI7BWgmccmn9i8UDk0ZJM487JIFC8SoKUe6OWnhVMYulpUSRTqIWKFMQ0
         JYzTv6ANCrAS81WunTaShBC3zHJ4d/qnQbVQ8vCpmhM0fM4aUbbiWRedSiWR42HobIoQ
         rqks05mCeeYN6nlOyxMzINPh8Xbfu35ojrCq4woaxXYfk92EzHOemRK+/EsmDvoLEeMY
         3uow==
X-Gm-Message-State: AOJu0Yz6WBoLWJBtQ8uxDhmQYEzPaUcBu1aCfTuCF5w9ojcE4LOggBfp
	tijEuw9MMKyXWdTGTN/+mbkMmxa/ZrdBHXdDOMACrL9iUnZ/Hc+Ro9J/NEIMRLP3ZlQ=
X-Gm-Gg: Acq92OFeCX5rl6XCv45zJD0w93keCP2QJkHSdZn0STt8w19v3orRthgJtXKvRy6r4AK
	NUOF4Rh6FSMkic6i7gtOH+uQ5ZpzPLfQjnwaxdetPWGeOSjIOHp10ODhK4UPJdZhbW7Gu9/VqJp
	dg+Q6BgO5RoaMhPU0BB5BW856bSGd2xdKwvlvJpuOn6Tmj3WUpKLFcBSiEmwQinTziIn+Jv5PbY
	V13JbhBoseulo+QkdZnFMW6i66rrXg5qdBcUOZgAzq1WGU2WyiX+QO36spy47ivQN+90W1khkT6
	yGsJz2VDOiQ/BAg0ZLBlE9GARuoJGcXBly+qRfV/V0Ms5N0HHZdl3EoHZja2KdOMbi39F/ePCLP
	uLEQp4hoc0/ZCedZJGflRVLzcceLUhi3Q3n+34ruyKetMcuVxHSBq06wpC+K/7wMbwyuzq8FlLS
	SJ88jbJYN6YkvhT8A+9IipW6uPvxh2oAad02Y1wSBHzNvVZYWimJHv3pIh29do8tgmGCIwwQcJQ
	BCdcmvN6W0HtA==
X-Received: by 2002:a05:600c:1f8c:b0:490:4b89:535f with SMTP id 5b1f17b1804b1-490ec4d6192mr21088205e9.8.1781252519971;
        Fri, 12 Jun 2026 01:21:59 -0700 (PDT)
Received: from localhost (p200300f65f47db040e4e5c1e98e7f0ff.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e4e:5c1e:98e7:f0ff])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490ea94f5b0sm32288625e9.1.2026.06.12.01.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:21:58 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] ata: Consistently define pci_device_ids using named initializers
Date: Fri, 12 Jun 2026 10:21:46 +0200
Message-ID: <cover.1781252167.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2185; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=P1CT7zq1J4RmNWF+rK7a4RYDe7VjAmxalfl2JAziOx4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqK8Ga9tWUOL1262cYccx+Nm4/z4POIt+iWQY3K HAplBn4oOWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaivBmgAKCRCPgPtYfRL+ TpkxB/48Pqnf2gvi0mWkBhPhMuHlxbM3uJ46BMRZbdVZeXVQaSVPEfhfHfXIrRnXBBde1KTd6CU ES/7epMLF9riksGQZ/8C1RKZTL8orVNA0X2e00cZh+0hO8ZBKpX6zTKM4m4cyLu4zgnTr0J1HdH b5qhJW8VeG9Qc7y455az6uHSZUTDjN1zqm5dl0EJd0TurgVZYlRzYiz8tPw0eyVRA9XhjGd/CZw 46Aq0ArQQnksWScPcU7KiUg2t9pLhJjCArR30Fom+JdXu/e76etqJAfvZ4QaZVv9MrXv/ALHHq1 XyrQ1/3YxHSW/NqZKYheH1m84Xi/zAl7SJqusouJ8kc/AGPp
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

changes since v2 from earlier today
(https://lore.kernel.org/linux-ide/cover.1781248922.git.ukleinek@kernel.org)
is only rewrapping the pci_device_id in drivers/ata/pata_pdc2027x.c,
drivers/ata/pata_serverworks.c, drivers/ata/sata_nv.c,
drivers/ata/sata_sis.c and drivers/ata/sata_via.c to keep below 81 chars
per line. This only affects patch #2. So I added Damien's Reviewed-by:
tag for the unchanged patch #1.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (2):
  ata: Drop unused assignments of pci_device_id driver data
  ata: Use named initializers for pci_device_id arrays

 drivers/ata/acard-ahci.c        |    8 +-
 drivers/ata/ahci.c              | 1626 ++++++++++++++++++++++++-------
 drivers/ata/ata_piix.c          |  532 ++++++----
 drivers/ata/pata_acpi.c         |    5 +-
 drivers/ata/pata_amd.c          |   88 +-
 drivers/ata/pata_artop.c        |   11 +-
 drivers/ata/pata_atp867x.c      |    6 +-
 drivers/ata/pata_cmd640.c       |    4 +-
 drivers/ata/pata_cmd64x.c       |   11 +-
 drivers/ata/pata_jmicron.c      |    7 +-
 drivers/ata/pata_macio.c        |   12 +-
 drivers/ata/pata_ninja32.c      |   14 +-
 drivers/ata/pata_opti.c         |    7 +-
 drivers/ata/pata_pdc2027x.c     |   30 +-
 drivers/ata/pata_pdc202xx_old.c |   13 +-
 drivers/ata/pata_sch.c          |    2 +-
 drivers/ata/pata_serverworks.c  |   24 +-
 drivers/ata/pata_sis.c          |    1 -
 drivers/ata/pata_via.c          |   19 +-
 drivers/ata/pdc_adma.c          |    3 +-
 drivers/ata/sata_mv.c           |   34 +-
 drivers/ata/sata_nv.c           |   58 +-
 drivers/ata/sata_promise.c      |   34 +-
 drivers/ata/sata_qstor.c        |    3 +-
 drivers/ata/sata_sil.c          |   15 +-
 drivers/ata/sata_sil24.c        |   15 +-
 drivers/ata/sata_sis.c          |   32 +-
 drivers/ata/sata_svw.c          |   15 +-
 drivers/ata/sata_sx4.c          |    3 +-
 drivers/ata/sata_uli.c          |    7 +-
 drivers/ata/sata_via.c          |   38 +-
 drivers/ata/sata_vsc.c          |   14 +-
 32 files changed, 1965 insertions(+), 726 deletions(-)

base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
-- 
2.47.3

