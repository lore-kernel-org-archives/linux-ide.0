From: Ralf Baechle <ralf@linux-mips.org>
Subject: [IDE] Fix build bug
Date: Thu, 25 Oct 2007 14:53:34 +0100
Message-ID: <20071025135334.GA23272@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:57176 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbXJYNxw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 09:53:52 -0400
Received: from localhost.localdomain ([127.0.0.1]:50085 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022619AbXJYNxv (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Thu, 25 Oct 2007 14:53:51 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mips@linux-mips.org

  CC      drivers/ide/pci/generic.o
drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
+section type conflict

This sort of build error is becoming a regular issue.  Either all or non
of the elements that go into a particular section of a compilation unit
need to be const.  Or an error may result such as in this case if
CONFIG_HOTPLUG is unset.

Maybe worth a check in checkpatch.pl - but certainly gcc's interolerance
is also being less than helpful here.

---
 drivers/ide/pci/generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
index f44d708..0047684 100644
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -67,7 +67,7 @@ MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE st
 		.udma_mask	= ATA_UDMA6, \
 	}
 
-static const struct ide_port_info generic_chipsets[] __devinitdata = {
+static struct ide_port_info generic_chipsets[] __devinitdata = {
 	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
 
 	{	/* 1 */
