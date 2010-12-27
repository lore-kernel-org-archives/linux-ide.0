From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata warning fix
Date: Sun, 26 Dec 2010 19:48:04 -0500
Message-ID: <20101227004804.GA14200@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:37542 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100Ab0L0AsR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Dec 2010 19:48:17 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/pata_cs5536.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

Jeff Garzik (1):
      pata_cs5536: avoid implicit MSR API inclusion on x86-64

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index a6e6c96..628c8fa 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -44,6 +44,8 @@ static int use_msr;
 module_param_named(msr, use_msr, int, 0644);
 MODULE_PARM_DESC(msr, "Force using MSR to configure IDE function (Default: 0)");
 #else
+#undef rdmsr	/* avoid accidental MSR usage on, e.g. x86-64 */
+#undef wrmsr
 #define rdmsr(x, y, z) do { } while (0)
 #define wrmsr(x, y, z) do { } while (0)
 #define use_msr 0
