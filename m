From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v3 02/11] ata: make PCI dependency explicit for PATA_ACPI
Date: Sun, 23 Dec 2018 23:25:11 +0000
Message-ID: <20181223232521.11320-3-okaya@kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181223232521.11320-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Jens Axboe <axboe@kernel.dk>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

PATA_ACPI is a PCI device driver but the PCI dependency has not been
explicitly called out.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 4ca7a6b4eaae..8218db17ebdb 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1091,7 +1091,7 @@ comment "Generic fallback / legacy drivers"
 
 config PATA_ACPI
 	tristate "ACPI firmware driver for PATA"
-	depends on ATA_ACPI && ATA_BMDMA
+	depends on ATA_ACPI && ATA_BMDMA && PCI
 	help
 	  This option enables an ACPI method driver which drives
 	  motherboard PATA controller interfaces through the ACPI
-- 
2.19.0
