From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 2/3 2.6.24-git] ARM/RPC: Use HAVE_PATA_PLATFORM to select pata
	platform driver
Date: Sat, 02 Feb 2008 16:21:35 +0000
Message-ID: <20080202162232.016724531@fluff.org.uk>
References: <20080202162133.678366209@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline; filename=libata-rpc-use-have-kconfig.patch
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-ide@vger.kernel.org, jeff@garzik.org, htejun@gmail.com
Cc: Ben Dooks <ben-linux@fluff.org>, Linux ARM Kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-ide@vger.kernel.org

Use HAVE_PATA_PLATFORM for ARCH_RPC 

Cc: Linux ARM Kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
PATCH FOLLOWS
KernelVersion: 2.6.24-git12

Index: linux-2.6.24-git12-pata/arch/arm/Kconfig
===================================================================
--- linux-2.6.24-git12-pata.orig/arch/arm/Kconfig
+++ linux-2.6.24-git12-pata/arch/arm/Kconfig
@@ -371,6 +371,7 @@ config ARCH_RPC
 	select FIQ
 	select TIMER_ACORN
 	select ARCH_MAY_HAVE_PC_FDC
+	select HAVE_PATA_PLATFORM
 	select ISA_DMA_API
 	select NO_IOPORT
 	help
Index: linux-2.6.24-git12-pata/drivers/ata/Kconfig
===================================================================
--- linux-2.6.24-git12-pata.orig/drivers/ata/Kconfig
+++ linux-2.6.24-git12-pata/drivers/ata/Kconfig
@@ -624,7 +624,7 @@ config HAVE_PATA_PLATFORM
 
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EMBEDDED || ARCH_RPC || PPC || HAVE_PATA_PLATFORM
+	depends on EMBEDDED || PPC || HAVE_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
