From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] libata-sff: clarification and trivial correction to Kconfig
 text
Date: Sun, 30 May 2010 16:00:18 +0200 (CEST)
Message-ID: <tkrat.acb772e71ffffd6e@s5r6.in-berlin.de>
References: <tkrat.67c3608aed9d86ad@s5r6.in-berlin.de>
 <4C010AA8.8070004@kernel.org> <4C0135BF.1010505@s5r6.in-berlin.de>
 <4C0225D1.90205@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4C0225D1.90205@kernel.org>
Content-Disposition: INLINE
Sender: linux-doc-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Change the text of the ATA_BMDMA prompt to indicate that it lets one access a class of
device drivers (rather than only add a certain feature to libata).  The divisions of
the "ATA SFF support" menu now read
  - SFF controllers with custom DMA interface,
  - SFF controllers with bus master DMA  (was: "ATA BMDMA support"),
      - SATA SFF controllers with BMDMA,
      - PATA SFF controllers with BMDMA,
  - PIO-only SFF controllers.
This hopefully helps convince users of "make oldconfig" to follow the
recommendation to switch that option on.

Also let the help text of this prompt say more precisely what it is about:  It adds a
little bit of support code to libata that is required by many but not all SFF drivers.
This option alone does not add support of respective controllers though; according
drivers are chosen at subsequent dependent Kconfig prompts. --- And fix a typo.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Supersedes patch "libata-sff: trivial corrections to Kconfig help text".

 drivers/ata/Kconfig |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 73f8833..31e288b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -164,14 +164,14 @@ config SATA_SX4
 	  If unsure, say N.
 
 config ATA_BMDMA
-	bool "ATA BMDMA support"
+	bool "SFF controllers with bus master DMA"
 	default y
 	help
-	  This option adds support for SFF ATA controllers with BMDMA
-	  capability.  BMDMA stands for bus-master DMA and the
-	  de-facto DMA interface for SFF controllers.
+	  This option is required by drivers of SFF ATA controllers with
+	  BMDMA capability.  BMDMA stands for bus master DMA and is the
+	  de facto DMA interface for SFF controllers.
 
-	  If unuser, say Y.
+	  If unsure, say Y.
 
 if ATA_BMDMA
 
-- 
Stefan Richter
-=====-==-=- -=-= ====-
http://arcgraph.de/sr/

