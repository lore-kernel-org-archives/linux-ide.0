Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7AAC48BE8
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 13:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362C36128C
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 13:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhFPNxG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhFPNxF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2021 09:53:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EB8C061574;
        Wed, 16 Jun 2021 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ghV8FofT/1S4G+Z5TMsWzHZydL55epexGiHCR5TOBAA=; b=l1aot1gcHfgHNK23M1842LV+x8
        Q8d0roYwIMyC+erN/eCZkuogTJpBaqMYJsdBQNBRSlaTvJE3uEST7mQ8K1lLBTvB4fJzMA0ZJN9Oa
        ObSF2PdH6gFHeRmOdqKLGVPWVnTWGoCT5LVAlnRFPKGFZ9zt1JO3nfzV8p1Ko1tFtbi3Km79nvHSe
        Ic/fJK+thesvlnGbzAXt7r5MuPV0RSU9vbYBlW05mivqUphKQtS+ck2E0SZg96TAXbp3AKN+dsHr6
        vAetPA5hUuphKKpekc29unyWVaQxfbtJA7PGfEvddz6b8goFPbYgC8lQOI4WpeYwTW4qd+dsxKSGa
        UTzhJpvg==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltVv9-00866d-N7; Wed, 16 Jun 2021 13:49:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 5/6] m68k: use libata instead of the legacy ide driver
Date:   Wed, 16 Jun 2021 15:46:57 +0200
Message-Id: <20210616134658.1471835-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616134658.1471835-1-hch@lst.de>
References: <20210616134658.1471835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Switch the m68 defconfigs from the deprecated ide subsystem to use libata
instead.  The gayle and buddha and falcon drivers are enabled for libata,
while support for the q40 and macide drivers is lost.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/configs/amiga_defconfig | 10 +++++-----
 arch/m68k/configs/atari_defconfig |  8 ++++----
 arch/m68k/configs/mac_defconfig   |  8 ++++----
 arch/m68k/configs/multi_defconfig | 14 +++++++-------
 arch/m68k/configs/q40_defconfig   |  8 ++++----
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 59b727b69357..4fe26d54627e 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -323,11 +323,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
-CONFIG_IDE=y
-CONFIG_IDE_GD_ATAPI=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_GAYLE=y
-CONFIG_BLK_DEV_BUDDHA=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -344,6 +339,11 @@ CONFIG_GVP11_SCSI=y
 CONFIG_SCSI_A4000T=y
 CONFIG_SCSI_ZORRO7XX=y
 CONFIG_SCSI_ZORRO_ESP=y
+CONFIG_ATA=y
+# CONFIG_ATA_VERBOSE_ERROR is not set
+# CONFIG_ATA_BMDMA is not set
+CONFIG_PATA_GAYLE=y
+CONFIG_PATA_BUDDHA=y
 CONFIG_MD=y
 CONFIG_MD_LINEAR=m
 CONFIG_BLK_DEV_DM=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 9cc9f1a06516..21b2990fe9af 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -324,10 +324,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
-CONFIG_IDE=y
-CONFIG_IDE_GD_ATAPI=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_FALCON_IDE=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -339,6 +335,10 @@ CONFIG_SCSI_SAS_ATTRS=m
 CONFIG_ISCSI_TCP=m
 CONFIG_ISCSI_BOOT_SYSFS=m
 CONFIG_ATARI_SCSI=y
+CONFIG_ATA=y
+# CONFIG_ATA_VERBOSE_ERROR is not set
+# CONFIG_ATA_BMDMA is not set
+CONFIG_PATA_FALCON=y
 CONFIG_MD=y
 CONFIG_MD_LINEAR=m
 CONFIG_BLK_DEV_DM=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 406d3f2a16ea..b03300df13fc 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -315,10 +315,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
-CONFIG_IDE=y
-CONFIG_IDE_GD_ATAPI=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_PLATFORM=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -331,6 +327,10 @@ CONFIG_ISCSI_TCP=m
 CONFIG_ISCSI_BOOT_SYSFS=m
 CONFIG_MAC_SCSI=y
 CONFIG_SCSI_MAC_ESP=y
+CONFIG_ATA=y
+# CONFIG_ATA_VERBOSE_ERROR is not set
+# CONFIG_ATA_BMDMA is not set
+CONFIG_PATA_PLATFORM=y
 CONFIG_MD=y
 CONFIG_MD_LINEAR=m
 CONFIG_BLK_DEV_DM=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index f0992435e9ef..e2c8368e2231 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -344,13 +344,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
-CONFIG_IDE=y
-CONFIG_IDE_GD_ATAPI=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_PLATFORM=y
-CONFIG_BLK_DEV_GAYLE=y
-CONFIG_BLK_DEV_BUDDHA=y
-CONFIG_BLK_DEV_FALCON_IDE=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -374,6 +367,13 @@ CONFIG_MVME147_SCSI=y
 CONFIG_MVME16x_SCSI=y
 CONFIG_BVME6000_SCSI=y
 CONFIG_SUN3X_ESP=y
+CONFIG_ATA=y
+# CONFIG_ATA_VERBOSE_ERROR is not set
+# CONFIG_ATA_BMDMA is not set
+CONFIG_PATA_FALCON=y
+CONFIG_PATA_GAYLE=y
+CONFIG_PATA_BUDDHA=y
+CONFIG_PATA_PLATFORM=y
 CONFIG_MD=y
 CONFIG_MD_LINEAR=m
 CONFIG_BLK_DEV_DM=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index b893163d9f06..514e2e8cddbd 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -314,10 +314,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
-CONFIG_IDE=y
-CONFIG_IDE_GD_ATAPI=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_FALCON_IDE=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -328,6 +324,10 @@ CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SAS_ATTRS=m
 CONFIG_ISCSI_TCP=m
 CONFIG_ISCSI_BOOT_SYSFS=m
+CONFIG_ATA=y
+# CONFIG_ATA_VERBOSE_ERROR is not set
+# CONFIG_ATA_BMDMA is not set
+CONFIG_PATA_FALCON=y
 CONFIG_MD=y
 CONFIG_MD_LINEAR=m
 CONFIG_BLK_DEV_DM=m
-- 
2.30.2

