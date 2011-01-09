From: mkl0301@gmail.com
Subject: [PATCH v5 1/3] ahci_platform: rename module ahci_platform to ahci_platforms
Date: Sun,  9 Jan 2011 15:26:08 +0800
Message-ID: <1294557970-654-2-git-send-email-mkl0301@gmail.com>
References: <1294557970-654-1-git-send-email-mkl0301@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36450 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1AIH1T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Jan 2011 02:27:19 -0500
Received: by mail-pz0-f46.google.com with SMTP id 35so2170122pzk.19
        for <linux-ide@vger.kernel.org>; Sat, 08 Jan 2011 23:27:19 -0800 (PST)
In-Reply-To: <1294557970-654-1-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Mac Lin <mkl0301@gmail.com>

From: Mac Lin <mkl0301@gmail.com>

Due to build system limitations, intermediate and final objects can't have the
same names. And as we're going to start building SoC-specific objects, rename
ahci_platform to ahci_platforms, into which link ahci_platform and SoC-specific
objects.

Signed-off-by: Mac Lin <mkl0301@gmail.com>
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/ata/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 2b67c90..d17bfe7 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -3,7 +3,9 @@ obj-$(CONFIG_ATA)		+= libata.o
 
 # non-SFF interface
 obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o
-obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o
+obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platforms.o libahci.o
+ahci_platforms-y		+= ahci_platform.o
+
 obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
 obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
-- 
1.7.3

