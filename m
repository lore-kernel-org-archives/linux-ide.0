From: Greg KH <gregkh@suse.de>
Subject: [patch 008/101] ide: fix drive side 80c cable check
Date: Wed, 07 Mar 2007 09:10:43 -0800
Message-ID: <20070307171143.664274314@mini.kroah.org>
References: <20070307171035.150802805@mini.kroah.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:43370 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422752AbXCGRN3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Mar 2007 12:13:29 -0500
Content-Disposition: inline; filename=ide-fix-drive-side-80c-cable-check.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org, Alan <alan@lxorguk.ukuu.org.uk>
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, Tejun Heo <htejun@gmail.com>


eighty_ninty_three() had word 93 validitity check but not the 80c bit
test itself (bit 12).  This increases the chance of incorrect wire
detection especially because host side cable detection is often
unreliable and we sometimes soley depend on drive side cable
detection.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Acked-by: Alan <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ide/ide-iops.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.20.1.orig/drivers/ide/ide-iops.c
+++ linux-2.6.20.1/drivers/ide/ide-iops.c
@@ -607,6 +607,8 @@ u8 eighty_ninty_three (ide_drive_t *driv
 	if(!(drive->id->hw_config & 0x4000))
 		return 0;
 #endif /* CONFIG_IDEDMA_IVB */
+	if (!(drive->id->hw_config & 0x2000))
+		return 0;
 	return 1;
 }
 

--
