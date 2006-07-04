From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 13/24] My name is Ingo Molnar, you killed my make allyesconfig, prepare to die
Date: Tue, 4 Jul 2006 18:14:54 +0000 (UTC)
Message-ID: <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48526 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932310AbWGDSO3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:29 -0400
Date: Maw, 04 Gor 2006 19:01:37 +0100
In-Reply-To: <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

Teach the qdi driver to be more polite about probing when compiled in
so that people who make allyesconfig don't get burned.

Alan

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/pata_qdi.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

ff61ee478044f481f73c07a392aab7dfdcfee215
diff --git a/drivers/scsi/pata_qdi.c b/drivers/scsi/pata_qdi.c
index ca6fef0..f8fc0ef 100644
--- a/drivers/scsi/pata_qdi.c
+++ b/drivers/scsi/pata_qdi.c
@@ -26,7 +26,7 @@
 #include <linux/platform_device.h>
 
 #define DRV_NAME "pata_qdi"
-#define DRV_VERSION "0.2.3"
+#define DRV_VERSION "0.2.4"
 
 #define NR_HOST 4	/* Two 6580s */
 
@@ -41,7 +41,13 @@ struct qdi_data {
 
 static struct ata_host_set *qdi_host[NR_HOST];
 static struct qdi_data qdi_data[NR_HOST];
-static int nr_qdi_host = 0;
+static int nr_qdi_host;
+
+#ifdef MODULE
+static int probe_qdi = 1;
+#else
+static int probe_qdi;
+#endif
 
 static void qdi6500_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
@@ -302,6 +308,9 @@ static __init int qdi_init(void)
 	int ct = 0;
 	int i;
 	
+	if (probe_qdi == 0)
+		return;
+	
 	/*
  	 *	Check each possible QD65xx base address
 	 */
@@ -390,3 +399,5 @@ MODULE_VERSION(DRV_VERSION);
 module_init(qdi_init);
 module_exit(qdi_exit);
 
+module_param(probe_qdi, int, 0);
+
-- 
1.2.GIT

