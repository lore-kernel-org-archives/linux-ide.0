Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2812AE78
	for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2026 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206497; cv=none; b=tJczvtaqeL+cFeIWOzZplOlGuKFGHOaN9R7LpRERMDoZhQwI9wPDc2p+iui3VM6uN4uIB/Eat/BHi2z4MDQfU9o0qwFZtxrKrbLG44h4XMzuKTn8m5lhNAB/yb/GniMFQLpYwvupzIlKKg990eX2GNm28QTl9dW1wjDQvyqziA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206497; c=relaxed/simple;
	bh=eQ+aPSF2o49MMvW+dAK+rnxNF5GReb17AE2PgBhkD94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQlszMdZMiJ7VGYhJ5rpjiCTD6OBbOzcpPJIoDV4wKsta+MULwE9EOwxe2z26ARPpF05FjWQ9JsiP15OiZNkLbqgz0mFS9TIcykArEXr6bft0HA35mdy3k+Gx21nfTSDzRDZU9b4E+68lG6hM4SqcOuGg2H8VcfmCbO0l/oA6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIC4MaGW; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIC4MaGW"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ff88549786so33796496d6.3
        for <linux-ide@vger.kernel.org>; Mon, 27 Jul 2026 19:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785206494; x=1785811294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KLe+nCkDPgXfI5lHYLRk/Vgw3wsM30n35xzzTJ428iQ=;
        b=cIC4MaGW8bT3Lgsuf9CfSUKeAAgZmL4fVGTpeYe7Ix6LmwxUzAvTzoZYyCcCs9CAMa
         NHKJTbH1APGhgfBq3o3LnjJMIIulDzxkhLGVNyNRBlHYN3F/kwPqvywCAJ49Wi6qTun1
         I7LdvaksbkgKYcxsWINsvdPI3SfAjHfa5L7OWEsEFPJSaLDApC0SC9FaQODrY3L1sBFR
         sBUMdf47xovaPs0wUJzP6gvtRF7D7Mpa0PArLBCMwwww7syO1pip2DWACZI1//w9KBTH
         dV8TGHT2OVj5Y37INNtTBZmzE8cSBNX+zVqIx0++EgbqqH3mLed4CFzWKdAE6QtWcciI
         +DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785206494; x=1785811294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KLe+nCkDPgXfI5lHYLRk/Vgw3wsM30n35xzzTJ428iQ=;
        b=ljHHdmz4uwXvjOfeCZkqkXmb03dncjVhslcK8yES3Kl2i2MON/ImRJI6aXxVsJ3j9v
         KizI9ERXjUc1sQyVIIsJlqhQLy3lk/SGVj4w1ZCsHjMWWX6AtdjNBS6YFa9gNt7Ewl8s
         GYiUjxQ1XfeHWUM9Rmi3cWfFJHscY3CZfOy/wHe469i+R415f6206Pil/o75iQ5xAFeh
         YAaoyIvVywtxCGxJ3SyAb6PDgH1sdXdolP8nvLQWkvYYMKBAe5HTOVM3lTOJlgWP+Ny+
         r+JUnGdIqurg8d+4MbEMv934kuiHv/uoaLjeryuuAco110dGK/flrvnOZqVbedSilT5h
         xAMg==
X-Forwarded-Encrypted: i=1; AHgh+RqP1scZT4Jigacqt8QUQL+od+fmylPwrhF+zMuNuDG8vmiyFNHPU36+mic9/v9KV/vE3hoVXgP3Fl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaPoF0NSi372fjboiGtLlrTvvfGggJC0K1Wnt88AgpMAM1yp7
	X/V1qFD9t2yp1MDx1BHZMhG6xfb65N7DkaZVyYMiop+eO91+npoe/YcEUleRVjxN
X-Gm-Gg: AR+sD10QtcQiYBx3PguQ4FyHga4LbU1jWScCMWAueW1uUaF3uQCTcwdXspQuUtilLIi
	l5yFEJFDxjLPohGcmDigU4phbCvzJXLnMEGMDmarvLYhxwmd4e6KjuHLYZYqE7vZmyU3eAEh8FT
	ojSsJeNq2QNVXOtYNgRDw1p55lpFDs9y78hSFFEuf51UYxh4/1TZtuVHiGHdSnJIUtew/lE1k46
	laUGEW+qfZkOROydPDVvQ8VweBWDHbQqfNW9aeuM6kt5tIiVkSbbXt/x9rJg6PoZLkM/2HuJnBf
	PtLJTJAGa9AFwl4t3WB08mjTkn745G4TTP82XBA9zT2LkkDoKqs6kYisBYkHBuEljamdPCLtGvP
	YsbyEw6W2fWBftTgqEAthUlfWhIasIp+65ViaBbno28gNZRhIM2Tw938j/A4iD8N2eRR4ZbEoNR
	HzD/qDMQkfzr85amYBX2OavlOv/1gaTW0yB446dZzjT45i4vK1zNxkudyD1wSjTgwTX6zTzdVBD
	D4wZljtSdg2IIv08Q==
X-Received: by 2002:a05:6214:d89:b0:8e9:f5de:d631 with SMTP id 6a1803df08f44-908173108f0mr5326786d6.50.1785206494479;
        Mon, 27 Jul 2026 19:41:34 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e86d7c80sm82183806d6.39.2026.07.27.19.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 19:41:34 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] ata: pata_parport: KASAN slab-use-after-free in driver_find
Date: Mon, 27 Jul 2026 22:40:13 -0400
Message-ID: <20260728024015.2014674-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in driver_find

on commit: 62efbc768363bc7bb00f0915ad265f34b40d414e (2026-07-27)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds a delay.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/a8a1b5339bc41944c2f80d9f87e01a7e

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  755.753286][ T8297] BUG: KASAN: slab-use-after-free in driver_find (drivers/base/bus.c:1430)
[  755.754175][ T8297] Read of size 8 at addr ffff88812200f490 by task repro.sh/8297
[  755.755320][ T8297] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  755.755331][ T8297] Call Trace:
[  755.755341][ T8297]  <TASK>
[  755.755344][ T8297]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  755.755393][ T8297]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  755.755478][ T8297]  kasan_report (mm/kasan/report.c:595)
[  755.755487][ T8297]  driver_find (drivers/base/bus.c:1430)
[  755.755502][ T8297]  new_device_store (drivers/ata/pata_parport/pata_parport.c:649)
[  755.755610][ T8297]  kernfs_fop_write_iter (fs/kernfs/file.c:345)
[  755.755615][ T8297]  vfs_write (fs/read_write.c:595 fs/read_write.c:687)
[  755.755678][ T8297]  ksys_write (fs/read_write.c:739)
[  755.755703][ T8297]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  755.755717][ T8297]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  755.779923][ T8297] Freed by task 8297 on cpu 0 at 755.752571s:
[  755.780598][ T8297]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  755.781128][ T8297]  kasan_save_free_info (mm/kasan/generic.c:584)
[  755.781700][ T8297]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[  755.782222][ T8297]  kfree (./include/linux/kasan.h:235 mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
[  755.782658][ T8297]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 ./include/linux/kref.h:65 lib/kobject.c:737)
[  755.783163][ T8297]  driver_find (drivers/base/bus.c:1429)
[  755.783659][ T8297]  new_device_store (drivers/ata/pata_parport/pata_parport.c:649)
[  755.787092][ T8297] The buggy address belongs to the object at ffff88812200f400
[  755.787092][ T8297]  which belongs to the cache kmalloc-192 of size 192
[  755.788598][ T8297] The buggy address is located 144 bytes inside of
[  755.788598][ T8297]  freed 192-byte region [ffff88812200f400, ffff88812200f4c0)

Best,
Shuangpeng
