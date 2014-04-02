From: Alexander Gordeev <agordeev@redhat.com>
Subject: [PATCH 2/2] ahci: Use pci_enable_msi_exact() instead of pci_enable_msi_range()
Date: Wed,  2 Apr 2014 10:19:57 +0200
Message-ID: <aabd5aabbbbc79e5534a9922240c341c153d2156.1396426390.git.agordeev@redhat.com>
References: <cover.1396426390.git.agordeev@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756574AbaDBISP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Apr 2014 04:18:15 -0400
In-Reply-To: <cover.1396426390.git.agordeev@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-ide@vger.kernel.org

The driver calls pci_enable_msi_range() function with the
range of [nvec..nvec] which what pci_enable_msi_exact()
function is for.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/ahci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 838d97e..01c5541 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1174,7 +1174,7 @@ static int ahci_is_mrsm(struct ahci_host_priv *hpriv)
 static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 			 struct ahci_host_priv *hpriv)
 {
-	int nvec;
+	int rc, nvec;
 
 	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
 		goto intx;
@@ -1191,10 +1191,10 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 	if (nvec < n_ports)
 		goto single_msi;
 
-	nvec = pci_enable_msi_range(pdev, nvec, nvec);
-	if (nvec == -ENOSPC)
+	rc = pci_enable_msi_exact(pdev, nvec);
+	if (rc == -ENOSPC)
 		goto single_msi;
-	else if (nvec < 0)
+	else if (rc < 0)
 		goto intx;
 
 	/*
-- 
1.7.7.6

