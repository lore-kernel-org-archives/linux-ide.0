From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/6] include, sound: pci_find_device remove (include/asm-i386/ide.h)
Date: Fri, 2 Sep 2005 23:45:27 +0200
Message-ID: <200509022145.j82LjRC0031385@wscnet.wsc.cz>
References: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wscnet.wsc.cz ([212.80.64.118]:55685 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1161065AbVIBVpb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Sep 2005 17:45:31 -0400
In-reply-to: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

Generated in 2.6.13-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 ide.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/asm-i386/ide.h b/include/asm-i386/ide.h
--- a/include/asm-i386/ide.h
+++ b/include/asm-i386/ide.h
@@ -41,7 +41,12 @@ static __inline__ int ide_default_irq(un
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
-	if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
+	struct pci_dev *pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
+	unsigned int a = !pdev;
+
+	pci_dev_put(pdev);
+
+	if (a) {
 		switch(index) {
 			case 2: return 0x1e8;
 			case 3: return 0x168;
