From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] IDE cleanups/fixups for 2.6.6-rc1 [0/3]
Date: Sun, 18 Apr 2004 01:55:23 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404180148.43941.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13470 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263202AbUDRAAY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Apr 2004 20:00:24 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Hi,

Three patches:
- ide.c: split init_hwif_default() out of init_hwif_data()
- ide_init_default_hwifs() -> ide_init_default_irq()
- generic ide_init_hwif_ports()

Long-term goal is to obsolete <asm/ide.h>...

Bartlomiej

