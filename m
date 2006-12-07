From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Incorrect timing computation for PIO5/6
Date: Thu, 7 Dec 2006 12:41:18 +0000
Message-ID: <20061207124118.0feee6d9@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59046 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032138AbWLGMfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Dec 2006 07:35:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

The ata timing computation code makes some mistakes in PIO5/6 because a
check was not updated correctly when I put this support into the kernel.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/ata/libata-core.c linux-2.6.19-rc6-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/libata-core.c	2006-11-24 13:58:28.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/libata-core.c	2006-12-07 10:28:21.229413880 +0000
@@ -2164,7 +2164,7 @@
 	 * DMA cycle timing is slower/equal than the fastest PIO timing.
 	 */
 
-	if (speed > XFER_PIO_4) {
+	if (speed > XFER_PIO_6) {
 		ata_timing_compute(adev, adev->pio_mode, &p, T, UT);
 		ata_timing_merge(&p, t, t, ATA_TIMING_ALL);
 	}
