From: Greg KH <greg@kroah.com>
Subject: [patch 10/21] ide: fix drive side 80c cable check
Date: Tue, 20 Feb 2007 17:37:41 -0800
Message-ID: <20070221013741.GK30227@kroah.com>
References: <20070221012758.925122216@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751083AbXBUBkB@vger.kernel.org>
Content-Disposition: inline; filename="ide-fix-drive-side-80c-cable-check.patch"
In-Reply-To: <20070221013619.GA30227@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org, Alan <alan@lxorguk.ukuu.org.uk>
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

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

--- linux-2.6.19.4.orig/drivers/ide/ide-iops.c
+++ linux-2.6.19.4/drivers/ide/ide-iops.c
@@ -607,6 +607,8 @@ u8 eighty_ninty_three (ide_drive_t *driv
 	if(!(drive->id->hw_config & 0x4000))
 		return 0;
 #endif /* CONFIG_IDEDMA_IVB */
+	if (!(drive->id->hw_config & 0x2000))
+		return 0;
 	return 1;
 }
 

--
