From: Lukasz Dorau <lukasz.dorau@intel.com>
Subject: [PATCH] libahci: fix turning on LEDs in ahci_start_port()
Date: Mon, 14 Oct 2013 14:58:19 +0200
Message-ID: <20131014125819.19262.32922.stgit@gklab-154-244.igk.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

If EM Transmit bit is busy during init ata_msleep() is called.
It is wrong - msleep() should be used instead of ata_msleep(),
because if EM Transmit bit is busy for one port, it will be busy
for all other ports too, so using ata_msleep() causes wasting
tries for another ports.

The most common scenario looks like that now
(six ports try to transmit a LED meaasege):
- port #0 tries for the 1st time and succeeds
- ports #1-5 try for the 1st time and sleeps
- port #1 tries for the 2nd time and succeeds
- ports #2-5 try for the 2nd time and sleeps
- port #2 tries for the 3rd time and succeeds
- ports #3-5 try for the 3rd time and sleeps
- port #3 tries for the 4th time and succeeds
- ports #4-5 try for the 4th time and sleeps
- port #4 tries for the 5th time and succeeds
- port #5 tries for the 5th time and sleeps
At this moment port #5 wasted all its five tries and failed to initialize.
Because there are only 5 (EM_MAX_RETRY) tries available usually only five ports
succeed to initialize. The sixth port and next ones usually will fail.

If msleep() is used instead of ata_msleep() the first port succeeds to initialize
in the first try and next ones usually succeed to initialize in the second try.

Signed-off-by: Lukasz Dorau <lukasz.dorau@intel.com>
---
 drivers/ata/libahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index acfd0f7..cf38692 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -779,7 +779,7 @@ static void ahci_start_port(struct ata_port *ap)
 							       emp->led_state,
 							       4);
 				if (rc == -EBUSY)
-					ata_msleep(ap, 1);
+					msleep(1);
 				else
 					break;
 			}
