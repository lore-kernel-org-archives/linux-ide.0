From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata: ahci enclosure save new led state
Date: Fri, 20 Mar 2009 14:14:23 -0500
Message-ID: <20090320191423.GA16289@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:36739 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432AbZCTTQE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Mar 2009 15:16:04 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com

ahci_transmit_led_message saves off the led_state
with a value that includes the port number OR'd
in, this incorrect value maybe reported back
in ahci_led_store.

For instance, if you turn off all the leds for
port 1 and cat the value back it will report 1
instead of 0.

# echo 0 > /sys/class/scsi_host/host1/em_message
# cat /sys/class/scsi_host/host1/em_message
1

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/ahci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 66e012c..288f12f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1348,7 +1348,7 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 	writel(message[1], mmio + hpriv->em_loc+4);
 
 	/* save off new led state for port/slot */
-	emp->led_state = message[1];
+	emp->led_state = state;
 
 	/*
 	 * tell hardware to transmit the message
