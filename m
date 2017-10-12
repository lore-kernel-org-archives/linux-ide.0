From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] documentation: Update ide-cd documentation to reflect
 CONFIG_BLK_DEV_HD_IDE removal
Date: Thu, 12 Oct 2017 15:00:06 +1100 (AEDT)
Message-ID: <alpine.LNX.2.00.1710121439020.3@nippy.intranet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-ide@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

CONFIG_BLK_DEV_HD_IDE was removed in commit 80aa31cb460d ("ide: 
remove CONFIG_BLK_DEV_HD_IDE config option (take 2)") but the ide-cd 
documentation was not updated and still asks users to disable it, 
which is misleading and involves a fruitless search.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

diff --git a/Documentation/cdrom/ide-cd b/Documentation/cdrom/ide-cd
index f4dc9de2694e..a5f2a7f1ff46 100644
--- a/Documentation/cdrom/ide-cd
+++ b/Documentation/cdrom/ide-cd
@@ -55,13 +55,9 @@ This driver provides the following features:
    (to compile support as a module which can be loaded and unloaded)
    to the options: 
 
-      Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
+      ATA/ATAPI/MFM/RLL support
       Include IDE/ATAPI CDROM support
 
-   and `no' to
-
-      Use old disk-only driver on primary interface
-
    Depending on what type of IDE interface you have, you may need to
    specify additional configuration options.  See
    Documentation/ide/ide.txt.
