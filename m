From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata: ahci enclosure management led sync
Date: Thu, 16 Oct 2008 09:26:19 -0500
Message-ID: <20081016142619.GA8282@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:38095 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbYJPOdo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 10:33:44 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com, tj@kernel.org

Synchronize ahci_sw_activity and ahci_sw_activity_blink with ata_port lock.

Signed-off-by: David Milburn <dmilburn@redhat.com>
--- 
 drivers/ata/ahci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2e1a7cb..40ec29a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1219,6 +1219,7 @@ static void ahci_sw_activity_blink(unsigned long arg)
 	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];
 	unsigned long led_message = emp->led_state;
 	u32 activity_led_state;
+	unsigned long flags;
 
 	led_message &= 0xffff0000;
 	led_message |= ap->port_no | (link->pmp << 8);
@@ -1227,6 +1228,7 @@ static void ahci_sw_activity_blink(unsigned long arg)
 	 * toggle state of LED and reset timer.  If not,
 	 * turn LED to desired idle state.
 	 */
+	spin_lock_irqsave(ap->lock, flags);
 	if (emp->saved_activity != emp->activity) {
 		emp->saved_activity = emp->activity;
 		/* get the current LED state */
@@ -1249,6 +1251,7 @@ static void ahci_sw_activity_blink(unsigned long arg)
 		if (emp->blink_policy == BLINK_OFF)
 			led_message |= (1 << 16);
 	}
+	spin_unlock_irqrestore(ap->lock, flags);
 	ahci_transmit_led_message(ap, led_message, 4);
 }
 
