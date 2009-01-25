From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: set NODEV_HINT for 0x7f status
Date: Sun, 25 Jan 2009 10:26:00 +0900
Message-ID: <497BBFA8.4080804@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49741 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045AbZAYB0P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jan 2009 20:26:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, bugsbuggy@ymail.com

Asus Pundit-R with atiixp controller has the second port missing and,
very unusually, its status is stuck at 0x7f and all others at 0.  This
meanst that it fails TF access test but gets detected as a disk due to
classification code check and then evades polling IDENTIFY presence
detection thanks to the missing BSY in the status value causing
excessive delays during boot.

This patch makes libata-sff HSM set NODEV_HINT if the status is 0x7f
to make polling IDENTIFY presence detection work for these machines.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 5a4aad1..c2e42a9 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1358,6 +1358,16 @@ fsm_start:
 					qc->err_mask |= AC_ERR_HSM;
 				}
 
+				/* There are oddball controllers with
+				 * status register stuck at 0x7f and
+				 * lbal/m/h at zero which makes it
+				 * pass all other presence detection
+				 * mechanisms we have.  Set NODEV_HINT
+				 * for it.  Kernel bz#7241.
+				 */
+				if (status == 0x7f)
+					qc->err_mask |= AC_ERR_NODEV_HINT;
+
 				/* ata_pio_sectors() might change the
 				 * state to HSM_ST_LAST. so, the state
 				 * is changed after ata_pio_sectors().

