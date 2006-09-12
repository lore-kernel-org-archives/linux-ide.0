From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH]: Update SiS PATA
Date: Tue, 12 Sep 2006 17:15:12 +0100
Message-ID: <1158077712.6780.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751446AbWILPxT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, "." <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

New chipset identifiers

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ata/pata_sis.c linux-2.6.18-rc6-mm1/drivers/ata/pata_sis.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/ata/pata_sis.c	2006-09-11 17:00:08.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/ata/pata_sis.c	2006-09-11 20:10:29.000000000 +0100
@@ -34,7 +34,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_sis"
-#define DRV_VERSION	"0.4.2"
+#define DRV_VERSION	"0.4.3"
 
 struct sis_chipset {
 	u16 device;			/* PCI host ID */
@@ -857,6 +857,10 @@
 	struct sis_chipset *chipset = NULL;
 
 	static struct sis_chipset sis_chipsets[] = {
+	
+		{ 0x0968, &sis_info133 },
+		{ 0x0966, &sis_info133 },
+		{ 0x0965, &sis_info133 },
 		{ 0x0745, &sis_info100 },
 		{ 0x0735, &sis_info100 },
 		{ 0x0733, &sis_info100 },
