From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] pata_it821x: Delete an error message for a failed memory
 allocation in it821x_firmware_command()
Date: Fri, 16 Feb 2018 15:22:18 +0100
Message-ID: <939014fc-8c9e-99a4-99fb-2fde4694cd29@users.sourceforge.net>
References: <6cdadc5e-bfbd-9866-a69f-d225e68c3b22@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6cdadc5e-bfbd-9866-a69f-d225e68c3b22@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 14:04:49 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_it821x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 7a21edf89e72..46eacb6b93dd 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -658,10 +658,10 @@ static u8 *it821x_firmware_command(struct ata_port *ap, u8 cmd, int len)
 	u8 status;
 	int n = 0;
 	u16 *buf = kmalloc(len, GFP_KERNEL);
-	if (buf == NULL) {
-		printk(KERN_ERR "it821x_firmware_command: Out of memory\n");
+
+	if (!buf)
 		return NULL;
-	}
+
 	/* This isn't quite a normal ATA command as we are talking to the
 	   firmware not the drives */
 	ap->ctl |= ATA_NIEN;
-- 
2.16.1
