From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH 09/10] IDE: Coding Style fixes to drivers/ide/pci/jmicron.c
Date: Sat, 23 Feb 2008 15:05:56 +0100
Message-ID: <20080223150556.1e55cbbd@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:33567 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758924AbYBWOGA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 09:06:00 -0500
Received: by fg-out-1718.google.com with SMTP id e21so582555fga.17
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 06:06:00 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

File is now error free.
Compile tested.


Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 drivers/ide/pci/jmicron.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/pci/jmicron.c b/drivers/ide/pci/jmicron.c
index 440266f..673f7dc 100644
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -63,8 +63,7 @@ static u8 __devinit ata66_jmicron(ide_hwif_t *hwif)
 	 *	actually do our cable checking etc. Thankfully we don't need
 	 *	to do the plumbing for other cases.
 	 */
-	switch (port_map[port])
-	{
+	switch (port_map[port]) {
 	case PORT_PATA0:
 		if (control & (1 << 3))	/* 40/80 pin primary */
 			return ATA_CBL_PATA40;
-- 
1.5.4.2.316.gf7a7

