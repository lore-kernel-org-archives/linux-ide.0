From: David Milburn <dmilburn@redhat.com>
Subject: [RFC PATCH] libata: ahci enclosure management sync
Date: Tue, 14 Oct 2008 20:39:16 -0500
Message-ID: <20081015013916.GA5982@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:44068 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbYJOBqv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 21:46:51 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com, tj@kernel.org

Hello,

Shouldn't we synchronize ahci_sw_activity and ahci_sw_activity_blink?
Isn't it possible that __run_timers has detached the timer so it is
no longer pending and it is in the process of running the timer func
on one cpu, and ahci_sw_activity is running on another cpu and may
see no timer pending so both ahci_sw_activity and ahci_sw_activity_blink
modify the timeout. Also, ahci_sw_activity is incrementing
emp->activity and ahci_sw_activity_blink is reading this value.
Since ap->lock is already being held when ahci_sw_activity runs
shouldn't ahci_sw_activity_blink grab this lock to better sync
between the two? 

Thanks,
David

 drivers/ata/ahci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2e1a7cb..1573ce3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1227,6 +1227,7 @@ static void ahci_sw_activity_blink(unsigned long arg)
 	 * toggle state of LED and reset timer.  If not,
 	 * turn LED to desired idle state.
 	 */
+	spin_lock(ap->lock);
 	if (emp->saved_activity != emp->activity) {
 		emp->saved_activity = emp->activity;
 		/* get the current LED state */
@@ -1249,6 +1250,7 @@ static void ahci_sw_activity_blink(unsigned long arg)
 		if (emp->blink_policy == BLINK_OFF)
 			led_message |= (1 << 16);
 	}
+	spin_unlock(ap->lock);
 	ahci_transmit_led_message(ap, led_message, 4);
 }
 
