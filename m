From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 24/54] MAINTAINERS: Add file patterns for ata device tree bindings
Date: Sun, 22 May 2016 11:06:01 +0200
Message-ID: <1463907991-7916-25-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82c82a72cb9cf02a..cf54ff0c9c168e26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6754,6 +6754,7 @@ M:	Tejun Heo <tj@kernel.org>
 L:	linux-ide@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/ata/
 F:	drivers/ata/
 F:	include/linux/ata.h
 F:	include/linux/libata.h
-- 
1.9.1
