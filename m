From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH #upstream] libata-transport: Fix compilation error on powerpc
Date: Wed, 18 Aug 2010 19:37:12 -0700
Message-ID: <1282185432-7069-1-git-send-email-gwendal@google.com>
References: <20100818104057.5fdaf20d.sfr@canb.auug.org.au>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:61539 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab0HSChj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Aug 2010 22:37:39 -0400
In-Reply-To: <20100818104057.5fdaf20d.sfr@canb.auug.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, sfr@canb.auug.org.au
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

slab.h was not included when compiling for powerpc.
It is implicitely included for x86.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-transport.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index a80860f..c136efc 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -25,6 +25,7 @@
 
 
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/spinlock.h>
 #include <scsi/scsi_transport.h>
-- 
1.7.1

