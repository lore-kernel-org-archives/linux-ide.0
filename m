From: Mika Kukkonen <mikukkon@gmail.com>
Subject: Small compile fix to ide.c with !CONFIG_PCI
Date: Thu, 10 Feb 2005 10:17:50 +0200
Message-ID: <4301cff605021000172ead5f0c@mail.gmail.com>
Reply-To: Mika Kukkonen <mikukkon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.201]:65090 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262043AbVBJIRu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2005 03:17:50 -0500
Received: by wproxy.gmail.com with SMTP id 68so74895wri
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2005 00:17:50 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, hannal@us.ibm.com

Hi!

Small patch to fix following warning with CONFIG_IDE && !CONFIG_PCI:

  CC	drivers/ide/ide.o
drivers/ide/ide.c: In function 'ide_system_bus_speed':
drivers/ide/ide.c:338: warning: unused variable 'pci_default'

I decided to save some bytes by #ifdef:ing the struct in question.
CC:ing Hanna because she did the change (and just to say hi ;-).

--MiKu

Signed-off-by: Mika Kukkonen <mikukkon@gmail.com>

--- linux-tiny/drivers/ide/ide.c	2005-02-10 09:47:08.000000000 +0200
+++ linux-2.5/drivers/ide/ide.c 2005-02-10 09:45:34.000000000 +0200
@@ -335,10 +335,14 @@ static void __init init_ide_data (void)

 static int ide_system_bus_speed(void)
 {
+#ifdef CONFIG_PCI
	static struct pci_device_id pci_default[] = {
		{ PCI_DEVICE(PCI_ANY_ID, PCI_ANY_ID) },
		{ }
	};
+#else
+#define pci_default 0
+#endif /* CONFIG_PCI */

	if (!system_bus_speed) {
		if (idebus_parameter) {
