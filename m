From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Swarm: Fix crash due to missing initialization
Date: Sun, 21 Sep 2008 22:47:16 +0200
Message-ID: <20080921204716.GA29927@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org
Cc: linux-mips@linux-mips.org
List-Id: linux-ide@vger.kernel.org

If things are just right this will result in the hws[0]->parent being
passed to ide_host_add() being non-zero and an ooops a little later.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---

This patch is needed for 2.6.27 only

diff --git a/drivers/ide/mips/swarm.c b/drivers/ide/mips/swarm.c
index badf79f..39c9ee9 100644
--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -107,6 +107,7 @@ static int __devinit swarm_ide_probe(struct device *dev)
 
 	base = ioremap(offset, size);
 
+	memset(&hw, 0, sizeof(hw));
 	for (i = 0; i <= 7; i++)
 		hw.io_ports_array[i] =
 				(unsigned long)(base + ((0x1f0 + i) << 5));
