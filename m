From: domen@coderock.org
Subject: [patch 1/2] drivers/scsi/ahci: Use the DMA_{64,32}BIT_MASK constants
Date: Fri, 08 Apr 2005 09:53:06 +0200
Message-ID: <20050408075306.C8B1D1EE91@trashy.coderock.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coderock.org ([193.77.147.115]:29664 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262746AbVDHHxQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Apr 2005 03:53:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, domen@coderock.org, tklauser@nuerscht.ch



The previous patch did not compile cleanly on all architectures so
here's a fixed one.

Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when calling
pci_set_dma_mask() or pci_set_consistent_dma_mask()
This patch includes dma-mapping.h explicitly because it caused errors
on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/scsi/ahci.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/scsi/ahci.c~dma_mask-drivers_scsi_ahci drivers/scsi/ahci.c
--- kj/drivers/scsi/ahci.c~dma_mask-drivers_scsi_ahci	2005-04-05 12:57:49.000000000 +0200
+++ kj-domen/drivers/scsi/ahci.c	2005-04-05 12:57:49.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/dma-mapping.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
_
