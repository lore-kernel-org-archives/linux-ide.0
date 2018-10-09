From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: remove redundant 'default n' from Kconfig
Date: Tue, 9 Oct 2018 16:45:20 +0200
Message-ID: <20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0~b9-NKlREZ1372313723eucas1p2t@eucas1p2.samsung.com>
References: <CGME20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2018-10-09 15:58:37.319122897 +0200
+++ b/drivers/ata/Kconfig	2018-10-09 16:43:07.823190149 +0200
@@ -33,7 +33,6 @@ if ATA
 
 config ATA_NONSTANDARD
        bool
-       default n
 
 config ATA_VERBOSE_ERROR
 	bool "Verbose ATA error reporting"
@@ -62,7 +61,6 @@ config ATA_ACPI
 config SATA_ZPODD
 	bool "SATA Zero Power Optical Disc Drive (ZPODD) support"
 	depends on ATA_ACPI && PM
-	default n
 	help
 	  This option adds support for SATA Zero Power Optical Disc
 	  Drive (ZPODD). It requires both the ODD and the platform
