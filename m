From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] pata_it821x: Use common error handling code in
 it821x_firmware_command()
Date: Fri, 16 Feb 2018 15:23:53 +0100
Message-ID: <6fc4ab6f-1168-d362-6a92-7d79b90489a2@users.sourceforge.net>
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
Date: Fri, 16 Feb 2018 14:40:42 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

Reorder three function calls.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_it821x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 46eacb6b93dd..6470112e5b48 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -675,9 +675,8 @@ static u8 *it821x_firmware_command(struct ata_port *ap, u8 cmd, int len)
 	while(n++ < 10) {
 		status = ioread8(ap->ioaddr.status_addr);
 		if (status & ATA_ERR) {
-			kfree(buf);
 			printk(KERN_ERR "it821x_firmware_command: rejected\n");
-			return NULL;
+			goto free_buffer;
 		}
 		if (status & ATA_DRQ) {
 			ioread16_rep(ap->ioaddr.data_addr, buf, len/2);
@@ -687,6 +686,8 @@ static u8 *it821x_firmware_command(struct ata_port *ap, u8 cmd, int len)
 	}
-	kfree(buf);
+
 	printk(KERN_ERR "it821x_firmware_command: timeout\n");
+free_buffer:
+	kfree(buf);
 	return NULL;
 }
 
-- 
2.16.1
