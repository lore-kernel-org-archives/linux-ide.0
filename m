From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 1/2] drivers: ata: Mark the function ahci_init_interrupts()
 as static in ahci.c
Date: Sat, 14 Dec 2013 19:38:08 +0530
Message-ID: <81391ee13d565f1db31247dfda803cd7123bb8a9.1387029964.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41221 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540Ab3LNOIR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Dec 2013 09:08:17 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, josh@joshtriplett.org

This patch marks the function ahci_init_interrupts() as static in ahci.=
c
because it is not used outside this file.

Thus, it also eliminates the following warning in ahci.c:
drivers/ata/ahci.c:1099:5: warning: no previous prototype for =E2=80=98=
ahci_init_interrupts=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 drivers/ata/ahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 14f1e95..4ab1d41 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1097,7 +1097,7 @@ static inline void ahci_gtf_filter_workaround(str=
uct ata_host *host)
 {}
 #endif
=20
-int ahci_init_interrupts(struct pci_dev *pdev, struct ahci_host_priv *=
hpriv)
+static int ahci_init_interrupts(struct pci_dev *pdev, struct ahci_host=
_priv *hpriv)
 {
 	int rc;
 	unsigned int maxvec;
--=20
1.7.9.5

