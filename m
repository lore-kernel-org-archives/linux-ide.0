From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ide: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Fri, 30 Nov 2018 21:20:48 -0500
Message-ID: <20181201022048.5106-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-ide@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/ide/ide-proc.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 45c997430332..4c8c7a620d08 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -614,18 +614,7 @@ static int ide_drivers_show(struct seq_file *s, void *p)
 	return 0;
 }
 
-static int ide_drivers_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, &ide_drivers_show, NULL);
-}
-
-static const struct file_operations ide_drivers_operations = {
-	.owner		= THIS_MODULE,
-	.open		= ide_drivers_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ide_drivers);
 
 void proc_ide_create(void)
 {
@@ -634,7 +623,7 @@ void proc_ide_create(void)
 	if (!proc_ide_root)
 		return;
 
-	proc_create("drivers", 0, proc_ide_root, &ide_drivers_operations);
+	proc_create("drivers", 0, proc_ide_root, &ide_drivers_fops);
 }
 
 void proc_ide_destroy(void)
-- 
2.17.0
