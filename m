From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH] drivers/ata/Kconfig: PATA_SCC depends on wrong platform
Date: Thu, 15 Mar 2007 14:32:58 +0900
Message-ID: <200703150530.l2F5Uwbo024856@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

PATA_SCC depends on PPC_CELLEB. (not PPC_IBM_CELL_BLADE)

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -Nrpu -X linux-2.6.21-rc3/Documentation/dontdiff linux-2.6.21-rc3/drivers/ata/Kconfig linux-2.6.21-rc3.mod/drivers/ata/Kconfig
--- linux-2.6.21-rc3/drivers/ata/Kconfig	2007-03-07 13:41:20.000000000 +0900
+++ linux-2.6.21-rc3.mod/drivers/ata/Kconfig	2007-03-15 23:04:14.000000000 +0900
@@ -564,7 +564,7 @@ config PATA_IXP4XX_CF
 
 config PATA_SCC
 	tristate "Toshiba's Cell Reference Set IDE support"
-	depends on PCI && PPC_IBM_CELL_BLADE
+	depends on PCI && PPC_CELLEB
 	help
 	  This option enables support for the built-in IDE controller on
 	  Toshiba Cell Reference Board.
