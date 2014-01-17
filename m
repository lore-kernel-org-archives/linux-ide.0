From: Lukasz Dorau <lukasz.dorau@intel.com>
Subject: [PATCH] libahci: correct a misleading comment
Date: Fri, 17 Jan 2014 12:43:20 +0100
Message-ID: <20140117114319.2784.3961.stgit@gklab-154-244.igk.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9870 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaAQLnW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Jan 2014 06:43:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

There is an error in a comment introduced by:
	commit fa070ee6dc70bcc19737a2406d741b089b3149d5
	libahci: fix turning on LEDs in ahci_start_port()

Correct it.

Signed-off-by: Lukasz Dorau <lukasz.dorau@intel.com>
---
 drivers/ata/libahci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c482f8c..1f526e6 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -780,8 +780,8 @@ static void ahci_start_port(struct ata_port *ap)
 							       4);
 				/*
 				 * If busy, give a breather but do not
-				 * release EH ownership by using msleep()
-				 * instead of ata_msleep().  EM Transmit
+				 * release EH ownership by using ata_msleep()
+				 * instead of msleep().  EM Transmit
 				 * bit is busy for the whole host and
 				 * releasing ownership will cause other
 				 * ports to fail the same way.

