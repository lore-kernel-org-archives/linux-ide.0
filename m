From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] Kconfig for VR1000 machine driver selection
Date: Fri, 18 Feb 2005 11:00:24 +0000
Message-ID: <20050218110024.GA16612@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:50056
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261319AbVBRLA2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Feb 2005 06:00:28 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: patch-out@fluff.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix the use of CONFIG_MACH_VR1000, which was missing an
trailing zero from the configuration variable, so never
being shown if only the VR1000 was selected

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--- linux-2.6.11-rc4/drivers/ide/Kconfig	2005-01-04 10:57:49.000000000 +0000
+++ linux-2.6.11-rc4-bjd8/drivers/ide/Kconfig	2005-02-18 10:54:21.000000000 +0000
@@ -812,7 +812,7 @@
 
 config BLK_DEV_IDE_BAST
 	tristate "Simtec BAST / Thorcom VR1000 IDE support"
-	depends on ARM && (ARCH_BAST || MACH_VR100)
+	depends on ARM && (ARCH_BAST || MACH_VR1000)
 	help
 	  Say Y here if you want to support the onboard IDE channels on the
 	  Simtec BAST or the Thorcom VR1000

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-kconfig-vr1000.patch"

--- linux-2.6.11-rc4/drivers/ide/Kconfig	2005-01-04 10:57:49.000000000 +0000
+++ linux-2.6.11-rc4-bjd8/drivers/ide/Kconfig	2005-02-18 10:54:21.000000000 +0000
@@ -812,7 +812,7 @@
 
 config BLK_DEV_IDE_BAST
 	tristate "Simtec BAST / Thorcom VR1000 IDE support"
-	depends on ARM && (ARCH_BAST || MACH_VR100)
+	depends on ARM && (ARCH_BAST || MACH_VR1000)
 	help
 	  Say Y here if you want to support the onboard IDE channels on the
 	  Simtec BAST or the Thorcom VR1000

--qDbXVdCdHGoSgWSk--
