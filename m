From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ide: silence some underflow warnings
Date: Fri, 13 Nov 2015 17:34:01 +0300
Message-ID: <20151113143401.GC1445@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:22714 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbbKMOeK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2015 09:34:10 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Back in the day we used to just say this code was root only so it was
ok that the bounds checking was sloppy.  These days it annoys static
checkers so we fix it.

In the original code "c > INT_MAX" was never true since "c" was an int.
I am not sure what was intended so I left it alone.  But because I made
"c" unsigned it means we don't have a warning any more.

The second warning is that we cap "i" but allow negatives leading to an
underflow of the ide_disks_chs[] array.  The third set of warnings is
because these values come from the user and we cap most of the upper
bounds but allow negative values.  Negative cylinders doesn't make
sense.

drivers/ide/ide.c:262 ide_set_disk_chs() warn: impossible condition '(c > ((~0 >> 1))) => (s32min-s32max > s32max)'
drivers/ide/ide.c:270 ide_set_disk_chs() warn: check 'ide_disks_chs[i]' for negative offsets 'i' = s32min.  extra = 's32min-19'
drivers/ide/ide.c:271 ide_set_disk_chs() warn: no lower bound on 'h'

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index f086ef3..d127ace 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -178,17 +178,17 @@ MODULE_PARM_DESC(pci_clock, "PCI bus clock frequency (in MHz)");
 
 static int ide_set_dev_param_mask(const char *s, const struct kernel_param *kp)
 {
-	int a, b, i, j = 1;
+	unsigned int a, b, i, j = 1;
 	unsigned int *dev_param_mask = (unsigned int *)kp->arg;
 
 	/* controller . device (0 or 1) [ : 1 (set) | 0 (clear) ] */
-	if (sscanf(s, "%d.%d:%d", &a, &b, &j) != 3 &&
-	    sscanf(s, "%d.%d", &a, &b) != 2)
+	if (sscanf(s, "%u.%u:%u", &a, &b, &j) != 3 &&
+	    sscanf(s, "%u.%u", &a, &b) != 2)
 		return -EINVAL;
 
 	i = a * MAX_DRIVES + b;
 
-	if (i >= MAX_HWIFS * MAX_DRIVES || j < 0 || j > 1)
+	if (i >= MAX_HWIFS * MAX_DRIVES || j > 1)
 		return -EINVAL;
 
 	if (j)
@@ -246,17 +246,17 @@ static struct chs_geom ide_disks_chs[MAX_HWIFS * MAX_DRIVES];
 
 static int ide_set_disk_chs(const char *str, struct kernel_param *kp)
 {
-	int a, b, c = 0, h = 0, s = 0, i, j = 1;
+	unsigned int a, b, c = 0, h = 0, s = 0, i, j = 1;
 
 	/* controller . device (0 or 1) : Cylinders , Heads , Sectors */
 	/* controller . device (0 or 1) : 1 (use CHS) | 0 (ignore CHS) */
-	if (sscanf(str, "%d.%d:%d,%d,%d", &a, &b, &c, &h, &s) != 5 &&
-	    sscanf(str, "%d.%d:%d", &a, &b, &j) != 3)
+	if (sscanf(str, "%u.%u:%u,%u,%u", &a, &b, &c, &h, &s) != 5 &&
+	    sscanf(str, "%u.%u:%u", &a, &b, &j) != 3)
 		return -EINVAL;
 
 	i = a * MAX_DRIVES + b;
 
-	if (i >= MAX_HWIFS * MAX_DRIVES || j < 0 || j > 1)
+	if (i >= MAX_HWIFS * MAX_DRIVES || j > 1)
 		return -EINVAL;
 
 	if (c > INT_MAX || h > 255 || s > 255)
