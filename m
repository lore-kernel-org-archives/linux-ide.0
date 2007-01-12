From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 0/4] drivers/ata: add low-level I/O calls
Date: Fri, 12 Jan 2007 19:00:45 +0900
Message-ID: <200701120958.l0C9wICB019343@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:41274 "EHLO
	inet-tsb5.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161054AbXALJ6W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 04:58:22 -0500
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0C9wJ7I012774
	for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 18:58:19 +0900 (JST)
Received: (from root@localhost)
	by tsb-wall.toshiba.co.jp  id l0C9wJZg012102
	for linux-ide@vger.kernel.org; Fri, 12 Jan 2007 18:58:19 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0C9wJpm015639
	for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 18:58:19 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com

Dear everyone,

This is the patchset (based on 2.6.20-rc4) to add low-level I/O calls
which access the taskfile registers. The idea comes from drivers/ide
IN*/OUT* calls.

As you know, these calls are unnecessary for most libata drivers.
But the Celleb PATA driver needs them to use the libata common code.
And using these calls, it is possible to remove similar code
about PIO/MMIO access.

Please give me any comments.

Best regards,
Akira Iguchi
